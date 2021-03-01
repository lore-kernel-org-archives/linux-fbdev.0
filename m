Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC29C433E6
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Mar 2021 09:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0815964E22
	for <linux-fbdev@archiver.kernel.org>; Mon,  1 Mar 2021 09:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhCAJaK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 1 Mar 2021 04:30:10 -0500
Received: from z11.mailgun.us ([104.130.96.11]:27805 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233920AbhCAJaF (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 1 Mar 2021 04:30:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614590981; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2sWU5eZ7cISZC9fb9u+h6bDTob0QedHUYcyBKSNzW30=; b=PX4mFL5jHQzLc5yedjuCjUr9+1HL0XeRP616ByFP/8luVPbFYbayo7y14gToRUBEnBthf3g6
 gZP1+xf8N4ejzYPRP4B/d9myX+JfeLJrfQ/nqXNKtbQmlR2gCqBNeOabfuFZYyTxz1U0taMC
 C8GPV92QVCR+DYjtek1s09D6qTM=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI4YmIzMiIsICJsaW51eC1mYmRldkB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 603cb3e08f0d5ba6c5337290 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Mar 2021 09:29:04
 GMT
Sender: kgunda=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A1A7BC43464; Mon,  1 Mar 2021 09:29:04 +0000 (UTC)
Received: from kgunda-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kgunda)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 183C2C433CA;
        Mon,  1 Mar 2021 09:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 183C2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kgunda@codeaurora.org
From:   Kiran Gunda <kgunda@codeaurora.org>
To:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        lee.jones@linaro.org, b.zolnierkie@samsung.com,
        dri-devel@lists.freedesktop.org, daniel.thompson@linaro.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, Kiran Gunda <kgunda@codeaurora.org>
Subject: [PATCH V3 2/2] backlight: qcom-wled: Correct the sync_toggle sequence
Date:   Mon,  1 Mar 2021 14:58:36 +0530
Message-Id: <1614590916-27070-3-git-send-email-kgunda@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614590916-27070-1-git-send-email-kgunda@codeaurora.org>
References: <1614590916-27070-1-git-send-email-kgunda@codeaurora.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

As per the current implementation, after FSC (Full Scale Current)
and brightness update the sync bits are transitioned from set-then-clear.
But, the FSC and brightness sync takes place during a clear-then-set
transition of the sync bits. So the hardware team recommends a
clear-then-set approach in order to guarantee such a transition
regardless of the previous register state.

Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
---
 drivers/video/backlight/qcom-wled.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index aef52b9..19f83ac 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -337,13 +337,13 @@ static int wled3_sync_toggle(struct wled *wled)
 
 	rc = regmap_update_bits(wled->regmap,
 				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
-				mask, mask);
+				mask, WLED3_SINK_REG_SYNC_CLEAR);
 	if (rc < 0)
 		return rc;
 
 	rc = regmap_update_bits(wled->regmap,
 				wled->ctrl_addr + WLED3_SINK_REG_SYNC,
-				mask, WLED3_SINK_REG_SYNC_CLEAR);
+				mask, mask);
 
 	return rc;
 }
@@ -353,17 +353,17 @@ static int wled5_mod_sync_toggle(struct wled *wled)
 	int rc;
 	u8 val;
 
-	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
-					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
 	rc = regmap_update_bits(wled->regmap,
 				wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
-				WLED5_SINK_REG_SYNC_MASK, val);
+				WLED5_SINK_REG_SYNC_MASK, 0);
 	if (rc < 0)
 		return rc;
 
+	val = (wled->cfg.mod_sel == MOD_A) ? WLED5_SINK_REG_SYNC_MOD_A_BIT :
+					     WLED5_SINK_REG_SYNC_MOD_B_BIT;
 	return regmap_update_bits(wled->regmap,
 				  wled->sink_addr + WLED5_SINK_REG_MOD_SYNC_BIT,
-				  WLED5_SINK_REG_SYNC_MASK, 0);
+				  WLED5_SINK_REG_SYNC_MASK, val);
 }
 
 static int wled_ovp_fault_status(struct wled *wled, bool *fault_set)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
 a Linux Foundation Collaborative Project

