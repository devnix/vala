/* valastruct.vala
 *
 * Copyright (C) 2006-2008  Jürg Billeter
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.

 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
 *
 * Author:
 * 	Jürg Billeter <j@bitron.ch>
 */

using GLib;
using Gee;

/**
 * Represents a struct declaration in the source code.
 */
public class Vala.Struct : TypeSymbol {
	private Gee.List<TypeParameter> type_parameters = new ArrayList<TypeParameter> ();
	private Gee.List<Constant> constants = new ArrayList<Constant> ();
	private Gee.List<Field> fields = new ArrayList<Field> ();
	private Gee.List<Method> methods = new ArrayList<Method> ();

	private Gee.List<DataType> base_types = new ArrayList<DataType> ();
	
	private string cname;
	private string const_cname;
	private string dup_function;
	private string free_function;
	private string type_id;
	private string lower_case_cprefix;
	private string lower_case_csuffix;
	private bool integer_type;
	private bool floating_type;
	private int rank;
	private string marshaller_type_name;
	private string get_value_function;
	private string set_value_function;
	private string default_value = null;
	private string? type_signature;
	private string copy_function;
	private string destroy_function;

	/**
	 * Specifies the default construction method.
	 */
	public Method default_construction_method { get; set; }
	
	/**
	 * Creates a new struct.
	 *
	 * @param name             type name
	 * @param source_reference reference to source code
	 * @return                 newly created struct
	 */
	public Struct (string name, SourceReference? source_reference = null) {
		base (name, source_reference);
	}

	/**
	 * Appends the specified parameter to the list of type parameters.
	 *
	 * @param p a type parameter
	 */
	public void add_type_parameter (TypeParameter p) {
		type_parameters.add (p);
		p.type = this;
		scope.add (p.name, p);
	}
	
	/**
	 * Returns a copy of the type parameter list.
	 *
	 * @return list of type parameters
	 */
	public Gee.List<TypeParameter> get_type_parameters () {
		return new ReadOnlyList<TypeParameter> (type_parameters);
	}

	/**
	 * Adds the specified constant as a member to this struct.
	 *
	 * @param c a constant
	 */
	public void add_constant (Constant c) {
		constants.add (c);
		scope.add (c.name, c);
	}
	
	/**
	 * Adds the specified field as a member to this struct.
	 *
	 * @param f a field
	 */
	public void add_field (Field f) {
		fields.add (f);
		scope.add (f.name, f);
	}
	
	/**
	 * Returns a copy of the list of fields.
	 *
	 * @return list of fields
	 */
	public Gee.List<Field> get_fields () {
		return new ReadOnlyList<Field> (fields);
	}

	/**
	 * Returns a copy of the list of constants.
	 *
	 * @return list of constants
	 */
	public Gee.List<Constant> get_constants () {
		return new ReadOnlyList<Constant> (constants);
	}

	/**
	 * Adds the specified method as a member to this struct.
	 *
	 * @param m a method
	 */
	public void add_method (Method m) {
		return_if_fail (m != null);
		
		if (m.binding == MemberBinding.INSTANCE || m is CreationMethod) {
			m.this_parameter = new FormalParameter ("this", new ValueType (this));
			m.scope.add (m.this_parameter.name, m.this_parameter);
		}
		if (!(m.return_type is VoidType) && m.get_postconditions ().size > 0) {
			m.result_var = new LocalVariable (m.return_type.copy (), "result");
			m.scope.add (m.result_var.name, m.result_var);
		}
		if (m is CreationMethod) {
			if (m.name == null) {
				default_construction_method = m;
				m.name = "new";
			}

			var cm = (CreationMethod) m;
			if (cm.type_name != null && cm.type_name != name) {
				// type_name is null for constructors generated by GIdlParser
				Report.error (m.source_reference, "missing return type in method `%s.%s´".printf (get_full_name (), cm.type_name));
				m.error = true;
				return;
			}
		}

		methods.add (m);
		scope.add (m.name, m);
	}
	
