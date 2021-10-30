Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05D8C433F5
	for <linux-fbdev@archiver.kernel.org>; Sat, 30 Oct 2021 16:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C2660E0B
	for <linux-fbdev@archiver.kernel.org>; Sat, 30 Oct 2021 16:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhJ3Qjp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 30 Oct 2021 12:39:45 -0400
Received: from asav21.altibox.net ([109.247.116.8]:50660 "EHLO
        asav21.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhJ3Qjp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 30 Oct 2021 12:39:45 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Oct 2021 12:39:44 EDT
Received: from localhost.localdomain (211.81-166-168.customer.lyse.net [81.166.168.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: noralf.tronnes@ebnett.no)
        by asav21.altibox.net (Postfix) with ESMTPSA id 3C0E08009D;
        Sat, 30 Oct 2021 18:29:26 +0200 (CEST)
From:   =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        stable@vger.kernel.org
Subject: [PATCH] staging/fbtft: Fix backlight
Date:   Sat, 30 Oct 2021 18:29:01 +0200
Message-Id: <20211030162901.17918-1-noralf@tronnes.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Dq54Bl3+ c=1 sm=1 tr=0
        a=OYZzhG0JTxDrWp/F2OJbnw==:117 a=OYZzhG0JTxDrWp/F2OJbnw==:17
        a=IkcTkHD0fZMA:10 a=M51BFTxLslgA:10 a=VwQbUJbxAAAA:8 a=SJz97ENfAAAA:8
        a=p9cCCTTYX0JvZlB5OkkA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
        a=vFet0B0WnEQeilDPIY6i:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Commit b4a1ed0cd18b ("fbdev: make FB_BACKLIGHT a tristate") forgot to
update fbtft breaking its backlight support when FB_BACKLIGHT is a module.

Fix this by using IS_ENABLED().

Fixes: b4a1ed0cd18b ("fbdev: make FB_BACKLIGHT a tristate")
Cc: <stable@vger.kernel.org>
Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/staging/fbtft/fbtft-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index ed992ca605eb..ff979f1eeee8 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -128,7 +128,7 @@ static int fbtft_request_gpios(struct fbtft_par *par)
 	return 0;
 }
 
-#ifdef CONFIG_FB_BACKLIGHT
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 static int fbtft_backlight_update_status(struct backlight_device *bd)
 {
 	struct fbtft_par *par = bl_get_data(bd);
@@ -853,7 +853,7 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
 		 fb_info->fix.smem_len >> 10, text1,
 		 HZ / fb_info->fbdefio->delay, text2);
 
-#ifdef CONFIG_FB_BACKLIGHT
+#if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	/* Turn on backlight if available */
 	if (fb_info->bl_dev) {
 		fb_info->bl_dev->props.power = FB_BLANK_UNBLANK;
-- 
2.33.0

