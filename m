From: Jim Hague <jim.hague@acm.org>
Subject: New API and X option UseFBDev
Date: Tue, 09 Sep 2003 07:49:55 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030909074955.jim.hague@acm.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wcK8-0005W3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 23:50:00 -0700
Received: from mta02-svc.ntlworld.com ([62.253.162.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wcK7-0000NG-9S
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 08 Sep 2003 23:49:59 -0700
Received: from fluffy.bear-cave.org.uk ([81.103.192.171])
          by mta02-svc.ntlworld.com
          (InterMail vM.4.01.03.37 201-229-121-137-20020806) with ESMTP
          id <20030909064955.RDHQ20614.mta02-svc.ntlworld.com@fluffy.bear-cave.org.uk>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Tue, 9 Sep 2003 07:49:55 +0100
Received: from hagrid ([192.168.1.1] helo=hagrid.bear-cave.org.uk)
	by fluffy.bear-cave.org.uk with esmtp (Exim 3.35 #1 (Debian))
	id 19wcK4-0001o8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 07:49:56 +0100
Received: from jim by hagrid.bear-cave.org.uk with local (Exim 3.36 #1 (Debian))
	id 19wcK3-00028k-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 07:49:55 +0100
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
To: linux-fbdev-devel@lists.sourceforge.net

I've been moving the pm2fb driver to the new API (currently working under
2.6.0-test3). I've got it working unaccelerated; still need to add acceleration
and option handling and tidy up.

I have a problem when I try and run X (Debian 4.2.1-11 20030829103906). My
config uses the Glint driver with UseFBDev true, and works fine on 2.4.22. It
fails on 2.6 like this:

(II) Setting vga for screen 0.
(**) GLINT(0): Depth 16, (--) framebuffer bpp 16
(==) GLINT(0): RGB weight 565
(==) GLINT(0): Default visual is TrueColor
(==) GLINT(0): Using gamma correction (1.0, 1.0, 1.0)
(**) GLINT(0): Option "UseFBDev" "true"
(==) GLINT(0): Using HW cursor
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
        compiled for 4.2.1.1, module version = 0.0.2
        ABI class: XFree86 Video Driver, version 0.5
(**) GLINT(0): Using Linux framebuffer device
(--) GLINT(0): Chipset: "ti_pm2"
(--) GLINT(0): Linear framebuffer at 0xCE800000
(--) GLINT(0): MMIO registers at 0xCFFE0000
(EE) GLINT(0): mmap mmio: Invalid argument
(EE) GLINT(0): mmap mmio: Invalid argument
 
Fatal server error:
Caught signal 11.  Server aborting

The lfb and MMIO addresses are correct. Now, I've new to this game and may have
missed filling out a structure field somewhere. But I'm dammed if I can see
what.

It's occurred to me that maybe this just doesn't work and I need an updated
fbdevhw. Do I? Or should it really Just Work?

-- 
Jim Hague - jim.hague@acm.org          Never trust a computer you can't lift.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
