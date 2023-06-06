Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174F2C77B7A
	for <linux-fbdev@archiver.kernel.org>; Tue,  6 Jun 2023 10:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbjFFKnO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 6 Jun 2023 06:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjFFKmX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 6 Jun 2023 06:42:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D8210F0;
        Tue,  6 Jun 2023 03:41:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 84FEE21995;
        Tue,  6 Jun 2023 10:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686048059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhJJbcCjd3StHqJY4ZuLu9T5nuWJxmVKfKSicKaY06E=;
        b=fhkdcuuNTFfkTsYxRC/trm0HiIGlI7N0tPU5JtPtkHEoE/C5tSPS40kMArl7JPEqOdWfcI
        V28vPj5JF6msqyDZsuloWa6bDE5wVX8x7aLuKOIpBcpEDQZDJsb07a/wFr5db3JOTU9fRN
        XvMB6zGKYKVRxPl8XKxBu2te/YBZ9So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686048059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zhJJbcCjd3StHqJY4ZuLu9T5nuWJxmVKfKSicKaY06E=;
        b=M/mH8AVJdfgbAVzmL8r3efISjouuT4PsG67RwapQGbLypQ2qS9lF2mTKs5YX8GFd4mIVDm
        8eQAsU5rkga3s3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6481413A47;
        Tue,  6 Jun 2023 10:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id COm/FzsNf2SHewAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 06 Jun 2023 10:40:59 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, David.Laight@ACULAB.COM
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/3] fbdev/hitfb: Declare hitfb_blank() as static
Date:   Tue,  6 Jun 2023 12:40:54 +0200
Message-Id: <20230606104056.29553-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606104056.29553-1-tzimmermann@suse.de>
References: <20230606104056.29553-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following warnings:

../drivers/video/fbdev/hitfb.c:186:5: warning: no previous prototype for 'hitfb_blank' [-Wmissing-prototypes]
  186 | int hitfb_blank(int blank_mode, struct fb_info *info)
      |     ^~~~~~~~~~~

../drivers/video/fbdev/hitfb.c:186:5: warning: symbol 'hitfb_blank' was not declared. Should it be static?

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/hitfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
index fb82869283db..551b00f761a7 100644
--- a/drivers/video/fbdev/hitfb.c
+++ b/drivers/video/fbdev/hitfb.c
@@ -183,7 +183,7 @@ static int hitfb_pan_display(struct fb_var_screeninfo *var,
 	return 0;
 }
 
-int hitfb_blank(int blank_mode, struct fb_info *info)
+static int hitfb_blank(int blank_mode, struct fb_info *info)
 {
 	unsigned short v;
 
-- 
2.40.1

