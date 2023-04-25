Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70599C6FD18
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 14:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjDYO2x (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjDYO2v (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 10:28:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E5D307
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 07:28:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4B30219AE;
        Tue, 25 Apr 2023 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682432929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+HXTfzHvCtey/8VylBhHx2YJ8SvB89ZYP/YSHdQ4+I=;
        b=OE82JL6hACMd5qu44KOIGG1R3GGSBoAABaJVPSocCFmk4gfxyfxRaD81sMENHmSjILdIb4
        s9Fz1uZXXEFhb34XoYS8wvuBI2BJ27kGOmLRJh8R6KmI36rzpaMDRLRfEVKwiB7vGtVw/b
        Idza6fBbwKOe7hSm3LKC2SQDYyWSuio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682432929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+HXTfzHvCtey/8VylBhHx2YJ8SvB89ZYP/YSHdQ4+I=;
        b=01CJK/8jLDZhk83Rhx54vUFdoxWqK4po5oJV8JsftNiXEviMDnIqOq/cq/E0Lfbp2JAsmb
        nZmc8AIrPPFe1pCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67C5E138E3;
        Tue, 25 Apr 2023 14:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +OlfGKHjR2ReOgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 25 Apr 2023 14:28:49 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/6] fbdev: Use screen_buffer in fb_sys_{read,write}()
Date:   Tue, 25 Apr 2023 16:28:42 +0200
Message-Id: <20230425142846.730-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425142846.730-1-tzimmermann@suse.de>
References: <20230425142846.730-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use info->screen_buffer when reading and writing framebuffers in
system memory. It's the correct pointer for this address space.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_sys_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbdev/core/fb_sys_fops.c
index cefb77b9546d..6589123f4127 100644
--- a/drivers/video/fbdev/core/fb_sys_fops.c
+++ b/drivers/video/fbdev/core/fb_sys_fops.c
@@ -39,7 +39,7 @@ ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
 	if (count + p > total_size)
 		count = total_size - p;
 
-	src = (void __force *)(info->screen_base + p);
+	src = info->screen_buffer + p;
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
@@ -87,7 +87,7 @@ ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 		count = total_size - p;
 	}
 
-	dst = (void __force *) (info->screen_base + p);
+	dst = info->screen_buffer + p;
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
-- 
2.40.0

