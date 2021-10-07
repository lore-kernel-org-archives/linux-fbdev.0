Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B48C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Oct 2021 21:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B471961245
	for <linux-fbdev@archiver.kernel.org>; Thu,  7 Oct 2021 21:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242451AbhJGVgJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:36:09 -0400
Received: from relay07.th.seeweb.it ([5.144.164.168]:52901 "EHLO
        relay07.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbhJGVgF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 7 Oct 2021 17:36:05 -0400
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DCD883E857;
        Thu,  7 Oct 2021 23:34:08 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] backlight: qcom-wled: Remove unnecessary double whitespace
Date:   Thu,  7 Oct 2021 23:33:55 +0200
Message-Id: <20211007213400.258371-9-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211007213400.258371-1-marijn.suijten@somainline.org>
References: <20211007213400.258371-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove redundant spaces inside for loop conditions.  No other double
spaces were found that are not part of indentation with `[^\s]  `.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/qcom-wled.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index a8fb8f19922d..4524e80591cd 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -235,7 +235,7 @@ static int wled3_set_brightness(struct wled *wled, u16 brightness)
 
 	v = cpu_to_le16(brightness & WLED3_SINK_REG_BRIGHT_MAX);
 
-	for (i = 0;  i < wled->cfg.num_strings; ++i) {
+	for (i = 0; i < wled->cfg.num_strings; ++i) {
 		rc = regmap_bulk_write(wled->regmap, wled->ctrl_addr +
 				       WLED3_SINK_REG_BRIGHT(i),
 				       &v, sizeof(v));
@@ -257,7 +257,7 @@ static int wled4_set_brightness(struct wled *wled, u16 brightness)
 
 	v = cpu_to_le16(brightness & WLED3_SINK_REG_BRIGHT_MAX);
 
-	for (i = 0;  i < wled->cfg.num_strings; ++i) {
+	for (i = 0; i < wled->cfg.num_strings; ++i) {
 		rc = regmap_bulk_write(wled->regmap, wled->sink_addr +
 				       WLED4_SINK_REG_BRIGHT(i),
 				       &v, sizeof(v));
-- 
2.33.0

