From: Rolf Offermanns <rolf.offermanns@gmx.net>
Subject: SMI712 driver 16bpp color problem (maybe endian related?)
Date: Mon, 24 Oct 2005 09:48:35 +0200
Message-ID: <200510240948.35531.rolf.offermanns@gmx.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ETx4X-0000sl-1U
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 00:48:45 -0700
Received: from mail.sysgo.com ([62.8.134.5])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ETx4V-0006mZ-HI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 00:48:45 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id 92C91FB86E
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Oct 2005 09:48:36 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id 80362FB86E
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Oct 2005 09:48:36 +0200 (CEST)
Received: from kolab.sysgo.com (rof.sysgo.com [172.22.10.10])
	by donald.sysgo.com (Postfix) with ESMTP id 5F5C81B01BF
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Oct 2005 09:48:34 +0200 (CEST)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

Hi All,
I am trying to port a fb driver for the SMI712 chip from kernel 2.4 to 2.6.

I use the 2.4 driver from SMIs homepage as a template. Having tried for
several days now, I could need some help in understanding a few things.

I know, that some of the below writings may look confused, because that's
the state my mind is in right now. :)

8bpp pseudo-color mode seems to work OK right now, but I am struggeling with
16bpp mode. 

According the the manual the chips support RGB565 16bpp. I changed the rgb
offset/length fields to:

red: 11/5
green: 5/6
blue: 0/5

I test the driver with the XF86FBDev server from x.org-6.8.1. Using the
xsetroot command for setting the root window color to red/green/blue, I
noticed, that the color were mixed up like this:

red -> blue
green -> red
blue -> green

So I changed the offsets to:

red: 5
green: 0
blue: 11

Now I get the expected result for xsetroot. However the color of my window
decorations look wrong. I use wm2 as window manager. I then tried fbtest
from CVS (w/o the image test, as I do not have netpbm on my target) and
there the color look wrong, too. I can post a screenshot (digicam) if that
is of any help (only tomorrow, because I have the setup in my office).

Does anyone has got an idea of what might be wrong here?

I read about endian problems in the archive.  My target is a ppc440ep (big
endian) and the chip is on a PCI card. Could this be the problem?

Any hint is greatly appreciated.

Thanks,
Rolf



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
