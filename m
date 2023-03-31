Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC6EC77B60
	for <linux-fbdev@archiver.kernel.org>; Fri, 31 Mar 2023 09:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCaJXY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 31 Mar 2023 05:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCaJXX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 31 Mar 2023 05:23:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9422BAF20
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Mar 2023 02:23:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DC90621B29;
        Fri, 31 Mar 2023 09:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680254596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6BDvmewT6vFBYy0qV6Q+CaZOwbZvK96nQnL6lmGYCY=;
        b=jFm88v83K7Z04zSb1JZMKXO4epA0Xgyv/YDucnMj5HWoAy/jFN/c36XX6jdkvJeKrKNvW3
        9A3sc3ZOPl8nOSADJEBdNW2Ae8EsJUOqUelELvHgKLepxFC5GJtUmikUxNWOrD44IIc1vC
        njhCcxngMrk5EjWkwiVA1r1QIf6n8OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680254596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K6BDvmewT6vFBYy0qV6Q+CaZOwbZvK96nQnL6lmGYCY=;
        b=CugmJ83sHI2XltuKmZR/tFHs723oq4Xl+11VGja9k5GFdFGi3yb/qo1pkDf2SFRh6qTs7g
        QnQkrsKdFlu2JbDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5FA3133B6;
        Fri, 31 Mar 2023 09:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SMmQK4SmJmTsOwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 31 Mar 2023 09:23:16 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/15] fbdev/atmel_lcdfb: Remove trailing whitespaces
Date:   Fri, 31 Mar 2023 11:23:01 +0200
Message-Id: <20230331092314.2209-3-tzimmermann@suse.de>
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
 drivers/video/fbdev/atmel_lcdfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 8187a7c4f910..987c5f5f0241 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -317,7 +317,7 @@ static inline void atmel_lcdfb_free_video_memory(struct atmel_lcdfb_info *sinfo)
 /**
  *	atmel_lcdfb_alloc_video_memory - Allocate framebuffer memory
  *	@sinfo: the frame buffer to allocate memory for
- * 	
+ *
  * 	This function is called only from the atmel_lcdfb_probe()
  * 	so no locking by fb_info->mm_lock around smem_len setting is needed.
  */
-- 
2.40.0