	/**
	 * Returns a copy of the list of methods.
	 *
	 * @return list of methods
	 */
	public Gee.List<Method> get_methods () {
		return new ReadOnlyList<Method> (methods);
	}

	public override void accept (CodeVisitor visitor) {
		visitor.visit_struct (this);
	}

	public override void accept_children (CodeVisitor visitor) {
		foreach (DataType type in base_types) {
			type.accept (visitor);
		}

		foreach (TypeParameter p in type_parameters) {
			p.accept (visitor);
		}
		
		foreach (Field f in fields) {
			f.accept (visitor);
		}
		
		foreach (Constant c in constants) {
			c.accept (visitor);
		}
		
		foreach (Method m in methods) {
			m.accept (visitor);
		}
	}

	public override string get_cname (bool const_type = false) {
		if (const_type && const_cname != null) {
			return const_cname;
		}
		
		if (cname == null) {
			var attr = get_attribute ("CCode");
			if (attr != null) {
				cname = attr.get_string ("cname");
			}
			if (cname == null) {
				cname = get_default_cname ();
			}
		}
		return cname;
	}

	/**
	 * Returns the default name of this struct as it is used in C code.
	 *
	 * @return the name to be used in C code by default
	 */
	public string get_default_cname () {
		return "%s%s".printf (parent_symbol.get_cprefix (), name);
	}

	private void set_cname (string cname) {
		this.cname = cname;
	}
	
	private void set_const_cname (string cname) {
		this.const_cname = cname;
	}
	
	public override string get_lower_case_cprefix () {
		if (lower_case_cprefix == null) {
			lower_case_cprefix = "%s_".printf (get_lower_case_cname (null));
		}
		return lower_case_cprefix;
	}
	
	private string get_lower_case_csuffix () {
		if (lower_case_csuffix == null) {
			lower_case_csuffix = camel_case_to_lower_case (name);
		}
		return lower_case_csuffix;
	}

	public override string? get_lower_case_cname (string? infix) {
		if (infix == null) {
			infix = "";
		}
		return "%s%s%s".printf (parent_symbol.get_lower_case_cprefix (), infix, get_lower_case_csuffix ());
	}
	
	public override string? get_upper_case_cname (string? infix) {
		return get_lower_case_cname (infix).up ();
	}

	public override string? get_type_signature () {
		if (type_signature == null) {
			var str = new StringBuilder ();
			str.append_c ('(');
			foreach (Field f in fields) {
				if (f.binding == MemberBinding.INSTANCE) {
					str.append (f.field_type.get_type_signature ());
				}
			}
			str.append_c (')');
			return str.str;
		}
		return type_signature;
	}

	/**
	 * Returns whether this is an integer type.
	 *
	 * @return true if this is an integer type, false otherwise
	 */
	public bool is_integer_type () {
		foreach (DataType type in base_types) {
			var st = type.data_type as Struct;
			if (st != null && st.is_integer_type ()) {
				return true;
			}
		}
		return integer_type;
	}
	
	/**
	 * Returns whether this is a floating point type.
	 *
	 * @return true if this is a floating point type, false otherwise
	 */
	public bool is_floating_type () {
		foreach (DataType type in base_types) {
			var st = type.data_type as Struct;
			if (st != null && st.is_floating_type ()) {
				return true;
			}
		}
		return floating_type;
	}
	
	/**
	 * Returns the rank of this integer or floating point type.
	 *
	 * @return the rank if this is an integer or floating point type
	 */
	public int get_rank () {
		return rank;
	}

