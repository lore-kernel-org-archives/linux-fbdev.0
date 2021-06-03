Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3726C47097
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Jun 2021 07:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3588613D6
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Jun 2021 07:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhFCHuT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Jun 2021 03:50:19 -0400
Received: from m12-11.163.com ([220.181.12.11]:35960 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhFCHuT (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 3 Jun 2021 03:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RnDVz
        AbO2cRJX+sWSzS+CpFRQSn/Oab2RiyOduZeFgU=; b=AgVkuWvuNfM0LQxunabmt
        7qeFD2MH8AZfOZrKJqbiEq54G5YmBP+f1zqVPQoT0havmn2Gg5qXgNECNXaSp4uh
        3T59J2qWamKzn/Aa5GKnBPzI5kYQRRRSimz/Ou665guQNCc1E172hfr3JnqfixnS
        VaI4lwU4kyFJv44wl1TFwo=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowAA3Xk5MibhgN5zUfw--.230S2;
        Thu, 03 Jun 2021 15:48:29 +0800 (CST)
From:   lijian_8010a29@163.com
To:     FlorianSchandinat@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: [PATCH] video: fbdev: via: dvi.c:  Fix a typo
Date:   Thu,  3 Jun 2021 15:47:31 +0800
Message-Id: <20210603074731.49717-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAA3Xk5MibhgN5zUfw--.230S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrurW7Zr43ur15GF1xXrW8WFg_yoW8JrW5pF
        WfKF95ArWYq3WkGrsrZ3W7WFy5K3WfJFZF9Fy0k34S9w43Ar4rWr1rAFy0q3yrXFy5JFyf
        tFW2yFWUKr1xuw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jX9NsUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiEQ2mUF7+3kJKIQAAs9
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'diplay' to 'display'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/video/fbdev/via/dvi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/via/dvi.c b/drivers/video/fbdev/via/dvi.c
index 13147e3066eb..ba1d9dbda99a 100644
--- a/drivers/video/fbdev/via/dvi.c
+++ b/drivers/video/fbdev/via/dvi.c
@@ -398,8 +398,10 @@ void viafb_dvi_enable(void)
 		if (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266)
 			tmds_register_write(0x88, 0x3b);
 		else
-			/*clear CR91[5] to direct on display period
-			   in the secondary diplay path */
+			/*
+			 * clear CR91[5] to direct on display period
+			 * in the secondary display path
+			 */
 			via_write_reg_mask(VIACR, 0x91, 0x00, 0x20);
 		break;
 
@@ -411,8 +413,10 @@ void viafb_dvi_enable(void)
 		if (viaparinfo->chip_info->gfx_chip_name == UNICHROME_CLE266)
 			tmds_register_write(0x88, 0x3b);
 		else
-			/*clear CR91[5] to direct on display period
-			  in the secondary diplay path */
+			/*
+			 * clear CR91[5] to direct on display period
+			 * in the secondary display path
+			 */
 			via_write_reg_mask(VIACR, 0x91, 0x00, 0x20);
 
 		/*fix DVI cannot enable on EPIA-M board */
-- 
2.25.1

