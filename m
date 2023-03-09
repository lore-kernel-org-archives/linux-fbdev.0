Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D39C74A4B
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Mar 2023 16:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCIQCK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Mar 2023 11:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjCIQCI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Mar 2023 11:02:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694E3F5AAE;
        Thu,  9 Mar 2023 08:02:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 240EC20178;
        Thu,  9 Mar 2023 16:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjVYDbqjwwkw2fXJsfJw/E5OA0vR4qLTqrFh9CEDVls=;
        b=pTHEcIUkdO4RI5ksVY5B1WkUN4P012LmRqtrO58/N4kKDBnDCWa9oM29LMeCFurbgFl4Zf
        ZlNri4lJcHlRlaHn+bEVUmULumv/9LTsYKpXmhimbXL20VD1q7fM0mzTLivplERk0xqEN8
        KcGf6hg5/SpVqncFC1gMCU3l42OU3G8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377726;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zjVYDbqjwwkw2fXJsfJw/E5OA0vR4qLTqrFh9CEDVls=;
        b=RTDEI9dmQRgy9k6aJ3HYKRujJ9aekExTA8pjDDMIHuVtJB+zt+BAbb4SJfWoDA0dJYAsAr
        QmBe2pzjY8kcHQAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B733F13A73;
        Thu,  9 Mar 2023 16:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SCy/K/0CCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:05 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert+renesas@glider.be, timur@kernel.org,
        rdunlap@infradead.org, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, adaplas@gmail.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, mbroemme@libmpq.org,
        thomas@winischhofer.net, James.Bottomley@HansenPartnership.com,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        corbet@lwn.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 004/101] fbdev/acornfb: Only init fb_info once
Date:   Thu,  9 Mar 2023 17:00:24 +0100
Message-Id: <20230309160201.5163-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309160201.5163-1-tzimmermann@suse.de>
References: <20230309160201.5163-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Init the fb_info instance once before parsing options. The current
code initializes the instance once again after parsing options, which
clears any resolution settings that have been given in the options
string.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/acornfb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
index 1b72edc01cfb..8642136a6bdc 100644
--- a/drivers/video/fbdev/acornfb.c
+++ b/drivers/video/fbdev/acornfb.c
@@ -887,8 +887,6 @@ static int acornfb_setup(char *options)
 	if (!options || !*options)
 		return 0;
 
-	acornfb_init_fbinfo();
-
 	while ((opt = strsep(&options, ",")) != NULL) {
 		if (!*opt)
 			continue;
@@ -930,9 +928,8 @@ static int acornfb_probe(struct platform_device *dev)
 
 	if (fb_get_options("acornfb", &option))
 		return -ENODEV;
-	acornfb_setup(option);
-
 	acornfb_init_fbinfo();
+	acornfb_setup(option);
 
 	current_par.dev = &dev->dev;
 
-- 
2.39.2

