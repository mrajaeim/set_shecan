# Set Shecan

## Supported OS

- [x] Windows (PowerShell Script)
- [ ] Linux (Currently version is not tested yet)

## ✨ Features

- Set and Reset DNS setting for adapter
- Use custom adapter and DNS address
- Find current active adapter

## 🔨 Usage

### Windows

#### way 1 (Auto mode):

Automatically discover active adapter that connected to internet:

Just Run **enable.bat** or **disable.bat** .

It will find your current active adapter and set or reset DNS.

#### way 2 (Custom mode):

For select custom adapter follow these steps:

- Open disable.bat or enable.bat
- after **shecan_dns.ps1\\"** add **-a \'<Your-Adapter-name\>'**

For example:

    ... -File \"%CD%\shecan_dns.ps1\" -a 'Wi-Fi' ...

- Now you can rename batch files (Optionally!)

#### way 3 (Directly Run Script):

- Open PowerShell as administrator
- Run shecan_dns with desired params

### PowerShell Script Params:

| Param | Description |
|--|--|
| -a | Set adapter name |
| -r | Reset flag |
| -d1 | Primary DNS address |
| -d2 | Secondary Primary DNS address |

## 🤝 Contributing

We welcome all contributions.
