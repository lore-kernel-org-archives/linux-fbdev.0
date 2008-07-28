From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] sh7760fb: write colormap value to
	hardware.
Date: Mon, 28 Jul 2008 20:05:13 +0200
Message-ID: <20080728180513.GA31478@roarinelk.homelinux.net>
References: <486B39E3.60601@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNX61-0001dr-Kg for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 11:05:21 -0700
Received: from fnoeppeil48.netpark.at ([217.175.205.176]
	helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KNX60-0006IF-08
	for Linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 Jul 2008 11:05:21 -0700
Content-Disposition: inline
In-Reply-To: <486B39E3.60601@renesas.com>
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
To: Andrew Morton <akpm@linux-foundation.org>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: Munakata Hisao <munakata.hisao@renesas.com>, Paul Mundt <lethal@linux-sh.org>, linuc-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>

The computed color value is never actually written to hardware
colormap register.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/video/sh7760fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index 4d0e28c..8d0212d 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -152,6 +152,7 @@ static int sh7760fb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 		col |= ((*g) & 0xff) << 8;
 		col |= ((*b) & 0xff);
 		col &= SH7760FB_PALETTE_MASK;
+		iowrite32(col, par->base + LDPR(s));
 
 		if (s < 16)
 			((u32 *) (info->pseudo_palette))[s] = s;
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
