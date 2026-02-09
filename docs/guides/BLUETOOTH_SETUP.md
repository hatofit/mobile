# Bluetooth Device Setup Guide

Complete guide to connecting heart rate monitors with HatoFit.

**Audience**: Users connecting fitness devices  
**Last Updated**: February 2026

---

## Supported Devices

### Polar Devices

| Device | Connection Type | Battery | Run Time |
|--------|-----------------|---------|----------|
| Polar H10 | Bluetooth | CR2025 | 400 hrs |
| Polar H9 | Bluetooth | CR2025 | 200 hrs |
| Polar OH1 | Bluetooth | Li-ion | 12 hrs |
| Polar Verity Sense | Bluetooth | Li-ion | 20 hrs |

### Generic BLE Devices

Any heart rate monitor implementing the Bluetooth GATT profile should work.

---

## Setup Steps

### Before You Begin

1. Enable Bluetooth on your phone
2. Ensure device is charged
3. Keep device within 3 feet of phone
4. Close other fitness apps

### Android Setup

1. **Open HatoFit**
   - Go to Devices tab
   - Tap "Add Device"

2. **Enable Permissions**
   - Grant Bluetooth permissions
   - Grant Location permission (required for BLE)

3. **Prepare Your Device**
   - Polar H10/H9: Press and hold button for 3 seconds
   - Polar OH1: Press button once

4. **Pair Device**
   - Select from device list
   - Confirm pairing code matches
   - Tap "Pair"

5. **Verify Connection**
   - Look for checkmark icon
   - Heart rate should appear immediately

### iOS Setup

1. **Open HatoFit**
   - Go to Devices tab
   - Tap "Add Device"

2. **Enable Bluetooth**
   - System Settings → Bluetooth → On

3. **Prepare Device**
   - Same as Android

4. **Pair Device**
   - Select from list
   - Accept pairing request

5. **Verify**
   - Check connection status

---

## Troubleshooting

### Device Not Found

| Check | Action |
|-------|--------|
| Bluetooth on? | Enable in phone settings |
| Device nearby? | Move within 3 feet |
| Device on? | Press device button |
| Other apps? | Close other fitness apps |
| Discovery mode? | Enable on device |

### Pairing Failed

| Error | Solution |
|-------|----------|
| "Pairing failed" | Retry pairing |
| "Wrong code" | Confirm same code on both |
| "Connection error" | Restart app and device |

### Connection Drops

| Cause | Solution |
|-------|----------|
| Distance | Stay within 10 meters |
| Interference | Move away from WiFi routers |
| Low battery | Replace/recharge battery |
| Obstructions | Remove phone case |

---

## Heart Rate Not Showing

### Quick Checklist

- [ ] Device paired successfully
- [ ] Heart rate icon shows connection
- [ ] Device is on your body
- [ ] Electrodes are moist (H10/H9)

### For Polar H10/H9

1. Moisten the electrode areas with water
2. Secure strap snugly (should be tight)
3. Position over sternum
4. Wait 10-15 seconds for signal

### For Polar OH1

1. Position on upper arm
2. Ensure skin contact
3. Wait for green LED to flash

---

## Best Practices

### Optimal Performance

1. **Keep device close** during workout
2. **Moisten electrodes** before use
3. **Check battery** before long workouts
4. **Update firmware** via Polar app

### Battery Tips

| Device | Battery Life | Tips |
|--------|-------------|------|
| H10 | 400 hours | Replace yearly |
| H9 | 200 hours | Replace yearly |
| OH1 | 12 hours | Charge regularly |

---

## Resetting Devices

### Forget Device

1. Go to Devices tab
2. Swipe left on device
3. Tap "Forget"

### Re-pair

1. Forget device
2. Restart phone
3. Repeat setup steps

---

## Supported Features by Device

| Feature | H10 | H9 | OH1 |
|---------|-----|-----|-----|
| Heart Rate | ✅ | ✅ | ✅ |
| ECG | ✅ | ❌ | ❌ |
| R-R Intervals | ✅ | ❌ | ❌ |
| Steps | ❌ | ❌ | ✅ |
| Swimming | ❌ | ✅ | ✅ |

---

## Privacy & Security

### Data Handling

- Heart rate data is stored locally
- Optional cloud sync for history
- No personal data shared with Polar

### BLE Security

- Encrypted pairing
- No data interception risk
- Device-specific connection only

---

## Support

- **Polar Support**: support.polar.com
- **HatoFit Support**: support@hatofit.com
- **In-App Help**: Settings → Help