Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80EC7C433ED
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 664E86108D
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 09:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347724AbhERJHS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 May 2021 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347709AbhERJHO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 May 2021 05:07:14 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F28C06175F
        for <linux-fbdev@vger.kernel.org>; Tue, 18 May 2021 02:05:56 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:c161:a89e:52bd:1787])
        by andre.telenet-ops.be with bizsmtp
        id 695s2500i446CkP0195sSN; Tue, 18 May 2021 11:05:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1livfk-006q2F-Dh; Tue, 18 May 2021 11:05:52 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1liv5J-0069n5-Lx; Tue, 18 May 2021 10:28:13 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/5] video: fbdev: ssd1307fb: Propagate errors via ssd1307fb_update_display()
Date:   Tue, 18 May 2021 10:28:05 +0200
Message-Id: <20210518082809.1467549-2-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210518082809.1467549-1-geert@linux-m68k.org>
References: <20210518082809.1467549-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Make ssd1307fb_update_display() return an error code, so callers that
can handle failures can propagate it.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/ssd1307fb.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index eda448b7a0c9d8ce..e6b6263e3bef847f 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -152,17 +152,17 @@ static inline int ssd1307fb_write_cmd(struct i2c_client *client, u8 cmd)
 	return ret;
 }
 
-static void ssd1307fb_update_display(struct ssd1307fb_par *par)
+static int ssd1307fb_update_display(struct ssd1307fb_par *par)
 {
 	struct ssd1307fb_array *array;
 	u8 *vmem = par->info->screen_buffer;
 	unsigned int line_length = par->info->fix.line_length;
 	unsigned int pages = DIV_ROUND_UP(par->height, 8);
-	int i, j, k;
+	int ret, i, j, k;
 
 	array = ssd1307fb_alloc_array(par->width * pages, SSD1307FB_DATA);
 	if (!array)
-		return;
+		return -ENOMEM;
 
 	/*
 	 * The screen is divided in pages, each having a height of 8
@@ -210,8 +210,9 @@ static void ssd1307fb_update_display(struct ssd1307fb_par *par)
 		}
 	}
 
-	ssd1307fb_write_array(par->client, array, par->width * pages);
+	ret = ssd1307fb_write_array(par->client, array, par->width * pages);
 	kfree(array);
+	return ret;
 }
 
 
@@ -222,6 +223,7 @@ static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
 	unsigned long total_size;
 	unsigned long p = *ppos;
 	void *dst;
+	int ret;
 
 	total_size = info->fix.smem_len;
 
@@ -239,7 +241,9 @@ static ssize_t ssd1307fb_write(struct fb_info *info, const char __user *buf,
 	if (copy_from_user(dst, buf, count))
 		return -EFAULT;
 
-	ssd1307fb_update_display(par);
+	ret = ssd1307fb_update_display(par);
+	if (ret < 0)
+		return ret;
 
 	*ppos += count;
 
@@ -483,7 +487,9 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		return ret;
 
 	/* Clear the screen */
-	ssd1307fb_update_display(par);
+	ret = ssd1307fb_update_display(par);
+	if (ret < 0)
+		return ret;
 
 	/* Turn on the display */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
-- 
2.25.1

