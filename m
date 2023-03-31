Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B30C76196
	for <linux-fbdev@archiver.kernel.org>; Fri, 31 Mar 2023 09:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCaJX1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 31 Mar 2023 05:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCaJXX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 31 Mar 2023 05:23:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F74113F0
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Mar 2023 02:23:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 93A461FE98;
        Fri, 31 Mar 2023 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680254597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJcSgdFmnfHrJ0ZpRg1xALi+u5FWWw3afSDEFFON944=;
        b=zN/ymXKRSusdwLtH16DRQEN1rStQXkM6RDSphAYIculyHnWg+RLsnDiE0ESSLvsTtlwLgd
        gVAKGGAynEcDg1bKCGZO3WDYQn9/1ER9xH2px3OkfrBCmwD4QJZ9Kx6H8XimVShfxKewHA
        3DTg1QJfrUdR0ADRu8Badppco8sbA3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680254597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IJcSgdFmnfHrJ0ZpRg1xALi+u5FWWw3afSDEFFON944=;
        b=OjRzprPPhRZlmUsuwAQaYv0OA65D0eDZMiswbRFpIkDhrEkVe26DmOGzenqnycMOEVirFq
        yL69c0SOdH/2PHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 787E9133B6;
        Fri, 31 Mar 2023 09:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iC2hHIWmJmTsOwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 31 Mar 2023 09:23:17 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 07/15] fbdev/hpfb: Remove trailing whitespaces
Date:   Fri, 31 Mar 2023 11:23:06 +0200
Message-Id: <20230331092314.2209-8-tzimmermann@suse.de>
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
 drivers/video/fbdev/hpfb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/hpfb.c b/drivers/video/fbdev/hpfb.c
index cdd44e5deafe..77fbff47b1a8 100644
--- a/drivers/video/fbdev/hpfb.c
+++ b/drivers/video/fbdev/hpfb.c
@@ -92,7 +92,7 @@ static int hpfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 	if (regno >= info->cmap.len)
 		return 1;
-	
+
 	while (in_be16(fb_regs + 0x6002) & 0x4) udelay(1);
 
 	out_be16(fb_regs + 0x60ba, 0xff);
@@ -143,7 +143,7 @@ static void topcat_blit(int x0, int y0, int x1, int y1, int w, int h, int rr)
 	out_8(fb_regs + WMOVE, fb_bitmask);
 }
 
-static void hpfb_copyarea(struct fb_info *info, const struct fb_copyarea *area) 
+static void hpfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 {
 	topcat_blit(area->sx, area->sy, area->dx, area->dy, area->width, area->height, RR_COPY);
 }
@@ -315,7 +315,7 @@ static int hpfb_init_one(unsigned long phys_base, unsigned long virt_base)
 	return ret;
 }
 
-/* 
+/*
  * Check that the secondary ID indicates that we have some hope of working with this
  * framebuffer.  The catseye boards are pretty much like topcats and we can muddle through.
  */
@@ -323,7 +323,7 @@ static int hpfb_init_one(unsigned long phys_base, unsigned long virt_base)
 #define topcat_sid_ok(x)  (((x) == DIO_ID2_LRCATSEYE) || ((x) == DIO_ID2_HRCCATSEYE)    \
 			   || ((x) == DIO_ID2_HRMCATSEYE) || ((x) == DIO_ID2_TOPCAT))
 
-/* 
+/*
  * Initialise the framebuffer
  */
 static int hpfb_dio_probe(struct dio_dev *d, const struct dio_device_id *ent)
-- 
2.40.0

