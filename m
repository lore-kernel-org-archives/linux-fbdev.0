From: "Thomas S. Iversen" <zensonic@zensonic.dk>
Subject: New driver for the Silicon Motion Lynx series chips
Date: Wed, 1 Oct 2003 15:02:18 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031001130218.GA8863@zensonic.dk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A4gdW-00014Q-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 01 Oct 2003 06:03:22 -0700
Received: from 213.237.25.228.adsl.van.worldonline.dk ([213.237.25.228] helo=www.zensonic.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A4gdU-0002Rc-PB
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 01 Oct 2003 06:03:21 -0700
Received: from www.zensonic.dk (localhost [127.0.0.1])
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.6) with ESMTP id h91D2IVB009374
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 1 Oct 2003 15:02:18 +0200
Received: (from zensonic@localhost)
	by www.zensonic.dk (8.12.3/8.12.3/Debian-6.6) id h91D2IwR009372
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 1 Oct 2003 15:02:18 +0200
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

Hi There

I have just finalized a new driver for the Silicon Motion Lynx series
chips. I have used it the last month or so. It works on my laptop, an
asus S8100 with the Lynx3DM chipset and I have just gained access to
another containing the LynxEM chip (on which I will test the driver
shortly). As the most critical part, the TFT timings, are taken from
XFree86 and/or the BIOS in my laptop, I do not think this driver will
break anything.

The driver only supports Digital Flat Panels at the moment (due
to time constraints in the course) but I will add real CRT
monitor support as soon as possible(tm)

The driver is totally accelerated with all three types of
blits and a hardware cursor.

Code can be found at http://www.dina.kvl.dk/~thomassi/lynxfb
It plugs into /usr/src/linux/drivers/video/lynxfb if unpacked in 
/usr/src/linux/drivers/video

There are 3 diff files in the code. One for the Makefile in drivers/video,
one for Kconfig and one for pci_ids.h

Regards Thomas S. Iversen



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
