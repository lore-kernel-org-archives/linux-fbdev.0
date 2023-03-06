Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81B8C678D4
	for <linux-fbdev@archiver.kernel.org>; Mon,  6 Mar 2023 16:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCFQCQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Mar 2023 11:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjCFQBE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 6 Mar 2023 11:01:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B37625E09;
        Mon,  6 Mar 2023 08:00:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C4A3422443;
        Mon,  6 Mar 2023 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678118455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGY7Fu+FjH5ebrEemOkXLczvoMTp1L2oXB861qWkvNU=;
        b=jO+jFE6XviH+PxwP2JyPoLSjnYyEpIn34E2rFOJkcRr0M7X98vcXTCiZDd8uzD5T6ZRojH
        6StEZ5ATSm4FgKja60Gp2u7FGnLZ5DDftD7PBHiCxseMbiGZEgD6ZkHe80NVcSMKkD0M79
        Gm2x2+2UOPr3prtpTjKJgh8IlQFG4mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678118455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aGY7Fu+FjH5ebrEemOkXLczvoMTp1L2oXB861qWkvNU=;
        b=VlJjJiIUs+oHeU8hDVVlqsE2CfYsTGg62x/mWIFG5U/Zh94oDrhdW8CkvrHNvrfjokCm16
        N6nRW7LywKCIABBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6655F13513;
        Mon,  6 Mar 2023 16:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gOr6FzcOBmQ/PwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 06 Mar 2023 16:00:55 +0000
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
Subject: [PATCH 82/99] fbdev/tgafb: Duplicate video-mode option string
Date:   Mon,  6 Mar 2023 16:59:59 +0100
Message-Id: <20230306160016.4459-83-tzimmermann@suse.de>
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

Done in preparation of switching the driver to struct option_iter and
constifying the option string.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/tgafb.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/tgafb.c b/drivers/video/fbdev/tgafb.c
index 14d37c49633c..a412fdddfd8c 100644
--- a/drivers/video/fbdev/tgafb.c
+++ b/drivers/video/fbdev/tgafb.c
@@ -1579,9 +1579,21 @@ static int tgafb_setup(char *arg)
 		while ((this_opt = strsep(&arg, ","))) {
 			if (!*this_opt)
 				continue;
-			if (!strncmp(this_opt, "mode:", 5))
-				mode_option = this_opt+5;
-			else
+			if (!strncmp(this_opt, "mode:", 5)) {
+				static char mode_option_buf[256];
+				int ret;
+
+				ret = snprintf(mode_option_buf, sizeof(mode_option_buf), "%s",
+					       this_opt + 5);
+				if (WARN(ret < 0,
+					 "tgafb: ignoring invalid option, ret=%d\n",
+					 ret))
+					continue;
+				if (WARN(ret >= sizeof(mode_option_buf),
+					 "tgafb: option too long\n"))
+					continue;
+				mode_option = mode_option_buf;
+			} else
 				printk(KERN_ERR
 				       "tgafb: unknown parameter %s\n",
 				       this_opt);
-- 
2.39.2

