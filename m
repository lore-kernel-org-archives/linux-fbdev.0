From: "David Guiraud" <david_guiraud@hotmail.com>
Subject: PROBLEM: System hangs off when logging off KDE
Date: Sat, 08 Nov 2003 00:00:06 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <BAY9-F39KrQRIiDLRaP000174a8@hotmail.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AIGWk-0002Pf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Nov 2003 16:00:30 -0800
Received: from bay9-f39.bay9.hotmail.com ([64.4.47.39] helo=hotmail.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AIGWk-00026R-8W
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 07 Nov 2003 16:00:30 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: davej@codemonkey.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net

[1]System hangs off when logging off KDE
[2] Compiled Kernel with agpgart and radeon modular; both loaded; (Sorry fo=
r=20
my bad english!) The KDE Login manager starts as common; i log in, as=20
common; when i try to symply log off (Shutdown or Reboot chosen with KDE=20
works fine), the monitor turns off (as usual), but does not turn on again; =

the systems seems to hang off (dont know if this is called hanging off?=20
translated it from german, but i think you know what i mean); cant get the =

terminals with CTRL-ALT-F?; only reset helps... Perhaps this is a problem=20
with the KDE-Code (ver 3.1.4), i can only say that 2.4.22 does not hang off=
.=20
Sorry, but i cant help saying (even if it doesnt help you fixing that=20
problem): Thanx for this kernel, its REALLY fast, cool new makefile
[4] Linux version 2.6.0-test9 (root@LinuxWS) (gcc version 3.2.3) #1 Sun Nov=
=20
2 17:36:29 UTC 2003
[7.1] Linux LinuxWS 2.6.0-test9 #1 Sun Nov 2 17:36:29 UTC 2003 i686 unknown=
=20
unknown GNU/Linux

Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.14
e2fsprogs              1.34
jfsutils               1.1.3
xfsprogs               2.5.6
pcmcia-cs              3.2.5
quota-tools            3.09.
PPP                    2.4.1
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Linux C++ Library      5.0.3
Procps                 2.0.16
Net-tools              1.60
Kbd                    1.08
Sh-utils               5.0
Modules Loaded         snd_pcm_oss snd_pcm snd_page_alloc snd_mixer_oss=20
ide_scsi agpgart radeon

[7.2] processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2600+
stepping        : 1
cpu MHz         : 2081.628
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =

cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 4087.80
[7.3]snd_pcm_oss 48772 - - Live 0xf89af000
snd_pcm 84992 - - Live 0xf8999000
snd_page_alloc 8900 - - Live 0xf894d000
snd_mixer_oss 17152 - - Live 0xf8954000
ide_scsi 11968 - - Live 0xf8941000
agpgart 26632 - - Live 0xf8945000
radeon 118584 - - Live 0xf8961000
[7.4]0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
  b800-b8ff : 0000:01:00.0
d400-d4ff : 0000:00:12.0
d800-d81f : 0000:00:10.0
  d800-d81f : uhci_hcd
dc00-dc1f : 0000:00:10.1
  dc00-dc1f : uhci_hcd
e000-e01f : 0000:00:10.2
  e000-e01f : uhci_hcd
e400-e41f : 0000:00:0b.0
  e400-e41f : ne2k-pci
e800-e8ff : 0000:00:0a.0
  e800-e8ff : sym53c8xx
ec00-ec3f : 0000:00:09.0
  ec00-ec3f : Ensoniq AudioPCI
fc00-fc0f : 0000:00:11.1

iomem:00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cb000-000ce5ff : Extension ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-003815f6 : Kernel code
  003815f7-0043f0ff : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
cfd00000-dfcfffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
dfe00000-dfefffff : PCI Bus #01
  dfef0000-dfefffff : 0000:01:00.0
dfffe000-dfffefff : 0000:00:0a.0
  dfffe000-dfffefff : sym53c8xx
dffffd00-dffffdff : 0000:00:12.0
dffffe00-dffffeff : 0000:00:10.3
  dffffe00-dffffeff : ehci_hcd
dfffff00-dfffffff : 0000:00:0a.0
  dfffff00-dfffffff : sym53c8xx
e0000000-e7ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved
[7.5] 00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3205
        Subsystem: Unknown device 1849:3205
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=3D128M]
        Capabilities: [80] AGP version 3.5
                Status: RQ=3D32 Iso- ArqSz=3D0 Cal=3D2 SBA+ ITACoh- GART64-=
=20
HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit- =
FW-=20
Rate=3Dx1
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b198 (prog-if 00=
=20
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D0
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: dfe00000-dfefffff
        Prefetchable memory behind bridge: cfd00000-dfcfffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:09.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 08)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-=20
<TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at ec00 [size=3D64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875 (rev 26)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 134 (4250ns min, 16000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e800 [size=3D256]
        Region 1: Memory at dfffff00 (32-bit, non-prefetchable) [size=3D256]
        Region 2: Memory at dfffe000 (32-bit, non-prefetchable) [size=3D4K]
        Expansion ROM at dffe0000 [disabled] [size=3D64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at e400 [size=3D32]
        Expansion ROM at ffff8000 [disabled] [size=3D32K]

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00=20
[UHCI])
        Subsystem: Unknown device 1849:3038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 4: I/O ports at d800 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00=20
[UHCI])
        Subsystem: Unknown device 1849:3038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin B routed to IRQ 3
        Region 4: I/O ports at dc00 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00=20
[UHCI])
        Subsystem: Unknown device 1849:3038
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin C routed to IRQ 10
        Region 4: I/O ports at e000 [size=3D32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20=
=20
[EHCI])
        Subsystem: Unknown device 1849:3104
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 10
        Interrupt: pin D routed to IRQ 10
        Region 0: Memory at dffffe00 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: Unknown device 1849:3177
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus=20
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Unknown device 1849:0571
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at fc00 [size=3D16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev =

74)
        Subsystem: Unknown device 1849:3065
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-=
=20
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (750ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d400 [size=3D256]
        Region 1: Memory at dffffd00 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable+ DSel=3D0 DScale=3D0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY=20
[Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: Elitegroup Computer Systems: Unknown device 4c33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-=
=20
Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =

<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=3D128M]
        Region 1: I/O ports at b800 [size=3D256]
        Region 2: Memory at dfef0000 (32-bit, non-prefetchable) [size=3D64K]
        Expansion ROM at dfec0000 [disabled] [size=3D128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=3D48 Iso- ArqSz=3D0 Cal=3D0 SBA+ ITACoh- GART64-=
=20
HTrans- 64bit- FW- AGP3- Rate=3Dx1,x2,x4
                Command: RQ=3D32 ArqSz=3D0 Cal=3D0 SBA+ AGP+ GART64- 64bit-=
 FW-=20
Rate=3Dx1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA=20
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-

[7.6] Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: SEAGATE  Model: ST34501W         Rev: 0018
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W8220T Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: TOSHIBA  Model: CD-ROM XM-6401TA Rev: 1001
  Type:   CD-ROM                           ANSI SCSI revision: 02

_________________________________________________________________
Wu=DFten Sie, da=DF Sie Ihren Hotmail-Posteingang auch =FCber den MSN Messe=
nger=20
abrufen k=F6nnen? http://messenger.msn.de Jetzt kostenlos downloaden und=20
einfach testen!



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
