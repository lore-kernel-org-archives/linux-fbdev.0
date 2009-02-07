From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 6/15] sm501fb: check fb_alloc_cmap
 return value and handle failure properly
Date: Sat, 7 Feb 2009 12:14:48 -0500
Message-ID: <20090207121448.7b18c3fd@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqlZ-0008TB-BF
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:14:53 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqlX-0000PI-Vt for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:14:53 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com


Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/sm501fb.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index dcd9879..eb5d73a 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -1525,7 +1525,10 @@ static int sm501fb_init_fb(struct fb_info *fb,
 	}
 
 	/* initialise and set the palette */
-	fb_alloc_cmap(&fb->cmap, NR_PALETTE, 0);
+	if (fb_alloc_cmap(&fb->cmap, NR_PALETTE, 0)) {
+		dev_err(info->dev, "failed to allocate cmap memory\n");
+		return -ENOMEM;
+	}
 	fb_set_cmap(&fb->cmap, fb);
 
 	ret = (fb->fbops->fb_check_var)(&fb->var, fb);
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
