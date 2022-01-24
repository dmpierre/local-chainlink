import psycopg2

class NodeDB(object):
    """
    Class to represent a connection to a chainlink node database
    """
    def __init__(self, host, database, user, password):
        conn = psycopg2.connect(host=host, database=database, user=user, password=password)
        self.cur = conn.cursor()
        
    def get_n_transactions(self):
        _ = self.cur.execute('SELECT count(*) FROM eth_txes')
        n_transactions_executed = self.cur.fetchone()[0]
        return n_transactions_executed
    
    def get_job_runs(self):
        _ = self.cur.execute('SELECT COUNT(*) FROM job_runs')
        n_jobs_runs = self.cur.fetchone()[0]
        return n_jobs_runs

tables = ["bridge_types",
    "configurations",
    "cron_specs",
    "csa_keys",
    "direct_request_specs",
    "encrypted_ocr_key_bundles",
    "encrypted_p2p_keys",
    "encrypted_vrf_keys",
    "encumbrances",
    "eth_receipts",
    "eth_task_run_txes",
    "eth_tx_attempts",
    "eth_txes",
    "external_initiator_webhook_specs",
    "external_initiators",
    "feeds_managers",
    "flux_monitor_round_stats",
    "flux_monitor_round_stats_v2",
    "flux_monitor_specs",
    "heads",
    "initiators",
    "job_proposals",
    "job_runs",
    "job_spec_errors",
    "job_spec_errors_v2",
    "job_specs",
    "jobs",
    "keeper_registries",
    "keeper_specs",
    "keys",
    "log_broadcasts",
    "log_configs",
    "migrations",
    "node_versions",
    "offchainreporting_contract_configs",
    "offchainreporting_discoverer_announcements",
    "offchainreporting_latest_round_requested",
    "offchainreporting_oracle_specs",
    "offchainreporting_pending_transmissions",
    "offchainreporting_persistent_states",
    "p2p_peers",
    "pipeline_runs",
    "pipeline_specs",
    "pipeline_task_runs",
    "run_requests",
    "run_results",
    "service_agreements",
    "sessions",
    "sync_events",
    "task_runs",
    "task_specs",
    "upkeep_registrations",
    "users",
    "vrf_specs",
    "webhook_specs"]