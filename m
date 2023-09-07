Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC64EC873E
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Sep 2023 15:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbjIGPqu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbjIGPaq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Sep 2023 11:30:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB091BFF;
        Thu,  7 Sep 2023 08:30:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C905F1F898;
        Thu,  7 Sep 2023 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694076851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aawKCKKwk4neSGVDzo2vKyR/qAgiaU0o0fBQ2B3exmA=;
        b=y3qnyyeqLd39yhqyvmYTvaWFkrDCKhjSO/1a2wudRsyAAL08EwhR8cRb6R+DTiAuWh6cZf
        JAxBjhp/PBl/aiODVRhnNIZnLv/VCCnWYAPmbiutvlmG5VpHJrCe8kB/LwodinTdsWzWlM
        Wf7AVCTRnGHQ87+5/AD91WffkqIH1H0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694076851;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aawKCKKwk4neSGVDzo2vKyR/qAgiaU0o0fBQ2B3exmA=;
        b=kV/QoUNiJniOA3dz0zN+UZ+vmykt87ewwahuvA4GIAnmRduduf39xBTDWTt3IFZnSf43DX
        sAACmKTV9lCbhqDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AD8813ADD;
        Thu,  7 Sep 2023 08:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2KPmJLOP+WT6JgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 07 Sep 2023 08:54:11 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, daniel@ffwll.ch, javierm@redhat.com,
        sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 6/7] fbdev/core: Remove empty internal helpers from fb_logo.c
Date:   Thu,  7 Sep 2023 10:52:05 +0200
Message-ID: <20230907085408.9354-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230907085408.9354-1-tzimmermann@suse.de>
References: <20230907085408.9354-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove the two empty helpers for the case the CONFIG_FB_LOGO_EXTRA
has not been set. They are internal functions and only called once.
Providing empty replacements seems like overkill. Instead protect
the call sites with a test for CONFIG_FB_LOGO_EXTRA.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/video/fbdev/core/fb_logo.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_logo.c b/drivers/video/fbdev/core/fb_logo.c
index 6897f7a898fc..0bab8352b684 100644
--- a/drivers/video/fbdev/core/fb_logo.c
+++ b/drivers/video/fbdev/core/fb_logo.c
@@ -413,21 +413,6 @@ static int fb_show_extra_logos(struct fb_info *info, int y, int rotate)
 
 	return y;
 }
-
-#else /* !CONFIG_FB_LOGO_EXTRA */
-
-static inline int fb_prepare_extra_logos(struct fb_info *info,
-					 unsigned int height,
-					 unsigned int yres)
-{
-	return height;
-}
-
-static inline int fb_show_extra_logos(struct fb_info *info, int y, int rotate)
-{
-	return y;
-}
-
 #endif /* CONFIG_FB_LOGO_EXTRA */
 
 int fb_prepare_logo(struct fb_info *info, int rotate)
@@ -498,8 +483,11 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	height = fb_logo.logo->height;
 	if (fb_center_logo)
 		height += (yres - fb_logo.logo->height) / 2;
+#ifdef CONFIG_FB_LOGO_EXTRA
+	height = fb_prepare_extra_logos(info, height, yres);
+#endif
 
-	return fb_prepare_extra_logos(info, height, yres);
+	return height;
 }
 
 int fb_show_logo(struct fb_info *info, int rotate)
@@ -512,7 +500,9 @@ int fb_show_logo(struct fb_info *info, int rotate)
 
 	count = fb_logo_count < 0 ? num_online_cpus() : fb_logo_count;
 	y = fb_show_logo_line(info, rotate, fb_logo.logo, 0, count);
+#ifdef CONFIG_FB_LOGO_EXTRA
 	y = fb_show_extra_logos(info, y, rotate);
+#endif
 
 	return y;
 }
-- 
2.42.0

