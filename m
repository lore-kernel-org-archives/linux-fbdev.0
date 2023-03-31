Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF04C77B6D
	for <linux-fbdev@archiver.kernel.org>; Fri, 31 Mar 2023 09:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCaJXZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 31 Mar 2023 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaJXX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 31 Mar 2023 05:23:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CB846BF
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Mar 2023 02:23:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 11D9A21B2A;
        Fri, 31 Mar 2023 09:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680254597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e31ezIijxOlkrRfnNMK4E5R+Ir+nIoDmGm/NefoSHM4=;
        b=KHOHI2NESgoIIp+h17hSFPn3LxN/al9Z4dhuDfEau1JJjo/tXM4v+HaugOm2Cf4Sz9hu6p
        AUdJ9ZPTOOVt6TfwdMxMw+JBHrxLEsXNohtym8SGqg5jgFyd84IChu8fKLNHNHsyfHA+Jq
        Z4Aclc4+Y3w4+Y9EAskdA7L/LvM+oao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680254597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e31ezIijxOlkrRfnNMK4E5R+Ir+nIoDmGm/NefoSHM4=;
        b=QQUGGqmOcea0Tm7jWYwVylzQfPGB9YK6kfM0nUFjqRGhZI76mm0UIpWVqUWOAGdTlCoem0
        6kzgV3D2m9ICLRAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E05D713A0E;
        Fri, 31 Mar 2023 09:23:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMG3NYSmJmTsOwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 31 Mar 2023 09:23:16 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 03/15] fbdev/cg14: Remove trailing whitespaces
Date:   Fri, 31 Mar 2023 11:23:02 +0200
Message-Id: <20230331092314.2209-4-tzimmermann@suse.de>
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
 drivers/video/fbdev/cg14.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cg14.c b/drivers/video/fbdev/cg14.c
index 6a745eb46ca1..1f87a9f54380 100644
--- a/drivers/video/fbdev/cg14.c
+++ b/drivers/video/fbdev/cg14.c
@@ -512,7 +512,7 @@ static int cg14_probe(struct platform_device *op)
 	is_8mb = (resource_size(&op->resource[1]) == (8 * 1024 * 1024));
 
 	BUILD_BUG_ON(sizeof(par->mmap_map) != sizeof(__cg14_mmap_map));
-		
+
 	memcpy(&par->mmap_map, &__cg14_mmap_map, sizeof(par->mmap_map));
 
 	for (i = 0; i < CG14_MMAP_ENTRIES; i++) {
-- 
2.40.0