	private void process_ccode_attribute (Attribute a) {
		if (a.has_argument ("const_cname")) {
			set_const_cname (a.get_string ("const_cname"));
		}
		if (a.has_argument ("cprefix")) {
			lower_case_cprefix = a.get_string ("cprefix");
		}
		if (a.has_argument ("cheader_filename")) {
			var val = a.get_string ("cheader_filename");
			foreach (string filename in val.split (",")) {
				add_cheader_filename (filename);
			}
		}
		if (a.has_argument ("type_id")) {
			set_type_id (a.get_string ("type_id"));
		}
		if (a.has_argument ("marshaller_type_name")) {
			set_marshaller_type_name (a.get_string ("marshaller_type_name"));
		}
		if (a.has_argument ("get_value_function")) {
			set_get_value_function (a.get_string ("get_value_function"));
		}
		if (a.has_argument ("set_value_function")) {
			set_set_value_function (a.get_string ("set_value_function"));
		}
		if (a.has_argument ("default_value")) {
			set_default_value (a.get_string ("default_value"));
		}
		if (a.has_argument ("type_signature")) {
			type_signature = a.get_string ("type_signature");
		}
		if (a.has_argument ("copy_function")) {
			set_copy_function (a.get_string ("copy_function"));
		}
		if (a.has_argument ("destroy_function")) {
			set_destroy_function (a.get_string ("destroy_function"));
		}
	}

	private void process_integer_type_attribute (Attribute a) {
		integer_type = true;
		if (a.has_argument ("rank")) {
			rank = a.get_integer ("rank");
		}
	}
	
	private void process_floating_type_attribute (Attribute a) {
		floating_type = true;
		if (a.has_argument ("rank")) {
			rank = a.get_integer ("rank");
		}
	}
	
	/**
	 * Process all associated attributes.
	 */
	public void process_attributes () {
		foreach (Attribute a in attributes) {
			if (a.name == "CCode") {
				process_ccode_attribute (a);
			} else if (a.name == "IntegerType") {
				process_integer_type_attribute (a);
			} else if (a.name == "FloatingType") {
				process_floating_type_attribute (a);
			}
		}
	}

	public override string? get_type_id () {
		if (type_id == null) {
			foreach (DataType type in base_types) {
				var st = type.data_type as Struct;
				if (st != null) {
					return st.get_type_id ();;
				}
			}
			if (is_simple_type ()) {
				Report.error (source_reference, "The type `%s` doesn't declare a type id".printf (get_full_name ()));
			} else {
				return "G_TYPE_POINTER";
			}
		}
		return type_id;
	}
	
	public void set_type_id (string? name) {
		this.type_id = name;
	}

	public override string? get_marshaller_type_name () {
		if (marshaller_type_name == null) {
			foreach (DataType type in base_types) {
				var st = type.data_type as Struct;
				if (st != null) {
					return st.get_marshaller_type_name ();
				}
			}
			if (is_simple_type ()) {
				Report.error (source_reference, "The type `%s` doesn't declare a marshaller type name".printf (get_full_name ()));
			} else {
				return "POINTER";
			}
		}
		return marshaller_type_name;
	}
	
	private void set_marshaller_type_name (string? name) {
		this.marshaller_type_name = name;
	}
	
	public override string? get_get_value_function () {
		if (get_value_function == null) {
			foreach (DataType type in base_types) {
				var st = type.data_type as Struct;
				if (st != null) {
					return st.get_get_value_function ();
				}
			}
			if (is_simple_type ()) {
				Report.error (source_reference, "The value type `%s` doesn't declare a GValue get function".printf (get_full_name ()));
				return null;
			} else {
				return "g_value_get_pointer";
			}
		} else {
			return get_value_function;
		}
	}
	
	public override string? get_set_value_function () {
		if (set_value_function == null) {
			foreach (DataType type in base_types) {
				var st = type.data_type as Struct;
				if (st != null) {
					return st.get_set_value_function ();
				}
			}
			if (is_simple_type ()) {
				Report.error (source_reference, "The value type `%s` doesn't declare a GValue set function".printf (get_full_name ()));
				return null;
			} else {
				return "g_value_set_pointer";
			}
		} else {
			return set_value_function;
		}
	}
	
