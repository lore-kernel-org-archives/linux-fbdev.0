Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12E1C433B4
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61086108D
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347748AbhERJHc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 May 2021 05:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347715AbhERJHP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 May 2021 05:07:15 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBD9C061763
        for <linux-fbdev@vger.kernel.org>; Tue, 18 May 2021 02:05:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:c161:a89e:52bd:1787])
        by andre.telenet-ops.be with bizsmtp
        id 695s2500g446CkP0195sSM; Tue, 18 May 2021 11:05:52 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1livfk-006q2F-CB; Tue, 18 May 2021 11:05:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1liv5J-0069nB-Mi; Tue, 18 May 2021 10:28:13 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/5] video: fbdev: ssd1307fb: Simplify ssd1307fb_update_display()
Date:   Tue, 18 May 2021 10:28:06 +0200
Message-Id: <20210518082809.1467549-3-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518082809.1467549-1-geert@linux-m68k.org>
References: <20210518082809.1467549-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Simplify the nested loops to handle conversion from linear frame buffer
to ssd1307 page layout:
  1. Move last page handling one level up, as the value of "m" is the
     same inside a page,
  2. array->data[] is filled linearly, so there is no need to
     recalculate array_idx over and over again; a simple increment is
     sufficient.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/ssd1307fb.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index e6b6263e3bef847f..6d7bd025bca1a175 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -158,6 +158,7 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 	u8 *vmem = par->info->screen_buffer;
 	unsigned int line_length = par->info->fix.line_length;
 	unsigned int pages = DIV_ROUND_UP(par->height, 8);
+	u32 array_idx = 0;
 	int ret, i, j, k;
 
 	array = ssd1307fb_alloc_array(par->width * pages, SSD1307FB_DATA);
@@ -194,19 +195,21 @@ static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 	 */
 
 	for (i = 0; i < pages; i++) {
+		int m = 8;
+
+		/* Last page may be partial */
+		if (i + 1 == pages && par->height % 8)
+			m = par->height % 8;
 		for (j = 0; j < par->width; j++) {
-			int m = 8;
-			u32 array_idx = i * par->width + j;
-			array->data[array_idx] = 0;
-			/* Last page may be partial */
-			if (i + 1 == pages && par->height % 8)
-				m = par->height % 8;
+			u8 data = 0;
+
 			for (k = 0; k < m; k++) {
 				u8 byte = vmem[(8 * i + k) * line_length +
 					       j / 8];
 				u8 bit = (byte >> (j % 8)) & 1;
-				array->data[array_idx] |= bit << k;
+				data |= bit << k;
 			}
+			array->data[array_idx++] = data;
 		}
 	}
 
-- 
2.25.1

