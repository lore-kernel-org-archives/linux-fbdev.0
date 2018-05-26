From: Matthias Urlichs <matthias@urlichs.de>
Date: Sat, 26 May 2018 08:11:32 +0000
Subject: Please rate limit kernel output!
Message-Id: <88e353ed-b49b-d454-8d09-4b941ff6558f@urlichs.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9X9rdGPGbO98wjP7VeFX0e3ZoXlssb6at"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9X9rdGPGbO98wjP7VeFX0e3ZoXlssb6at
Content-Type: multipart/mixed; boundary="dF90ErrhFqKfjrGAIJZPrw9NwB1IQx3Lh";
 protected-headers="v1"
From: Matthias Urlichs <matthias@urlichs.de>
To: linux-fbdev@vger.kernel.org
Message-ID: <88e353ed-b49b-d454-8d09-4b941ff6558f@urlichs.de>
Subject: Please rate limit kernel output!

--dF90ErrhFqKfjrGAIJZPrw9NwB1IQx3Lh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: de-DE

Hi,

the below dump happens a whole lot when I work with my system.

Please teach the radeonfb driver to stop spewing stack dumps. More than
one per minute/hour/whatever is not helpful, and the machine is
unresponsive while the kernel does this.

This is current Debain testing, Gnome 3.28 on Wayland.

$ uname -a
Linux s-desk 4.16.0-1-amd64 #1 SMP Debian 4.16.5-1 (2018-04-29) x86_64 GN=
U/Linux

$ lspci -vv
[=E2=80=A6]
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]=
 Redwood PRO [Radeon HD 5550/5570/5630/6510/6610/7570] (prog-if 00 [VGA c=
ontroller])
        Subsystem: PC Partner Limited / Sapphire Technology Radeon HD 557=
