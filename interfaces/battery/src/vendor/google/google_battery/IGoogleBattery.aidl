package vendor.google.google_battery;

interface IGoogleBattery {
    @Backing(type="int")
    enum BatteryChargingPolicy {
        DEFAULT = 1,
        LONGLIFE = 2,
        ADAPTIVE = 3,
    }
    void setChargingPolicy(BatteryChargingPolicy policy) = 22;

    String getStringProperty(int feature, int prop) = 23;
}
