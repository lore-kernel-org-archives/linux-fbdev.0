From: Kate Alhola <kate@iti.fi>
Subject: fbdev/xfree86 getting rid of /dev/tty0 console
Date: Fri, 04 Jun 2004 10:07:18 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40C01FA6.2010806@iti.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BW8nV-0007SH-0q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Jun 2004 00:07:25 -0700
Received: from [195.218.81.131] (helo=ns.iti.fi)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BW8nT-0007Rg-Tv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Jun 2004 00:07:24 -0700
Received: from iti.fi ([195.218.81.132])
	by ns.iti.fi (8.12.8/8.12.8) with ESMTP id i5477JDo020706
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 4 Jun 2004 10:07:19 +0300
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

I try to use Xfree86 with fbdev_drv in embedded system and i got stuck 
to "xf86OpenConsole: Cannot open /dev/tty0" or
"xf86OpenConsole: Cannot find a free VT" etc.

The problem is that the device is embedded ppc without any console at 
all and lesst there won't never be
one in /dev/tty0 that is normally linked to serial port.

The problem is that /dev/tty0 looks a like to be hardcoded to "void 
xf86OpenConsole(void)" in xfree86 lnx_init.c and
it is called unconditionally from xf86Init.c . I have not found any 
switch to switch console off from xfree86
config files. Also linkig /dev/tty to /dev/null or /dev/vcs0 etc does 
not help, it just replaces
"can not open" error with "Cannot find a free VT".

I know that i  can hack xfree86 source and remove this dependency by 
hand but it looks a like
not to be right or most elegant solution because i can't believe that i 
am first one that tries to use
fbdev in embedded hw without any console.


Kate


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
