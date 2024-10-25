#[oracle(get_number_sequence)]
unconstrained fn get_number_sequence(_size: Field) -> [Field] {}

// The timeout for when using an external RPC oracle resolver can be set with the NARGO_FOREIGN_CALL_TIMEOUT environment variable. This timeout is in units of milliseconds.

