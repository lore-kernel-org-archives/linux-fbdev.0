From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: framebuffer_{alloc,release}
Date: Tue, 23 Sep 2003 17:49:29 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030923154929.GA4240@dreamland.darkstar.lan>
References: <20030918160142.GA2280@dreamland.darkstar.lan> <Pine.LNX.4.44.0309222223310.6431-100000@phoenix.infradead.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1pRu-0005En-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 08:51:34 -0700
Received: from mail-7.tiscali.it ([195.130.225.153])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1pRt-0000a6-VF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Sep 2003 08:51:34 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309222223310.6431-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Petr Vandrovec <VANDROVE@vc.cvut.cz>

Il Mon, Sep 22, 2003 at 10:24:04PM +0100, James Simmons ha scritto: 
> This is acceptable. I applied your changes.

Good. I've just finished matroxfb, you can do a bk pull from:

bk://mesa3d.bkbits.net/fbdev-2.5

This will update the following files:

 drivers/video/Kconfig                   |   20 
 drivers/video/matrox/g450_pll.c         |  166 +++---
 drivers/video/matrox/g450_pll.h         |    6 
 drivers/video/matrox/i2c-matroxfb.c     |   18 
 drivers/video/matrox/matroxfb_DAC1064.c |  586 ++++++++++++------------
 drivers/video/matrox/matroxfb_DAC1064.h |    4 
 drivers/video/matrox/matroxfb_Ti3026.c  |  256 +++++-----
 drivers/video/matrox/matroxfb_accel.c   |  130 ++---
 drivers/video/matrox/matroxfb_accel.h   |    2 
 drivers/video/matrox/matroxfb_base.c    |  778 +++++++++++++++-----------------
 drivers/video/matrox/matroxfb_base.h    |   76 ---
 drivers/video/matrox/matroxfb_crtc2.c   |  259 +++++-----
 drivers/video/matrox/matroxfb_crtc2.h   |    2 
 drivers/video/matrox/matroxfb_g450.c    |  162 +++---
 drivers/video/matrox/matroxfb_g450.h    |    8 
 drivers/video/matrox/matroxfb_maven.c   |   38 -
 drivers/video/matrox/matroxfb_misc.c    |  264 +++++-----
 drivers/video/matrox/matroxfb_misc.h    |   10 
 18 files changed, 1355 insertions(+), 1430 deletions(-)

through these ChangeSets:

<kronos@kronoz.cjb.net> (03/09/23 1.1290)
   Port driver to the new framebuffer_{alloc,release} API.

<kronos@kronoz.cjb.net> (03/09/21 1.1289)
   Remove FB_MATROX_MULTIHEAD and helper macros.
   Now minfo is always dynamically allocated.


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
