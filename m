From: Axel Lin <axel.lin@gmail.com>
Date: Fri, 21 Jan 2011 11:18:06 +0000
Subject: [PATCH] video: pxa168fb: remove a redundant pxa168fb_check_var call
Message-Id: <1295608686.3976.9.camel@phoenix>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Lennert Buytenhek <buytenh@marvell.com>, Green Wan <gwan@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, linux-fbdev@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>Lennert Buytenhek <buytenh@marvell.com>Green Wan <gwan@marvell.com>Eric Miao <eric.y.miao@gmail.com>Marek Vasut <marek.vasut@gmail.com>Haojian Zhuang <haojian.zhuang@marvell.com>linux-fbdev@vger.kernel.orgPaul Mundt <lethal@linux-sh.org>

Current implementation calls pxa168fb_check_var twice in pxa168fb_probe.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/video/pxa168fb.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index cea6403..35f61dd 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -701,16 +701,12 @@ static int __devinit pxa168fb_probe(struct platform_device *pdev)
 	 */
 	pxa168fb_init_mode(info, mi);
 
-	ret = pxa168fb_check_var(&info->var, info);
-	if (ret)
-		goto failed_free_fbmem;
-
 	/*
 	 * Fill in sane defaults.
 	 */
 	ret = pxa168fb_check_var(&info->var, info);
 	if (ret)
-		goto failed;
+		goto failed_free_fbmem;
 
 	/*
 	 * enable controller clock
-- 
1.7.0.4



