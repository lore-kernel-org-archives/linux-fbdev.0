From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH] atyfb: Fix a cast
Date: Wed,  4 Jun 2008 12:14:25 +0300
Message-ID: <1212570865-31419-7-git-send-email-syrjala@sci.fi>
References: <1212570865-31419-1-git-send-email-syrjala@sci.fi>
	<1212570865-31419-2-git-send-email-syrjala@sci.fi>
	<1212570865-31419-3-git-send-email-syrjala@sci.fi>
	<1212570865-31419-4-git-send-email-syrjala@sci.fi>
	<1212570865-31419-5-git-send-email-syrjala@sci.fi>
	<1212570865-31419-6-git-send-email-syrjala@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K3p4k-0008IK-RT for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:34 -0700
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K3p4k-0003Vh-Ae
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jun 2008 02:14:34 -0700
In-Reply-To: <1212570865-31419-6-git-send-email-syrjala@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Ville Syrjala <syrjala@sci.fi>, adaplas@gmail.com

The argument to iounmap() is void __iomem *. Fix the cast.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/video/aty/atyfb_base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index e38398f..620ba81 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -3335,7 +3335,7 @@ static int __devinit init_from_bios(struct atyfb_par *par)
 		PRINTKE("no BIOS frequency table found, use parameters\n");
 		ret = -ENXIO;
 	}
-	iounmap((void* __iomem )bios_base);
+	iounmap((void __iomem *)bios_base);
 
 	return ret;
 }
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