	private void set_get_value_function (string? function) {
		get_value_function = function;
	}
	
	private void set_set_value_function (string? function) {
		set_value_function = function;
	}

	public override string? get_default_value () {
		if (default_value != null) {
			return default_value;
		}

		// inherit default value from base type
		foreach (DataType type in base_types) {
			var st = type.data_type as Struct;
			if (st != null) {
				return st.get_default_value ();
			}
		}
		return null;
	}

	private void set_default_value (string? value) {
		default_value = value;
	}

	/**
	 * Adds the specified struct to the list of base types of this struct.
	 *
	 * @param type a class or interface reference
	 */
	public void add_base_type (DataType type) {
		base_types.add (type);
		type.parent_node = this;
	}

	/**
	 * Returns a copy of the base type list.
	 *
	 * @return list of base types
	 */
	public Gee.List<DataType> get_base_types () {
		return new ReadOnlyList<DataType> (base_types);
	}
	
	public override int get_type_parameter_index (string name) {
		int i = 0;
		
		foreach (TypeParameter p in type_parameters) {
			if (p.name == name) {
				return (i);
			}
			i++;
		}
		
		return -1;
	}

	/**
	 * Returns whether this struct is a simple type, i.e. whether
	 * instances are passed by value.
	 */
	public bool is_simple_type () {
		foreach (DataType type in base_types) {
			var st = type.data_type as Struct;
			if (st != null && st.is_simple_type ()) {
				return true;
			}
		}
		return get_attribute ("SimpleType") != null;
	}

	/**
	 * Marks this struct as simple type, i.e. instances will be passed by
	 * value.
	 */
	public void set_simple_type (bool simple_type) {
		attributes.append (new Attribute ("SimpleType"));
	}

	public override void replace_type (DataType old_type, DataType new_type) {
		for (int i = 0; i < base_types.size; i++) {
			if (base_types[i] == old_type) {
				base_types[i] = new_type;
				return;
			}
		}
	}

	public override bool is_subtype_of (TypeSymbol t) {
		if (this == t) {
			return true;
		}

		foreach (DataType base_type in base_types) {
			if (base_type.data_type != null && base_type.data_type.is_subtype_of (t)) {
				return true;
			}
		}
		
		return false;
	}

	public string get_default_copy_function () {
		return get_lower_case_cprefix () + "copy";
	}

	public override string? get_copy_function () {
		if (copy_function == null) {
			copy_function = get_default_copy_function ();
		}
		return copy_function;
	}

	public void set_copy_function (string name) {
		this.copy_function = name;
	}

	public string get_default_destroy_function () {
		return get_lower_case_cprefix () + "destroy";
	}

	public override string? get_destroy_function () {
		if (destroy_function == null) {
			destroy_function = get_default_destroy_function ();
		}
		return destroy_function;
	}

	public void set_destroy_function (string name) {
		this.destroy_function = name;
	}

	public bool is_disposable () {
		if (destroy_function != null) {
			return true;
		}

		foreach (Field f in fields) {
			if (f.binding == MemberBinding.INSTANCE
			    && f.field_type.is_disposable ()) {
				return true;
			}
		}

		return false;
	}

	public override bool check (SemanticAnalyzer analyzer) {
		if (checked) {
			return !error;
		}

		checked = true;

		process_attributes ();

		var old_source_file = analyzer.current_source_file;
		var old_symbol = analyzer.current_symbol;
		var old_struct = analyzer.current_struct;

		if (source_reference != null) {
			analyzer.current_source_file = source_reference.file;
		}
		analyzer.current_symbol = this;
		analyzer.current_struct = this;

		accept_children (analyzer);

		if (!external && !external_package && get_base_types ().size == 0 && get_fields ().size == 0) {
			Report.error (source_reference, "structs cannot be empty");
		}

		analyzer.current_source_file = old_source_file;
		analyzer.current_symbol = old_symbol;
		analyzer.current_struct = old_struct;

		return !error;
	}
}