0
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 27
        Region 0: Memory at d0000000 (64-bit, prefetchable) [size=3D256M]=

        Region 2: Memory at fe620000 (64-bit, non-prefetchable) [size=3D1=
28K]
        Region 4: I/O ports at e000 [size=3D256]
        Expansion ROM at 000c0000 [disabled] [size=3D128K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA PME(D0-,D1-,=
D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME=
-
        Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4=
us, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Uns=
upported-
                        RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- =
TransPend-
                LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Exi=
t Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x16, TrErr- Train- SlotClk+ DL=
Active- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, LTR=
-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, L=
TR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Speed=
Dis-
                         Transmit Margin: Normal Operating Range, EnterMo=
difiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationCom=
plete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, LinkEq=
ualizationRequest-
        Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
                Address: 00000000fee02004  Data: 4025
        Capabilities: [100 v1] Vendor Specific Information: ID=3D0001 Rev=
=3D1 Len=3D010 <?>
        Capabilities: [150 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFat=
alErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFat=
alErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ =
ChkEn-
        Kernel driver in use: radeon
        Kernel modules: radeon

# journalctl =E2=80=A6
Mai 25 16:31:11 s-desk kernel: radeon 0000:01:00.0: swiotlb buffer is ful=
l (sz: 2097152 bytes)

Mai 25 16:31:11 s-desk kernel: radeon 0000:01:00.0: swiotlb: coherent all=
ocation failed, size=3D209715

Mai 25 16:31:11 s-desk kernel: CPU: 3 PID: 23724 Comm: gnome-shell Not ta=
inted 4.16.0-1-amd64 #1 Deb

Mai 25 16:31:11 s-desk kernel: Hardware name: Packard Bell imedia S3850/i=
media S3850, BIOS P01-A0=C2=A0=C2=A0=20

Mai 25 16:31:11 s-desk kernel: Call Trace:

Mai 25 16:31:11 s-desk kernel:=C2=A0 dump_stack+0x5c/0x85

Mai 25 16:31:11 s-desk kernel:=C2=A0 swiotlb_alloc_coherent+0x19b/0x1b0

Mai 25 16:31:11 s-desk kernel:=C2=A0 ttm_dma_pool_get_pages+0x235/0x620 [=
ttm]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ttm_dma_populate+0x25e/0x350 [ttm]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ttm_tt_bind+0x2c/0x60 [ttm]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ttm_bo_handle_move_mem+0x577/0x5b0 [=
ttm]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ttm_bo_validate+0x120/0x130 [ttm]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ? drm_mm_insert_node_in_range+0x30e/=
0x500 [drm]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ttm_bo_init_reserved+0x386/0x430 [tt=
m]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ttm_bo_init+0x6b/0xe0 [ttm]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ? radeon_update_memory_usage.isra.3+=
0x50/0x50 [radeon]

Mai 25 16:31:11 s-desk kernel:=C2=A0 radeon_bo_create+0x180/0x230 [radeon=
]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ? radeon_update_memory_usage.isra.3+=
0x50/0x50 [radeon]

Mai 25 16:31:11 s-desk kernel:=C2=A0 radeon_gem_object_create+0xa7/0x1d0 =
[radeon]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ? import_iovec+0x37/0xd0

Mai 25 16:31:11 s-desk kernel:=C2=A0 ? radeon_gem_pwrite_ioctl+0x30/0x30 =
[radeon]

Mai 25 16:31:11 s-desk kernel:=C2=A0 radeon_gem_create_ioctl+0x66/0x100 [=
radeon]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ? radeon_gem_pwrite_ioctl+0x30/0x30 =
[radeon]

Mai 25 16:31:11 s-desk kernel:=C2=A0 drm_ioctl_kernel+0x5b/0xb0 [drm]

Mai 25 16:31:11 s-desk kernel:=C2=A0 drm_ioctl+0x2cb/0x380 [drm]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ? radeon_gem_pwrite_ioctl+0x30/0x30 =
[radeon]

Mai 25 16:31:11 s-desk kernel:=C2=A0 ? ep_scan_ready_list.constprop.16+0x=
242/0x250

Mai 25 16:31:11 s-desk kernel:=C2=A0 radeon_drm_ioctl+0x49/0x80 [radeon]

Mai 25 16:31:11 s-desk kernel:=C2=A0 do_vfs_ioctl+0xa4/0x630

Mai 25 16:31:11 s-desk kernel:=C2=A0 ? __sys_recvmsg+0x7d/0x90

Mai 25 16:31:11 s-desk kernel:=C2=A0 SyS_ioctl+0x74/0x80

Mai 25 16:31:11 s-desk kernel:=C2=A0 do_syscall_64+0x6c/0x130

Mai 25 16:31:11 s-desk kernel:=C2=A0 entry_SYSCALL_64_after_hwframe+0x3d/=
0xa2

Mai 25 16:31:11 s-desk kernel: RIP: 0033:0x7fa4fc87ff07

Mai 25 16:31:11 s-desk kernel: RSP: 002b:00007ffd7a6bdf78 EFLAGS: 0000024=
6 ORIG_RAX: 000000000000001

Mai 25 16:31:11 s-desk kernel: RAX: ffffffffffffffda RBX: 000000000000000=
2 RCX: 00007fa4fc87ff07

Mai 25 16:31:11 s-desk kernel: RDX: 00007ffd7a6bdff0 RSI: 00000000c020645=
d RDI: 000000000000000d

Mai 25 16:31:11 s-desk kernel: RBP: 00007ffd7a6bdff0 R08: 000000000000000=
2 R09: 0000000000000000

Mai 25 16:31:11 s-desk kernel: R10: 0000000000000000 R11: 000000000000024=
6 R12: 00000000c020645d

Mai 25 16:31:11 s-desk kernel: R13: 000000000000000d R14: 00005650f6c18c0=
0 R15: 00005650f6c18c00


--=20
-- Matthias Urlichs



--dF90ErrhFqKfjrGAIJZPrw9NwB1IQx3Lh--

--9X9rdGPGbO98wjP7VeFX0e3ZoXlssb6at
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEr9eXgvO67AILKKGfcs+OXiW0wpMFAlsJFrYACgkQcs+OXiW0
wpP+QBAAuqvzkE5oBlve0Mca7poHLW00eMXXQAjTejFgI4EDhdHH9OuRhU5jzyv2
kjI/LLmZziu3X+b2x2bPjsAOD+bSezaVcAnGXzj1w+EiY3ZYLMeofKeF7GTvT9G4
fOgkTsmlePDtQa1TY82ExuvN4OupYCHMHBP8Oq3qDVnMHYHrl+/+0nf3RNP9+vj7
uKQ8fFxP/02+3bqh2KpV+I+F4Odb3MJ/dZVKara+tuz+O7bQ/AwRk1pjPYnvPT37
RT7LnrzLrtqwn+Jx07OCSEplfDMus7Sb1PHAiw5poT6w8biTj4YIcva20Yo38k+7
DILLg9Hy78ae8g0sRr81oKcN5sHGJTKdb0UWNWhQv/QrrUz9JFF+MnhKqbVW51Ty
JJ8MgwoiQ+oFCQ1btexSL2dTz8lsOShALZ/0rbTMs0M3cagieHl1Pu6EZ+FtKYav
JrSrIm69y4m9HrI3DOjihZjoOOhXF++dNMPG2yO5x005YL72li+DB1TBmCe7ZAtv
ouu0R4DIsMpV7ddSFXDHgyToRQrHWK33JeayKQZZYIQGJ9jub0JcIG+i3mvud6L3
Ewfew4G/GCqDXcdpYHPu826le2aDstMhXZItSZJXkLtv03q1qmagQ7djqh+z/t1x
FqRdjKIPolib1U8LVlaQrSi3NVald1Wbw4LArl1CrtCQXI8CCyc=
=osj8
-----END PGP SIGNATURE-----

--9X9rdGPGbO98wjP7VeFX0e3ZoXlssb6at--
