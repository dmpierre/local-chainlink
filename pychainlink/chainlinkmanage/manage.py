def sync_node_nonce(w3, nodedb_connection, node_address):
    """
    For syncing node nonce with chain nonce for node_address
    """
    transactions_receits = []
    expected_transactions_count = w3.eth.get_transaction_count(node_address)
    node_transactions_count = nodedb_connection.get_n_transactions()
    print(f"Expected transactions count: {expected_transactions_count}, node transactions count: {node_transactions_count}")
    if expected_transactions_count != node_transactions_count:
        # update node's number of transactions
        n_transactions_to_operate = node_transactions_count - expected_transactions_count
        print(f"Carrying out {n_transactions_to_operate} transaction(s)...")
        for i in range(n_transactions_to_operate):
            receit = w3.eth.send_transaction({"from": node_address, "to": w3.eth.accounts[0]})
            transactions_receits.append(receit)
    return transactions_receits