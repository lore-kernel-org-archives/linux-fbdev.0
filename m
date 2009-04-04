From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cirrusfb: do not allow unsupported
	pixel depth
Date: Sat, 4 Apr 2009 14:46:42 +0200
Message-ID: <20090404144642.be0e3a17.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Lq5FL-0003Em-Sb
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Apr 2009 12:45:15 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lq5FJ-0001tG-27 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 04 Apr 2009 12:45:15 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Do not allow modes with unsupported pixel depth.
Otherwise, one can hang a computer by setting
incorrect value with fbset command.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index d42e385..4c2bf92 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -567,9 +567,7 @@ static int cirrusfb_check_var(struct fb_var_screeninfo *var,
 	default:
 		dev_dbg(info->device,
 			"Unsupported bpp size: %d\n", var->bits_per_pixel);
-		assert(false);
-		/* should never occur */
-		break;
+		return -EINVAL;
 	}
 
 	if (var->xres_virtual < var->xres)
-- 
1.6.0.3


----------------------------------------------------------------------
Kawalerka za 89 tys. zl!
Sprawdz >>> http://link.interia.pl/f20fb


------------------------------------------------------------------------------
