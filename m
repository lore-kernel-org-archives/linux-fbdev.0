From: brian mckimmie <openitca@gmail.com>
Date: Mon, 16 Dec 2013 13:11:45 +0000
Subject: HP Pavilion 15-e010ax Notebook PC - Unable to boot newest upstream mainline kernel
Message-Id: <CABjEESHBZWdgZxB7JJP_CjChPK7LurXcB9mukVc8d4hXYXePMQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

[1.] One line summary of the problem:
[HP Pavilion 15-e010ax Notebook PC] Unable to install Saucy   Bug #1252945

[2.] Full description of the problem/report:
When trying to boot latest mainline kernel no gui is obtained - only
the fallback "The System in running in Low Graphics Mode" screen from
which no progress is possible. A ctr+alt+f2 terminal is available.
Note the original bug was based on a complete lockup when trying the
Saucy Installer. This is a regression from commit
2a0f90551a76a626fd6a606877c8635f52f066e6  (drm/radeon: add Hainan pci
ids)

[3.] Keywords (i.e., modules, networking, kernel): Please do not put
anything here. This is how Kernel.org uses an undocumented keyword
system then the Ubuntu Tags system.

[4.] Kernel version (from /proc/version):
Linux version 3.13.0-031300rc3-generic (apw@gomeisa) (gcc version
4.6.3 (Ubuntu/Linaro 4.6.3-1ubuntu5) ) #201312061335 SMP Fri Dec 6
18:37:23 UTC 2013

[5.] Output of Oops.. message (if applicable) with symbolic
information resolved (see Documentation/oops-tracing.txt)

[6.] A small shell script or example program which triggers the
problem (if possible)

[7.] Environment
Description:    Ubuntu 13.10
Release:    13.10

