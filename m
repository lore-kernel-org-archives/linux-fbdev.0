Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABD9C4338F
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 13:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F78619F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 13:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhG0Ntm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Jul 2021 09:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbhG0Ntg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Jul 2021 09:49:36 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056BFC0619DC
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Jul 2021 06:47:37 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:b0a9:7e88:5ca4:551a])
        by baptiste.telenet-ops.be with bizsmtp
        id aDnb2500B1fSPfK01DnbQn; Tue, 27 Jul 2021 15:47:35 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8NQk-001Pc7-W3; Tue, 27 Jul 2021 15:47:34 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m8NQk-00Fnhe-FW; Tue, 27 Jul 2021 15:47:34 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <mripard@kernel.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 5/5] video: fbdev: ssd1307fb: Cache address ranges
Date:   Tue, 27 Jul 2021 15:47:30 +0200
Message-Id: <20210727134730.3765898-6-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210727134730.3765898-1-geert@linux-m68k.org>
References: <20210727134730.3765898-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Cache the column and page ranges, to avoid doing unneeded I2C transfers
when the values haven't changed.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
---
v2:
  - Add Acked-by,
  - Rebase.
---
 drivers/video/fbdev/ssd1307fb.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 9aed5ee0094f2d95..1e2f71c2f8a8bc78 100644
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
@@ -158,6 +163,9 @@ static int ssd1307fb_set_col_range(struct ssd1307fb_par *par, u8 col_start,
 	u8 col_end = col_start + cols - 1;
 	int ret;
 
+	if (col_start == par->col_start && col_end == par->col_end)
+		return 0;
+
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_COL_RANGE);
 	if (ret < 0)
 		return ret;
@@ -166,7 +174,13 @@ static int ssd1307fb_set_col_range(struct ssd1307fb_par *par, u8 col_start,
 	if (ret < 0)
 		return ret;
 
-	return ssd1307fb_write_cmd(par->client, col_end);
+	ret = ssd1307fb_write_cmd(par->client, col_end);
+	if (ret < 0)
+		return ret;
+
+	par->col_start = col_start;
+	par->col_end = col_end;
+	return 0;
 }
 
 static int ssd1307fb_set_page_range(struct ssd1307fb_par *par, u8 page_start,
@@ -175,6 +189,9 @@ static int ssd1307fb_set_page_range(struct ssd1307fb_par *par, u8 page_start,
 	u8 page_end = page_start + pages - 1;
 	int ret;
 
+	if (page_start == par->page_start && page_end == par->page_end)
+		return 0;
+
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_PAGE_RANGE);
 	if (ret < 0)
 		return ret;
@@ -183,7 +200,13 @@ static int ssd1307fb_set_page_range(struct ssd1307fb_par *par, u8 page_start,
 	if (ret < 0)
 		return ret;
 
-	return ssd1307fb_write_cmd(par->client, page_end);
+	ret = ssd1307fb_write_cmd(par->client, page_end);
+	if (ret < 0)
+		return ret;
+
+	par->page_start = page_start;
+	par->page_end = page_end;
+	return 0;
 }
 
 static int ssd1307fb_update_rect(struct ssd1307fb_par *par, unsigned int x,
-- 
2.25.1

