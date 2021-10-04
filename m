Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A290C433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Oct 2021 19:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD26611C8
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Oct 2021 19:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhJDTfx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:35:53 -0400
Received: from relay02.th.seeweb.it ([5.144.164.163]:49601 "EHLO
        relay02.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbhJDTfv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Oct 2021 15:35:51 -0400
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 9D6AD1F691;
        Mon,  4 Oct 2021 21:27:46 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Kiran Gunda <kgunda@codeaurora.org>,
        Courtney Cavin <courtney.cavin@sonymobile.com>,
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] backlight: qcom-wled: Validate enabled string indices in DT
Date:   Mon,  4 Oct 2021 21:27:35 +0200
Message-Id: <20211004192741.621870-5-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211004192741.621870-1-marijn.suijten@somainline.org>
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The strings passed in DT may possibly cause out-of-bounds register
accesses and should be validated before use.

Fixes: 775d2ffb4af6 ("backlight: qcom-wled: Restructure the driver for WLED3")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/video/backlight/qcom-wled.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 29910e603c42..27e8949c7922 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1526,6 +1526,12 @@ static int wled_configure(struct wled *wled)
 						     "qcom,enabled-strings",
 						     sizeof(u32));
 	if (string_len > 0) {
+		if (string_len > wled->max_string_count) {
+			dev_err(dev, "Cannot have more than %d strings\n",
+				wled->max_string_count);
+			return -EINVAL;
+		}
+
 		rc = of_property_read_u32_array(dev->of_node,
 						"qcom,enabled-strings",
 						wled->cfg.enabled_strings,
@@ -1537,6 +1543,14 @@ static int wled_configure(struct wled *wled)
 			return -EINVAL;
 		}
 
+		for (i = 0; i < string_len; ++i) {
+			if (wled->cfg.enabled_strings[i] >= wled->max_string_count) {
+				dev_err(dev, "qcom,enabled-strings index %d at %d is out of bounds\n",
+					wled->cfg.enabled_strings[i], i);
+				return -EINVAL;
+			}
+		}
+
 		cfg->num_strings = string_len;
 	}
 
-- 
2.33.0

