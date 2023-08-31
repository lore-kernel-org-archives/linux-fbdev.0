Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8118C83F01
	for <linux-fbdev@archiver.kernel.org>; Thu, 31 Aug 2023 12:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbjHaMGF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 31 Aug 2023 08:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjHaMGA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 31 Aug 2023 08:06:00 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB51C5
        for <linux-fbdev@vger.kernel.org>; Thu, 31 Aug 2023 05:05:57 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6c13:6b1b:7366:87c0])
        by laurent.telenet-ops.be with bizsmtp
        id gC5v2A00V3874jb01C5vkN; Thu, 31 Aug 2023 14:05:55 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qbgQg-00275z-Qp;
        Thu, 31 Aug 2023 14:05:55 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qbgQt-00CIgY-88;
        Thu, 31 Aug 2023 14:05:55 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] fbdev: ssd1307fb: Use bool for ssd1307fb_deviceinfo flags
Date:   Thu, 31 Aug 2023 14:05:54 +0200
Message-Id: <303bb1a5012862f0003d3246a0c8120b97ea995b.1693483416.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The .need_pwm and .need_chargepump fields in struct ssd1307fb_deviceinfo
are flags that can have only two possible values: 0 and 1.
Reduce kernel size by changing their types from int to bool.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/ssd1307fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 86dd24022871a843..5ae48e36fccb4e8d 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -52,8 +52,8 @@ struct ssd1307fb_deviceinfo {
 	u32 default_vcomh;
 	u32 default_dclk_div;
 	u32 default_dclk_frq;
-	int need_pwm;
-	int need_chargepump;
+	bool need_pwm;
+	bool need_chargepump;
 };
 
 struct ssd1307fb_par {
-- 
2.34.1

