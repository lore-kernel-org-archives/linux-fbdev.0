Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3072AC43334
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Jul 2022 10:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiGNKjM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 14 Jul 2022 06:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiGNKjC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 14 Jul 2022 06:39:02 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D4129CB1
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Jul 2022 03:39:00 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id uyex270084C55Sk01yexDE; Thu, 14 Jul 2022 12:38:58 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oBvwx-003The-2S; Thu, 14 Jul 2022 12:20:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oBulZ-00Bf1n-I5; Thu, 14 Jul 2022 11:04:13 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 3/5] drm/modes: parse_cmdline: Make mode->*specified handling more uniform
Date:   Thu, 14 Jul 2022 11:04:08 +0200
Message-Id: <3696bcbf95fa1ae98f452c7ea32072642b46caa7.1657788997.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657788997.git.geert@linux-m68k.org>
References: <cover.1657788997.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The various mode->*specified flags are not handled in an uniform way:
some flags are set by the corresponding drm_mode_parse_cmdline_*()
function, some flags by the caller of the function, and some flags by
both.

Make this uniform by making this the responsibility of the various
parsing helpers, i.e.
  - Move the setting of mode->specified from caller to callee,
  - Drop the duplicate setting of mode->bpp_specified and
    mode->refresh_specified from callers.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---
v2:
  - Add Reviewed-by, Acked-by.
---
 drivers/gpu/drm/drm_modes.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index a3df18fccb31fa77..0cbf0467f263b30a 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1599,6 +1599,7 @@ static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
 	mode->yres = yres;
 	mode->cvt = cvt;
 	mode->rb = rb;
+	mode->specified = true;
 
 	return 0;
 }
@@ -1861,8 +1862,6 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 						      mode);
 		if (ret)
 			return false;
-
-		mode->specified = true;
 	}
 
 	/* No mode? Check for freestanding extras and/or options */
@@ -1884,8 +1883,6 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 		ret = drm_mode_parse_cmdline_bpp(bpp_ptr, &bpp_end_ptr, mode);
 		if (ret)
 			return false;
-
-		mode->bpp_specified = true;
 	}
 
 	if (refresh_ptr) {
@@ -1893,8 +1890,6 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 						     &refresh_end_ptr, mode);
 		if (ret)
 			return false;
-
-		mode->refresh_specified = true;
 	}
 
 	/*
-- 
2.25.1

