From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sun, 14 Jul 2013 20:13:43 +0000
Subject: Re: [BUG] radeon: suspend resume
Message-Id: <19854957-FF6F-4E39-940B-3C711EF209D1@jcrosoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG27Bk2NzdZELTeByjH5Sj_NbB+TOhYDK66aX1-9e=W_LT39Hg@mail.gmail.com>
In-Reply-To: <CAG27Bk2NzdZELTeByjH5Sj_NbB+TOhYDK66aX1-9e=W_LT39Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org


On Jul 14, 2013, at 8:26 PM, Sami Kerola <kerolasa@iki.fi> wrote:

> Hello,
>=20
> I build from Linus's tree from point
>=20
> commit 9903883f1dd6e86f286b7bfa6e4b423f98c1cd9e
>=20
> a kernel which has a power management suspend/resume problem.  In short I
> do not get video back at resume, and my laptop becomes completely
> unresponsive.  I have hunch the NO_HZ has something to do with issue.

You will have to bisect and found the commit that introduce the bug

as commit 9903883f1dd6e86

    Merge tag 'dm-3.11-changes' of git://git.kernel.org/pub/scm/linux/kerne=
l/git/agk/linux-dm

    Pull device-mapper changes from Alasdair G Kergon:
     "Add a device-mapper target called dm-switch to provide a multipath
      framework for storage arrays that dynamically reconfigure their
      preferred paths for different device regions.

      Fix a bug in the verity target that prevented its use with some
      specific sizes of devices.

      Improve some locking mechanisms in the device-mapper core and bufio.

      Add Mike Snitzer as a device-mapper maintainer.

      A few more clean-ups and fixes"

is a merge about device-mapper not fbdev and even Radeon drivers

Best Regards,
J.

