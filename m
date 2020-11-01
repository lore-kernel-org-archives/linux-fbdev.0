Return-Path: <SRS0=n/V2=EH=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5059C55178
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 10:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D1E2071A
	for <linux-fbdev@archiver.kernel.org>; Sun,  1 Nov 2020 10:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgKAK3p (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 1 Nov 2020 05:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgKAK3p (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sun, 1 Nov 2020 05:29:45 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E4BC0617A6
        for <linux-fbdev@vger.kernel.org>; Sun,  1 Nov 2020 02:29:44 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id myVi2300B4C55Sk01yVi9K; Sun, 01 Nov 2020 11:29:42 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kZAcI-001vTN-Dq; Sun, 01 Nov 2020 11:29:42 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kZAcH-00C871-TI; Sun, 01 Nov 2020 11:29:41 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Michael Schmitz <schmitzmic@gmail.com>
Cc:     linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC v2] video: fbdev: atari: Fix TT High video mode
Date:   Sun,  1 Nov 2020 11:29:41 +0100
Message-Id: <20201101102941.2891076-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The horizontal resolution (640) for the TT High video mode (1280x960) is
definitely bogus.  While fixing that, correct the timings to match the
TTM195 service manual.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Untested on actual hardware, hence the RFC.

v2:
  - Use correct base.
---
 drivers/video/fbdev/atafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index f253daa05d9d3872..5ecf3ec9f94cb720 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -495,8 +495,8 @@ static struct fb_videomode atafb_modedb[] __initdata = {
 		"tt-mid", 60, 640, 480, 31041, 120, 100, 8, 16, 140, 30,
 		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
 	}, {
-		/* 1280x960, 29 kHz, 60 Hz (TT high) */
-		"tt-high", 57, 640, 960, 31041, 120, 100, 8, 16, 140, 30,
+		/* 1280x960, 72 kHz, 72 Hz (TT high) */
+		"tt-high", 57, 1280, 960, 7761, 260, 60, 36, 4, 192, 4,
 		0, FB_VMODE_NONINTERLACED | FB_VMODE_YWRAP
 	},
 
-- 
2.25.1

