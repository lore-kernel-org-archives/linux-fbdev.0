Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05BFC76196
	for <linux-fbdev@archiver.kernel.org>; Fri, 31 Mar 2023 09:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjCaJXa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 31 Mar 2023 05:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCaJXX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 31 Mar 2023 05:23:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98571A976
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Mar 2023 02:23:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3E3DC1FE9B;
        Fri, 31 Mar 2023 09:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680254598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/I6ead1u40Ck6jaluR9caZidI1V+/KOAX3RFpxN9mYM=;
        b=Yyw7B3srM3OeMva89KGCDbiiOcfrCXUQu7R2sC+JKsN7mjwLdIif447KL4q7jzRCwYL+jj
        SDyOHDS/tKsvpB84hprIvjvxuhuflCn6g4qsGooncBmK3upE5jQOA7xVfLYwFoZ5GFrneI
        xdP9G+MwQpWgH7GEmo2J1YG3HDU5bbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680254598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/I6ead1u40Ck6jaluR9caZidI1V+/KOAX3RFpxN9mYM=;
        b=r7YdIsrjBFaNYvxaGobBF6q+k9Qny16qdNcPi0X0f8ae7M7TyZiNtby5WrQJ0Z7C0aguh/
        tfLC5ShcB0s9lTBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 230B1133B6;
        Fri, 31 Mar 2023 09:23:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CO+hB4amJmTsOwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 31 Mar 2023 09:23:18 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 10/15] fbdev/p9100: Remove trailing whitespaces
Date:   Fri, 31 Mar 2023 11:23:09 +0200
Message-Id: <20230331092314.2209-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331092314.2209-1-tzimmermann@suse.de>
References: <20230331092314.2209-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/p9100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/p9100.c b/drivers/video/fbdev/p9100.c
index 4e88a0a195ad..10b4866b6c9a 100644
--- a/drivers/video/fbdev/p9100.c
+++ b/drivers/video/fbdev/p9100.c
@@ -65,7 +65,7 @@ static const struct fb_ops p9100_ops = {
 #define P9100_FB_OFF 0x0UL
 
 /* 3 bits: 2=8bpp 3=16bpp 5=32bpp 7=24bpp */
-#define SYS_CONFIG_PIXELSIZE_SHIFT 26 
+#define SYS_CONFIG_PIXELSIZE_SHIFT 26
 
 #define SCREENPAINT_TIMECTL1_ENABLE_VIDEO 0x20 /* 0 = off, 1 = on */
 
@@ -110,7 +110,7 @@ struct p9100_regs {
 	u32 vram_xxx[25];
 
 	/* Registers for IBM RGB528 Palette */
-	u32 ramdac_cmap_wridx; 
+	u32 ramdac_cmap_wridx;
 	u32 ramdac_palette_data;
 	u32 ramdac_pixel_mask;
 	u32 ramdac_palette_rdaddr;
-- 
2.40.0

