Layer,Module,File,Current_Name,Definitive_Name,Visibility,Notes
L0,bootstrap,launcher.sh,main (entrypoint),nexus_launcher_main,public,Script entry point
L0,bootstrap,launcher.sh,load_pod_layer,__nexus_launcher_load_pod,private,
L0,bootstrap,launcher.sh,validate_environment,__nexus_launcher_validate_env,private,
L0,bootstrap,launcher.sh,show_main_menu,nexus_launcher_menu,public,
L0,base,base_dependencies.sh,generate_uuid,nexus_base_uuid,public,
L0,base,base_dependencies.sh,get_timestamp_ms,nexus_base_timestamp_ms,public,
L0,base,base_dependencies.sh,get_timestamp_iso,nexus_base_timestamp_iso,public,
L0,base,base_dependencies.sh,log_message,nexus_log_emit,public,Funcion bootstrap de log pre-logger
L0,base,base_dependencies.sh,init_directories,nexus_base_init_dirs,public,
L0,base,base_dependencies.sh,set_operation_mode,nexus_base_set_mode,public,
L0,base,base_dependencies.sh,(internal) parse mode config,__nexus_base_parse_mode,private,
L0,xdg,xdg_paths.sh,nk_xdg_init,nexus_xdg_init,public,Inicializa todas las rutas XDG
L0,xdg,xdg_paths.sh,nk_xdg_validate_rootless,nexus_xdg_validate_rootless,public,
L0,xdg,xdg_paths.sh,nk_xdg_get_path,nexus_xdg_get_path,public,nexus_xdg_get_path <module> <type>
L0,xdg,xdg_paths.sh,nk_xdg_info,nexus_xdg_info,public,
L0,xdg,xdg_paths.sh,(internal) detect env,__nexus_xdg_detect_env,private,Termux/Linux/WSL/Docker
L0,xdg,xdg_paths.sh,(internal) create dirs,__nexus_xdg_create_dirs,private,
L0,xdg,xdg_paths.sh,(internal) set permissions,__nexus_xdg_set_permissions,private,
L1,loader,loader.sh,nexus_discover_modules,nexus_loader_discover,public,
L1,loader,loader.sh,nexus_load_module,nexus_loader_load,public,
L1,loader,loader.sh,nexus_resolve_load_order,__nexus_loader_resolve_order,private,DFS topological sort
L1,loader,loader.sh,nexus_extract_dependencies,__nexus_loader_extract_deps,private,
L1,loader,loader.sh,nexus_load_checksums,__nexus_loader_load_checksums,private,
L1,loader,loader.sh,(dfs_visit),__nexus_loader_dfs_visit,private,Recursion helper
L1,error,error_handler.sh,setup_error_traps,nexus_error_setup_traps,public,
L1,error,error_handler.sh,handle_error,nexus_error_handle,public,
L1,error,error_handler.sh,cleanup_on_exit,nexus_error_cleanup,public,
L1,error,error_handler.sh,(internal) format_stacktrace,__nexus_error_format_stacktrace,private,
L1,error,error_handler.sh,(internal) notify_error,__nexus_error_notify,private,
L1,log,logger.sh,nexus_log,nexus_log_emit,public,Función principal de logging
L1,log,logger.sh,nexus_debug,nexus_log_debug,public,
L1,log,logger.sh,nexus_info,nexus_log_info,public,
L1,log,logger.sh,nexus_success,nexus_log_success,public,
L1,log,logger.sh,nexus_warn,nexus_log_warn,public,
L1,log,logger.sh,nexus_error (log),nexus_log_error,public,
L1,log,logger.sh,nexus_fatal,nexus_log_fatal,public,Logs + exit 1
L1,log,logger.sh,(internal) format_entry,__nexus_log_format_entry,private,
L1,log,logger.sh,(internal) write_to_file,__nexus_log_write,private,
L1,logrot,logrotation.sh,rotate_logs_advanced,nexus_logrot_rotate,public,
L1,logrot,logrotation.sh,analyze_logs,nexus_logrot_analyze,public,
L1,logrot,logrotation.sh,(internal) compress_old,__nexus_logrot_compress,private,
L1,logrot,logrotation.sh,(internal) cleanup_expired,__nexus_logrot_cleanup_expired,private,
L1,core,core_utils.sh,nexus_timestamp,nexus_core_timestamp,public,Wrapper rápido
L1,core,core_utils.sh,nexus_create_dirs,nexus_core_create_dirs,public,
L1,core,core_utils.sh,nexus_apply_permissions,nexus_core_apply_permissions,public,
L1,config,config_manager.sh,nexus_config_init,nexus_config_init,public,Ya alineado
L1,config,config_manager.sh,nexus_config_get,nexus_config_get,public,Ya alineado
L1,config,config_manager.sh,nexus_config_set,nexus_config_set,public,Ya alineado
L1,config,config_manager.sh,nexus_config_load,nexus_config_load,public,
L1,config,config_manager.sh,nexus_config_save,nexus_config_save,public,
L1,config,config_manager.sh,(internal) parse_layer,__nexus_config_parse_layer,private,
L1,config,config_manager.sh,(internal) merge_configs,__nexus_config_merge,private,
L2,system,system_checks.sh,get_memory_usage,nexus_system_get_memory,public,
L2,system,system_checks.sh,get_cpu_usage,nexus_system_get_cpu,public,
L2,system,system_checks.sh,get_disk_usage,nexus_system_get_disk,public,
L2,system,system_checks.sh,check_dependencies,nexus_system_check_deps,public,
L2,system,system_checks.sh,check_architecture,nexus_system_check_arch,public,
L2,system,system_checks.sh,system_selftest,nexus_system_selftest,public,
L2,system,system_checks.sh,(internal) parse_proc_meminfo,__nexus_system_parse_meminfo,private,
L2,system,system_checks.sh,(internal) detect_container,__nexus_system_detect_container,private,
L2,sysutil,system_utils.sh,get_system_info,nexus_sysutil_get_info,public,
L2,sysutil,system_utils.sh,check_root,nexus_sysutil_check_root,public,
L2,sysutil,system_utils.sh,require_command,nexus_sysutil_require_cmd,public,
L2,validate,validator.sh,validate_string,nexus_validate_string,public,
L2,validate,validator.sh,validate_number,nexus_validate_number,public,
L2,validate,validator.sh,validate_path,nexus_validate_path,public,
L2,validate,validator.sh,validate_url,nexus_validate_url,public,
L2,validate,validator.sh,validate_ip,nexus_validate_ip,public,
L2,validate,validator.sh,validate_email,nexus_validate_email,public,
L2,validate,validator.sh,(internal) regex_match,__nexus_validate_regex,private,
L2,input,input_validator.sh,sanitize_input,nexus_input_sanitize,public,Anti-injection
L2,input,input_validator.sh,validate_user_input,nexus_input_validate,public,
L2,input,input_validator.sh,(internal) strip_control_chars,__nexus_input_strip_ctrl,private,
L2,input,input_validator.sh,(internal) detect_injection,__nexus_input_detect_injection,private,
L2,security,security_core.sh,security_init,nexus_security_init,public,
L2,security,security_core.sh,verify_checksum,nexus_security_verify_checksum,public,
L2,security,security_core.sh,generate_hmac,nexus_security_generate_hmac,public,
L2,security,security_core.sh,encrypt_data,nexus_security_encrypt,public,
L2,security,security_core.sh,decrypt_data,nexus_security_decrypt,public,
L2,security,security_core.sh,(internal) derive_key,__nexus_security_derive_key,private,
L2,security,security_core.sh,(internal) constant_time_compare,__nexus_security_ct_compare,private,
L2,cache,cache_utils.sh,cache_get,nexus_cache_get,public,
L2,cache,cache_utils.sh,cache_set,nexus_cache_set,public,
L2,cache,cache_utils.sh,cache_invalidate,nexus_cache_invalidate,public,
L2,cache,cache_utils.sh,cache_clear,nexus_cache_clear,public,
L2,cache,cache_utils.sh,cache_stats,nexus_cache_stats,public,
L2,cache,cache_utils.sh,(internal) cache_evict_lru,__nexus_cache_evict_lru,private,
L2,cache,cache_utils.sh,(internal) cache_check_ttl,__nexus_cache_check_ttl,private,
L2,file,file_operations.sh,atomic_write,nexus_file_atomic_write,public,
L2,file,file_operations.sh,safe_copy,nexus_file_safe_copy,public,
L2,file,file_operations.sh,safe_move,nexus_file_safe_move,public,
L2,file,file_operations.sh,transaction_begin,nexus_file_tx_begin,public,
L2,file,file_operations.sh,transaction_commit,nexus_file_tx_commit,public,
L2,file,file_operations.sh,transaction_rollback,nexus_file_tx_rollback,public,
L2,file,file_operations.sh,(internal) create_backup,__nexus_file_create_backup,private,
L2,file,file_operations.sh,(internal) cleanup_tmp,__nexus_file_cleanup_tmp,private,
L2,deps,deps_utils.sh,check_all_dependencies,nexus_deps_check_all,public,
L2,deps,deps_utils.sh,install_dependency,nexus_deps_install,public,
L2,deps,deps_utils.sh,(internal) resolve_package_manager,__nexus_deps_resolve_pkgmgr,private,
L2,i18n,lang_utils.sh,load_language,nexus_i18n_load,public,
L2,i18n,lang_utils.sh,get_text / t(),nexus_i18n_t,public,Shorthand: t()
L2,i18n,lang_utils.sh,set_locale,nexus_i18n_set_locale,public,
L2,i18n,lang_utils.sh,(internal) parse_msg_file,__nexus_i18n_parse_msg,private,
L2,i18n,lang_utils.sh,(internal) fallback_text,__nexus_i18n_fallback,private,
L2,net,network_utils.sh,check_connectivity,nexus_net_check,public,
L2,net,network_utils.sh,http_get,nexus_net_http_get,public,
L2,net,network_utils.sh,http_post,nexus_net_http_post,public,
L2,net,network_utils.sh,download_with_retry,nexus_net_download,public,
L2,net,network_utils.sh,(internal) select_backend,__nexus_net_select_backend,private,curl/wget
L2,net,network_utils.sh,(internal) parse_http_response,__nexus_net_parse_response,private,
L3,download,download_manager.sh,download_file,nexus_download_file,public,
L3,download,download_manager.sh,download_and_verify,nexus_download_verify,public,
L3,download,download_manager.sh,(internal) stage_download,__nexus_download_stage,private,
L3,download,download_manager.sh,(internal) verify_checksum,__nexus_download_verify_sha,private,
L3,backup,backup_utils.sh,create_backup,nexus_backup_create,public,
L3,backup,backup_utils.sh,restore_backup,nexus_backup_restore,public,
L3,backup,backup_utils.sh,list_backups,nexus_backup_list,public,
L3,backup,backup_utils.sh,(internal) compress_archive,__nexus_backup_compress,private,
L3,backup,backup_utils.sh,(internal) validate_archive,__nexus_backup_validate,private,
L3,auto,automation_utils.sh,run_automation,nexus_auto_run,public,
L3,auto,automation_utils.sh,schedule_task,nexus_auto_schedule,public,
L3,auto,automation_utils.sh,(internal) parse_schedule,__nexus_auto_parse_schedule,private,
L3,build,build_utils.sh,build_package,nexus_build_package,public,
L3,build,build_utils.sh,verify_build,nexus_build_verify,public,
L3,plugin,plugin_system.sh,load_plugin,nexus_plugin_load,public,
L3,plugin,plugin_system.sh,unload_plugin,nexus_plugin_unload,public,
L3,plugin,plugin_system.sh,list_plugins,nexus_plugin_list,public,
L3,plugin,plugin_system.sh,validate_plugin,nexus_plugin_validate,public,
L3,plugin,plugin_system.sh,execute_plugin,nexus_plugin_execute,public,
L3,plugin,plugin_system.sh,(internal) resolve_deps,__nexus_plugin_resolve_deps,private,
L3,plugin,plugin_system.sh,(internal) sandbox_exec,__nexus_plugin_sandbox_exec,private,
L3,plugin,plugin_system.sh,(internal) verify_signature,__nexus_plugin_verify_sig,private,
L4,opt,auto_optimization.sh,auto_optimize,nexus_opt_run,public,Entry point
L4,opt,auto_optimization.sh,circuit_breaker_init,nexus_cb_init,public,
L4,opt,auto_optimization.sh,circuit_breaker_allow,nexus_cb_allow,public,
L4,opt,auto_optimization.sh,circuit_breaker_success,nexus_cb_success,public,
L4,opt,auto_optimization.sh,circuit_breaker_failure,nexus_cb_failure,public,
L4,opt,auto_optimization.sh,rate_limiter_init,nexus_ratelimit_init,public,
L4,opt,auto_optimization.sh,rate_limiter_allow,nexus_ratelimit_allow,public,
L4,opt,auto_optimization.sh,retry_with_backoff,nexus_retry_backoff,public,
L4,opt,auto_optimization.sh,(internal) apply_strategy,__nexus_opt_apply_strategy,private,
L4,opt,auto_optimization.sh,(internal) gc_soft,__nexus_opt_gc_soft,private,
L4,opt,auto_optimization.sh,(internal) gc_aggressive,__nexus_opt_gc_aggressive,private,
L4,heal,auto_healing.sh,auto_healing_init,nexus_heal_init,public,
L4,heal,auto_healing.sh,auto_healing_check,nexus_heal_check,public,
L4,heal,auto_healing.sh,auto_healing_repair,nexus_heal_repair,public,
L4,heal,auto_healing.sh,(internal) detect_corruption,__nexus_heal_detect_corruption,private,
L4,heal,auto_healing.sh,(internal) restore_baseline,__nexus_heal_restore_baseline,private,
L4,heal,auto_healing.sh,(internal) record_baseline,__nexus_heal_record_baseline,private,
L4,metrics,metrics_system.sh,metrics_init,nexus_metrics_init,public,
L4,metrics,metrics_system.sh,register_metric,nexus_metrics_register,public,
L4,metrics,metrics_system.sh,counter_inc,nexus_metrics_counter_inc,public,
L4,metrics,metrics_system.sh,gauge_set,nexus_metrics_gauge_set,public,
L4,metrics,metrics_system.sh,gauge_inc,nexus_metrics_gauge_inc,public,
L4,metrics,metrics_system.sh,gauge_dec,nexus_metrics_gauge_dec,public,
L4,metrics,metrics_system.sh,histogram_observe,nexus_metrics_histogram_observe,public,
L4,metrics,metrics_system.sh,flush_metrics,__nexus_metrics_flush,private,
L4,metrics,metrics_system.sh,add_to_buffer,__nexus_metrics_buffer_add,private,
L4,metrics,metrics_system.sh,(internal) bucket_classify,__nexus_metrics_bucket_classify,private,
L4,predict,predictive_engine.sh,predictive_engine_run,nexus_predict_run,public,
L4,predict,predictive_engine.sh,run_predictive_analysis,__nexus_predict_analysis,private,
L4,predict,predictive_engine.sh,predictive_engine_init,__nexus_predict_init,private,
L4,predict,predictive_engine.sh,predict_resource_exhaustion,__nexus_predict_resource_exhaust,private,
L4,predict,predictive_engine.sh,detect_anomaly,__nexus_predict_detect_anomaly,private,
L4,predict,predictive_engine.sh,record_metric,__nexus_predict_record_metric,private,
L4,predict,predictive_engine.sh,calculate_mean,__nexus_predict_calc_mean,private,
L4,predict,predictive_engine.sh,calculate_stddev,__nexus_predict_calc_stddev,private,
L4,predict,predictive_engine.sh,register_context,__nexus_predict_register_ctx,private,
L4,telemetry,telemetry.sh,telemetry_init,nexus_telemetry_init,public,
L4,telemetry,telemetry.sh,telemetry_span_start,nexus_telemetry_span_start,public,
L4,telemetry,telemetry.sh,telemetry_span_end,nexus_telemetry_span_end,public,
L4,telemetry,telemetry.sh,telemetry_event,nexus_telemetry_event,public,
L4,telemetry,telemetry.sh,(internal) write_span,__nexus_telemetry_write_span,private,
L4,telemetry,telemetry.sh,(internal) flush_spans,__nexus_telemetry_flush,private,
L4,monitor,monitoring_utils.sh,monitor_start,nexus_monitor_start,public,
L4,monitor,monitoring_utils.sh,monitor_check_health,nexus_monitor_check_health,public,
L4,monitor,monitoring_utils.sh,monitor_alert,nexus_monitor_alert,public,
L4,monitor,monitoring_utils.sh,(internal) collect_metrics,__nexus_monitor_collect,private,
L5,ui,ui_utils.sh,ui_menu,nexus_ui_menu,public,
L5,ui,ui_utils.sh,ui_confirm,nexus_ui_confirm,public,
L5,ui,ui_utils.sh,ui_input,nexus_ui_input,public,
L5,ui,ui_utils.sh,ui_password,nexus_ui_password,public,
L5,ui,ui_utils.sh,ui_info,nexus_ui_info,public,
L5,ui,ui_utils.sh,ui_error,nexus_ui_error,public,
L5,ui,ui_utils.sh,ui_progress,nexus_ui_progress,public,
L5,ui,ui_utils.sh,ui_checklist,nexus_ui_checklist,public,
L5,ui,ui_utils.sh,ui_radiolist,nexus_ui_radiolist,public,
L5,ui,ui_utils.sh,ui_gauge,nexus_ui_gauge,public,
L5,ui,ui_utils.sh,ui_textbox,nexus_ui_textbox,public,
L5,ui,ui_utils.sh,ui_clear,nexus_ui_clear,public,
L5,ui,ui_utils.sh,ui_get_term_size,__nexus_ui_get_term_size,private,
L5,ui,ui_utils.sh,ui_auto_resize,__nexus_ui_auto_resize,private,
L5,ui,ui_utils.sh,ui_utils_selftest,nexus_ui_selftest,public,
L5,ui,ui_banner.sh,show_banner,nexus_ui_show_banner,public,
L5,ui,ui_banner.sh,show_system_info,nexus_ui_show_sysinfo,public,
L5,ui,ui_banner.sh,show_help,nexus_ui_show_help,public,
Plugin,plugin_01,01_install_custom.sh,install_custom,nexus_plugin_install_custom,public,Plugin entry point
Plugin,plugin_01,01_install_custom.sh,download_and_verify,__nexus_p01_download_and_verify,private,
Plugin,plugin_01,01_install_custom.sh,extract_rootfs,__nexus_p01_extract_rootfs,private,
Plugin,plugin_01,01_install_custom.sh,configure_kali,__nexus_p01_configure_kali,private,
Plugin,plugin_01,01_install_custom.sh,create_launcher,__nexus_p01_create_launcher,private,
Plugin,plugin_01,01_install_custom.sh,show_loading_bar,__nexus_p01_show_loading_bar,private,
Plugin,plugin_01,01_install_custom.sh,backup_existing,__nexus_p01_backup_existing,private,
Plugin,plugin_01,01_install_custom.sh,setup_kex,__nexus_p01_setup_kex,private,
Plugin,plugin_01,01_install_custom.sh,configure_dns,__nexus_p01_configure_dns,private,
Plugin,plugin_01,01_install_custom.sh,configure_hosts,__nexus_p01_configure_hosts,private,
Plugin,plugin_02,02_install_official.sh,install_official,nexus_plugin_install_official,public,Plugin entry point
Plugin,plugin_02,02_install_official.sh,download_official,__nexus_p02_download_official,private,
Plugin,plugin_02,02_install_official.sh,verify_image,__nexus_p02_verify_image,private,
Plugin,plugin_02,02_install_official.sh,install_image,__nexus_p02_install_image,private,
Plugin,plugin_02,02_install_official.sh,configure_official,__nexus_p02_configure_official,private,
Plugin,plugin_03,03_manage_instances.sh,manage_instances,nexus_plugin_manage_instances,public,Plugin entry point
Plugin,plugin_03,03_manage_instances.sh,list_instances,__nexus_p03_list_instances,private,
Plugin,plugin_03,03_manage_instances.sh,delete_instance,__nexus_p03_delete_instance,private,
Plugin,plugin_03,03_manage_instances.sh,rename_instance,__nexus_p03_rename_instance,private,
Plugin,plugin_03,03_manage_instances.sh,backup_instance,__nexus_p03_backup_instance,private,
Plugin,plugin_03,03_manage_instances.sh,restore_instance,__nexus_p03_restore_instance,private,
Plugin,plugin_04,04_advanced_config.sh,advanced_config,nexus_plugin_advanced_config,public,Plugin entry point
Plugin,plugin_04,04_advanced_config.sh,configure_dns,__nexus_p04_configure_dns,private,
Plugin,plugin_04,04_advanced_config.sh,configure_hosts,__nexus_p04_configure_hosts,private,
Plugin,plugin_04,04_advanced_config.sh,configure_kex,__nexus_p04_configure_kex,private,
Plugin,plugin_04,04_advanced_config.sh,configure_audio,__nexus_p04_configure_audio,private,
Plugin,plugin_04,04_advanced_config.sh,configure_vnc,__nexus_p04_configure_vnc,private,
Plugin,plugin_05,05_feedback.sh,feedback,nexus_plugin_feedback,public,Plugin entry point
Plugin,plugin_05,05_feedback.sh,collect_feedback,__nexus_p05_collect_feedback,private,
Plugin,plugin_05,05_feedback.sh,submit_feedback,__nexus_p05_submit_feedback,private,
Plugin,plugin_05,05_feedback.sh,show_feedback_form,__nexus_p05_show_feedback_form,private,
Plugin,plugin_06,06_playbooks.sh,playbooks,nexus_plugin_playbooks,public,Plugin entry point
Plugin,plugin_06,06_playbooks.sh,list_playbooks,__nexus_p06_list_playbooks,private,
Plugin,plugin_06,06_playbooks.sh,run_playbook,__nexus_p06_run_playbook,private,
Plugin,plugin_06,06_playbooks.sh,create_playbook,__nexus_p06_create_playbook,private,
Plugin,plugin_07,07_kali_tools.sh,kali_tools,nexus_plugin_kali_tools,public,Plugin entry point
Plugin,plugin_07,07_kali_tools.sh,list_tools,__nexus_p07_list_tools,private,
Plugin,plugin_07,07_kali_tools.sh,install_tool,__nexus_p07_install_tool,private,
Plugin,plugin_07,07_kali_tools.sh,remove_tool,__nexus_p07_remove_tool,private,
Plugin,plugin_07,07_kali_tools.sh,update_tools,__nexus_p07_update_tools,private,
Plugin,plugin_08,08_desktop_suite.sh,desktop_suite,nexus_plugin_desktop_suite,public,Plugin entry point
Plugin,plugin_08,08_desktop_suite.sh,install_desktop,__nexus_p08_install_desktop,private,
Plugin,plugin_08,08_desktop_suite.sh,configure_desktop,__nexus_p08_configure_desktop,private,
Plugin,plugin_08,08_desktop_suite.sh,launch_desktop,__nexus_p08_launch_desktop,private,
Plugin,plugin_08,08_desktop_suite.sh,list_desktops,__nexus_p08_list_desktops,private,
Plugin,plugin_09,09_security_hardening.sh,security_hardening,nexus_plugin_security_hardening,public,Plugin entry point
Plugin,plugin_09,09_security_hardening.sh,harden_instance,__nexus_p09_harden_instance,private,
Plugin,plugin_09,09_security_hardening.sh,audit_instance,__nexus_p09_audit_instance,private,
Plugin,plugin_09,09_security_hardening.sh,generate_report,__nexus_p09_generate_report,private,
W0,paths,nexus_paths.sh,(new),nexus_paths_resolve,public,Resolve all pipeline paths
W0,paths,nexus_paths.sh,(new),nexus_paths_get,public,Get specific path
W0,paths,nexus_paths.sh,(new),__nexus_paths_detect_env,private,
W0,atomic,nexus_atomic_ops.sh,(new),nexus_atomic_write,public,
W0,atomic,nexus_atomic_ops.sh,(new),nexus_atomic_rename,public,
W0,atomic,nexus_atomic_ops.sh,(new),__nexus_atomic_mktemp,private,
W0,atomic,nexus_atomic_ops.sh,(new),__nexus_atomic_fsync,private,
W0,json,nexus_json_extract.sh,(new),nexus_json_get,public,Get value by path
W0,json,nexus_json_extract.sh,(new),nexus_json_set,public,Set value by path
W0,json,nexus_json_extract.sh,(new),nexus_json_validate,public,Validate against schema
W0,json,nexus_json_extract.sh,(new),__nexus_json_parse_path,private,
W0,json,nexus_json_extract.sh,(new),__nexus_json_tokenize,private,
W0,json,nexus_json_extract.sh,(new),__nexus_json_type_check,private,
W1,detector,nexus_detector_syntax.sh,(new),nexus_detector_syntax_scan,public,Detector syntax
W1,detector,nexus_detector_syntax.sh,(new),__nexus_detector_syntax_init,private,
W1,detector,nexus_detector_syntax.sh,(new),__nexus_detector_syntax_parse,private,
W1,detector,nexus_detector_security.sh,(new),nexus_detector_security_scan,public,Detector security
W1,detector,nexus_detector_security.sh,(new),__nexus_detector_security_init,private,
W1,detector,nexus_detector_security.sh,(new),__nexus_detector_security_parse,private,
W1,detector,nexus_detector_convention.sh,(new),nexus_detector_convention_scan,public,Detector convention
W1,detector,nexus_detector_convention.sh,(new),__nexus_detector_convention_init,private,
W1,detector,nexus_detector_convention.sh,(new),__nexus_detector_convention_parse,private,
W1,detector,nexus_detector_portability.sh,(new),nexus_detector_portability_scan,public,Detector portability
W1,detector,nexus_detector_portability.sh,(new),__nexus_detector_portability_init,private,
W1,detector,nexus_detector_portability.sh,(new),__nexus_detector_portability_parse,private,
W1,detector,nexus_detector_dependency.sh,(new),nexus_detector_dependency_scan,public,Detector dependency
W1,detector,nexus_detector_dependency.sh,(new),__nexus_detector_dependency_init,private,
W1,detector,nexus_detector_dependency.sh,(new),__nexus_detector_dependency_parse,private,
W1,detector,nexus_detector_runner.sh,(new),nexus_detector_run_all,public,Orchestrator paralelo
W1,detector,nexus_detector_runner.sh,(new),nexus_detector_run_single,public,
W1,detector,nexus_detector_runner.sh,(new),__nexus_detector_emit_finding,private,Genera Finding object
W1,detector,nexus_detector_runner.sh,(new),__nexus_detector_map_cwe,private,CWE mapping
W1,detector,nexus_detector_runner.sh,(new),__nexus_detector_merge_outputs,private,
W2,risk,nexus_risk_engine.sh,(new),nexus_risk_compute,public,R(t) composite score
W2,risk,nexus_risk_engine.sh,(new),nexus_risk_get_density,public,density(t)
W2,risk,nexus_risk_engine.sh,(new),nexus_risk_get_distribution,public,severity_distribution
W2,risk,nexus_risk_engine.sh,(new),__nexus_risk_apply_weights,private,w_sev × count_sev
W2,risk,nexus_risk_engine.sh,(new),__nexus_risk_density_correction,private,D(t) = findings/LoC × k_d
W2,risk,nexus_risk_engine.sh,(new),__nexus_risk_entropy_correction,private,Shannon entropy adj
W2,schema,nexus_assert_schema.sh,(new),nexus_schema_validate,public,
W2,schema,nexus_assert_schema.sh,(new),nexus_schema_version_check,public,Semver compat
W2,schema,nexus_assert_schema.sh,(new),__nexus_schema_load_def,private,
W2,schema,nexus_assert_schema.sh,(new),__nexus_schema_check_field,private,
W2,gate,nexus_gate.sh,(new),nexus_gate_evaluate,public,Per-worker gate
W2,gate,nexus_gate.sh,(new),nexus_gate_status,public,Return pass/fail/warn
W2,gate,nexus_gate.sh,(new),__nexus_gate_check_regression,private,R(t) > R(t-1)?
W2,gate,nexus_gate.sh,(new),__nexus_gate_validate_bashn,private,bash -n check
W3,vortex,nexus_vortex.sh,(new),nexus_vortex_compute,public,Full VortexState
W3,vortex,nexus_vortex.sh,(new),nexus_vortex_get_state,public,Read current state
W3,vortex,nexus_vortex.sh,(new),__nexus_vortex_calc_velocity,private,"v(t,n)"
W3,vortex,nexus_vortex.sh,(new),__nexus_vortex_calc_acceleration,private,a(t)
W3,vortex,nexus_vortex.sh,(new),__nexus_vortex_calc_entropy,private,H_n(t)
W3,vortex,nexus_vortex.sh,(new),__nexus_vortex_calc_volatility,private,"σ(t,n)"
W3,vortex,nexus_vortex.sh,(new),__nexus_vortex_calc_window_mean,private,"R̄(t,n)"
W3,phase,nexus_phase_classifier.sh,(new),nexus_phase_classify,public,stable|oscillating|unstable|critical
W3,phase,nexus_phase_classifier.sh,(new),nexus_phase_get_attractor,public,safe|watch|unstable|critical
W3,phase,nexus_phase_classifier.sh,(new),__nexus_phase_calc_confidence,private,Distance from boundary
W3,phase,nexus_phase_classifier.sh,(new),__nexus_phase_detect_transition,private,
W3,event,nexus_event_emitter.sh,(new),nexus_event_check_all,public,Check all 13 events
W3,event,nexus_event_emitter.sh,(new),nexus_event_emit,public,Emit single event
W3,event,nexus_event_emitter.sh,(new),__nexus_event_build_payload,private,JSON event payload
W3,event,nexus_event_emitter.sh,(new),__nexus_event_check_runaway,private,RUNAWAY_RISK check
W4,predictor,nexus_predictor.sh,(new),nexus_predictor_project,public,prediction.json
W4,predictor,nexus_predictor.sh,(new),__nexus_predictor_calc_horizon,private,horizon_commits
W4,predictor,nexus_predictor.sh,(new),__nexus_predictor_confidence_interval,private,"{lower, upper}"
W4,predictor,nexus_predictor.sh,(new),__nexus_predictor_extrapolate,private,Linear extrapolation
W4,enforcer,nexus_enforcer.sh,(new),nexus_enforcer_classify,public,GREEN→BLACK
W4,enforcer,nexus_enforcer.sh,(new),nexus_enforcer_dispatch,public,Actions: block/warn/escalate
W4,enforcer,nexus_enforcer.sh,(new),__nexus_enforcer_check_governance,private,Committee rules
W4,enforcer,nexus_enforcer.sh,(new),__nexus_enforcer_emit_report,private,security_state_report.json
W4,gate_v2,nexus_gate_v2.sh,(new),nexus_gate_v2_full_pipeline,public,Final gate
W4,gate_v2,nexus_gate_v2.sh,(new),__nexus_gate_v2_composition_check,private,Full pipeline validation
W5,registry,nexus_registry.sh,(new),nexus_registry_init,public,Create XDG dir structure
W5,registry,nexus_registry.sh,(new),nexus_registry_publish,public,Store SSR
W5,registry,nexus_registry.sh,(new),nexus_registry_query,public,Query by spec:// URI
W5,registry,nexus_registry.sh,(new),nexus_registry_list,public,List entries
W5,registry,nexus_registry.sh,(new),__nexus_registry_resolve_uri,private,spec://org/repo/commit → path
W5,registry,nexus_registry.sh,(new),__nexus_registry_update_index,private,index.json maintenance
W5,registry,nexus_registry.sh,(new),__nexus_registry_archive,private,Archival policy
W5,ctl,nexusctl,(new),nexus_ctl_main,public,CLI dispatch
W5,ctl,nexusctl,(new),nexus_ctl_init,public,nexusctl init
W5,ctl,nexusctl,(new),nexus_ctl_scan,public,nexusctl scan
W5,ctl,nexusctl,(new),nexus_ctl_gate,public,nexusctl gate
W5,ctl,nexusctl,(new),nexus_ctl_vortex,public,nexusctl vortex
W5,ctl,nexusctl,(new),nexus_ctl_publish,public,nexusctl publish
W5,ctl,nexusctl,(new),nexus_ctl_history,public,nexusctl history
W5,ctl,nexusctl,(new),nexus_ctl_diff,public,nexusctl diff
W5,ctl,nexusctl,(new),nexus_ctl_doctor,public,nexusctl doctor
W5,ctl,nexusctl,(new),__nexus_ctl_parse_args,private,Argument parser
W5,ctl,nexusctl,(new),__nexus_ctl_dispatch,private,Command router
W5,history,nexus_history.sh,(new),nexus_history_display,public,Terminal visualization
W5,history,nexus_history.sh,(new),__nexus_history_render_trajectory,private,ASCII phase trajectory
W5,history,nexus_history.sh,(new),__nexus_history_format_table,private,
W6,observatory,nexus_observatory.sh,(new),nexus_observatory_render,public,Dashboard main
W6,observatory,nexus_observatory.sh,(new),nexus_observatory_phase_plot,public,"(R,v) scatter"
W6,observatory,nexus_observatory.sh,(new),nexus_observatory_diff_view,public,SSR comparison
W6,observatory,nexus_observatory.sh,(new),__nexus_observatory_fetch_data,private,
W6,observatory,nexus_observatory.sh,(new),__nexus_observatory_render_ansi,private,
