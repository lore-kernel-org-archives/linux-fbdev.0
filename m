From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] video: remove unused sh_mobile_lcdc platform data
Date: Thu, 09 Oct 2008 18:47:27 +0900
Message-ID: <20081009094727.6476.16691.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-fbdev-devel@lists.sourceforge.net

From: Magnus Damm <damm@igel.co.jp>

Remove lddckr from the platform data, these days we calculate the
register value from clock source and clock dividers anyway.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Paul, can you handle this together with the other SuperH patches?

 drivers/video/sh_mobile_lcdcfb.c |    1 -
 include/video/sh_mobile_lcdc.h   |    1 -
 2 files changed, 2 deletions(-)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2008-10-09 17:08:26.000000000 +0900
@@ -589,7 +589,6 @@ static int __init sh_mobile_lcdc_probe(s
 		goto err1;
 	}
 
-	priv->lddckr = pdata->lddckr;
 	priv->base = ioremap_nocache(res->start, (res->end - res->start) + 1);
 
 	for (i = 0; i < j; i++) {
--- 0001/include/video/sh_mobile_lcdc.h
+++ work/include/video/sh_mobile_lcdc.h	2008-10-09 17:08:26.000000000 +0900
@@ -64,7 +64,6 @@ struct sh_mobile_lcdc_chan_cfg {
 };
 
 struct sh_mobile_lcdc_info {
-	unsigned long lddckr;
 	int clock_source;
 	struct sh_mobile_lcdc_chan_cfg ch[2];
 };
