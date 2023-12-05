library;

/// Event logged when a deposit is made.
pub struct Deposit {
    /// The caller of the deposit function.
    caller: Identity,
    /// The receiver of the deposit.
    receiver: Identity,
    /// The asset being deposited.
    asset: AssetId,
    /// The SubId of the vault.
    sub_id: SubId,
    /// The amount of assets being deposited.
    assets: u64,
    /// The amount of shares being minted.
    shares: u64,
}

/// Event logged when a withdrawal is made.
pub struct Withdraw {
    /// The caller of the withdrawal function.
    caller: Identity,
    /// The receiver of the withdrawal.
    receiver: Identity,
    /// The asset being withdrawn.
    asset: AssetId,
    /// The SubId of the vault.
    sub_id: SubId,
    /// The amount of assets being withdrawn.
    assets: u64,
    /// The amount of shares being burned.
    shares: u64,
}

abi SRC6 {
    /// Deposits assets into the contract and mints shares to the receiver.
    ///
    /// # Additional Information
    ///
    /// * Assets must be forwarded to the contract in the contract call.
    ///
    /// # Arguments
    ///
    /// * `receiver`: [Identity] - The receiver of the shares.
    /// * `sub_id`: [SubId] - The SubId of the vault.
    ///
    /// # Returns
    ///
    /// * [u64] - The amount of shares minted.
    ///
    /// # Reverts
    ///
    /// * If the asset is not supported by the contract.
    /// * If the amount of assets forwarded to the contract is zero.
    /// * The user crosses any global or user specific deposit limits.
    #[storage(read, write)]
    fn deposit(receiver: Identity, sub_id: SubId) -> u64;

    /// Burns shares from the sender and transfers assets to the receiver.
    ///
    /// # Additional Information
    ///
    /// * Shares must be forwarded to the contract in the contract call.
    ///
    /// # Arguments
    ///
    /// * `receiver`: [Identity] - The receiver of the assets.
    /// * `asset`: [AssetId] - The asset for which the shares should be burned.
    /// * `sub_id`: [SubId] - The SubId of the vault.
    ///
    /// # Returns
    ///
    /// * [u64] - The amount of assets transferred.
    ///
    /// # Reverts
    ///
    /// * If the asset is not supported by the contract.
    /// * If the amount of shares is zero.
    /// * If the transferred shares do not corresspond to the given asset.
    /// * The user crosses any global or user specific withdrawal limits.
    #[storage(read, write)]
    fn withdraw(receiver: Identity, asset: AssetId, sub_id: SubId) -> u64;

    /// Returns the amount of managed assets of the given asset.
    ///
    /// # Arguments
    ///
    /// * `asset`: [AssetId] - The asset for which the amount of managed assets should be returned.
    /// * `sub_id`: [SubId] - The SubId of the vault.
    ///
    /// # Returns
    ///
    /// * [u64] - The amount of managed assets of the given asset.
    #[storage(read)]
    fn managed_assets(asset: AssetId, sub_id: SubId) -> u64;

    /// Returns the maximum amount of assets that can be deposited into the contract, for the given asset.
    ///
    /// # Additional Information
    ///
    /// Must account for any user or global limits.
    ///
    /// # Arguments
    ///
    /// * `receiver`: [Identity] - The hypothetical receiver of the shares.
    /// * `asset`: [AssetId] - The asset for which the maximum amount of depositable assets should be returned.
    /// * `sub_id`: [SubId] - The SubId of the vault.
    ///
    /// # Returns
    ///
    /// * [Some(u64)] - The maximum amount of assets that can be deposited into the contract, for the given asset.
    /// * [None] - If the asset is not supported by the contract.
    #[storage(read)]
    fn max_depositable(receiver: Identity, asset: AssetId, sub_id: SubId) -> Option<u64>;

    /// Returns the maximum amount of assets that can be withdrawn from the contract, for the given asset.
    ///
    /// # Additional Information
    ///
    /// Must account for any global limits.
    ///
    /// # Arguments
    ///
    /// * `asset`: [AssetId] - The asset for which the maximum amount of withdrawable assets should be returned.
    /// * `sub_id`: [SubId] - The SubId of the vault.
    ///
    /// # Returns
    ///
    /// * [Some(u64)] - The maximum amount of assets that can be withdrawn from the contract, for the given asset.
    /// * [None] - If the asset is not supported by the contract.
    #[storage(read)]
    fn max_withdrawable(asset: AssetId, sub_id: SubId) -> Option<u64>;
}
