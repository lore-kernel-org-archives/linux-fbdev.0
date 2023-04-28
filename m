Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EDEC77B7F
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Apr 2023 12:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345755AbjD1MZL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Apr 2023 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjD1MZB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Apr 2023 08:25:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5374497
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Apr 2023 05:25:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 14C2521F5A;
        Fri, 28 Apr 2023 12:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682684699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=USWD/iAP7VvqqS3jPSlmBxxzXVWGLapBVB8uaV1NxOA=;
        b=E4OkxnLj/rzTA3OfbhOCfRrGELmaLeAFEvG64XLxRt9yatrssiF/T7m6Y3UkCD1MC+j3NC
        gFmldcPWYuGCHnd6+ZDn6XZMKbpL1i0vz0eRSNfWdNUwIeqd4g/NbML8rSYKLU8z+W8f44
        rEXft8aPv3MYVgZqa23D6pFeeSfuyOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682684699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=USWD/iAP7VvqqS3jPSlmBxxzXVWGLapBVB8uaV1NxOA=;
        b=R8oSraXaq4QLD0d8BDxj9QStOHaKorDiWYMHPoDWtRTKXSkt0BZLNE5f4ntgQ2sFtYoy7a
        8Wu88pxbXeUeVcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C37DF1390E;
        Fri, 28 Apr 2023 12:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aAzpLhq7S2RgeAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 28 Apr 2023 12:24:58 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 12/19] fbdev/vfb: Use struct fb_info.screen_buffer
Date:   Fri, 28 Apr 2023 14:24:45 +0200
Message-Id: <20230428122452.4856-13-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428122452.4856-1-tzimmermann@suse.de>
References: <20230428122452.4856-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use info->screen_buffer when reading and writing framebuffers in
system memory. It's the correct pointer for this address space.

The struct fb_info has a union to store the framebuffer memory. This can
either be info->screen_base if the framebuffer is stored in I/O memory,
or info->screen_buffer if the framebuffer is stored in system memory.

As the driver operates on the latter address space, it is wrong to use
.screen_base and .screen_buffer must be used instead. This also gets
rid of casting needed due to not using the correct data type.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/vfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index a0a2009e003e..43c5ac90d527 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -440,7 +440,7 @@ static int vfb_probe(struct platform_device *dev)
 	if (!info)
 		goto err;
 
-	info->screen_base = (char __iomem *)videomemory;
+	info->screen_buffer = videomemory;
 	info->fbops = &vfb_ops;
 
 	if (!fb_find_mode(&info->var, info, mode_option,
-- 
2.40.0

