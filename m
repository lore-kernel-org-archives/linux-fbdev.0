Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC38AC11F6B
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Jul 2021 14:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B94B0613C2
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Jul 2021 14:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhGNPBG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhGNPBF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Jul 2021 11:01:05 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD162C0613DB
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Jul 2021 07:58:12 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:bcf3:b2b1:dff6:480b])
        by andre.telenet-ops.be with bizsmtp
        id V2yA2500S4sai0K012yA1C; Wed, 14 Jul 2021 16:58:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3gKw-001AEk-Ka; Wed, 14 Jul 2021 16:58:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3gKv-00AcNJ-UM; Wed, 14 Jul 2021 16:58:09 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend 3/5] video: fbdev: ssd1307fb: Extract ssd1307fb_set_address_range()
Date:   Wed, 14 Jul 2021 16:58:02 +0200
Message-Id: <20210714145804.2530727-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714145804.2530727-1-geert@linux-m68k.org>
References: <20210714145804.2530727-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Extract the code to set the column and page ranges into a helper
function.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/ssd1307fb.c | 61 +++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 6d7bd025bca1a175..cfa27ea0feab4f01 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -152,6 +152,38 @@ static inline int ssd1307fb_write_cmd(struct i2c_client *client, u8 cmd)
 	return ret;
 }
 
+static int ssd1307fb_set_address_range(struct ssd1307fb_par *par, u8 col_start,
+				       u8 cols, u8 page_start, u8 pages)
+{
+	u8 col_end = col_start + cols - 1;
+	u8 page_end = page_start + pages - 1;
+	int ret;
+
+	/* Set column range */
+	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, col_start);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, col_end);
+	if (ret < 0)
+		return ret;
+
+	/* Set page range */
+	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
+	if (ret < 0)
+		return ret;
+
+	ret = ssd1307fb_write_cmd(par->client, page_start);
+	if (ret < 0)
+		return ret;
+
+	return ssd1307fb_write_cmd(par->client, page_end);
+}
+
 static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 {
 	struct ssd1307fb_array *array;
@@ -461,31 +493,10 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	/* Set column range */
-	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd1307fb_write_cmd(par->client, par->col_offset);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd1307fb_write_cmd(par->client, par->col_offset + par->width - 1);
-	if (ret < 0)
-		return ret;
-
-	/* Set page range */
-	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd1307fb_write_cmd(par->client, par->page_offset);
-	if (ret < 0)
-		return ret;
-
-	ret = ssd1307fb_write_cmd(par->client,
-				  par->page_offset +
-				  DIV_ROUND_UP(par->height, 8) - 1);
+	/* Set column and page range */
+	ret = ssd1307fb_set_address_range(par, par->col_offset, par->width,
+					  par->page_offset,
+					  DIV_ROUND_UP(par->height, 8));
 	if (ret < 0)
 		return ret;
 
-- 
2.25.1

