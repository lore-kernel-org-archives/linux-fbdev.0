Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2FCC636D6
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Feb 2023 13:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjBINz0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Feb 2023 08:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjBINzU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Feb 2023 08:55:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8624F5BA49
        for <linux-fbdev@vger.kernel.org>; Thu,  9 Feb 2023 05:55:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8BBC45D033;
        Thu,  9 Feb 2023 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675950915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LTaTXQl7Ph7tUuGylQ6ryNfXYsJmmkGD7j+C1k3qtoM=;
        b=DtpLAvd9BKfp41MBStPAMWug8yr4+0J7aMLfMMm5Gx0JzM9FeD4hW1FZqYtxuJy+98D/Ct
        vHW8tWp0O/LEE3S4hmuqevKRtwsnQK6peEV/L7inTePr7oImF9FJcAmFEqAJku12OH08jF
        G5ZuveCfUT/zYWu2nBgxR4zPb/+OhEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675950915;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LTaTXQl7Ph7tUuGylQ6ryNfXYsJmmkGD7j+C1k3qtoM=;
        b=Ko8a9NVaWGMHJqNrZNa6jjJJwkeMfyM6Yo5qJ0RWSG04fiXXKbTHJ627Eood7v2/xhEglM
        v7Rjq2K47w3PrIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 43DCD138E4;
        Thu,  9 Feb 2023 13:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iOqRD0P75GNTfwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Feb 2023 13:55:15 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, geoff@infradead.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 10/11] drm: Include <video/cmdline.h> for mode parsing
Date:   Thu,  9 Feb 2023 14:55:08 +0100
Message-Id: <20230209135509.7786-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209135509.7786-1-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Include <video/cmdline.h> in drm_connector.c to get video_get_options()
and avoid the dependency on <linux/fb.h>. The replaced function
fb_get_options() is just a tiny wrapper around video_get_opions(). No
functional changes.

Include <linux/property.h> to get fwnode_handle_put(), which had been
provided via <linux/fb.h>.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_connector.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 9d0250c28e9b..ca5fb54b7aab 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -33,9 +33,11 @@
 #include <drm/drm_sysfs.h>
 #include <drm/drm_utils.h>
 
-#include <linux/fb.h>
+#include <linux/property.h>
 #include <linux/uaccess.h>
 
+#include <video/cmdline.h>
+
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
 
@@ -154,9 +156,10 @@ EXPORT_SYMBOL(drm_get_connector_type_name);
 static void drm_connector_get_cmdline_mode(struct drm_connector *connector)
 {
 	struct drm_cmdline_mode *mode = &connector->cmdline_mode;
-	char *option = NULL;
+	const char *option;
 
-	if (fb_get_options(connector->name, &option))
+	option = video_get_options(connector->name);
+	if (!option)
 		return;
 
 	if (!drm_mode_parse_command_line_for_connector(option,
-- 
2.39.1

