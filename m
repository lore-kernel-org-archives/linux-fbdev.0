From: jfj <jfj@freemail.gr>
Subject: Status of WAITFORVSYNC (waitretrace)
Date: Sun, 24 Sep 2006 02:53:10 -0700
Message-ID: <45165586.2@freemail.gr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRRbJ-000546-8i for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 03:52:45 -0700
Received: from aiolos.otenet.gr ([195.170.0.93] ident=OTEnet-mail-system)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRRbI-0003Hg-MQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 03:52:45 -0700
Received: from [85.75.150.73] (athedsl-155307.otenet.gr [85.75.150.73])
	by aiolos.otenet.gr (8.13.4.20060308/8.13.4/Debian-9) with ESMTP id
	k8O9pkDc031487 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 24 Sep 2006 12:51:46 +0300
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

Hi.

I have kernel 2.6.17
It seems that the matrox card implements FBIO_WAITFORVSYNC ioctl.

Also, in the archives of the list I saw that there have been
patches that implement WAITFORVSYNC for radeonfb, intelfb and
omapfb.  And for the SiS card there is a static inline
waitforretrace() function that uses the polling+watchdog
method, as well as a sisfb_accelsync() [but I don't know if
.fb_sync is the same as WAITFORVSYNC].

So, um, what's the status of the ioctl()?
Are they in 2.6.18?

It would be really useful to have this for DirectFB (which
currently tries to get iolp() and do the polling method)
*and* SDL (which calls the ioctl if FBIOWAITRETRACE is
defined, based on a patch Sam sent implementing FBIOWAITRETRACE).
Then DirectFB and SDL would be able to run on framebuffer
consoles nicely, without root privs (actually hyperuser privs
which is root+DMA)

Thanks,

jerald


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
