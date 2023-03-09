Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919A2C7618A
	for <linux-fbdev@archiver.kernel.org>; Thu,  9 Mar 2023 16:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjCIQC4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 9 Mar 2023 11:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjCIQCK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 9 Mar 2023 11:02:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D76F3670;
        Thu,  9 Mar 2023 08:02:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3403B2017B;
        Thu,  9 Mar 2023 16:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678377728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJxf0lFvTB2HQ0JfmzXfmeLR3kXSn2VgL48irVHdc4o=;
        b=OfP4AUqE1G6wqcMwo+biFpyvRku0GsvDk2KcxTo82UkvW0KlMksgCFcaLvI42vcmAgHWvD
        T7c84ECqUxcqCDCJ9yfERGuWnFJ0FYvaN5wnBKkgUwu7wsWjBK5BwfSh7FoQj/bqIRFiAM
        fgmUGc47BupFlUJzKL+488arK+q9DK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678377728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJxf0lFvTB2HQ0JfmzXfmeLR3kXSn2VgL48irVHdc4o=;
        b=mooOxt9sv6gR3aoiuNS1J+h19T0EnHD1fByofsVZVu2Mq32B6Lujc/C6Li+smhWDqdvS1Q
        G3R5S4Th8NrjBkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C47D51391B;
        Thu,  9 Mar 2023 16:02:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kIcEL/8CCmQHbgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 09 Mar 2023 16:02:07 +0000
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
Subject: [PATCH v2 009/101] fbdev/atafb: Duplicate video-mode option string
Date:   Thu,  9 Mar 2023 17:00:29 +0100
Message-Id: <20230309160201.5163-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309160201.5163-1-tzimmermann@suse.de>
References: <20230309160201.5163-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Assume that the driver does not own the option string or its substrings
and hence duplicate the option string for the video mode. Allocate the
copy's memory with devm_kstrdup(), as the driver parses the option string
once per probed device. Linux will automatically free the memory upon
releasing the device.

Done in preparation of switching the driver to struct option_iter and
constifying the option string.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/atafb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index 2bc4089865e6..f0cc7c992c88 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2934,7 +2934,7 @@ static void __init atafb_setup_user(char *spec)
 	}
 }
 
-static int __init atafb_setup(char *options)
+static int __init atafb_setup(char *options, struct platform_device *pdev)
 {
 	char *this_opt;
 	int temp;
@@ -2946,8 +2946,9 @@ static int __init atafb_setup(char *options)
 		if (!*this_opt)
 			continue;
 		if ((temp = get_video_mode(this_opt))) {
+			// ignore errors
+			mode_option = devm_kstrdup(&pdev->dev, this_opt, GFP_KERNEL);
 			default_par = temp;
-			mode_option = this_opt;
 		} else if (!strcmp(this_opt, "inverse"))
 			fb_invert_cmaps();
 		else if (!strncmp(this_opt, "hwscroll_", 9)) {
@@ -2992,7 +2993,7 @@ static int __init atafb_probe(struct platform_device *pdev)
 
 	if (fb_get_options("atafb", &option))
 		return -ENODEV;
-	atafb_setup(option);
+	atafb_setup(option, pdev);
 	dev_dbg(&pdev->dev, "%s: start\n", __func__);
 
 	do {
-- 
2.39.2

