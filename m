From: Matthew Hodgson <matthew@arasphere.net>
Subject: intelfb with 855GME and DVI?
Date: Tue, 13 Feb 2007 01:07:21 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702130101030.16307@phoenix.arasphere.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HGm8n-0006hE-4A for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Feb 2007 17:07:31 -0800
Received: from 87-194-2-4.bethere.co.uk ([87.194.2.4] helo=mail.arasphere.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HGm8j-0003l9-9p
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Feb 2007 17:07:28 -0800
Received: from localhost ([127.0.0.1])
	by mail.arasphere.net with esmtp (Exim 4.54) id 1HGm8f-0004xb-Se
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Feb 2007 01:07:21 +0000
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

Hi,

I have an obscure Pentium M motherboard with 855GME graphics 
(http://www.ibase-i.com.tw/mb890.htm) which I'm trying to use with a DVI 
monitor for video playback.  On compiling intelfb into 2.6.20, the fb 
fails to load with a boot option of video=intelfb:1024x768-24@75 with

intelfb: intelfb_init
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
intelfb: Version 0.9.4
intelfb: intelfb_setup
intelfb: options: 1024x768-24@75
intelfb: intelfb_pci_register
intelfb: fb aperture: 0xd8000000/0x8000000, MMIO region: 0xec080000/0x80000
intelfb: 00:02.0: Intel(R) 855GME, aperture size 128MB, stolen memory 32636kB
intelfb: fb: 0xd8000000(+ 0x0)/0x1fdf000 (0xde980000)
intelfb: MMIO: 0xec080000/0x80000 (0xe3980000)
intelfb: ring buffer: 0xdb001000/0x10000 (0xe1981000)
intelfb: HW cursor: 0x0/0x0 (0x00000000) (offset 0x0) (phys 0x0)
intelfb: options: vram = 4, accel = 1, hwcursor = 0, fixed = 0, noinit = 0
intelfb: options: mode = "1024x768-24@75"
intelfb: Non-CRT device is enabled ( DVO port C ).  Disabling mode switching.
intelfb: Video mode must be programmed at boot time.
intelfb: cleanup

I'm confused: I thought that I /was/ trying to program the video mode at 
boot time by specifying the video= boot option.  Or is this trying to tell 
me that there's actually no support of Non-CRT at all?  Specifying vga= 
options in lilo.conf and disabling/enabling vesafb doesn't seem to alter 
the behaviour.

Should this work?

thanks,

Matthew.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
