Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C538BC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 12 May 2021 09:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9225F613BC
	for <linux-fbdev@archiver.kernel.org>; Wed, 12 May 2021 09:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhELJ5Q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 12 May 2021 05:57:16 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:25156 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhELJ5O (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 12 May 2021 05:57:14 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 May 2021 05:57:14 EDT
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 61FCCA02C2;
        Wed, 12 May 2021 11:48:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1620812935;
        bh=2985J8QEH7ypkIWT9eXgR8S1j/LwdOsTbCDZrn2V8iY=;
        h=From:To:Cc:Subject:Date:From;
        b=R9RP4TAfFQKyc869XKMykTIB2y/DaUteIxfcu/WAqiD5OkWu+IWclRRZIHUNl7SDZ
         LipOKwxTcu1P6R7giYF9eLI03p4yzyt1h1hlwTZEdFxy44Eww1bI3rUTDrsg8bqDqJ
         94EdkamI3qf6053FEfpVbln1Tb4esF2gOaAMhWmo=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH RESEND] video: ssd1307fb: Enable charge pump only on displays that actually have it
Date:   Wed, 12 May 2021 11:48:50 +0200
Message-Id: <1620812930-30356-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

A note in the datasheet says:

 "Patterns other than those given in the Command Table are prohibited to
  enter the chip as a command; as unexpected results can occur."

So do not send the charge pump command to displays that do not support it.

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 drivers/video/fbdev/ssd1307fb.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 1b0b2a096afa..54903ea2e3ac 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -497,14 +497,16 @@ static int ssd1307fb_init_regs(struct ssd1307fb_par *par)
 		return ret;
 
 	/* Turn on the DC-DC Charge Pump */
-	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_CHARGE_PUMP);
-	if (ret < 0)
-		return ret;
+	if (par->device_info->need_chargepump) {
+		ret = ssd1307fb_write_cmd(par->client, SSD1307FB_CHARGE_PUMP);
+		if (ret < 0)
+			return ret;
 
-	ret = ssd1307fb_write_cmd(par->client,
-		BIT(4) | (par->device_info->need_chargepump ? BIT(2) : 0));
-	if (ret < 0)
-		return ret;
+		ret = ssd1307fb_write_cmd(par->client,
+			BIT(4) | (par->device_info->need_chargepump ? BIT(2) : 0));
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Set lookup table */
 	if (par->lookup_table_set) {
-- 
2.1.4

