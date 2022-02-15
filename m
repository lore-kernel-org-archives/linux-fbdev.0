Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D9DC433FE
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Feb 2022 11:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbiBOLVr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:21:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiBOLVr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Feb 2022 06:21:47 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809E3AA2E1
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Feb 2022 03:21:36 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:8c73:faf1:1d11:4a47])
        by laurent.telenet-ops.be with bizsmtp
        id vPMZ2600A3BmCM301PMZ7K; Tue, 15 Feb 2022 12:21:33 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nJvtk-000rqf-KT; Tue, 15 Feb 2022 12:21:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nJvtk-00B351-6e; Tue, 15 Feb 2022 12:21:32 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] video: fbdev: atari: Remove unused atafb_setcolreg()
Date:   Tue, 15 Feb 2022 12:21:26 +0100
Message-Id: <20220215112126.2633383-4-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220215112126.2633383-1-geert@linux-m68k.org>
References: <20220215112126.2633383-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

atafb_probe() overrides the atafb_ops.fb_setcolreg() method to match the
actual graphics hardware.  Besides, the shifts by 8 were bogus, as the
individual .fb_setcolreg() implementations already take care of that.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index b9d6aaaeae43f2f1..e95333e004744bf5 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2404,16 +2404,6 @@ static void atafb_set_disp(struct fb_info *info)
 				atari_stram_to_virt(info->fix.smem_start));
 }
 
-static int atafb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-			   u_int transp, struct fb_info *info)
-{
-	red >>= 8;
-	green >>= 8;
-	blue >>= 8;
-
-	return info->fbops->fb_setcolreg(regno, red, green, blue, transp, info);
-}
-
 static int
 atafb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 {
@@ -2724,7 +2714,6 @@ static struct fb_ops atafb_ops = {
 	.owner =	THIS_MODULE,
 	.fb_check_var	= atafb_check_var,
 	.fb_set_par	= atafb_set_par,
-	.fb_setcolreg	= atafb_setcolreg,
 	.fb_blank =	atafb_blank,
 	.fb_pan_display	= atafb_pan_display,
 	.fb_fillrect	= atafb_fillrect,
-- 
2.25.1