>=20
> # zgrep ^CONFIG_NO_HZ /proc/config.gz
> CONFIG_NO_HZ_COMMON=3Dy
> CONFIG_NO_HZ_FULL=3Dy
> CONFIG_NO_HZ=3Dy
>=20
> The NO_HZ combined with this piece of hardware results seems to be the
> issue.
>=20
> 00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
> [AMD/ATI] Wrestler [Radeon HD 7310] (prog-if 00 [VGA controller])
>        Subsystem: Toshiba America Info Systems Device fb33
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 64 bytes
>        Interrupt: pin A routed to IRQ 49
>        Region 0: Memory at e0000000 (32-bit, prefetchable) [size%6M]
>        Region 1: I/O ports at 5000 [size%6]
>        Region 2: Memory at f0400000 (32-bit, non-prefetchable) [size%6K]
>        Expansion ROM at <unassigned> [disabled]
>        Capabilities: [50] Power Management version 3
>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
>        Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, =
MSI 00
>                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> <4us, L1 unlimited
>                        ExtTag+ RBE+ FLReset-
>                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                        MaxPayload 128 bytes, MaxReadReq 128 bytes
>                DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+
> AuxPwr- TransPend-
>                LnkCap: Port #0, Speed unknown, Width x0, ASPM
> unknown, Latency L0 <64ns, L1 <1us
>                        ClockPM- Surprise- LLActRep- BwNot-
>                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                LnkSta: Speed unknown, Width x0, TrErr- Train-
> SlotClk- DLActive- BWMgmt- ABWMgmt-
>                DevCap2: Completion Timeout: Not Supported,
> TimeoutDis-, LTR-, OBFF Not Supported
>                DevCtl2: Completion Timeout: 50us to 50ms,
> TimeoutDis-, LTR-, OBFF Disabled
>                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Spee=
dDis-
>                         Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                         Compliance De-emphasis: -6dB
>                LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
>                         EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>        Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>                Address: 00000000fee0300c  Data: 4152
>        Capabilities: [100 v1] Vendor Specific Information: ID=0001
> Rev=3D1 Len=010 <?>
>        Kernel driver in use: radeon
>        Kernel modules: radeon
>=20
>=20
> Here are some message from journalctl from the time suspend begun, and
> resume failed.  To me the two lines with '*ERROR* radeon' does not look
> right.  The messages are result of 'echo devices > /sys/power/pm_test'.
>=20
>=20
> Jul 14 12:51:12 kerolasa-home kernel: PM: Hibernation mode set to 'platfo=
rm'
> Jul 14 12:51:12 kerolasa-home kernel: kobject: 'vcs63'
> (ffff8800d2c09010): kobject_add_internal: parent: 'vc', set: 'devices'
> Jul 14 12:51:12 kerolasa-home kernel: kobject: 'vcs63'
> (ffff8800d2c09010): kobject_uevent_env
> Jul 14 12:51:12 kerolasa-home kernel: kobject: 'vcs63'
> (ffff8800d2c09010): fill_kobj_path: path =3D '/devices/virtual/vc/vcs63'
> Jul 14 12:51:12 kerolasa-home kernel: kobject: 'vcsa63'
> (ffff8800d2c08010): kobject_add_internal: parent: 'vc', set: 'devices'
> Jul 14 12:51:12 kerolasa-home kernel: kobject: 'vcsa63'
> (ffff8800d2c08010): kobject_uevent_env
> Jul 14 12:51:12 kerolasa-home kernel: kobject: 'vcsa63'
> (ffff8800d2c08010): fill_kobj_path: path > '/devices/virtual/vc/vcsa63'
> Jul 14 12:51:12 kerolasa-home kernel: PM: Marking nosave pages: [mem
> 0x0009f000-0x000fffff]
> Jul 14 12:51:12 kerolasa-home kernel: PM: Marking nosave pages: [mem
> 0xdf6bf000-0xdfbfefff]
> Jul 14 12:51:12 kerolasa-home kernel: PM: Marking nosave pages: [mem
> 0xdfc00000-0xffffffff]
> Jul 14 12:51:12 kerolasa-home kernel: PM: Basic memory bitmaps created
> Jul 14 12:51:31 kerolasa-home kernel: PM: Syncing filesystems ... done.
> Jul 14 12:51:31 kerolasa-home dhcpcd[451]: wlan0: carrier lost
> Jul 14 12:51:31 kerolasa-home dhcpcd[451]: wlan0: deleting host route
> to 192.168.1.2 via 127.0.0.1
> Jul 14 12:51:31 kerolasa-home dhcpcd[451]: wlan0: deleting route to
> 192.168.1.0/24
> Jul 14 12:51:31 kerolasa-home dhcpcd[451]: wlan0: deleting default
> route via 192.168.1.1
> Jul 14 12:51:31 kerolasa-home kernel: Freezing user space processes
> ... (elapsed 0.001 seconds) done.
> Jul 14 12:51:31 kerolasa-home kernel: PM: Preallocating image
> memory... done (allocated 187558 pages)
> Jul 14 12:51:31 kerolasa-home kernel: PM: Allocated 750232 kbytes in
> 0.32 seconds (2344.47 MB/s)
> Jul 14 12:51:31 kerolasa-home kernel: Freezing remaining freezable
> tasks ... (elapsed 0.001 seconds) done.
> Jul 14 12:51:31 kerolasa-home kernel: Suspending console(s) (use
> no_console_suspend to debug)
> Jul 14 12:51:31 kerolasa-home kernel: wlan0: deauthenticating from
> 20:f3:a3:39:74:56 by local choice (reason=3D3)
> Jul 14 12:51:31 kerolasa-home kernel: cfg80211: Calling CRDA to update
> world regulatory domain
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'regulatory.0'
> (ffff8800d98bc820): kobject_uevent_env
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'regulatory.0'
> (ffff8800d98bc820): fill_kobj_path: path > '/devices/platform/regulatory.=
0'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '50'
> (ffff8800d8c97888): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '50'
> (ffff8800d8c97888): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '50': free name
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d8c974d8): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d8c974d8): auto cleanup kobject_del
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d8c974d8): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d8c974d8): kset_release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs': free name
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '49'
> (ffff8800d8c97ac8): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '49'
> (ffff8800d8c97ac8): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '49': free name
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d8c97b98): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d8c97b98): auto cleanup kobject_del
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d8c97b98): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d8c97b98): kset_release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs': free name
> Jul 14 12:51:31 kerolasa-home kernel: radeon 0000:00:01.0: fence
> driver on ring 5 use gpu addr 0x0000000000177118 and cpu addr
> 0xffffc90004ab2118
> Jul 14 12:51:31 kerolasa-home kernel: PM: freeze of devices complete
> after 631.979 msecs
> Jul 14 12:51:31 kerolasa-home kernel: hibernation debug: Waiting for 5 se=
conds.
> Jul 14 12:51:31 kerolasa-home kernel: usb usb1: root hub lost power or wa=
s reset
> Jul 14 12:51:31 kerolasa-home kernel: usb usb2: root hub lost power or wa=
s reset
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '43'
> (ffff880106a39dc8): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '43'
> (ffff880106a39dc8): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '43': free name
> Jul 14 12:51:31 kerolasa-home kernel: usb usb4: root hub lost power or wa=
s reset
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '44'
> (ffff880106a39d08): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '44'
> (ffff880106a39d08): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '44': free name
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '45'
> (ffff880106a39c48): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '45'
> (ffff880106a39c48): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '45': free name
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff880106a39b98): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff880106a39b98): auto cleanup kobject_del
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff880106a39b98): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff880106a39b98): kset_release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs': free name
> Jul 14 12:51:31 kerolasa-home kernel: usb usb5: root hub lost power or wa=
s reset
> Jul 14 12:51:31 kerolasa-home kernel: xhci_hcd 0000:00:10.0: irq 43
> for MSI/MSI-X
> Jul 14 12:51:31 kerolasa-home kernel: xhci_hcd 0000:00:10.0: irq 44
> for MSI/MSI-X
> Jul 14 12:51:31 kerolasa-home kernel: rtlwifi: wireless switch is on
> Jul 14 12:51:31 kerolasa-home kernel: xhci_hcd 0000:00:10.0: irq 45
> for MSI/MSI-X
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d9012118): kobject_add_internal: parent: '0000:00:10.0', set:
> '<NULL>'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d9012118): kobject_uevent_env
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d9012118): kobject_uevent_env: filter function caused the
> event to drop!
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '43'
> (ffff8800d90121c8): kobject_add_internal: parent: 'msi_irqs', set:
> 'msi_irqs'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '44'
> (ffff8800d9012e88): kobject_add_internal: parent: 'msi_irqs', set:
> 'msi_irqs'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '45'
> (ffff8800d9012c48): kobject_add_internal: parent: 'msi_irqs', set:
> 'msi_irqs'
> Jul 14 12:51:31 kerolasa-home kernel: [drm] PCIE GART of 512M enabled
> (table at 0x0000000000145000).
> Jul 14 12:51:31 kerolasa-home kernel: radeon 0000:00:01.0: WB enabled
> Jul 14 12:51:31 kerolasa-home kernel: radeon 0000:00:01.0: fence
> driver on ring 0 use gpu addr 0x0000000018000c00 and cpu addr
> 0xffff8800d98a2c00
> Jul 14 12:51:31 kerolasa-home kernel: radeon 0000:00:01.0: fence
> driver on ring 3 use gpu addr 0x0000000018000c0c and cpu addr
> 0xffff8800d98a2c0c
> Jul 14 12:51:31 kerolasa-home kernel: snd_hda_intel 0000:00:14.2: irq
> 49 for MSI/MSI-X
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d92b5718): kobject_add_internal: parent: '0000:00:14.2', set:
> '<NULL>'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d92b5718): kobject_uevent_env
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff8800d92b5718): kobject_uevent_env: filter function caused the
> event to drop!
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '49'
> (ffff8800d92b5648): kobject_add_internal: parent: 'msi_irqs', set:
> 'msi_irqs'
> Jul 14 12:51:31 kerolasa-home kernel: radeon 0000:00:01.0: fence
> driver on ring 5 use gpu addr 0x00000000007ca118 and cpu addr
> 0xffffc90005432118
> Jul 14 12:51:31 kerolasa-home kernel: snd_hda_intel 0000:00:01.1: irq
> 50 for MSI/MSI-X
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff880106a39658): kobject_add_internal: parent: '0000:00:01.1', set:
> '<NULL>'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff880106a39658): kobject_uevent_env
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'msi_irqs'
> (ffff880106a39658): kobject_uevent_env: filter function caused the
> event to drop!
> Jul 14 12:51:31 kerolasa-home kernel: kobject: '50'
> (ffff8800d9012a08): kobject_add_internal: parent: 'msi_irqs', set:
> 'msi_irqs'
> Jul 14 12:51:31 kerolasa-home kernel: [drm] ring test on 0 succeeded in 1=
 usecs
