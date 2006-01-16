From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: intelfb problems
Date: Mon, 16 Jan 2006 10:40:44 +0100
Message-ID: <43CB6A1C.8000209@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyQql-0002vM-0f
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Jan 2006 01:40:31 -0800
Received: from mailout05.sul.t-online.com ([194.25.134.82])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EyQqk-00065f-GH
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 16 Jan 2006 01:40:31 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi everybody,

I built a new system using an AOpen i915GMm-HFS motherboard,
1GB of PC4200 RAM and a Pentium M 750 running at 1.86 GHz.

The system is much faster than my EPIA 5000 system, after a
"make clean" it needs about 14 Minutes for a  complete compilation
of my kernel 2.6.15 configuration. And it does that while consuming
about 60 Watts ;-)

The monitor is an Eizo Flexscan, connect to the motherboard
using a dvi-i cable.

I use intelfb:

[4294667.296000] Kernel command line: root=/dev/sda3 
video=intelfb:vram=8 vga=0x307
[4294669.547000] intelfb: intelfb_init
[4294669.547000] intelfb: Framebuffer driver for Intel(R) 
830M/845G/852GM/855GM/865G/915G/915GM chipsets
[4294669.547000] intelfb: Version 0.9.2
[4294669.547000] intelfb: intelfb_setup
[4294669.547000] intelfb: options: vram=8
[4294669.547000] intelfb: intelfb_pci_register
[4294669.547000] intelfb: fb aperture: 0xc0000000/0x10000000, MMIO 
region: 0xd0400000/0x80000
[4294669.547000] intelfb: 00:02.0: Intel(R) 915GM, aperture size 128MB, 
stolen memory 8060kB
[4294669.548000] intelfb: fb: 0xc0000000(+ 0x0)/0x7df000 (0xf8a00000)
[4294669.548000] intelfb: MMIO: 0xd0400000/0x80000 (0xfc200000)
[4294669.548000] intelfb: ring buffer: 0xc3001000/0x10000 (0xfba01000)
[4294669.548000] intelfb: HW cursor: 0x0/0x0 (0x0) (offset 0x0) (phys 0x0)
[4294669.548000] intelfb: options: vram = 0, accel = 1, hwcursor = 0, 
fixed = 0, noinit = 0
[4294669.548000] intelfb: options: mode = ""
[4294669.548000] intelfb: Non-CRT device is enabled ( DVO port B ).  
Disabling mode switching.
[4294669.548000] intelfb: get_initial_mode
[4294669.548000] intelfb: Initial info: FB is 0xc0000000/0x7b0000 (7872 
kByte)
[4294669.548000] intelfb: Initial info: mode is 1280x1024-8 (1280)
[4294669.548000] intelfb: update_dinfo
[4294669.548000] intelfb: intelfb_var_to_depth: bpp: 8, green.length is 8
[4294669.548000] intelfb: intelfb_set_fbinfo
[4294669.548000] intelfb: intelfb_init_var
[4294669.548000] intelfb: Initial video mode is 1280x1024-8@60.
[4294669.548000] intelfb: Initial video mode is from 5.
[4294669.548000] intelfb: update_dinfo
[4294669.548000] intelfb: intelfb_var_to_depth: bpp: 8, green.length is 8
[4294669.548000] intelfb: intelfbhw_print_hw_state
[4294669.548000] intelfb: Changing the video mode is not supported.
[4294709.470000] intelfb: ring buffer : space: 40824 wanted 65472
[4294709.470000] intelfb: lockup - turning off hardware acceleration
[4294709.472000] intelfb: intelfb_check_var: accel_flags is 1
[4294709.472000] intelfb: Changing the video mode is not supported.
[4294721.176000] intelfb: intelfb_check_var: accel_flags is 1
[4294823.372000] intelfb: intelfb_check_var: accel_flags is 1

First of all: The framebuffer console is _slow_. A "time cat testfile" that
needs 0.69 seconds on the 533 Mhz Via Eden system using the cyblafb driver
needs 5.26 seconds on the intelfb system with the i915GM. Obviously cyblafb
has the advantage of ywrap scrolling using vxres 2048 and vyres 4096, but
changing of vxres and vyres is not possible with intelfb, at least I 
find no way
of doing that. Any hints? At least I want to increase vyres/vxres to allow
ypan/xpan scrolling.

The help text of Kconfig needs to be updated to reflect all supported chips.

The lockup is probably a result of the known kdm bug, as it only occures 
once
at the very first switch from X back to the framebuffer console.

cu,
 Knut


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
