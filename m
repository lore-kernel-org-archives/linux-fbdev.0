Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF485C11F67
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Jul 2021 14:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D592613C2
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Jul 2021 14:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239481AbhGNPBF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhGNPBE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Jul 2021 11:01:04 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5502C061765
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Jul 2021 07:58:12 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:bcf3:b2b1:dff6:480b])
        by andre.telenet-ops.be with bizsmtp
        id V2yA2500L4sai0K012yA18; Wed, 14 Jul 2021 16:58:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3gKw-001AEm-H8; Wed, 14 Jul 2021 16:58:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m3gKv-00AcNX-Vv; Wed, 14 Jul 2021 16:58:09 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH resend 5/5] video: fbdev: ssd1307fb: Cache address ranges
Date:   Wed, 14 Jul 2021 16:58:04 +0200
Message-Id: <20210714145804.2530727-6-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210714145804.2530727-1-geert@linux-m68k.org>
References: <20210714145804.2530727-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Cache the column and page ranges, to avoid doing unneeded I2C transfers
when the values haven't changed.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/ssd1307fb.c | 52 +++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 8e3d4be74723b9bf..23b43ce479898813 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -82,6 +82,11 @@ struct ssd1307fb_par {
 	struct regulator *vbat_reg;
 	u32 vcomh;
 	u32 width;
+	/* Cached address ranges */
+	u8 col_start;
+	u8 col_end;
+	u8 page_start;
+	u8 page_end;
 };
 
 struct ssd1307fb_array {
@@ -160,28 +165,43 @@ static int ssd1307fb_set_address_range(struct ssd1307fb_par *par, u8 col_start,
 	int ret;
 
 	/* Set column range */
-	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
-	if (ret < 0)
-		return ret;
+	if (col_start != par->col_start || col_end != par->col_end) {
+		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
+		if (ret < 0)
+			return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, col_start);
-	if (ret < 0)
-		return ret;
+		ret = ssd1307fb_write_cmd(par->client, col_start);
+		if (ret < 0)
+			return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, col_end);
-	if (ret < 0)
-		return ret;
+		ret = ssd1307fb_write_cmd(par->client, col_end);
+		if (ret < 0)
+			return ret;
+
+		par->col_start = col_start;
+		par->col_end = col_end;
+	}
 
 	/* Set page range */
-	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
-	if (ret < 0)
-		return ret;
+	if (page_start != par->page_start || page_end != par->page_end) {
+		ret = ssd1307fb_write_cmd(par->client,
+					  SSD1307FB_SET_PAGE_RANGE);
+		if (ret < 0)
+			return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, page_start);
-	if (ret < 0)
-		return ret;
+		ret = ssd1307fb_write_cmd(par->client, page_start);
+		if (ret < 0)
+			return ret;
+
+		ret = ssd1307fb_write_cmd(par->client, page_end);
+		if (ret < 0)
+			return ret;
 
-	return ssd1307fb_write_cmd(par->client, page_end);
+		par->page_start = page_start;
+		par->page_end = page_end;
+	}
+
+	return 0;
 }
 
 static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
-- 
2.25.1

