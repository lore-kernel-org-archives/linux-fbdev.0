From: Luca Tettamanti <kronos@people.it>
Subject: Re: radeonfb: Add ATOM BIOS parsing v6a
	(rebased)
Date: Sun, 26 Nov 2006 17:46:21 +0100
Message-ID: <20061126164621.GA6691@dreamland.darkstar.lan>
References: <20060905153713.GA22789@shaftnet.org>
	<20060906220027.GA30385@shaftnet.org>
	<20061109052524.GA25031@shaftnet.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GoMDQ-0003Jx-L1 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 07:46:48 -0800
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GoMDM-0004BW-Qf
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Nov 2006 07:46:48 -0800
Content-Disposition: inline
In-Reply-To: <20061109052524.GA25031@shaftnet.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: pizza@shaftnet.org

Il Thu, Nov 09, 2006 at 12:25:24AM -0500, Stuffed Crust ha scritto: 
> For those of you who are still tracking this, I've rebased my ATOM BIOS 
> patch against 2.6.19-rc5:  
> 
>    http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.18-v6a.diff
>    http://www.shaftnet.org/users/pizza/radeonfb-atom-2.6.19-v6a.diff
> 
> There are no (intentional) functional changes between the two, although  
> 2.6.19 re-did the edid probing to use generic calls, so it may behave 
> differently.

Hello,
I was testing your patch radeonfb-atom-2.6.19-v6a.diff on my new radeon X850.
I get a NULL pointer dereference in fb_ddc_read (during connector probe):

radeonfb_pci_register BEGIN
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb (0000:01:00.0): Found 131072k of DDR 256 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
Retrieved PLL infos from ATOM BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=540.00 Mhz, System=520.00 MHz
PLL min 20000 max 50000
TMDS PLL from BIOS: 16500 b011c
index 3 port 2 conn 2 dac -1 ddc 0 tmds 0
index 4 port 2 conn 2 dac 1 ddc 0 tmds -1
index 7 port 1 conn 2 dac -1 ddc 1 tmds 1
Starting monitor auto detection...
radeonfb: I2C (port 0) ... found CRT display
radeonfb: I2C (port 0) ... found CRT display
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
radeonfb: I2C (port 1) ... not found
BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
f0d44013
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
Modules linked in: radeonfb(F) fb_ddc cfbcopyarea cfbimgblt cfbfillrect binfmt_misc nfs button ac battery cls_u32 cls_route sch_sfq sch_cbq nfsd exportfs lockd sunrpc vfat fat ntfs nls_base hwmon_vid hwmon i2c_isa ipv6 snd_hda_intel snd_hda_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer ohci1394 snd parport_pc parport ieee1394 e100 mii uhci_hcd ehci_hcd intel_agp agpgart usbcore i2c_i801 rtc soundcore snd_page_alloc thermal processor fan pata_ali reiserfs xfs
CPU:    1
EIP:    0060:[<f0d44013>]    Tainted: GF     VLI
EFLAGS: 00010282   (2.6.19-rc6-g1abbfb41 #2)
EIP is at fb_ddc_read+0x13/0x1d8 [fb_ddc]
eax: e9ba6938   ebx: 00000000   ecx: 00000001   edx: 00000001
esi: e9ba6240   edi: 00000000   ebp: e9ba6938   esp: e2ab6e40
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 15297, ti=e2ab6000 task=ef2a8070 task.ti=e2ab6000)
Stack: f0d4420d b0326128 e9ba7370 00000003 00000050 00000001 e2ab6e6b e9ba6610 
       e9ba6240 00000000 00000002 e9ba6634 e9ba6240 0000006c 00000003 f0db693d 
       f0db7f92 00000001 e9ba6240 e9ba6634 0000006c f0db4f90 f0db7c5e 00000008 
Call Trace:
 [<f0db693d>] radeon_probe_i2c_connector+0x63/0x152 [radeonfb]
 [<f0db4f90>] radeon_probe_screens+0x2ca/0x7b4 [radeonfb]
 [<f0da859a>] radeonfb_pci_register+0x886/0xe09 [radeonfb]
 [<b01d1d51>] pci_device_probe+0x36/0x57
 [<b02350d3>] really_probe+0x39/0xda
 [<b02352fb>] __driver_attach+0x69/0xa1
 [<b02347ec>] bus_for_each_dev+0x36/0x58
 [<b0234ff3>] driver_attach+0x16/0x18
 [<b0234ac0>] bus_add_driver+0x61/0x165
 [<b01d1eb6>] __pci_register_driver+0x6e/0x88
 [<b013e0a9>] sys_init_module+0x98/0x1db
 [<b0102f73>] syscall_call+0x7/0xb
