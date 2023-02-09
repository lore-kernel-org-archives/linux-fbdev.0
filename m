Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72DAC636D6
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Feb 2023 13:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjBINzW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Feb 2023 08:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjBINzS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Feb 2023 08:55:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D95BA47
        for <linux-fbdev@vger.kernel.org>; Thu,  9 Feb 2023 05:55:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3F99422A1C;
        Thu,  9 Feb 2023 13:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1675950915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwfR56fbuvo/MTtNd66Z0ieJlINfxnc673WXqwCPhUo=;
        b=slW/zNLmt7PqCtBY4PkTg9bqTEq4TrXg9jivZrHOg9VS7y44jRth1wfoUs6OmGfKzDIZQ+
        7k8F/9ABuOMEi2WVRYf/Q+dJUD9b3jLf7AzbI3F6vYbT1pdO02IHzFLyky3vumxhxlmhxl
        yAyUkiVrlNVKnZf6egj45VUmx7u18AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1675950915;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwfR56fbuvo/MTtNd66Z0ieJlINfxnc673WXqwCPhUo=;
        b=LI9oqUHUjxx48qBXEZ1ggfFn05NONmrCTtN5Yt57T+rCVaMLahL9D+GGqUzaZtpgaOtm0O
        A56+cDKRDTGNqcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E47CF13915;
        Thu,  9 Feb 2023 13:55:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mBXLNkL75GNTfwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Feb 2023 13:55:14 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@gmail.com, deller@gmx.de,
        javierm@redhat.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, geoff@infradead.org, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 09/11] driver/ps3: Include <video/cmdline.h> for mode parsing
Date:   Thu,  9 Feb 2023 14:55:07 +0100
Message-Id: <20230209135509.7786-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209135509.7786-1-tzimmermann@suse.de>
References: <20230209135509.7786-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Include <video/cmdline.h> in ps3av.c to get video_get_options() and
avoid the dependency on <linux/fb.h>. The replaced function
fb_get_options() is just a tiny wrapper around video_get_opions(). No
functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/ps3/ps3av.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/ps3/ps3av.c b/drivers/ps3/ps3av.c
index 8f3e60f1bfe2..f6c9e56bdba7 100644
--- a/drivers/ps3/ps3av.c
+++ b/drivers/ps3/ps3av.c
@@ -11,13 +11,14 @@
 #include <linux/delay.h>
 #include <linux/notifier.h>
 #include <linux/ioctl.h>
-#include <linux/fb.h>
 #include <linux/slab.h>
 
 #include <asm/firmware.h>
 #include <asm/ps3av.h>
 #include <asm/ps3.h>
 
+#include <video/cmdline.h>
+
 #include "vuart.h"
 
 #define BUFSIZE          4096	/* vuart buf size */
@@ -921,9 +922,7 @@ EXPORT_SYMBOL_GPL(ps3av_audio_mute);
 
 static int ps3av_probe(struct ps3_system_bus_device *dev)
 {
-#ifdef CONFIG_FB
-	char *mode_option = NULL;
-#endif
+	const char *mode_option;
 	int res;
 	int id;
 
@@ -971,14 +970,9 @@ static int ps3av_probe(struct ps3_system_bus_device *dev)
 
 	ps3av_get_hw_conf(ps3av);
 
-#ifdef CONFIG_FB
-	fb_get_options(NULL, &mode_option);
-	if (mode_option) {
-		if (!strcmp(mode_option, "safe"))
-			safe_mode = 1;
-		kfree(mode_option);
-	}
-#endif /* CONFIG_FB */
+	mode_option = video_get_options(NULL);
+	if (mode_option && !strcmp(mode_option, "safe"))
+		safe_mode = 1;
 	id = ps3av_auto_videomode(&ps3av->av_hw_conf);
 	if (id < 0) {
 		printk(KERN_ERR "%s: invalid id :%d\n", __func__, id);
-- 
2.39.1

