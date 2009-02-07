From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 1/15] fix memory leaks in removal path
Date: Sat, 7 Feb 2009 12:12:15 -0500
Message-ID: <20090207121215.77e45acf@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dilinger@queued.net>) id 1LVqj6-0001jz-QM
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:12:20 +0000
Received: from lunge.mit.edu ([18.54.1.69] helo=lunge.queued.net)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LVqj5-0002BI-Aq for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Feb 2009 17:12:20 +0000
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


We were leaking both the cmap memory and the info struct memory.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/sgivwfb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sgivwfb.c b/drivers/video/sgivwfb.c
index f5252c2..bba5371 100644
--- a/drivers/video/sgivwfb.c
+++ b/drivers/video/sgivwfb.c
@@ -837,6 +837,8 @@ static int sgivwfb_remove(struct platform_device *dev)
 		iounmap(par->regs);
 		iounmap(info->screen_base);
 		release_mem_region(DBE_REG_PHYS, DBE_REG_SIZE);
+		fb_dealloc_cmap(&info->cmap);
+		framebuffer_release(info);
 	}
 	return 0;
 }
-- 
1.5.6.5


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
