Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD4DCCA483
	for <linux-fbdev@archiver.kernel.org>; Fri,  8 Jul 2022 18:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239140AbiGHSWl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 8 Jul 2022 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239287AbiGHSVq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 8 Jul 2022 14:21:46 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A182D83F32
        for <linux-fbdev@vger.kernel.org>; Fri,  8 Jul 2022 11:21:40 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id siMf2700o4C55Sk06iMfjY; Fri, 08 Jul 2022 20:21:40 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbg-002fKq-Tg; Fri, 08 Jul 2022 20:21:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o9sbg-00BtQ5-AW; Fri, 08 Jul 2022 20:21:36 +0200
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
Subject: [PATCH 5/5] drm/modes: parse_cmdline: Add support for named modes containing dashes
Date:   Fri,  8 Jul 2022 20:21:29 +0200
Message-Id: <4788a9c346d6b650964402e0e26c33e739f02c7c.1657301107.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657301107.git.geert@linux-m68k.org>
References: <cover.1657301107.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

It is fairly common for named video modes to contain dashes (e.g.
"tt-mid" on Atari, "dblntsc-ff" on Amiga).  Currently such mode names
are not recognized, as the dash is considered to be a separator between
mode name and bpp.

Fix this by skipping any dashes that are not followed immediately by a
digit when looking for the separator.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/gpu/drm/drm_modes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 7a00eb6df502e991..52e852518c6ad8e9 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1828,6 +1828,8 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 
 	/* Try to locate the bpp and refresh specifiers, if any */
 	bpp_ptr = strchr(name, '-');
+	while (bpp_ptr && !isdigit(bpp_ptr[1]))
+		bpp_ptr = strchr(bpp_ptr + 1, '-');
 	if (bpp_ptr)
 		bpp_off = bpp_ptr - name;
 
-- 
2.25.1

