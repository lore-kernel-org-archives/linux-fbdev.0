Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EEFC761AF
	for <linux-fbdev@archiver.kernel.org>; Mon,  6 Mar 2023 16:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCFQC0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Mar 2023 11:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjCFQBK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 6 Mar 2023 11:01:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926702E0D3;
        Mon,  6 Mar 2023 08:01:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3427B2245B;
        Mon,  6 Mar 2023 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jPw1gekX+dS3alKpIhYWuod0yFkaKVmgthd+u+9Q3I=;
        b=BZCIBnjT4VG2watd8QiYGZnfT3gnTX0oWbbZ/wo0QDvu1fLYkpFx8+kzl197N8PW9XiMgK
        dK8wIAlA4l5TYEOwT3EpDASIhkF5Ain2/FyssDJ9BvNyQDHPqWHxxabnciQI9Fc0rDeOnm
        HRLN5ZIRHvdY51yTQDrtWsM6emHsZAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118462;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jPw1gekX+dS3alKpIhYWuod0yFkaKVmgthd+u+9Q3I=;
        b=Xj87SiI0F2lYajydSZ9VDJqbuHcFCbMfqbg59Q1PzPiAgepDEYeJTtbYJQUfEIF9IdLmBR
        wyl+8GbplWzpOLDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF9B813513;
        Mon,  6 Mar 2023 16:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2EfpLT0OBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:01:01 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, paulus@samba.org, benh@kernel.crashing.org,
        linux@armlinux.org.uk, pjones@redhat.com, timur@kernel.org,
        adaplas@gmail.com, s.hauer@pengutronix.de, shawnguo@kernel.org,
        mbroemme@libmpq.org, thomas@winischhofer.net,
        James.Bottomley@HansenPartnership.com, spock@gentoo.org,
        sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        geert+renesas@glider.be, corbet@lwn.net
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 97/99] fbdev/vt8623fb: Duplicate video-mode option string
Date:   Mon,  6 Mar 2023 17:00:14 +0100
Message-Id: <20230306160016.4459-98-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306160016.4459-1-tzimmermann@suse.de>
References: <20230306160016.4459-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Assume that the driver does not own the option string or its substrings
and hence duplicate the option string for the video mode. The driver only
parses the option string once as part of module initialization, so use
a static buffer to store the duplicated mode option. Linux automatically
frees the memory upon releasing the module.

Done in preparation of constifying the option string.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/vt8623fb.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index 034333ee6e45..cbdca42d1708 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -929,8 +929,17 @@ static int __init vt8623fb_init(void)
 	if (fb_get_options("vt8623fb", &option))
 		return -ENODEV;
 
-	if (option && *option)
-		mode_option = option;
+	if (option && *option) {
+		static char mode_option_buf[256];
+		int ret;
+
+		ret = snprintf(mode_option_buf, sizeof(mode_option_buf), "%s", option);
+		if (WARN(ret < 0, "vt8623fb: ignoring invalid option, ret=%d\n", ret))
+			break;
+		if (WARN(ret >= sizeof(mode_option_buf), "vt8623fb: option too long\n"))
+			break;
+		mode_option = mode_option_buf;
+	}
 #endif
 
 	pr_debug("vt8623fb: initializing\n");
-- 
2.39.2

