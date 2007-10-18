From: Paride Legovini <legovini@spiro.fisica.unipd.it>
Subject: intelfb not working on a 945GM
Date: Thu, 18 Oct 2007 14:18:34 +0200
Message-ID: <47174F1A.4050307@spiro.fisica.unipd.it>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IiUKt-0005hC-LJ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 05:18:47 -0700
Received: from mail231.csoft.net ([205.205.221.4] ident=_postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IiUKq-0006Sp-KI
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Oct 2007 05:18:47 -0700
Received: from [192.168.0.3] (ip-142-33.sn1.eutelia.it [62.94.142.33])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail231.csoft.net (Postfix) with ESMTP id 949AF475DF
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 18 Oct 2007 08:18:39 -0400 (EDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

I'm an owner of a Thinkpad x60s, that is provided with an Intel 945GM
(details: http://www.thinkwiki.org/wiki/Category:X60s). This is the
relevant lspci line:

00:02.0 VGA compatible controller: Intel Corporation Mobile
945GM/GMS/940GML Express Integrated Graphics Controller (rev 03).

This is not working for me. I tried booting with a lot of vga=xxx
options, but I always get a scrambled screen and the system freezes.
Yes, it doesn't continue the boot, so no log is written. If I attach an
external CRT monitor to the VGA port it doesn't get scrambled, but shuts
down as there were no signal, and the system freezes.

Moreover, I can't try to boot the system and THEN change video mode, as
the driver prevents this when an LVDS port is in use. For the same
reason specifying a 'mode:XxY-D@R' option is unuseful: the driver only
accept the vga= option. I've also tried put both (matching, I hope), but
nothing changed (scrambled screen). Here is the output of a dmesg | grep
intelfb (with the debug kernel option enabled, IIRC):

intelfb: intelfb_init
intelfb: Framebuffer driver for Intel(R)
830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
intelfb: Version 0.9.4
intelfb: intelfb_setup
intelfb: no options
intelfb: intelfb_pci_register
intelfb: fb aperture: 0xd0000000/0x10000000, MMIO region: 0xee100000/0x80000
intelfb: 00:02.0: Intel(R) 945GM, aperture size 256MB, stolen memory 7932kB
intelfb: fb: 0xd0000000(+ 0x0)/0x7bf000 (0xf8a00000)
intelfb: MMIO: 0xee100000/0x80000 (0xfc200000)
intelfb: ring buffer: 0xd3001000/0x10000 (0xfba01000)
intelfb: HW cursor: 0x0/0x0 (0x00000000) (offset 0x0) (phys 0x0)
intelfb: options: vram = 4, accel = 1, hwcursor = 0, fixed = 0, noinit = 0
intelfb: options: mode = ""
intelfb: Non-CRT device is enabled ( LVDS port ).  Disabling mode switching.
intelfb: Video mode must be programmed at boot time.
intelfb: cleanup

Both the vesafb and the X11 'intel' driver work really fine. What could
this be? If you need mode informations or want me to make any sort of
test just tell me.

Thank you,
p.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
