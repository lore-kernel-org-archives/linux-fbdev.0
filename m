Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D83C433B4
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27776108D
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347720AbhERJHP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 May 2021 05:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347707AbhERJHO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 May 2021 05:07:14 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FB3C061756
        for <linux-fbdev@vger.kernel.org>; Tue, 18 May 2021 02:05:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:c161:a89e:52bd:1787])
        by andre.telenet-ops.be with bizsmtp
        id 695s2500a446CkP0195sSK; Tue, 18 May 2021 11:05:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1livfk-006q2F-7g; Tue, 18 May 2021 11:05:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1liv5J-0069nl-OS; Tue, 18 May 2021 10:28:13 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/5] video: fbdev: ssd1307fb: Optimize screen updates
Date:   Tue, 18 May 2021 10:28:08 +0200
Message-Id: <20210518082809.1467549-5-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518082809.1467549-1-geert@linux-m68k.org>
References: <20210518082809.1467549-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Currently, each screen update triggers an I2C transfer of all screen
data, up to 1 KiB of data for a 128x64 display, which takes at least 20
ms in Fast mode.

Reduce the amount of transferred data by only updating the rectangle
that changed.  Remove the call to ssd1307fb_set_address_range() during
initialization, as ssd1307fb_update_rect() now takes care of that.

Note that for now the optimized operation is only used for fillrect,
copyarea, and imageblit, which are used by fbcon.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/ssd1307fb.c | 43 ++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index cfa27ea0feab4f01..8e3d4be74723b9bf 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -184,16 +184,18 @@ static int ssd1307fb_set_address_range(struct ssd1307fb_par *par, u8 col_start,
 	return ssd1307fb_write_cmd(par->client, page_end);
 }
 
-static int ssd1307fb_update_display(struct ssd1307fb_par *par)
+static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
+				 unsigned int y, unsigned int width,
+				 unsigned int height)
 {
 	struct ssd1307fb_array *array;
 	u8 *vmem = par->info->screen_buffer;
 	unsigned int line_length = par->info->fix.line_length;
-	unsigned int pages = DIV_ROUND_UP(par->height, 8);
+	unsigned int pages = DIV_ROUND_UP(height + y % 8, 8);
 	u32 array_idx = 0;
 	int ret, i, j, k;
 
-	array = ssd1307fb_alloc_array(par->width * pages, SSD1307FB_DATA);
+	array = ssd1307fb_alloc_array(width * pages, SSD1307FB_DATA);
 	if (!array)
 		return -ENOMEM;
 
@@ -226,13 +228,18 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 	 *  (5) A4 B4 C4 D4 E4 F4 G4 H4
 	 */
 
-	for (i = 0; i < pages; i++) {
+	ret = ssd1307fb_set_address_range(par, par->col_offset + x, width,
+					  par->page_offset + y / 8, pages);
+	if (ret < 0)
+		goto out_free;
+
+	for (i = y / 8; i < y / 8 + pages; i++) {
 		int m = 8;
 
 		/* Last page may be partial */
-		if (i + 1 == pages && par->height % 8)
+		if (8 * (i + 1) > par->height)
 			m = par->height % 8;
-		for (j = 0; j < par->width; j++) {
+		for (j = x; j < x + width; j++) {
 			u8 data = 0;
 
 			for (k = 0; k < m; k++) {
@@ -245,11 +252,17 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 		}
 	}
 
-	ret = ssd1307fb_write_array(par->client, array, par->width * pages);
+	ret = ssd1307fb_write_array(par->client, array, width * pages);
+
+out_free:
 	kfree(array);
 	return ret;
 }
 
+static int ssd1307fb_update_display(struct ssd1307fb_par *par)
+{
+	return ssd1307fb_update_rect(par, 0, 0, par->width, par->height);
+}
 
 static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
 		size_t count, loff_t *ppos)
@@ -299,21 +312,24 @@ static void ssd1307fb_fillrect(struct fb_info *info, const struct fb_fillrect *r
 {
 	struct ssd1307fb_par *par = info->par;
 	sys_fillrect(info, rect);
-	ssd1307fb_update_display(par);
+	ssd1307fb_update_rect(par, rect->dx, rect->dy, rect->width,
+			      rect->height);
 }
 
 static void ssd1307fb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 	struct ssd1307fb_par *par = info->par;
 	sys_copyarea(info, area);
-	ssd1307fb_update_display(par);
+	ssd1307fb_update_rect(par, area->dx, area->dy, area->width,
+			      area->height);
 }
 
 static void ssd1307fb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct ssd1307fb_par *par = info->par;
 	sys_imageblit(info, image);
-	ssd1307fb_update_display(par);
+	ssd1307fb_update_rect(par, image->dx, image->dy, image->width,
+			      image->height);
 }
 
 static const struct fb_ops ssd1307fb_ops = {
@@ -493,13 +509,6 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	/* Set column and page range */
-	ret = ssd1307fb_set_address_range(par, par->col_offset, par->width,
-					  par->page_offset,
-					  DIV_ROUND_UP(par->height, 8));
-	if (ret < 0)
-		return ret;
-
 	/* Clear the screen */
 	ret = ssd1307fb_update_display(par);
 	if (ret < 0)
-- 
2.25.1

