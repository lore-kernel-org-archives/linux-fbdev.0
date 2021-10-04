Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBBEC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Oct 2021 19:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C02611C8
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Oct 2021 19:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbhJDTfu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Oct 2021 15:35:50 -0400
Received: from relay01.th.seeweb.it ([5.144.164.162]:41391 "EHLO
        relay01.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhJDTfu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Oct 2021 15:35:50 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Oct 2021 15:35:50 EDT
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 85F901F6A2;
        Mon,  4 Oct 2021 21:27:47 +0200 (CEST)
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
Subject: [PATCH 05/10] backlight: qcom-wled: Fix off-by-one maximum with default num_strings
Date:   Mon,  4 Oct 2021 21:27:36 +0200
Message-Id: <20211004192741.621870-6-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211004192741.621870-1-marijn.suijten@somainline.org>
References: <20211004192741.621870-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

When not specifying num-strings in the DT the default is used, but +1 is
added to it which turns wled3 into 4 and wled4/5 into 5 strings instead
of 3 and 4 respectively, causing out of bounds reads and register
read/writes.  This +1 exists for a deficiency in the DT parsing code,
and is simply omitted entirely - solving this oob issue - by allowing
one extra iteration of the wled_var_cfg function parsing this particular
property.

Fixes: 93c64f1ea1e8 ("leds: add Qualcomm PM8941 WLED driver")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/video/backlight/qcom-wled.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 27e8949c7922..66ce77ee3099 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -1255,17 +1255,17 @@ static const struct wled_var_cfg wled5_ovp_cfg = {
 
 static u32 wled3_num_strings_values_fn(u32 idx)
 {
-	return idx + 1;
+	return idx;
 }
 
 static const struct wled_var_cfg wled3_num_strings_cfg = {
 	.fn = wled3_num_strings_values_fn,
-	.size = 3,
+	.size = 4, /* [0, 3] */
 };
 
 static const struct wled_var_cfg wled4_num_strings_cfg = {
 	.fn = wled3_num_strings_values_fn,
-	.size = 4,
+	.size = 5, /* [0, 4] */
 };
 
 static u32 wled3_switch_freq_values_fn(u32 idx)
@@ -1520,8 +1520,6 @@ static int wled_configure(struct wled *wled)
 			*bool_opts[i].val_ptr = true;
 	}
 
-	cfg->num_strings = cfg->num_strings + 1;
-
 	string_len = of_property_count_elems_of_size(dev->of_node,
 						     "qcom,enabled-strings",
 						     sizeof(u32));
-- 
2.33.0

