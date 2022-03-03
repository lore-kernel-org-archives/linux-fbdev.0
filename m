Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14387C43217
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Mar 2022 20:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236393AbiCCU7e (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Mar 2022 15:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbiCCU7b (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 3 Mar 2022 15:59:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FDA46B20
        for <linux-fbdev@vger.kernel.org>; Thu,  3 Mar 2022 12:58:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1A552218EA;
        Thu,  3 Mar 2022 20:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646341123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DCmDk81nbdNEgBW4F9PrKTQOw7SN+B56i/UU6XlrFc=;
        b=XsjlJ8bQ9pVWTFSVfM3s7T7wTNoCLnwzZQQZbgXH3cYdIA27AmYeHD6fQpJwB7KGyrqsz+
        M0y+5nBARcs+DDtVc+0RLr/3H4g5nhq1gErGxmHlAlg5c5DsjUffk+xRbIr0hGFZRHqFTi
        smjA8d4VV3Y/lCQLkK5iRM2dXRUauOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646341123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1DCmDk81nbdNEgBW4F9PrKTQOw7SN+B56i/UU6XlrFc=;
        b=UZ7amyrYsEKBNszCR62lXM2CmlWGySWq5lMaqsr4gvQ+nVbmmcDXQlLCLU319PbqPov9Sz
        N/hVsevNa1KDibCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9AFC13AEE;
        Thu,  3 Mar 2022 20:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KDU8NAIsIWJoHAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 03 Mar 2022 20:58:42 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, deller@gmx.de,
        javierm@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 7/9] drm/fb-helper: Provide fbdev deferred-I/O helpers
Date:   Thu,  3 Mar 2022 21:58:37 +0100
Message-Id: <20220303205839.28484-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303205839.28484-1-tzimmermann@suse.de>
References: <20220303205839.28484-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Add drm_fb_helper_vm_page_mkwrite(), a helper to track pages written
by fbdev userspace. DRM drivers should use this function to implement
fbdev deferred I/O.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fb_helper.c | 10 ++++++++++
 include/drm/drm_fb_helper.h     |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 9d1140a789f4..6203f5ab33af 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -760,6 +760,16 @@ void drm_fb_helper_deferred_io(struct fb_info *info,
 }
 EXPORT_SYMBOL(drm_fb_helper_deferred_io);
 
+vm_fault_t drm_fb_helper_vm_page_mkwrite(struct drm_fb_helper *fb_helper, struct vm_fault *vmf)
+{
+	struct fb_info *info = fb_helper->fbdev;
+
+	if (!info->fbdefio)
+		return 0;
+	return fb_deferred_io_page_mkwrite(info, vmf);
+}
+EXPORT_SYMBOL(drm_fb_helper_vm_page_mkwrite);
+
 /**
  * drm_fb_helper_sys_read - wrapper around fb_sys_read
  * @info: fb_info struct pointer
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 3af4624368d8..8994c65f0b5a 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -232,6 +232,9 @@ void drm_fb_helper_fill_info(struct fb_info *info,
 void drm_fb_helper_deferred_io(struct fb_info *info,
 			       struct list_head *pagelist);
 
+vm_fault_t drm_fb_helper_vm_page_mkwrite(struct drm_fb_helper *fb_helper,
+					 struct vm_fault *vmf);
+
 ssize_t drm_fb_helper_sys_read(struct fb_info *info, char __user *buf,
 			       size_t count, loff_t *ppos);
 ssize_t drm_fb_helper_sys_write(struct fb_info *info, const char __user *buf,
@@ -355,6 +358,12 @@ static inline void drm_fb_helper_deferred_io(struct fb_info *info,
 {
 }
 
+static inline vm_fault_t drm_fb_helper_vm_page_mkwrite(struct drm_fb_helper *fb_helper,
+						       struct vm_fault *vmf)
+{
+	return 0;
+}
+
 static inline int drm_fb_helper_defio_init(struct drm_fb_helper *fb_helper)
 {
 	return -ENODEV;
-- 
2.35.1