> Jul 14 12:51:31 kerolasa-home kernel: [drm] ring test on 3 succeeded in 1=
 usecs
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'radeon_bl0'
> (ffff8800da197198): kobject_uevent_env
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'radeon_bl0'
> (ffff8800da197198): fill_kobj_path: path > '/devices/pci0000:00/0000:00:0=
1.0/drm/card0/card0-LVDS-1/radeon_bl0'
> Jul 14 12:51:31 kerolasa-home kernel: ACPI: \_SB_.PCI0:
> ACPI_NOTIFY_BUS_CHECK event: unsupported
> Jul 14 12:51:31 kerolasa-home kernel: ACPI: \_SB_.PCI0: Bus check
> notify on _handle_hotplug_event_root
> Jul 14 12:51:31 kerolasa-home kernel: [drm] ring test on 5 succeeded in 1=
 usecs
> Jul 14 12:51:31 kerolasa-home kernel: [drm] UVD initialized successfully.
> Jul 14 12:51:31 kerolasa-home kernel: [drm] ib test on ring 0
> succeeded in 0 usecs
> Jul 14 12:51:31 kerolasa-home kernel: [drm] ib test on ring 3
> succeeded in 1 usecs
> Jul 14 12:51:31 kerolasa-home kernel: usb 5-4: reset high-speed USB
> device number 3 using ehci-pci
> Jul 14 12:51:31 kerolasa-home kernel: ata1: SATA link up 3.0 Gbps
> (SStatus 123 SControl 300)
> Jul 14 12:51:31 kerolasa-home kernel: ata2: SATA link up 1.5 Gbps
> (SStatus 113 SControl 300)
> Jul 14 12:51:31 kerolasa-home kernel: ata2.00: configured for UDMA/100
> Jul 14 12:51:31 kerolasa-home kernel: ata1.00: configured for UDMA/100
> Jul 14 12:51:31 kerolasa-home kernel: sd 0:0:0:0: [sda] Starting disk
> Jul 14 12:51:31 kerolasa-home kernel: radeon 0000:00:01.0: GPU lockup
> CP stall for more than 10000msec
> Jul 14 12:51:31 kerolasa-home kernel: radeon 0000:00:01.0: GPU lockup
> (waiting for 0x0000000000000004 last fence id 0x0000000000000002)
> Jul 14 12:51:31 kerolasa-home kernel: [drm:r600_uvd_ib_test] *ERROR*
> radeon: fence wait failed (-35).
> Jul 14 12:51:31 kerolasa-home kernel: [drm:radeon_ib_ring_tests]
> *ERROR* radeon: failed testing IB on ring 5 (-35).
> Jul 14 12:51:31 kerolasa-home kernel: PM: restore of devices complete
> after 11949.096 msecs
> Jul 14 12:51:31 kerolasa-home kernel: PM: Image restored successfully.
> Jul 14 12:51:31 kerolasa-home kernel: Restarting tasks ... done.
> Jul 14 12:51:31 kerolasa-home kernel: PM: Basic memory bitmaps freed
> Jul 14 12:51:31 kerolasa-home kernel: video LNXVIDEO:00: Restoring
> backlight state
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'radeon_bl0'
> (ffff8800da197198): kobject_uevent_env
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'radeon_bl0'
> (ffff8800da197198): fill_kobj_path: path > '/devices/pci0000:00/0000:00:0=
1.0/drm/card0/card0-LVDS-1/radeon_bl0'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0'
> (ffff8800db3b6010): kobject_uevent_env
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0'
> (ffff8800db3b6010): fill_kobj_path: path > '/devices/LNXSYSTM:00/device:0=
0/PNP0A08:00/PNP0C0A:00/power_supply/BAT0'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'power_supply'
> (ffff880106aba8a0): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'power_supply'
> (ffff880106aba8a0): auto cleanup kobject_del
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'power_supply'
> (ffff880106aba8a0): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'power_supply': free name
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0'
> (ffff8800db3b6010): kobject_cleanup
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0'
> (ffff8800db3b6010): calling ktype release
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0': free name
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'power_supply'
> (ffff8800d924d180): kobject_add_internal: parent: 'PNP0C0A:00', set:
> '(null)'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0'
> (ffff8800d2c0e010): kobject_add_internal: parent: 'power_supply', set:
> 'devices'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0'
> (ffff8800d2c0e010): kobject_uevent_env
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0'
> (ffff8800d2c0e010): fill_kobj_path: path > '/devices/LNXSYSTM:00/device:0=
0/PNP0A08:00/PNP0C0A:00/power_supply/BAT0'
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0'
> (ffff8800d2c0e010): kobject_uevent_env
> Jul 14 12:51:31 kerolasa-home kernel: kobject: 'BAT0'
> (ffff8800d2c0e010): fill_kobj_path: path > '/devices/LNXSYSTM:00/device:0=
0/PNP0A08:00/PNP0C0A:00/power_supply/BAT0'
> Jul 14 12:51:31 kerolasa-home kernel: PM: Hibernation mode set to 'platfo=
rm'
> Jul 14 12:51:31 kerolasa-home kernel: PM: Marking nosave pages: [mem
> 0x0009f000-0x000fffff]
> Jul 14 12:51:31 kerolasa-home kernel: PM: Marking nosave pages: [mem
> 0xdf6bf000-0xdfbfefff]
> Jul 14 12:51:31 kerolasa-home kernel: PM: Marking nosave pages: [mem
> 0xdfc00000-0xffffffff]
> Jul 14 12:51:31 kerolasa-home kernel: PM: Basic memory bitmaps created
> Jul 14 12:51:32 kerolasa-home kernel: wlan0: authenticate with 20:f3:a3:3=
9:74:56
> Jul 14 12:51:32 kerolasa-home kernel: wlan0: send auth to
> 20:f3:a3:39:74:56 (try 1/3)
> Jul 14 12:51:32 kerolasa-home kernel: wlan0: authenticated
> Jul 14 12:51:32 kerolasa-home kernel: wlan0: associate with
> 20:f3:a3:39:74:56 (try 1/3)
> Jul 14 12:51:32 kerolasa-home kernel: wlan0: RX AssocResp from
> 20:f3:a3:39:74:56 (capab=3D0x411 status=3D0 aid=3D1)
> Jul 14 12:51:32 kerolasa-home kernel: wlan0: associated
> Jul 14 12:51:32 kerolasa-home dhcpcd[451]: wlan0: carrier acquired
>=20
> Let me know if more debug information or output is needed.
>=20
> --
> Sami Kerola
> http://www.iki.fi/kerolasa/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

