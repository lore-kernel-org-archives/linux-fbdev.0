Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C5C433B4
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C652761209
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347768AbhERJHi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 May 2021 05:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347707AbhERJHS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 May 2021 05:07:18 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52106C06138F
        for <linux-fbdev@vger.kernel.org>; Tue, 18 May 2021 02:05:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:c161:a89e:52bd:1787])
        by xavier.telenet-ops.be with bizsmtp
        id 695s2500Q446CkP0195sBf; Tue, 18 May 2021 11:05:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1livfk-006q2F-4x; Tue, 18 May 2021 11:05:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1liv5J-0069nz-PT; Tue, 18 May 2021 10:28:13 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/5] video: fbdev: ssd1307fb: Cache address ranges
Date:   Tue, 18 May 2021 10:28:09 +0200
Message-Id: <20210518082809.1467549-6-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518082809.1467549-1-geert@linux-m68k.org>
References: <20210518082809.1467549-1-geert@linux-m68k.org>
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

