From: Joachim Steiger <roh@hyte.de>
Subject: [patch] using a sgi 1600sw flatpanel with aty128fb at full res.
Date: Mon, 21 Oct 2002 03:45:56 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0210210328450.23666-100000@reactor.hyte.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from reactor.hyte.de ([212.84.215.194])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 183Rds-0007p1-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Oct 2002 18:46:04 -0700
Received: from roh (helo=localhost)
	by reactor.hyte.de with local-esmtp (Exim 3.35 #1 (Debian))
	id 183Rdk-0006Aw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Oct 2002 03:45:56 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

since i was asked a few times

to use a sgi1600sw flatpanel with multilink adapter with aty128fb at full
resolution at boot time i made a small patch against 2.4.17-pre8 some time
ago

you can get it here:
http://reactor.hyte.de/~roh/patches/aty128fb-sgi1600sw-resolution.diff

the aty is (in my case still) connected via analog-vga to the
multilink-adapter
the timings are 'borrowed' from the output of the dcc-module from xfree at
starting time
the resolution is set to 1600x1024pixels, the bpp default is 16(565)

the patch also applies to 2.4.19 with a small offset in one hunk

i saw something about merging atyfb, aty128fb and radeonfb some time on a
mailinglist... how far is the process done?
is there the possibility to make things like working ddc-detection and automatic calculation of
timings from that information a working option?

regards

roh

ps: mail me if you have any questions regarding this hardware-combination



-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
