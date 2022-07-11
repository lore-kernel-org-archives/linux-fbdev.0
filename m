Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29085CCA480
	for <linux-fbdev@archiver.kernel.org>; Mon, 11 Jul 2022 15:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiGKPvH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGKPu7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 11 Jul 2022 11:50:59 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AE077A51
        for <linux-fbdev@vger.kernel.org>; Mon, 11 Jul 2022 08:50:40 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id trqe2700J4C55Sk01rqe5Y; Mon, 11 Jul 2022 17:50:38 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgD-0036xI-Rt; Mon, 11 Jul 2022 17:50:37 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgD-006siC-6A; Mon, 11 Jul 2022 17:50:37 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 10/10] [RFC] video: fbdev: atari: Remove backward bug-compatibility
Date:   Mon, 11 Jul 2022 17:50:34 +0200
Message-Id: <52d52566a80bfd00acdcfc28a24799d3fbf638f6.1657554353.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657554353.git.geert@linux-m68k.org>
References: <cover.1657554353.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

As of v2.1.0, falcon_decode_var() contains a quirk to fix a rounding
error, as explained by Günther Kelleter on Fri, 30 Aug 1996:

    This diff removes the now obsolete Falcon video option "pwrsave", and
    fixes a rounding error that is triggered by the resolution switching X
    server (those who use the pixel clock value 39722 in their /etc/fb.modes
    should change it to 39721).

However, this causes the modified video mode returned by
falcon_decode_var() to not match the video mode returned by
falcon_encode_var().  Fix this by dropping the quirk.

Unfortunately /etc/fb.modes in fbset was never updated, so the
"640x480-60" mode still contains the wrong pixclock.
Hence this change may introduce a regression.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Any comments?
---
 drivers/video/fbdev/atafb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index e8b178e732e2c785..2bc4089865e60ac2 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -1008,10 +1008,6 @@ static int falcon_decode_var(struct fb_var_screeninfo *var,
 	else if (yres_virtual < yres)
 		yres_virtual = yres;
 
-	/* backward bug-compatibility */
-	if (var->pixclock > 1)
-		var->pixclock -= 1;
-
 	par->hw.falcon.line_width = bpp * xres / 16;
 	par->hw.falcon.line_offset = bpp * (xres_virtual - xres) / 16;
 
-- 
2.25.1

