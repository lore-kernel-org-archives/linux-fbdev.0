From: "ankur maheshwari" <ankur_maheshwari@procsys.com>
Subject: how to enable logo
Date: Tue, 29 Aug 2006 20:29:34 +0530
Message-ID: <005601c6cb7b$bd9592b0$f301a8c0@procsys>
References: <0ab101c69042$ed73d330$f301a8c0@procsys>
	<Pine.LNX.4.62.0606151037450.19321@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GI4zx-0008BM-BK for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Aug 2006 07:55:29 -0700
Received: from [61.95.199.26] (helo=mailsvr.procsys.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GI4zr-0005Zn-Jz
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Aug 2006 07:55:29 -0700
Received: from ankurmaheshwari ([192.168.1.243])
	by mailsvr.procsys.com (8.12.10/8.12.10) with SMTP id k7TErtsX006652
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 29 Aug 2006 20:23:55 +0530
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

hi,

I have written a framebuffer driver of my own, which is base on virtual
framebuffer driver (vfb.c).
After linux boot up I can see my framebuffer in /proc/fb as device 0

0 myfbdriver

I am working on 2.6.11 uclinux.
What I want to know is ----
what are the option I need to enable in menuconfig in 2.6 kernel for
displaying logo on bootup.


Currently I tried
Device Driver -> Character device -> Virtual Terminal
Device Driver -> Character device -> Serial Driver -> Support for console on
serial device.
Graphic support -> Support of frame buffer devices
Graphic support ->Console display driver support -> Frame buffer console
support
Graphic support ->Logo configuration -> Standard 224-color Linux logo.
and My framebuffer driver.


After boot linux when I do cat /dev/fb0, I get a logo on my hyperterminal.
But console remains blank, I copied other files (.ppm) on /dev/fb0 and its
getting written on /dev/fb0 but console remains blank.

Can anyone share basic steps for logo display on linux 2.6 ???

I observed that while boot up console gives print ....
Console: Dummy colour device 80x25 .....

later when fb driver get loaded, I get following prints
Console: switching to frame buffer device 80x30

I have given fix. params as 640x480 but even then it switchs to 80x30.

Can any one explain me what going wrong ???? I am not passing any command
line params at present also I am not using _setup for command line parsing,
is that must ??

One more observation I made when I enable support for logo16 or black&white
logo, my driver gets loaded after fbcon and other fb modules, so doing cat
/dev/fb0 does not show me anything.


thanks
Ankur




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
