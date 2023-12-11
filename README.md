# Makina
In-progress


## Dell Specific HW Issue
* Slow mouse issue
```bash
sudo sh -c 'echo "options i915 modeset=1 enable_rc6=1 enable_fbc=1 enable_guc_loading=1 enable_guc_submission=1 enable_huc=1 enable_psr=1 disable_power_well=0" > /etc/modprobe.d/i915.conf'
```

## Connect to Wi-Fi
* Required to have ```SSID``` and its ```password```
    ```bash
    iwctl
    [iwd] station wlan0 get-networks
    [iwd] station wlan0 scan
    [iwd] station wlan0 connect <ssid>
    [iwd] station wlan0 show
    ```

## Connect to Bluetooth
* Install ```bluez``` ```bluez-utils``` first.
    ```bash
    sudo systemctl enable bluetooth 
    sudo systemctl start bluetooth 
    sudo systemctl status bluetooth 
    bluetoothctl
    [bluetooth] power on
    [bluetooth] scan on
    [bluetooth] pair <mac_address>
    [bluetooth] remove <mac_address>
    ```