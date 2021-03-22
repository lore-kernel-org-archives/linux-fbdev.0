Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5BBC433DB
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Mar 2021 18:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63C861994
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Mar 2021 18:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCVSRe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:17:34 -0400
Received: from uho.ysoft.cz ([81.19.3.130]:25346 "EHLO uho.ysoft.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhCVSRH (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 22 Mar 2021 14:17:07 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Mar 2021 14:17:07 EDT
Received: from iota-build.ysoft.local (unknown [10.1.5.151])
        by uho.ysoft.cz (Postfix) with ESMTP id 45B40A0844;
        Mon, 22 Mar 2021 19:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1616436678;
        bh=2985J8QEH7ypkIWT9eXgR8S1j/LwdOsTbCDZrn2V8iY=;
        h=From:To:Cc:Subject:Date:From;
        b=YyQ6y3UjcBm9m5OnmISfpM373Lr3fjosNXanrhsx+RIWltLiS4H/synlnJNXAXycM
         FGx8MQNRxfn7ncC9WLb2LIn+yIOdKt/iDALRiU+AqgB4IKfQoR7U0bWYw4IkcmzOfr
         qRh13JhEjA/7eKlxCb81hlBx6AMEJ3wR6RZ273u8=
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH] video: ssd1307fb: Enable charge pump only on displays that actually have it
Date:   Mon, 22 Mar 2021 19:11:05 +0100
Message-Id: <1616436665-3046-1-git-send-email-michal.vokac@ysoft.com>
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

