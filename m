From: Jurriaan <thunder7@xs4all.nl>
Subject: 2.6.7mm5: switching from X to fbdev gives wrong vertical frequency
Date: Sun, 4 Jul 2004 15:36:25 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040704133625.GA30035@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bh7Ba-00008M-Br
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 06:37:38 -0700
Received: from smtp-out4.xs4all.nl ([194.109.24.5])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bh7BD-0006wx-5U
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 06:37:37 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-out4.xs4all.nl (8.12.10/8.12.10) with ESMTP id i64Dav34080651
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 4 Jul 2004 15:36:57 +0200 (CEST)
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

I boot my kernel like this:

kernel /boot/vmlinuz-267mm5 root=/dev/md3 video=radeonfb:1600x1200-16@85 softrepeat=1

and that works fine in 2.6.7-mm5 with Davids 16bpp copyarea fix.

XFree also works fine (latest debian version:)

xfree86-common 4.3.0.dfsg.1-5 X Window System (XFree86) infrastructure
xserver-xfree8 4.3.0.dfsg.1-5 the XFree86 X server

In 2.6.7 both worked fine, and I could switch from X to fb and back
without any problem. Now, when I switch from X to fb, my 85 Hz refresh
is changed to 60. That looks really awful.

Jurriaan
-- 
I am Lwaxana Troi of Borg. Oh, Jean-Luc, what futile thoughts...
Debian (Unstable) GNU/Linux 2.6.7-mm5 2x6078 bogomips load 3.42


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
