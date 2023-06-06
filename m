Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EAAC7EE2F
	for <linux-fbdev@archiver.kernel.org>; Tue,  6 Jun 2023 10:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbjFFKnR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 6 Jun 2023 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFFKmY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 6 Jun 2023 06:42:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9681BC7;
        Tue,  6 Jun 2023 03:41:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CE4621FD67;
        Tue,  6 Jun 2023 10:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686048059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCdWkYIApbrbN3XIAOkaX0ST5l1P0QNhDjNAcytAn5E=;
        b=Ij0YycoE9UtSviJPMS+QFaV3g/tWu+hR7gjEr3YOddZaQACP7h0oSbu9BagLCPzdZBkMs8
        ls8BruMDLOAz41UT83fqn9rvNuGsSnGo91CVgeMxuh13MBCM4oibcuATm2xAzLx4K9sPv1
        cUHVA9bru7Zs9OKiSL5UXTSrEf1+qkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686048059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RCdWkYIApbrbN3XIAOkaX0ST5l1P0QNhDjNAcytAn5E=;
        b=UIPVtLv3bTCbN1qQSnRQYUgG0ZI3Y0Wm38OSvj5ub48keUmkiLU4qgA/MxzBwyyd4HCj6M
        /rEM4tloPSX9OPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC37113A47;
        Tue,  6 Jun 2023 10:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0IFDKTsNf2SHewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 06 Jun 2023 10:40:59 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, David.Laight@ACULAB.COM
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/3] fbdev/hitfb: Use NULL for pointers
Date:   Tue,  6 Jun 2023 12:40:56 +0200
Message-Id: <20230606104056.29553-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606104056.29553-1-tzimmermann@suse.de>
References: <20230606104056.29553-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Replace integer constants with NULL. Resolves the following
warnings:

../drivers/video/fbdev/hitfb.c:447:23: warning: Using plain integer as NULL pointer
../drivers/video/fbdev/hitfb.c:465:23: warning: Using plain integer as NULL pointer

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/hitfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
index 1ee3aa3d3fc7..c6b3d9f38c01 100644
--- a/drivers/video/fbdev/hitfb.c
+++ b/drivers/video/fbdev/hitfb.c
@@ -444,7 +444,7 @@ static int hitfb_suspend(struct device *dev)
 {
 	u16 v;
 
-	hitfb_blank(1,0);
+	hitfb_blank(1, NULL);
 	v = hitfb_readw(HD64461_STBCR);
 	v |= HD64461_STBCR_SLCKE_IST;
 	hitfb_writew(v, HD64461_STBCR);
@@ -462,7 +462,7 @@ static int hitfb_resume(struct device *dev)
 	v = hitfb_readw(HD64461_STBCR);
 	v &= ~HD64461_STBCR_SLCKE_IST;
 	hitfb_writew(v, HD64461_STBCR);
-	hitfb_blank(0,0);
+	hitfb_blank(0, NULL);
 
 	return 0;
 }
-- 
2.40.1

