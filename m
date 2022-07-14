Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E352ECCA482
	for <linux-fbdev@archiver.kernel.org>; Thu, 14 Jul 2022 10:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiGNKUM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 14 Jul 2022 06:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbiGNKUL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 14 Jul 2022 06:20:11 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BECE2229A
        for <linux-fbdev@vger.kernel.org>; Thu, 14 Jul 2022 03:20:07 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id uyL32700G4C55Sk01yL3Cw; Thu, 14 Jul 2022 12:20:05 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oBvwx-003The-0z; Thu, 14 Jul 2022 12:20:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oBulZ-00Bf27-Ik; Thu, 14 Jul 2022 11:04:13 +0200
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
Subject: [PATCH v2 4/5] drm/modes: Add support for driver-specific named modes
Date:   Thu, 14 Jul 2022 11:04:09 +0200
Message-Id: <528b126b3d932bff055ff085e598b91e2e690a4e.1657788997.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657788997.git.geert@linux-m68k.org>
References: <cover.1657788997.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The mode parsing code recognizes named modes only if they are explicitly
listed in the internal whitelist, which is currently limited to "NTSC"
and "PAL".

Provide a mechanism for drivers to override this list to support custom
mode names.

Ideally, this list should just come from the driver's actual list of
modes, but connector->probed_modes is not yet populated at the time of
parsing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2:
  - Add Reviewed-by.
---
 drivers/gpu/drm/drm_modes.c | 15 +++++++++++----
 include/drm/drm_connector.h | 10 ++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
index 0cbf0467f263b30a..bfc3a08614522689 100644
--- a/drivers/gpu/drm/drm_modes.c
+++ b/drivers/gpu/drm/drm_modes.c
@@ -1748,24 +1748,30 @@ static int drm_mode_parse_cmdline_options(const char *str,
 static const char * const drm_named_modes_whitelist[] = {
 	"NTSC",
 	"PAL",
+	NULL
 };
 
 static int drm_mode_parse_cmdline_named_mode(const char *name,
 					     unsigned int length, bool refresh,
+					     const struct drm_connector *connector,
 					     struct drm_cmdline_mode *mode)
 {
+	const char * const *named_modes_whitelist;
 	unsigned int i;
 	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(drm_named_modes_whitelist); i++) {
-		ret = str_has_prefix(name, drm_named_modes_whitelist[i]);
+	named_modes_whitelist = connector->named_modes_whitelist ? :
+				drm_named_modes_whitelist;
+
+	for (i = 0; named_modes_whitelist[i]; i++) {
+		ret = str_has_prefix(name, named_modes_whitelist[i]);
 		if (ret != length)
 			continue;
 
 		if (refresh)
 			return -EINVAL; /* named + refresh is invalid */
 
-		strcpy(mode->name, drm_named_modes_whitelist[i]);
+		strcpy(mode->name, named_modes_whitelist[i]);
 		mode->specified = true;
 		return 0;
 	}
@@ -1849,7 +1855,8 @@ bool drm_mode_parse_command_line_for_connector(const char *mode_option,
 	/* First check for a named mode */
 	if (mode_end) {
 		ret = drm_mode_parse_cmdline_named_mode(name, mode_end,
-							refresh_ptr, mode);
+							refresh_ptr, connector,
+							mode);
 		if (ret)
 			return false;
 	}
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 3ac4bf87f2571c4c..6361f8a596c01107 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1659,6 +1659,16 @@ struct drm_connector {
 
 	/** @hdr_sink_metadata: HDR Metadata Information read from sink */
 	struct hdr_sink_metadata hdr_sink_metadata;
+
+	/**
+	 * @named_modes_whitelist:
+	 *
+	 * Optional NULL-terminated array of names to be considered valid mode
+	 * names.  This lets the command line option parser distinguish between
+	 * mode names and freestanding extras and/or options.
+	 * If not set, a set of defaults will be used.
+	 */
+	const char * const *named_modes_whitelist;
 };
 
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
-- 
2.25.1

