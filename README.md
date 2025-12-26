## What Are STIGs?

**STIGs (Security Technical Implementation Guides)** are configuration standards developed by the **U.S. Department of Defense (DoD)** and maintained by **DISA (Defense Information Systems Agency)**.

They define **secure baseline settings** for:
- Operating systems
- Applications
- Network devices
- Cloud platforms  
  *(e.g., Windows 10, Windows Server, Linux, browsers, databases)*

Each **STIG**:

- Has a **unique identifier** (e.g., `WN10-SO-000120`)
- Describes a **specific security control**
- Includes **risk justification**
- Provides **detection** and **remediation** guidance

### In Simple Terms

> **STIGs turn security policy into concrete, enforceable technical controls.**

---

### Remediation Scripts

| STIG ID | Description |
|-------|----------------------|
| [WN10-AC-000005](https://github.com/Muts256/STIGs/blob/main/WN10-AC-000005.ps1) | Enforces a minimum account lockout duration to reduce the risk of brute-force password attacks. |
| [WN10-AC-000020](https://github.com/Muts256/STIGs/blob/main/WN10-AC-000020.ps1) | Requires Windows to remember at least 24 previous passwords to prevent password reuse. |
| [WN10-AU-000050](https://github.com/Muts256/STIGs/blob/main/WN10-AU-000050.ps1) | Ensures successful process creation events are audited for security monitoring and investigations. |
| [WN10-AU-000082](https://github.com/Muts256/STIGs/blob/main/WN10-AU-000082.ps1) | Enables auditing of successful file share access to detect unauthorized access to shared resources. |
| [WN10-AU-000585](https://github.com/Muts256/STIGs/blob/main/WN10-AU-000585.ps1) | Requires auditing of failed process creation events to help identify malicious execution attempts. |
| [WN10-CC-000230](https://github.com/Muts256/STIGs/blob/main/WN10-CC-000230.ps1) | Prevents users from bypassing Microsoft Defender SmartScreen warnings for malicious websites. |
| [WN10-CC-000252](https://github.com/Muts256/STIGs/blob/main/WN10-CC-000252.ps1) | Disables Windows Game Recording and Broadcasting to reduce attack surface and data leakage. |
| [WN10-CC-000325](https://github.com/Muts256/STIGs/blob/main/WN10-CC-000325.ps1) | Prevents Windows from automatically signing in the last interactive user after a system-initiated restart, ensuring re-authentication is required. |
| [WN10-SO-000100](https://github.com/Muts256/STIGs/blob/main/WN10-SO-000100.ps1) | Enforces SMB client packet signing to protect network communications from tampering. |
| [WN10-SO-000120](https://github.com/Muts256/STIGs/blob/main/WN10-SO-000120.ps1) | Requires the Windows SMB server to always digitally sign SMB communications. |
| [WN10-SO-000250](https://github.com/Muts256/STIGs/blob/main/WN10-SO-000250.ps1) | Ensures administrators are prompted for consent on the secure desktop when elevating privileges. |
| [WN10-SO-000255](https://github.com/Muts256/STIGs/blob/main/WN10-SO-000255.ps1) | Automatically denies elevation requests for standard users to prevent unauthorized privilege escalation. |
| [WN11-AC-000010](https://github.com/Muts256/STIGs/blob/main/WN11-AC-000010.ps1) | Limits the number of failed logon attempts to 3 or fewer to prevent brute-force attacks. |
| [WN11-AU-000035](https://github.com/Muts256/STIGs/blob/main/WN11-AU-000035.ps1) | Logs failed attempts to create, modify, or delete user accounts, enabling detection of unauthorized or malicious account activity. |
| [WN11-AU-000050](https://github.com/Muts256/STIGs/blob/main/WN11-AU-000050.ps1) | Logs successful and failed logon and logoff attempts to detect unauthorized access. |
| [WN11-AU-000150](https://github.com/Muts256/STIGs/blob/main/WN11-AU-000150.ps1) | Logs successful loading of security system extensions (e.g., authentication packages, SSPs) to detect unauthorized or malicious security components. |
| [WN11-AU-000560](https://github.com/Muts256/STIGs/blob/main/WN11-AU-000560.ps1) | Ensures auditing of non-standard logon events, capturing unusual authentication activity for monitoring and investigation. |
| [WN11-CC-000206](https://github.com/Muts256/STIGs/blob/main/WN11-CC-000206.ps1) | Prevents Windows Update from downloading updates from unknown Internet PCs, ensuring updates come only from trusted sources or LAN peers. |
| [WN11-CC-000285](https://github.com/Muts256/STIGs/blob/main/WN11-CC-000285.ps1) | Configures Remote Desktop Session Host to require secure RPC communication, preventing unencrypted or unauthenticated connections. |
| [WN11-CC-000290](https://github.com/Muts256/STIGs/blob/main/WN11-CC-000290.ps1) | Enforces High Level encryption (128-bit) for RDP connections to protect against interception and session hijacking. |