[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux u1310lapnew 3.13.0-031300rc3-generic #201312061335 SMP Fri Dec 6
18:37:23 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux

Gnu C                  4.8
Gnu make               3.81
binutils               2.23.52.20130913
util-linux             2.20.1
mount                  support
module-init-tools      9
e2fsprogs              1.42.8
pcmciautils            018
PPP                    2.4.5
Linux C Library        2.17
Dynamic linker (ldd)   2.17
Procps                 3.3.3
Net-tools              1.60
Kbd                    1.15.5
Sh-utils               8.20
wireless-tools         30
Modules Loaded         parport_pc ppdev bnep rfcomm bluetooth
nls_iso8859_1 amd_freq_sensitivity kvm crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel aesni_intel aes_x86_64 lrw gf128mul glue_helper
ablk_helper cryptd joydev hp_wmi sparse_keymap arc4 radeon rt2800pci
snd_hda_codec_realtek rt2800mmio snd_hda_codec_hdmi rt2800lib
snd_hda_intel rt2x00pci rtsx_pci_ms memstick rt2x00mmio snd_hda_codec
rt2x00lib mac80211 snd_hwdep snd_pcm snd_page_alloc snd_seq_midi
snd_seq_midi_event snd_rawmidi cfg80211 edac_core uvcvideo
edac_mce_amd snd_seq videobuf2_vmalloc ttm videobuf2_memops
snd_seq_device videobuf2_core microcode snd_timer videodev
drm_kms_helper lp drm snd psmouse parport eeprom_93cx6 k10temp
i2c_algo_bit fam15h_power serio_raw crc_ccitt i2c_piix4 soundcore wmi
mac_hid video hid_generic usbhid hid rtsx_pci_sdmmc ahci r8169 libahci
mii rtsx_pci

[7.2.] Processor information (from /proc/cpuinfo):
processor    : 0
vendor_id    : AuthenticAMD
cpu family    : 22
model        : 0
model name    : AMD A6-5200 APU with Radeon(TM) HD Graphics
stepping    : 1
microcode    : 0x700010b
cpu MHz        : 800.000
cache size    : 2048 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit
wdt topoext perfctr_nb perfctr_l2 arat xsaveopt hw_pstate
proc_feedback npt lbrv svm_lock nrip_save tsc_scale flushbyasid
decodeassists pausefilter pfthreshold bmi1
bogomips    : 3992.90
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate [11]

processor    : 1
vendor_id    : AuthenticAMD
cpu family    : 22
model        : 0
model name    : AMD A6-5200 APU with Radeon(TM) HD Graphics
stepping    : 1
microcode    : 0x700010b
cpu MHz        : 800.000
cache size    : 2048 KB
physical id    : 0
siblings    : 4
core id        : 1
cpu cores    : 4
apicid        : 1
initial apicid    : 1
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit
wdt topoext perfctr_nb perfctr_l2 arat xsaveopt hw_pstate
proc_feedback npt lbrv svm_lock nrip_save tsc_scale flushbyasid
decodeassists pausefilter pfthreshold bmi1
bogomips    : 3992.90
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate [11]

processor    : 2
vendor_id    : AuthenticAMD
cpu family    : 22
model        : 0
model name    : AMD A6-5200 APU with Radeon(TM) HD Graphics
stepping    : 1
microcode    : 0x700010b
cpu MHz        : 800.000
cache size    : 2048 KB
physical id    : 0
siblings    : 4
core id        : 2
cpu cores    : 4
apicid        : 2
initial apicid    : 2
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit
wdt topoext perfctr_nb perfctr_l2 arat xsaveopt hw_pstate
proc_feedback npt lbrv svm_lock nrip_save tsc_scale flushbyasid
decodeassists pausefilter pfthreshold bmi1
bogomips    : 3992.90
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate [11]

processor    : 3
vendor_id    : AuthenticAMD
cpu family    : 22
model        : 0
model name    : AMD A6-5200 APU with Radeon(TM) HD Graphics
stepping    : 1
microcode    : 0x700010b
cpu MHz        : 800.000
cache size    : 2048 KB
physical id    : 0
siblings    : 4
core id        : 3
cpu cores    : 4
apicid        : 3
initial apicid    : 3
fpu        : yes
fpu_exception    : yes
cpuid level    : 13
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext
fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
extd_apicid aperfmperf eagerfpu pni pclmulqdq monitor ssse3 cx16
sse4_1 sse4_2 movbe popcnt aes xsave avx f16c lahf_lm cmp_legacy svm
extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit
wdt topoext perfctr_nb perfctr_l2 arat xsaveopt hw_pstate
proc_feedback npt lbrv svm_lock nrip_save tsc_scale flushbyasid
decodeassists pausefilter pfthreshold bmi1
bogomips    : 3992.90
TLB size    : 1024 4K pages
clflush size    : 64
cache_alignment    : 64
address sizes    : 40 bits physical, 48 bits virtual
power management: ts ttp tm 100mhzsteps hwpstate [11]


[7.3.] Module information (from /proc/modules):
rfcomm 74748 0 - Live 0x0000000000000000
bnep 19884 2 - Live 0x0000000000000000
parport_pc 36962 0 - Live 0x0000000000000000
bluetooth 411140 10 rfcomm,bnep, Live 0x0000000000000000
ppdev 17711 0 - Live 0x0000000000000000
nls_iso8859_1 12713 1 - Live 0x0000000000000000
amd_freq_sensitivity 12589 0 - Live 0x0000000000000000
kvm 468147 0 - Live 0x0000000000000000
crct10dif_pclmul 14250 0 - Live 0x0000000000000000
crc32_pclmul 13160 0 - Live 0x0000000000000000
ghash_clmulni_intel 13259 0 - Live 0x0000000000000000
aesni_intel 55720 0 - Live 0x0000000000000000
arc4 12573 2 - Live 0x0000000000000000
rt2800pci 13650 0 - Live 0x0000000000000000
rt2800mmio 21082 1 rt2800pci, Live 0x0000000000000000
aes_x86_64 17131 1 aesni_intel, Live 0x0000000000000000
joydev 17575 0 - Live 0x0000000000000000
rt2800lib 95492 2 rt2800pci,rt2800mmio, Live 0x0000000000000000
rt2x00pci 13287 1 rt2800pci, Live 0x0000000000000000
rt2x00mmio 13661 2 rt2800pci,rt2800mmio, Live 0x0000000000000000
lrw 13323 1 aesni_intel, Live 0x0000000000000000
gf128mul 14951 1 lrw, Live 0x0000000000000000
glue_helper 14095 1 aesni_intel, Live 0x0000000000000000
rt2x00lib 56124 5 rt2800pci,rt2800mmio,rt2800lib,rt2x00pci,rt2x00mmio,
Live 0x0000000000000000
ablk_helper 13597 1 aesni_intel, Live 0x0000000000000000
cryptd 20530 3 ghash_clmulni_intel,aesni_intel,ablk_helper, Live
0x0000000000000000
mac80211 654078 3 rt2800lib,rt2x00pci,rt2x00lib, Live 0x0000000000000000
hp_wmi 18202 0 - Live 0x0000000000000000
sparse_keymap 13890 1 hp_wmi, Live 0x0000000000000000
snd_hda_codec_realtek 61978 1 - Live 0x0000000000000000
snd_hda_codec_hdmi 46898 1 - Live 0x0000000000000000
radeon 1560357 1 - Live 0x0000000000000000
snd_hda_intel 57222 0 - Live 0x0000000000000000
snd_hda_codec 195017 3
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel, Live
0x0000000000000000
uvcvideo 82247 0 - Live 0x0000000000000000
videobuf2_vmalloc 13216 1 uvcvideo, Live 0x0000000000000000
videobuf2_memops 13362 1 videobuf2_vmalloc, Live 0x0000000000000000
videobuf2_core 40972 1 uvcvideo, Live 0x0000000000000000
videodev 139761 2 uvcvideo,videobuf2_core, Live 0x0000000000000000
cfg80211 509407 2 rt2x00lib,mac80211, Live 0x0000000000000000
snd_hwdep 13613 1 snd_hda_codec, Live 0x0000000000000000
snd_pcm 107140 3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec, Live
0x0000000000000000
rtsx_pci_ms 18320 0 - Live 0x0000000000000000
snd_page_alloc 18798 2 snd_hda_intel,snd_pcm, Live 0x0000000000000000
snd_seq_midi 13324 0 - Live 0x0000000000000000
snd_seq_midi_event 14899 1 snd_seq_midi, Live 0x0000000000000000
snd_rawmidi 30465 1 snd_seq_midi, Live 0x0000000000000000
snd_seq 66061 2 snd_seq_midi,snd_seq_midi_event, Live 0x0000000000000000
ttm 89884 1 radeon, Live 0x0000000000000000
eeprom_93cx6 13344 1 rt2800pci, Live 0x0000000000000000
snd_seq_device 14497 3 snd_seq_midi,snd_rawmidi,snd_seq, Live 0x00000000000=
00000
snd_timer 30038 2 snd_pcm,snd_seq, Live 0x0000000000000000
crc_ccitt 12707 1 rt2800lib, Live 0x0000000000000000
edac_core 62944 0 - Live 0x0000000000000000
drm_kms_helper 53224 1 radeon, Live 0x0000000000000000
edac_mce_amd 22792 0 - Live 0x0000000000000000
snd 73850 11 snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel,snd_hda=
_codec,snd_hwdep,snd_pcm,snd_seq_midi,snd_rawmidi,snd_seq,snd_seq_device,sn=
d_timer,
Live 0x0000000000000000
psmouse 104142 0 - Live 0x0000000000000000
drm 308397 3 radeon,ttm,drm_kms_helper, Live 0x0000000000000000
serio_raw 13462 0 - Live 0x0000000000000000
microcode 23788 0 - Live 0x0000000000000000
soundcore 12680 1 snd, Live 0x0000000000000000
memstick 16968 1 rtsx_pci_ms, Live 0x0000000000000000
wmi 19363 1 hp_wmi, Live 0x0000000000000000
k10temp 13173 0 - Live 0x0000000000000000
i2c_algo_bit 13564 1 radeon, Live 0x0000000000000000
i2c_piix4 22299 0 - Live 0x0000000000000000
fam15h_power 13166 0 - Live 0x0000000000000000
lp 17799 0 - Live 0x0000000000000000
parport 42481 3 parport_pc,ppdev,lp, Live 0x0000000000000000
mac_hid 13253 0 - Live 0x0000000000000000
video 19859 0 - Live 0x0000000000000000
hid_generic 12548 0 - Live 0x0000000000000000
usbhid 53067 0 - Live 0x0000000000000000
hid 106254 2 hid_generic,usbhid, Live 0x0000000000000000
ahci 30063 3 - Live 0x0000000000000000
rtsx_pci_sdmmc 23667 0 - Live 0x0000000000000000
libahci 32277 1 ahci, Live 0x0000000000000000
r8169 73299 0 - Live 0x0000000000000000
rtsx_pci 46133 2 rtsx_pci_ms,rtsx_pci_sdmmc, Live 0x0000000000000000
mii 13981 1 r8169, Live 0x0000000000000000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-0cf7 : PCI Bus 0000:00
  0000-001f : dma1
  0020-0021 : pic1
  0040-0043 : timer0
  0050-0053 : timer1
  0060-0060 : keyboard
  0062-0062 : EC data
  0064-0064 : keyboard
  0066-0066 : EC cmd
  0070-0071 : rtc0
  0080-008f : dma page reg
  00a0-00a1 : pic2
  00c0-00df : dma2
  00f0-00ff : fpu
  0380-0387 : pnp 00:08
  0400-0403 : ACPI PM1a_EVT_BLK
  0404-0405 : ACPI PM1a_CNT_BLK
  0408-040b : ACPI PM_TMR
  0410-0415 : ACPI CPU throttle
  0420-0427 : ACPI GPE0_BLK
  04d0-04d1 : pnp 00:08
  04d6-04d6 : pnp 00:08
  0680-06ff : pnp 00:08
  077a-077a : pnp 00:08
  0800-0800 : ACPI PM2_CNT_BLK
  0840-0847 : pnp 00:08
  0c00-0c01 : pnp 00:08
  0c14-0c14 : pnp 00:08
  0c50-0c52 : pnp 00:08
  0c6c-0c6c : pnp 00:08
  0c6f-0c6f : pnp 00:08
  0cd0-0cdb : pnp 00:08
0cf8-0cff : PCI conf1
0d00-ffff : PCI Bus 0000:00
  2000-2fff : PCI Bus 0000:06
    2000-20ff : 0000:06:00.0
      2000-20ff : r8169
  3000-3fff : PCI Bus 0000:02
  4000-4fff : PCI Bus 0000:01
    4000-40ff : 0000:01:00.0
  5000-50ff : 0000:00:01.0
  5100-510f : 0000:00:11.0
    5100-510f : ahci
  5110-5117 : 0000:00:11.0
    5110-5117 : ahci
  5118-511f : 0000:00:11.0
    5118-511f : ahci
  5120-5123 : 0000:00:11.0
    5120-5123 : ahci
  5124-5127 : 0000:00:11.0
    5124-5127 : ahci

00000000-00000fff : reserved
00001000-0006dfff : System RAM
0006e000-0006ffff : ACPI Non-volatile Storage
00070000-00087fff : System RAM
00088000-000bffff : reserved
  000a0000-000bffff : PCI Bus 0000:00
000c0000-000ce9ff : Video ROM
  000c0000-000c3fff : PCI Bus 0000:00
  000c4000-000c7fff : PCI Bus 0000:00
  000c8000-000cbfff : PCI Bus 0000:00
000d0000-000d3fff : PCI Bus 0000:00
000d4000-000d7fff : PCI Bus 0000:00
000d8000-000dbfff : PCI Bus 0000:00
000dc000-000dffff : PCI Bus 0000:00
000e0000-000e3fff : PCI Bus 0000:00
000e4000-000e7fff : PCI Bus 0000:00
000e8000-000ebfff : PCI Bus 0000:00
000ec000-000effff : PCI Bus 0000:00
000f0000-000fffff : System ROM
00100000-a6cf4fff : System RAM
  01000000-0177171d : Kernel code
  0177171e-01d1bdbf : Kernel data
  01e78000-01fdcfff : Kernel bss
  a0000000-a3ffffff : GART
a6cf5000-a7315fff : reserved
a7316000-af28efff : System RAM
af28f000-afa8efff : reserved
afa8f000-afb8efff : ACPI Non-volatile Storage
afb8f000-afbfefff : ACPI Tables
afbff000-afbfffff : System RAM
afc00000-cfffffff : reserved
d0000000-f7ffffff : PCI Bus 0000:00
  d0000000-dfffffff : PCI Bus 0000:01
    d0000000-dfffffff : 0000:01:00.0
  e0000000-efffffff : 0000:00:01.0
    e0000000-e041ffff : BOOTFB
  f0000000-f00fffff : PCI Bus 0000:02
  f0100000-f01fffff : PCI Bus 0000:06
    f0100000-f0103fff : 0000:06:00.0
      f0100000-f0103fff : r8169
    f0104000-f0104fff : 0000:06:00.0
      f0104000-f0104fff : r8169
    f0110000-f011ffff : 0000:06:00.0
  f0200000-f02fffff : PCI Bus 0000:07
    f0200000-f020ffff : 0000:07:00.1
    f0210000-f021ffff : 0000:07:00.0
      f0210000-f021ffff : 0000:07:00.0
  f0300000-f03fffff : PCI Bus 0000:01
    f0300000-f033ffff : 0000:01:00.0
    f0340000-f035ffff : 0000:01:00.0
  f0400000-f043ffff : 0000:00:01.0
  f0440000-f0443fff : 0000:00:01.1
    f0440000-f0443fff : ICH HD audio
  f0444000-f0447fff : 0000:00:14.2
    f0444000-f0447fff : ICH HD audio
  f0448000-f0449fff : 0000:00:10.0
    f0448000-f0449fff : xhci_hcd
  f044a000-f044a0ff : 0000:00:13.2
    f044a000-f044a0ff : ehci_hcd
  f044b000-f044bfff : 0000:00:13.0
    f044b000-f044bfff : ohci_hcd
  f044c000-f044c0ff : 0000:00:12.2
    f044c000-f044c0ff : ehci_hcd
  f044d000-f044dfff : 0000:00:12.0
    f044d000-f044dfff : ohci_hcd
  f044e000-f044e3ff : 0000:00:11.0
    f044e000-f044e3ff : ahci
  f0460000-f047ffff : 0000:00:01.0
  f0500000-f05fffff : PCI Bus 0000:06
  f0800000-f0ffffff : 0000:00:01.0
  f1000000-f1ffffff : PCI Bus 0000:02
    f1000000-f1000fff : 0000:02:00.0
      f1000000-f1000fff : rtsx_pci
f8000000-fbffffff : PCI MMCONFIG 0000 [bus 00-3f]
  f8000000-fbffffff : reserved
    f8000000-fbffffff : pnp 00:00
fc000000-fed3ffff : PCI Bus 0000:00
  fec00000-fec00fff : reserved
    fec00000-fec003ff : IOAPIC 0
  fec01000-fec013ff : IOAPIC 1
  fec10000-fec10fff : reserved
  fed00000-fed003ff : HPET 0
fed45000-ffffffff : PCI Bus 0000:00
  fed80000-fed80fff : reserved
  fee00000-fee00fff : Local APIC
    fee00000-fee00fff : reserved
      fee00000-fee00fff : pnp 00:00
  ffc00000-ffffffff : reserved
    ffc00000-ffffffff : pnp 00:09
100000000-12effffff : System RAM
12f000000-12fffffff : RAM buffer


[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Root Complex
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

00:01.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Kabini [Radeon HD 8400] (prog-if 00 [VGA controller])
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 83
    Region 0: Memory at e0000000 (64-bit, prefetchable) [size%6M]
    Region 2: Memory at f0800000 (64-bit, prefetchable) [size=3D8M]
    Region 4: I/O ports at 5000 [size%6]
    Region 5: Memory at f0400000 (32-bit, non-prefetchable) [size%6K]
    Expansion ROM at f0460000 [disabled] [size=128K]
    Capabilities: [48] Vendor Specific Information: Len=08 <?>
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 =
<1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPe=
nd-
        LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown,
Latency L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 4143
    Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=3D1
Len=010 <?>
    Capabilities: [270 v1] #19
    Kernel driver in use: radeon

00:01.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 9840
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 81
    Region 0: Memory at f0440000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [48] Vendor Specific Information: Len=08 <?>
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 =
<1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPe=
nd-
        LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown,
Latency L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 41c2
    Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=3D1
Len=010 <?>
    Kernel driver in use: snd_hda_intel

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Function 0
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Functions 5:1 (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=3D0
    I/O behind bridge: 00004000-00004fff
    Memory behind bridge: f0300000-f03fffff
    Prefetchable memory behind bridge: 00000000d0000000-00000000dfffffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1=
 <1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 256 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPe=
nd-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x4, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- Com=
mClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surpris=
e-
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt-
HPIrq+ LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interl=
ock-
            Changed: MRL- PresDet- LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisi=
ble-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ ARIFwd-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis+, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 4181
    Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device=
 1234
    Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
    Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=3D1
Len=010 <?>
    Kernel driver in use: pcieport

00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Functions 5:1 (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=02, subordinate=05, sec-latency=3D0
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: f1000000-f1ffffff
    Prefetchable memory behind bridge: 00000000f0000000-00000000f00fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1=
 <1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPe=
nd-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x2, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- Com=
mClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpris=
e-
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interl=
ock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisi=
ble-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ ARIFwd-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis+, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device=
 1234
    Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
    Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=3D1
Len=010 <?>
    Kernel driver in use: pcieport

00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Functions 5:1 (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=06, subordinate=06, sec-latency=3D0
    I/O behind bridge: 00002000-00002fff
    Memory behind bridge: f0500000-f05fffff
    Prefetchable memory behind bridge: 00000000f0100000-00000000f01fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1=
 <1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPe=
nd-
        LnkCap:    Port #2, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpris=
e-
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interl=
ock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisi=
ble-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ ARIFwd-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis+, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device=
 1234
    Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
    Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=3D1
Len=010 <?>
    Kernel driver in use: pcieport

00:02.4 PCI bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Functions 5:1 (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Bus: primary=00, secondary=07, subordinate=07, sec-latency=3D0
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: f0200000-f02fffff
    Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
    Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort+ <SERR- <PERR-
    BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s <64ns, L1=
 <1us
            ExtTag+ RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPe=
nd-
        LnkCap:    Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM- Surprise- LLActRep+ BwNot+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive+ BWMgmt- ABWMgmt-
        SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpris=
e-
            Slot #0, PowerLimit 0.000W; Interlock- NoCompl+
        SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt-
HPIrq- LinkChg-
            Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interl=
ock-
            Changed: MRL- PresDet+ LinkState+
        RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna- CRSVisi=
ble-
        RootCap: CRSVisible-
        RootSta: PME ReqID 0000, PMEStatus- PMEPending-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ ARIFwd-
        DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- ARIFwd-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis+, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [a0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [b0] Subsystem: Advanced Micro Devices, Inc. [AMD] Device=
 1234
    Capabilities: [b8] HyperTransport: MSI Mapping Enable+ Fixed+
    Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=3D1
Len=010 <?>
    Kernel driver in use: pcieport

00:10.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
XHCI Controller (rev 01) (prog-if 30 [XHCI])
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at f0448000 (64-bit, non-prefetchable) [size=3D8K]
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [70] MSI: Enable- Count=3D1/8 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [90] MSI-X: Enable+ Count=3D8 Masked-
        Vector table: BAR=3D0 offset=00001000
        PBA: BAR=3D0 offset=00001080
    Capabilities: [a0] Express (v2) Root Complex Integrated Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPe=
nd-
        LnkCap:    Port #0, Speed unknown, Width x0, ASPM unknown,
Latency L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; Disabled- Retrain- CommClk-
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed unknown, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [100 v1] Latency Tolerance Reporting
        Max snoop latency: 0ns
        Max no snoop latency: 0ns
    Kernel driver in use: xhci_hcd

00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (prog-if 01 [AHCI 1.0])
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 64, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 80
    Region 0: I/O ports at 5118 [size=3D8]
    Region 1: I/O ports at 5124 [size=3D4]
    Region 2: I/O ports at 5110 [size=3D8]
    Region 3: I/O ports at 5120 [size=3D4]
    Region 4: I/O ports at 5100 [size=16]
    Region 5: Memory at f044e000 (32-bit, non-prefetchable) [size=3D1K]
    Capabilities: [60] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA
PME(D0-,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [70] SATA HBA v1.0 InCfgSpace
    Capabilities: [50] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 41a2
    Capabilities: [d0] PCI Advanced Features
        AFCap: TP+ FLR+
        AFCtrl: FLR-
        AFStatus: TP-
    Kernel driver in use: ahci

00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
OHCI Controller (rev 39) (prog-if 10 [OHCI])
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at f044d000 (32-bit, non-prefetchable) [size=3D4K]
    Kernel driver in use: ohci-pci

00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
EHCI Controller (rev 39) (prog-if 20 [EHCI])
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 17
    Region 0: Memory at f044c000 (32-bit, non-prefetchable) [size%6]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
        Bridge: PM- B3+
    Capabilities: [e4] Debug port: BAR=3D1 offset=00e0
    Kernel driver in use: ehci-pci

00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
OHCI Controller (rev 39) (prog-if 10 [OHCI])
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at f044b000 (32-bit, non-prefetchable) [size=3D4K]
    Kernel driver in use: ohci-pci

00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD] FCH USB
EHCI Controller (rev 39) (prog-if 20 [EHCI])
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32, Cache Line Size: 64 bytes
    Interrupt: pin B routed to IRQ 17
    Region 0: Memory at f044a000 (32-bit, non-prefetchable) [size%6]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
        Bridge: PM- B3+
    Capabilities: [e4] Debug port: BAR=3D1 offset=00e0
    Kernel driver in use: ehci-pci

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev=
 3a)
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD] FCH Azalia
Controller (rev 02)
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dslow >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 32, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 82
    Region 0: Memory at f0444000 (64-bit, non-prefetchable) [size=16K]
    Capabilities: [50] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrentUmA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [60] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 41e2
    Kernel driver in use: snd_hda_intel

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev =
11)
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Function 0
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Function 1
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Function 2
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Function 3
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Capabilities: [f0] Secure device <?>
    Kernel driver in use: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Function 4
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Kernel driver in use: fam15h_power

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 16h
Processor Function 5
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-

01:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Sun
XT [Radeon HD 8670A/8670M/8690M]
    Subsystem: Hewlett-Packard Company Device 213a
    Physical Slot: 0
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 84
    Region 0: Memory at d0000000 (64-bit, prefetchable) [size%6M]
    Region 2: Memory at f0300000 (64-bit, non-prefetchable) [size%6K]
    Region 4: I/O ports at 4000 [size%6]
    Expansion ROM at f0340000 [disabled] [size=128K]
    Capabilities: [48] Vendor Specific Information: Len=08 <?>
    Capabilities: [50] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
            MaxPayload 256 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPe=
nd-
        LnkCap:    Port #0, Speed 8GT/s, Width x8, ASPM L0s L1,
Latency L0 <64ns, L1 <1us
            ClockPM- Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes Disabled- Retrain- Com=
mClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 4173
    Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=3D1
Len=010 <?>
    Capabilities: [150 v2] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [270 v1] #19
    Kernel driver in use: radeon

02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTS5229 PCI Express Card Reader (rev 01)
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 78
    Region 0: Memory at f1000000 (32-bit, non-prefetchable) [size=3D4K]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent75mA
PME(D0-,D1+,D2+,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 4162
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPe=
nd-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 unlimited, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes Disabled- Retrain- CommClk-
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Device Serial Number 00-00-00-01-00-4c-e0-00
    Kernel driver in use: rtsx_pci

06:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8101E/RTL8102E PCI Express Fast Ethernet controller (rev 07)
    Subsystem: Hewlett-Packard Company Device 213a
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 79
    Region 0: I/O ports at 2000 [size%6]
    Region 2: Memory at f0104000 (64-bit, prefetchable) [size=3D4K]
    Region 4: Memory at f0100000 (64-bit, prefetchable) [size=16K]
    Expansion ROM at f0110000 [disabled] [sizedK]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent75mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
        Address: 00000000fee0f00c  Data: 4182
    Capabilities: [70] Express (v2) Endpoint, MSI 01
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 <64us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPe=
nd-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 unlimited, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [b0] MSI-X: Enable- Count=3D4 Masked-
        Vector table: BAR=3D4 offset=00000000
        PBA: BAR=3D4 offset=00000800
    Capabilities: [d0] Vital Product Data
        No end tag found
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Virtual Channel
        Caps:    LPEVC=3D0 RefClk=100ns PATEntryBits=3D1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=3DFixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=3D1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=FF
            Status:    NegoPending- InProgress-
    Capabilities: [160 v1] Device Serial Number 00-00-00-00-00-00-00-00
    Capabilities: [170 v1] Latency Tolerance Reporting
        Max snoop latency: 0ns
        Max no snoop latency: 0ns
    Kernel driver in use: r8169

07:00.0 Network controller: Ralink corp. RT3290 Wireless 802.11n 1T/1R PCIe
    Subsystem: Hewlett-Packard Company Device 18ec
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 36
    Region 0: Memory at f0210000 (32-bit, non-prefetchable) [sizedK]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent75mA
PME(D0+,D1-,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME+
    Capabilities: [50] MSI: Enable- Count=3D1/32 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<128ns, L1 <2us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPe=
nd-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Device Serial Number 00-00-ef-fa-09-56-85-bc
    Kernel driver in use: rt2800pci

07:00.1 Bluetooth: Ralink corp. RT3290 Bluetooth
    Subsystem: Hewlett-Packard Company Device 18ec
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=FAst >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 3
    Region 0: Memory at f0200000 (32-bit, non-prefetchable) [sizedK]
    Capabilities: [40] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2- AuxCurrent75mA
PME(D0+,D1+,D2-,D3hot+,D3cold-)
        Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME-
    Capabilities: [50] MSI: Enable- Count=3D1/32 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [70] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<128ns, L1 <2us
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
        DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- Unsupporte=
d-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPe=
nd-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 <512ns, L1 <64us
            ClockPM+ Surprise- LLActRep- BwNot-
        LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
             EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequ=
est-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap:    First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
    Capabilities: [140 v1] Device Serial Number 00-00-f0-fa-09-56-85-bc


[7.6.] SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST500LT012-9WS14 Rev: 0001
  Type:   Direct-Access                    ANSI  SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: hp       Model: DVD RAM UJ8C2    Rev: 1.00
  Type:   CD-ROM                           ANSI  SCSI revision: 05i

[7.7.] Other information that might be relevant to the problem (please
look in /proc and include all information that you think to be
relevant):


[X.] Other notes, patches, fixes, workarounds:

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1252945

The following dmesg lines are probably relevant:
26.418352] [drm:radeon_acpi_init] *ERROR* Cannot find a backlight controller

36.058156] [drm:r600_ring_test] *ERROR* radeon: ring 0 test failed
(scratch(0x850C)=3D0xCAFEDEAD)
[   36.058228] [drm:si_resume] *ERROR* si startup failed on resume
