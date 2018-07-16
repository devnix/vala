/* gstreamer-rtsp-server-1.0.vapi generated by vapigen, do not modify. */

[CCode (cprefix = "Gst", gir_namespace = "GstRtspServer", gir_version = "1.0", lower_case_cprefix = "gst_")]
namespace Gst {
	namespace RTSPServer {
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPAddress", copy_function = "g_boxed_copy", free_function = "g_boxed_free", lower_case_cprefix = "gst_rtsp_address_", type_id = "gst_rtsp_address_get_type ()")]
		[Compact]
		[GIR (name = "RTSPAddress")]
		public class Address {
			public string address;
			public int n_ports;
			public Gst.RTSPServer.AddressPool pool;
			public uint16 port;
			public uint8 ttl;
			public Gst.RTSPServer.Address copy ();
			public void free ();
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPAddressPool", lower_case_cprefix = "gst_rtsp_address_pool_", type_id = "gst_rtsp_address_pool_get_type ()")]
		[GIR (name = "RTSPAddressPool")]
		public class AddressPool : GLib.Object {
			[CCode (cname = "GST_RTSP_ADDRESS_POOL_ANY_IPV4")]
			public const string ANY_IPV4;
			[CCode (cname = "GST_RTSP_ADDRESS_POOL_ANY_IPV6")]
			public const string ANY_IPV6;
			[CCode (has_construct_function = false)]
			public AddressPool ();
			public Gst.RTSPServer.Address? acquire_address (Gst.RTSPServer.AddressFlags flags, int n_ports);
			public bool add_range (string min_address, string max_address, uint16 min_port, uint16 max_port, uint8 ttl);
			public void clear ();
			public void dump ();
			public bool has_unicast_addresses ();
			public Gst.RTSPServer.AddressPoolResult reserve_address (string ip_address, uint port, uint n_ports, uint ttl, out Gst.RTSPServer.Address address);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPAuth", lower_case_cprefix = "gst_rtsp_auth_", type_id = "gst_rtsp_auth_get_type ()")]
		[GIR (name = "RTSPAuth")]
		public class Auth : GLib.Object {
			[CCode (cname = "GST_RTSP_AUTH_CHECK_CONNECT")]
			public const string CHECK_CONNECT;
			[CCode (cname = "GST_RTSP_AUTH_CHECK_MEDIA_FACTORY_ACCESS")]
			public const string CHECK_MEDIA_FACTORY_ACCESS;
			[CCode (cname = "GST_RTSP_AUTH_CHECK_MEDIA_FACTORY_CONSTRUCT")]
			public const string CHECK_MEDIA_FACTORY_CONSTRUCT;
			[CCode (cname = "GST_RTSP_AUTH_CHECK_TRANSPORT_CLIENT_SETTINGS")]
			public const string CHECK_TRANSPORT_CLIENT_SETTINGS;
			[CCode (cname = "GST_RTSP_AUTH_CHECK_URL")]
			public const string CHECK_URL;
			[CCode (has_construct_function = false)]
			public Auth ();
			public void add_basic (string basic, Gst.RTSPServer.Token token);
			[Version (since = "1.12")]
			public void add_digest (string user, string pass, Gst.RTSPServer.Token token);
			[NoWrapper]
			public virtual bool authenticate (Gst.RTSPServer.Context ctx);
			[NoWrapper]
			public virtual bool check (Gst.RTSPServer.Context ctx, string check);
			[CCode (cname = "gst_rtsp_auth_check")]
			public static bool check_current_context (string check);
			[NoWrapper]
			public virtual void generate_authenticate_header (Gst.RTSPServer.Context ctx);
			public Gst.RTSPServer.Token? get_default_token ();
			[Version (since = "1.12")]
			public Gst.RTSP.AuthMethod get_supported_methods ();
			public GLib.TlsAuthenticationMode get_tls_authentication_mode ();
			public GLib.TlsCertificate? get_tls_certificate ();
			[Version (since = "1.6")]
			public GLib.TlsDatabase? get_tls_database ();
			public static string make_basic (string user, string pass);
			public void remove_basic (string basic);
			[Version (since = "1.12")]
			public void remove_digest (string user);
			public void set_default_token (Gst.RTSPServer.Token? token);
			[Version (since = "1.12")]
			public void set_supported_methods (Gst.RTSP.AuthMethod methods);
			[Version (since = "1.6")]
			public void set_tls_authentication_mode (GLib.TlsAuthenticationMode mode);
			public void set_tls_certificate (GLib.TlsCertificate? cert);
			public void set_tls_database (GLib.TlsDatabase? database);
			[Version (since = "1.6")]
			public virtual signal bool accept_certificate (GLib.TlsConnection connection, GLib.TlsCertificate peer_cert, GLib.TlsCertificateFlags errors);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPClient", lower_case_cprefix = "gst_rtsp_client_", type_id = "gst_rtsp_client_get_type ()")]
		[GIR (name = "RTSPClient")]
		public class Client : GLib.Object {
			[CCode (has_construct_function = false)]
			public Client ();
			public uint attach (GLib.MainContext? context);
			[Version (since = "1.4")]
			public void close ();
			[NoWrapper]
			public virtual bool configure_client_media (Gst.RTSPServer.Media media, Gst.RTSPServer.Stream stream, Gst.RTSPServer.Context ctx);
			[NoWrapper]
			public virtual bool configure_client_transport (Gst.RTSPServer.Context ctx, Gst.RTSP.Transport ct);
			[NoWrapper]
			public virtual Gst.SDP.Message create_sdp (Gst.RTSPServer.Media media);
			public Gst.RTSPServer.Auth? get_auth ();
			public unowned Gst.RTSP.Connection? get_connection ();
			public Gst.RTSPServer.MountPoints? get_mount_points ();
			public Gst.RTSPServer.SessionPool? get_session_pool ();
			public Gst.RTSPServer.ThreadPool? get_thread_pool ();
			public Gst.RTSP.Result handle_message (Gst.RTSP.Message message);
			[NoWrapper]
			public virtual bool handle_sdp (Gst.RTSPServer.Context ctx, Gst.RTSPServer.Media media, Gst.SDP.Message sdp);
			[NoWrapper]
			public virtual string make_path_from_uri (Gst.RTSP.Url uri);
			[NoWrapper]
			public virtual Gst.RTSP.Result params_get (Gst.RTSPServer.Context ctx);
			[NoWrapper]
			public virtual Gst.RTSP.Result params_set (Gst.RTSPServer.Context ctx);
			public GLib.List<Gst.RTSPServer.Session> session_filter (Gst.RTSPServer.ClientSessionFilterFunc? func);
			public void set_auth (Gst.RTSPServer.Auth? auth);
			public bool set_connection (owned Gst.RTSP.Connection conn);
			public void set_mount_points (Gst.RTSPServer.MountPoints? mounts);
			public void set_send_func (owned Gst.RTSPServer.ClientSendFunc func);
			public void set_session_pool (Gst.RTSPServer.SessionPool? pool);
			public void set_thread_pool (Gst.RTSPServer.ThreadPool? pool);
			[NoWrapper]
			public virtual void tunnel_http_response (Gst.RTSP.Message request, Gst.RTSP.Message response);
			[NoAccessorMethod]
			public bool drop_backlog { get; set; }
			public Gst.RTSPServer.MountPoints mount_points { owned get; set; }
			public Gst.RTSPServer.SessionPool session_pool { owned get; set; }
			public virtual signal void announce_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.6")]
			public virtual signal string check_requirements (Gst.RTSPServer.Context ctx, [CCode (array_length = false, array_null_terminated = true)] string[] arr);
			public virtual signal void closed ();
			public virtual signal void describe_request (Gst.RTSPServer.Context ctx);
			public virtual signal void get_parameter_request (Gst.RTSPServer.Context ctx);
			public virtual signal void handle_response (Gst.RTSPServer.Context ctx);
			public virtual signal void new_session (Gst.RTSPServer.Session session);
			public virtual signal void options_request (Gst.RTSPServer.Context ctx);
			public virtual signal void pause_request (Gst.RTSPServer.Context ctx);
			public virtual signal void play_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_announce_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_describe_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_get_parameter_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_options_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_pause_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_play_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_record_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_set_parameter_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_setup_request (Gst.RTSPServer.Context ctx);
			[Version (since = "1.12")]
			public virtual signal Gst.RTSP.StatusCode pre_teardown_request (Gst.RTSPServer.Context ctx);
			public virtual signal void record_request (Gst.RTSPServer.Context ctx);
			[HasEmitter]
			public virtual signal void send_message (Gst.RTSPServer.Session ctx, Gst.RTSP.Message response);
			public virtual signal void set_parameter_request (Gst.RTSPServer.Context ctx);
			public virtual signal void setup_request (Gst.RTSPServer.Context ctx);
			public virtual signal void teardown_request (Gst.RTSPServer.Context ctx);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPMedia", lower_case_cprefix = "gst_rtsp_media_", type_id = "gst_rtsp_media_get_type ()")]
		[GIR (name = "RTSPMedia")]
		public class Media : GLib.Object {
			[CCode (has_construct_function = false)]
			public Media (owned Gst.Element element);
			public void collect_streams ();
			[NoWrapper]
			public virtual bool convert_range (Gst.RTSP.TimeRange range, Gst.RTSP.RangeUnit unit);
			[CCode (returns_floating_reference = true)]
			[NoWrapper]
			public virtual Gst.Element create_rtpbin ();
			public unowned Gst.RTSPServer.Stream create_stream (Gst.Element payloader, Gst.Pad pad);
			public unowned Gst.RTSPServer.Stream? find_stream (string control);
			public Gst.RTSPServer.AddressPool? get_address_pool ();
			public Gst.ClockTime get_base_time ();
			public uint get_buffer_size ();
			public Gst.Clock? get_clock ();
			public Gst.Element get_element ();
			public uint get_latency ();
			public string? get_multicast_iface ();
			public Gst.RTSPServer.Permissions? get_permissions ();
			public Gst.RTSP.Profile get_profiles ();
			public Gst.RTSP.LowerTrans get_protocols ();
			[Version (since = "1.8")]
			public Gst.RTSPServer.PublishClockMode get_publish_clock_mode ();
			public string? get_range_string (bool play, Gst.RTSP.RangeUnit unit);
			public Gst.ClockTime get_retransmission_time ();
			public Gst.RTSPServer.MediaStatus get_status ();
			public unowned Gst.RTSPServer.Stream? get_stream (uint idx);
			public Gst.RTSPServer.SuspendMode get_suspend_mode ();
			public Gst.Net.TimeProvider get_time_provider (string? address, uint16 port);
			public Gst.RTSPServer.TransportMode get_transport_mode ();
			[NoWrapper]
			public virtual bool handle_message (Gst.Message message);
			public virtual bool handle_sdp (Gst.SDP.Message sdp);
			public bool is_eos_shutdown ();
			public bool is_reusable ();
			public bool is_shared ();
			public bool is_stop_on_disconnect ();
			public bool is_time_provider ();
			public uint n_streams ();
			public virtual bool prepare (owned Gst.RTSPServer.Thread? thread);
			[NoWrapper]
			public virtual bool query_position (int64 position);
			[NoWrapper]
			public virtual bool query_stop (int64 stop);
			public bool seek (Gst.RTSP.TimeRange range);
			public void set_address_pool (Gst.RTSPServer.AddressPool? pool);
			public void set_buffer_size (uint size);
			public void set_clock (Gst.Clock? clock);
			public void set_eos_shutdown (bool eos_shutdown);
			public void set_latency (uint latency);
			public void set_multicast_iface (string? multicast_iface);
			public void set_permissions (Gst.RTSPServer.Permissions? permissions);
			public void set_pipeline_state (Gst.State state);
			public void set_profiles (Gst.RTSP.Profile profiles);
			public void set_protocols (Gst.RTSP.LowerTrans protocols);
			[Version (since = "1.8")]
			public void set_publish_clock_mode (Gst.RTSPServer.PublishClockMode mode);
			public void set_retransmission_time (Gst.ClockTime time);
			public void set_reusable (bool reusable);
			public void set_shared (bool shared);
			public bool set_state (Gst.State state, GLib.GenericArray<Gst.RTSPServer.StreamTransport> transports);
			public void set_stop_on_disconnect (bool stop_on_disconnect);
			public void set_suspend_mode (Gst.RTSPServer.SuspendMode mode);
			public void set_transport_mode (Gst.RTSPServer.TransportMode mode);
			[NoWrapper]
			public virtual bool setup_rtpbin (Gst.Element rtpbin);
			public virtual bool setup_sdp (Gst.SDP.Message sdp, Gst.RTSPServer.SDPInfo info);
			public virtual bool suspend ();
			public void take_pipeline (owned Gst.Pipeline pipeline);
			public virtual bool unprepare ();
			public virtual bool unsuspend ();
			public void use_time_provider (bool time_provider);
			public uint buffer_size { get; set; }
			public Gst.Clock clock { owned get; set; }
			public Gst.Element element { owned get; construct; }
			[NoAccessorMethod]
			public bool eos_shutdown { get; set; }
			public uint latency { get; set; }
			public Gst.RTSP.Profile profiles { get; set; }
			public Gst.RTSP.LowerTrans protocols { get; set; }
			[NoAccessorMethod]
			public bool reusable { get; set; }
			[NoAccessorMethod]
			public bool shared { get; set; }
			[NoAccessorMethod]
			public bool stop_on_disconnect { get; set; }
			public Gst.RTSPServer.SuspendMode suspend_mode { get; set; }
			[NoAccessorMethod]
			public bool time_provider { get; set; }
			public Gst.RTSPServer.TransportMode transport_mode { get; set; }
			public virtual signal void new_state (int state);
			public virtual signal void new_stream (Gst.RTSPServer.Stream stream);
			public virtual signal void prepared ();
			public virtual signal void removed_stream (Gst.RTSPServer.Stream stream);
			public virtual signal void target_state (int state);
			public virtual signal void unprepared ();
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPMediaFactory", lower_case_cprefix = "gst_rtsp_media_factory_", type_id = "gst_rtsp_media_factory_get_type ()")]
		[GIR (name = "RTSPMediaFactory")]
		public class MediaFactory : GLib.Object {
			[CCode (has_construct_function = false)]
			public MediaFactory ();
			public void add_role (string role, string fieldname, ...);
			[NoWrapper]
			public virtual void configure (Gst.RTSPServer.Media media);
			public virtual Gst.RTSPServer.Media @construct (Gst.RTSP.Url url);
			[CCode (returns_floating_reference = true)]
			public virtual Gst.Element create_element (Gst.RTSP.Url url);
			[CCode (returns_floating_reference = true)]
			[NoWrapper]
			public virtual Gst.Pipeline create_pipeline (Gst.RTSPServer.Media media);
			[NoWrapper]
			public virtual string gen_key (Gst.RTSP.Url url);
			public Gst.RTSPServer.AddressPool? get_address_pool ();
			public uint get_buffer_size ();
			[Version (since = "1.8")]
			public Gst.Clock get_clock ();
			public uint get_latency ();
			public string? get_launch ();
			[Version (since = "1.6")]
			public GLib.Type get_media_gtype ();
			public string? get_multicast_iface ();
			public Gst.RTSPServer.Permissions? get_permissions ();
			public Gst.RTSP.Profile get_profiles ();
			public Gst.RTSP.LowerTrans get_protocols ();
			[Version (since = "1.8")]
			public Gst.RTSPServer.PublishClockMode get_publish_clock_mode ();
			public Gst.ClockTime get_retransmission_time ();
			public Gst.RTSPServer.SuspendMode get_suspend_mode ();
			public Gst.RTSPServer.TransportMode get_transport_mode ();
			public bool is_eos_shutdown ();
			public bool is_shared ();
			public bool is_stop_on_disonnect ();
			public void set_address_pool (Gst.RTSPServer.AddressPool? pool);
			public void set_buffer_size (uint size);
			[Version (since = "1.8")]
			public void set_clock (Gst.Clock? clock);
			public void set_eos_shutdown (bool eos_shutdown);
			public void set_latency (uint latency);
			public void set_launch (string launch);
			[Version (since = "1.6")]
			public void set_media_gtype (GLib.Type media_gtype);
			public void set_multicast_iface (string? multicast_iface);
			public void set_permissions (Gst.RTSPServer.Permissions? permissions);
			public void set_profiles (Gst.RTSP.Profile profiles);
			public void set_protocols (Gst.RTSP.LowerTrans protocols);
			[Version (since = "1.8")]
			public void set_publish_clock_mode (Gst.RTSPServer.PublishClockMode mode);
			public void set_retransmission_time (Gst.ClockTime time);
			public void set_shared (bool shared);
			public void set_stop_on_disconnect (bool stop_on_disconnect);
			public void set_suspend_mode (Gst.RTSPServer.SuspendMode mode);
			public void set_transport_mode (Gst.RTSPServer.TransportMode mode);
			public uint buffer_size { get; set; }
			public Gst.Clock clock { owned get; set; }
			[NoAccessorMethod]
			public bool eos_shutdown { get; set; }
			public uint latency { get; set; }
			public string launch { owned get; set; }
			public Gst.RTSP.Profile profiles { get; set; }
			public Gst.RTSP.LowerTrans protocols { get; set; }
			[NoAccessorMethod]
			public bool shared { get; set; }
			[NoAccessorMethod]
			public bool stop_on_disconnect { get; set; }
			public Gst.RTSPServer.SuspendMode suspend_mode { get; set; }
			public Gst.RTSPServer.TransportMode transport_mode { get; set; }
			public virtual signal void media_configure (Gst.RTSPServer.Media media);
			public virtual signal void media_constructed (Gst.RTSPServer.Media media);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPMediaFactoryURI", lower_case_cprefix = "gst_rtsp_media_factory_uri_", type_id = "gst_rtsp_media_factory_uri_get_type ()")]
		[GIR (name = "RTSPMediaFactoryURI")]
		public class MediaFactoryURI : Gst.RTSPServer.MediaFactory {
			[CCode (has_construct_function = false)]
			public MediaFactoryURI ();
			public string get_uri ();
			public void set_uri (string uri);
			public string uri { owned get; set; }
			[NoAccessorMethod]
			public bool use_gstpay { get; set; }
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPMountPoints", lower_case_cprefix = "gst_rtsp_mount_points_", type_id = "gst_rtsp_mount_points_get_type ()")]
		[GIR (name = "RTSPMountPoints")]
		public class MountPoints : GLib.Object {
			[CCode (has_construct_function = false)]
			public MountPoints ();
			public void add_factory (string path, owned Gst.RTSPServer.MediaFactory factory);
			public virtual string? make_path (Gst.RTSP.Url url);
			public Gst.RTSPServer.MediaFactory match (string path, out int matched);
			public void remove_factory (string path);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPPermissions", copy_function = "g_boxed_copy", free_function = "g_boxed_free", lower_case_cprefix = "gst_rtsp_permissions_", type_id = "gst_rtsp_permissions_get_type ()")]
		[Compact]
		[GIR (name = "RTSPPermissions")]
		public class Permissions : Gst.MiniObject {
			[CCode (cname = "GST_RTSP_PERM_MEDIA_FACTORY_ACCESS")]
			public const string MEDIA_FACTORY_ACCESS;
			[CCode (cname = "GST_RTSP_PERM_MEDIA_FACTORY_CONSTRUCT")]
			public const string MEDIA_FACTORY_CONSTRUCT;
			[CCode (has_construct_function = false)]
			public Permissions ();
			public void add_role (string role, string fieldname, ...);
			public void add_role_valist (string role, string fieldname, va_list var_args);
			public unowned Gst.Structure get_role (string role);
			public bool is_allowed (string role, string permission);
			public void remove_role (string role);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPServer", lower_case_cprefix = "gst_rtsp_server_", type_id = "gst_rtsp_server_get_type ()")]
		[GIR (name = "RTSPServer")]
		public class Server : GLib.Object {
			[CCode (has_construct_function = false)]
			public Server ();
			public uint attach (GLib.MainContext? context);
			public GLib.List<Gst.RTSPServer.Client> client_filter (Gst.RTSPServer.ServerClientFilterFunc? func);
			[NoWrapper]
			public virtual Gst.RTSPServer.Client create_client ();
			public GLib.Socket create_socket (GLib.Cancellable? cancellable = null) throws GLib.Error;
			public GLib.Source create_source (GLib.Cancellable? cancellable = null) throws GLib.Error;
			public string? get_address ();
			public Gst.RTSPServer.Auth? get_auth ();
			public int get_backlog ();
			public int get_bound_port ();
			public Gst.RTSPServer.MountPoints? get_mount_points ();
			public string? get_service ();
			public Gst.RTSPServer.SessionPool? get_session_pool ();
			public Gst.RTSPServer.ThreadPool? get_thread_pool ();
			public static bool io_func (GLib.Socket socket, GLib.IOCondition condition, Gst.RTSPServer.Server server);
			public void set_address (string address);
			public void set_auth (Gst.RTSPServer.Auth? auth);
			public void set_backlog (int backlog);
			public void set_mount_points (Gst.RTSPServer.MountPoints? mounts);
			public void set_service (string service);
			public void set_session_pool (Gst.RTSPServer.SessionPool? pool);
			public void set_thread_pool (Gst.RTSPServer.ThreadPool? pool);
			public bool transfer_connection (owned GLib.Socket socket, string ip, int port, string? initial_buffer);
			public string address { owned get; set; }
			public int backlog { get; set; }
			public int bound_port { get; }
			public Gst.RTSPServer.MountPoints mount_points { owned get; set; }
			public string service { owned get; set; }
			public Gst.RTSPServer.SessionPool session_pool { owned get; set; }
			public virtual signal void client_connected (Gst.RTSPServer.Client client);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPSession", lower_case_cprefix = "gst_rtsp_session_", type_id = "gst_rtsp_session_get_type ()")]
		[GIR (name = "RTSPSession")]
		public class Session : GLib.Object {
			[CCode (has_construct_function = false)]
			public Session (string sessionid);
			public void allow_expire ();
			public GLib.List<Gst.RTSPServer.SessionMedia> filter (Gst.RTSPServer.SessionFilterFunc? func);
			public string? get_header ();
			public unowned Gst.RTSPServer.SessionMedia? get_media (string path, out int matched);
			public unowned string? get_sessionid ();
			public uint get_timeout ();
			[Version (deprecated = true)]
			public bool is_expired (GLib.TimeVal now);
			public bool is_expired_usec (int64 now);
			public unowned Gst.RTSPServer.SessionMedia manage_media (string path, owned Gst.RTSPServer.Media media);
			[Version (deprecated = true)]
			public int next_timeout (GLib.TimeVal now);
			public int next_timeout_usec (int64 now);
			public void prevent_expire ();
			public bool release_media (Gst.RTSPServer.SessionMedia media);
			public void set_timeout (uint timeout);
			public void touch ();
			public string sessionid { get; construct; }
			public uint timeout { get; set; }
			[NoAccessorMethod]
			public bool timeout_always_visible { get; set; }
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPSessionMedia", lower_case_cprefix = "gst_rtsp_session_media_", type_id = "gst_rtsp_session_media_get_type ()")]
		[GIR (name = "RTSPSessionMedia")]
		public class SessionMedia : GLib.Object {
			[CCode (has_construct_function = false)]
			public SessionMedia (string path, owned Gst.RTSPServer.Media media);
			public bool alloc_channels (out Gst.RTSP.Range range);
			public Gst.ClockTime get_base_time ();
			public unowned Gst.RTSPServer.Media? get_media ();
			public string? get_rtpinfo ();
			public Gst.RTSP.State get_rtsp_state ();
			public unowned Gst.RTSPServer.StreamTransport? get_transport (uint idx);
			public bool matches (string path, out int matched);
			public void set_rtsp_state (Gst.RTSP.State state);
			public bool set_state (Gst.State state);
			public unowned Gst.RTSPServer.StreamTransport set_transport (Gst.RTSPServer.Stream stream, owned Gst.RTSP.Transport tr);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPSessionPool", lower_case_cprefix = "gst_rtsp_session_pool_", type_id = "gst_rtsp_session_pool_get_type ()")]
		[GIR (name = "RTSPSessionPool")]
		public class SessionPool : GLib.Object {
			[CCode (has_construct_function = false)]
			public SessionPool ();
			public uint cleanup ();
			public Gst.RTSPServer.Session? create ();
			[NoWrapper]
			public virtual Gst.RTSPServer.Session create_session (string id);
			[NoWrapper]
			public virtual string create_session_id ();
			public GLib.Source create_watch ();
			public GLib.List<Gst.RTSPServer.Session> filter (Gst.RTSPServer.SessionPoolFilterFunc? func);
			public Gst.RTSPServer.Session? find (string sessionid);
			public uint get_max_sessions ();
			public uint get_n_sessions ();
			public bool remove (Gst.RTSPServer.Session sess);
			public void set_max_sessions (uint max);
			public uint max_sessions { get; set; }
			public virtual signal void session_removed (Gst.RTSPServer.Session session);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPStream", lower_case_cprefix = "gst_rtsp_stream_", type_id = "gst_rtsp_stream_get_type ()")]
		[GIR (name = "RTSPStream")]
		public class Stream : GLib.Object {
			[CCode (has_construct_function = false)]
			public Stream (uint idx, Gst.Element payloader, Gst.Pad pad);
			public bool add_transport (Gst.RTSPServer.StreamTransport trans);
			[Version (deprecated = true)]
			public bool allocate_udp_sockets (GLib.SocketFamily family, Gst.RTSP.Transport transport, bool use_client_setttings);
			public Gst.RTSPServer.AddressPool? get_address_pool ();
			[Version (since = "1.6")]
			public uint get_buffer_size ();
			public Gst.Caps? get_caps ();
			public string? get_control ();
			public uint16 get_current_seqnum ();
			public int get_dscp_qos ();
			public uint get_index ();
			public Gst.Bin? get_joined_bin ();
			public uint get_mtu ();
			public Gst.RTSPServer.Address? get_multicast_address (GLib.SocketFamily family);
			public string? get_multicast_iface ();
			public Gst.RTSP.Profile get_profiles ();
			public Gst.RTSP.LowerTrans get_protocols ();
			public uint get_pt ();
			[Version (since = "1.8")]
			public Gst.RTSPServer.PublishClockMode get_publish_clock_mode ();
			public uint get_retransmission_pt ();
			public Gst.ClockTime get_retransmission_time ();
			public GLib.Socket? get_rtcp_socket (GLib.SocketFamily family);
			public GLib.Socket? get_rtp_socket (GLib.SocketFamily family);
			public bool get_rtpinfo (out uint rtptime, out uint seq, out uint clock_rate, out Gst.ClockTime running_time);
			public GLib.Object get_rtpsession ();
			public void get_server_port (out Gst.RTSP.Range server_port, GLib.SocketFamily family);
			public Gst.Pad? get_sinkpad ();
			public Gst.Pad? get_srcpad ();
			public Gst.Element get_srtp_encoder ();
			public void get_ssrc (out uint ssrc);
			public bool has_control (string? control);
			public bool is_blocking ();
			public bool is_client_side ();
			public bool is_transport_supported (Gst.RTSP.Transport transport);
			public bool join_bin (Gst.Bin bin, Gst.Element rtpbin, Gst.State state);
			public bool leave_bin (Gst.Bin bin, Gst.Element rtpbin);
			public bool query_position (out int64 position);
			public bool query_stop (out int64 stop);
			public Gst.FlowReturn recv_rtcp (owned Gst.Buffer buffer);
			public Gst.FlowReturn recv_rtp (owned Gst.Buffer buffer);
			public bool remove_transport (Gst.RTSPServer.StreamTransport trans);
			[Version (since = "1.6")]
			public Gst.Element? request_aux_sender (uint sessid);
			public Gst.RTSPServer.Address? reserve_address (string address, uint port, uint n_ports, uint ttl);
			public void set_address_pool (Gst.RTSPServer.AddressPool? pool);
			public bool set_blocked (bool blocked);
			[Version (since = "1.6")]
			public void set_buffer_size (uint size);
			public void set_client_side (bool client_side);
			public void set_control (string? control);
			public void set_dscp_qos (int dscp_qos);
			public void set_mtu (uint mtu);
			public void set_multicast_iface (string? multicast_iface);
			public void set_profiles (Gst.RTSP.Profile profiles);
			public void set_protocols (Gst.RTSP.LowerTrans protocols);
			public void set_pt_map (uint pt, Gst.Caps caps);
			[Version (since = "1.8")]
			public void set_publish_clock_mode (Gst.RTSPServer.PublishClockMode mode);
			public void set_retransmission_pt (uint rtx_pt);
			public void set_retransmission_time (Gst.ClockTime time);
			public void set_seqnum_offset (uint16 seqnum);
			public GLib.List<Gst.RTSPServer.StreamTransport> transport_filter (Gst.RTSPServer.StreamTransportFilterFunc? func);
			public bool update_crypto (uint ssrc, Gst.Caps? crypto);
			public string control { owned get; set; }
			public Gst.RTSP.Profile profiles { get; set; }
			public Gst.RTSP.LowerTrans protocols { get; set; }
			public signal void new_rtcp_encoder (Gst.Element object);
			public signal void new_rtp_encoder (Gst.Element object);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPStreamTransport", lower_case_cprefix = "gst_rtsp_stream_transport_", type_id = "gst_rtsp_stream_transport_get_type ()")]
		[GIR (name = "RTSPStreamTransport")]
		public class StreamTransport : GLib.Object {
			[CCode (has_construct_function = false)]
			public StreamTransport (Gst.RTSPServer.Stream stream, owned Gst.RTSP.Transport tr);
			public string? get_rtpinfo (Gst.ClockTime start_time);
			public unowned Gst.RTSPServer.Stream? get_stream ();
			public unowned Gst.RTSP.Transport? get_transport ();
			public unowned Gst.RTSP.Url? get_url ();
			public bool is_timed_out ();
			public void keep_alive ();
			public Gst.FlowReturn recv_data (uint channel, owned Gst.Buffer buffer);
			public bool send_rtcp (Gst.Buffer buffer);
			public bool send_rtp (Gst.Buffer buffer);
			public bool set_active (bool active);
			public void set_callbacks (Gst.RTSPServer.SendFunc send_rtp, owned Gst.RTSPServer.SendFunc send_rtcp);
			public void set_keepalive (owned Gst.RTSPServer.KeepAliveFunc keep_alive);
			public void set_timed_out (bool timedout);
			public void set_transport (owned Gst.RTSP.Transport tr);
			public void set_url (Gst.RTSP.Url? url);
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPThread", copy_function = "g_boxed_copy", free_function = "g_boxed_free", lower_case_cprefix = "gst_rtsp_thread_", type_id = "gst_rtsp_thread_get_type ()")]
		[Compact]
		[GIR (name = "RTSPThread")]
		public class Thread : Gst.MiniObject {
			public GLib.MainContext context;
			public GLib.MainLoop loop;
			public Gst.RTSPServer.ThreadType type;
			[CCode (has_construct_function = false)]
			public Thread (Gst.RTSPServer.ThreadType type);
			public bool reuse ();
			public void stop ();
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPThreadPool", lower_case_cprefix = "gst_rtsp_thread_pool_", type_id = "gst_rtsp_thread_pool_get_type ()")]
		[GIR (name = "RTSPThreadPool")]
		public class ThreadPool : GLib.Object {
			[CCode (has_construct_function = false)]
			public ThreadPool ();
			public static void cleanup ();
			[NoWrapper]
			public virtual void configure_thread (Gst.RTSPServer.Thread thread, Gst.RTSPServer.Context ctx);
			public int get_max_threads ();
			public virtual Gst.RTSPServer.Thread? get_thread (Gst.RTSPServer.ThreadType type, Gst.RTSPServer.Context ctx);
			public void set_max_threads (int max_threads);
			[NoWrapper]
			public virtual void thread_enter (Gst.RTSPServer.Thread thread);
			[NoWrapper]
			public virtual void thread_leave (Gst.RTSPServer.Thread thread);
			public int max_threads { get; set; }
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPToken", copy_function = "g_boxed_copy", free_function = "g_boxed_free", lower_case_cprefix = "gst_rtsp_token_", type_id = "gst_rtsp_token_get_type ()")]
		[Compact]
		[GIR (name = "RTSPToken")]
		public class Token : Gst.MiniObject {
			[CCode (cname = "GST_RTSP_TOKEN_MEDIA_FACTORY_ROLE")]
			public const string MEDIA_FACTORY_ROLE;
			[CCode (cname = "GST_RTSP_TOKEN_TRANSPORT_CLIENT_SETTINGS")]
			public const string TRANSPORT_CLIENT_SETTINGS;
			[CCode (has_construct_function = false)]
			public Token (string firstfield, ...);
			[CCode (has_construct_function = false)]
			public Token.empty ();
			public unowned string? get_string (string field);
			public unowned Gst.Structure get_structure ();
			public bool is_allowed (string field);
			[CCode (has_construct_function = false)]
			public Token.valist (string firstfield, va_list var_args);
			public unowned Gst.Structure writable_structure ();
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPContext", has_type_id = false)]
		[GIR (name = "RTSPContext")]
		public struct Context {
			public weak Gst.RTSPServer.Server server;
			public weak Gst.RTSP.Connection conn;
			public weak Gst.RTSPServer.Client client;
			public Gst.RTSP.Message request;
			public weak Gst.RTSP.Url uri;
			public Gst.RTSP.Method method;
			public weak Gst.RTSPServer.Auth auth;
			public weak Gst.RTSPServer.Token token;
			public weak Gst.RTSPServer.Session session;
			public weak Gst.RTSPServer.SessionMedia sessmedia;
			public weak Gst.RTSPServer.MediaFactory factory;
			public weak Gst.RTSPServer.Media media;
			public weak Gst.RTSPServer.Stream stream;
			public Gst.RTSP.Message response;
			public weak Gst.RTSPServer.StreamTransport trans;
			[CCode (cname = "gst_rtsp_context_pop_current")]
			public void pop_current ();
			[CCode (cname = "gst_rtsp_context_push_current")]
			public void push_current ();
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstSDPInfo", has_type_id = false)]
		[GIR (name = "SDPInfo")]
		public struct SDPInfo {
			public bool is_ipv6;
			public weak string server_ip;
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPAddressFlags", cprefix = "GST_RTSP_ADDRESS_FLAG_", has_type_id = false)]
		[Flags]
		[GIR (name = "RTSPAddressFlags")]
		public enum AddressFlags {
			NONE,
			IPV4,
			IPV6,
			EVEN_PORT,
			MULTICAST,
			UNICAST
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPAddressPoolResult", cprefix = "GST_RTSP_ADDRESS_POOL_", has_type_id = false)]
		[GIR (name = "RTSPAddressPoolResult")]
		public enum AddressPoolResult {
			OK,
			EINVAL,
			ERESERVED,
			ERANGE,
			ELAST
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPFilterResult", cprefix = "GST_RTSP_FILTER_", has_type_id = false)]
		[GIR (name = "RTSPFilterResult")]
		public enum FilterResult {
			REMOVE,
			KEEP,
			REF
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPMediaStatus", cprefix = "GST_RTSP_MEDIA_STATUS_", has_type_id = false)]
		[GIR (name = "RTSPMediaStatus")]
		public enum MediaStatus {
			UNPREPARED,
			UNPREPARING,
			PREPARING,
			PREPARED,
			SUSPENDED,
			ERROR
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPPublishClockMode", cprefix = "GST_RTSP_PUBLISH_CLOCK_MODE_", type_id = "gst_rtsp_publish_clock_mode_get_type ()")]
		[GIR (name = "RTSPPublishClockMode")]
		public enum PublishClockMode {
			NONE,
			CLOCK,
			CLOCK_AND_OFFSET
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPSuspendMode", cprefix = "GST_RTSP_SUSPEND_MODE_", type_id = "gst_rtsp_suspend_mode_get_type ()")]
		[GIR (name = "RTSPSuspendMode")]
		public enum SuspendMode {
			NONE,
			PAUSE,
			RESET
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPThreadType", cprefix = "GST_RTSP_THREAD_TYPE_", has_type_id = false)]
		[GIR (name = "RTSPThreadType")]
		public enum ThreadType {
			CLIENT,
			MEDIA
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPTransportMode", cprefix = "GST_RTSP_TRANSPORT_MODE_", type_id = "gst_rtsp_transport_mode_get_type ()")]
		[Flags]
		[GIR (name = "RTSPTransportMode")]
		public enum TransportMode {
			PLAY,
			RECORD
		}
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPClientSendFunc", instance_pos = 3.9)]
		public delegate bool ClientSendFunc (Gst.RTSPServer.Client client, Gst.RTSP.Message message, bool close);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPClientSessionFilterFunc", instance_pos = 2.9)]
		public delegate Gst.RTSPServer.FilterResult ClientSessionFilterFunc (Gst.RTSPServer.Client client, Gst.RTSPServer.Session sess);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPKeepAliveFunc", instance_pos = 0.9)]
		public delegate void KeepAliveFunc ();
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPSendFunc", instance_pos = 2.9)]
		public delegate bool SendFunc (Gst.Buffer buffer, uint8 channel);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPServerClientFilterFunc", instance_pos = 2.9)]
		public delegate Gst.RTSPServer.FilterResult ServerClientFilterFunc (Gst.RTSPServer.Server server, Gst.RTSPServer.Client client);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPSessionFilterFunc", instance_pos = 2.9)]
		public delegate Gst.RTSPServer.FilterResult SessionFilterFunc (Gst.RTSPServer.Session sess, Gst.RTSPServer.SessionMedia media);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPSessionPoolFilterFunc", instance_pos = 2.9)]
		public delegate Gst.RTSPServer.FilterResult SessionPoolFilterFunc (Gst.RTSPServer.SessionPool pool, Gst.RTSPServer.Session session);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPSessionPoolFunc", instance_pos = 1.9)]
		public delegate bool SessionPoolFunc (Gst.RTSPServer.SessionPool pool);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "GstRTSPStreamTransportFilterFunc", instance_pos = 2.9)]
		public delegate Gst.RTSPServer.FilterResult StreamTransportFilterFunc (Gst.RTSPServer.Stream stream, Gst.RTSPServer.StreamTransport trans);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "gst_rtsp_context_get_type")]
		public static GLib.Type context_get_type ();
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "gst_rtsp_params_get")]
		public static Gst.RTSP.Result params_get (Gst.RTSPServer.Client client, Gst.RTSPServer.Context ctx);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "gst_rtsp_params_set")]
		public static Gst.RTSP.Result params_set (Gst.RTSPServer.Client client, Gst.RTSPServer.Context ctx);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "gst_rtsp_sdp_from_media")]
		public static bool sdp_from_media (Gst.SDP.Message sdp, Gst.RTSPServer.SDPInfo info, Gst.RTSPServer.Media media);
		[CCode (cheader_filename = "gst/rtsp-server/rtsp-server.h", cname = "gst_rtsp_sdp_from_stream")]
		public static bool sdp_from_stream (Gst.SDP.Message sdp, Gst.RTSPServer.SDPInfo info, Gst.RTSPServer.Stream stream);
	}
}