DWARF2 unwinder stuck at syscall_call+0x7/0xb

Leftover inexact backtrace:

 =======================
Code: <8b> 03 ff 53 08 31 d2 8b 03 ff 53 08 c7 44 24 0c 00 00 00 00 31 d2 8b 03 31 f6 ff 53 04 b8 0d 00 
EIP: [<f0d44013>] fb_ddc_read+0x13/0x1d8 [fb_ddc] SS:ESP 0068:e2ab6e40

I've added some debug printk and it it turned out that algo_data is NULL:

radeonfb_pci_register BEGIN
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
radeonfb (0000:01:00.0): Found 131072k of DDR 256 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
Retrieved PLL infos from ATOM BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=540.00 Mhz, System=520.00 MHz
PLL min 20000 max 50000
TMDS PLL from BIOS: 16500 b011c
index 3 port 2 conn 2 dac -1 ddc 0 tmds 0
index 4 port 2 conn 2 dac 1 ddc 0 tmds -1
index 7 port 1 conn 2 dac -1 ddc 1 tmds 1
Starting monitor auto detection...
radeonfb: I2C (port 0) ... found CRT display
radeonfb: I2C (port 0) ... found CRT display
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
i2c_adapter i2c-2: unable to read EDID block.
radeonfb: I2C (port 1) ... not found
algo_data is NULL
radeonfb: I2C (port -1) ... not found
 * Connector 1 is DVI-I. Head 0, Monitor: CRT (EDID probed)
   ddc port: 0, dac: 1, tmds: -1
 * Connector 2 is DVI-I. Head 1, Monitor: CRT (EDID probed)
   ddc port: 0, dac: -1, tmds: 0
 * Connector 3 is DVI-I. Head -1, Monitor: None 
   ddc port: 1, dac: -1, tmds: 1
hStart = 1048, hEnd = 1184, hTotal = 1344
vStart = 771, vEnd = 777, vTotal = 806
h_total_disp = 0x7f00a7	   hsync_strt_wid = 0x910422
v_total_disp = 0x2ff0325	   vsync_strt_wid = 0x860302
pixclock = 15384
freq = 6500
freq = 6500, PLL min = 20000, PLL max = 50000
ref_div = 12, ref_clk = 2700, output_freq = 26000
ref_div = 12, ref_clk = 2700, output_freq = 26000
post div = 0x2
fb_div = 0x74
ppll_div_3 = 0x20074
Console: switching to colour frame buffer device 128x48
radeonfb (0000:01:00.0): ATI Radeon ]R 
radeonfb_pci_register END

For reference, I've added this code to fb_ddc_read:

if (!algo_data) {
        printk(KERN_WARNING "algo_data is NULL\n");
        return NULL;
}

radeonfb then works fine. The only strange thing is that it thinks that I have
two CRTs. I also have two edid files (with identical content of course).
The card has 2 DVI connectors and I'm using a VGA LCD (using DVI->VGA adapter).
The card is CrossFire capable but there's only one card in the system.

Xorg says:

(II) RADEON(0): I2C bus "DDC" initialized.
(II) RADEON(0): ATOM BIOS detected
(II) RADEON(0): Port0: DDCType-1, DACType-1, TMDSType-0, ConnectorType-2
(II) RADEON(0): Port1: DDCType-2, DACType--1, TMDSType-1, ConnectorType-2
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 1, Detected Type: 1
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): I2C device "DDC:ddc2" registered at address 0xA0.
(II) RADEON(0): I2C device "DDC:ddc2" removed.
(II) RADEON(0): DDC Type: 2, Detected Type: 0
[skip]
(II) RADEON(0): Primary:
 Monitor   -- CRT
 Connector -- DVI-I
 DAC Type  -- TVDAC/ExtDAC
 TMDS Type -- Internal
 DDC Type  -- MONID
 (II) RADEON(0): Secondary:
 Monitor   -- NONE
 Connector -- DVI-I
 DAC Type  -- Unknown
 TMDS Type -- External
 DDC Type  -- DVI_DDC



Luca
-- 
Io mi ricordo sempre il compleanno della mia ragazza:
cade il giorno dopo di quando lei me lo ricorda

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
