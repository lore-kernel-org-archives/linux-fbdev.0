Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DAFC433FE
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Nov 2021 00:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B7361073
	for <linux-fbdev@archiver.kernel.org>; Fri, 12 Nov 2021 00:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhKLAaT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 Nov 2021 19:30:19 -0500
Received: from relay03.th.seeweb.it ([5.144.164.164]:42173 "EHLO
        relay03.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234573AbhKLAaG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 Nov 2021 19:30:06 -0500
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 96A50203C6;
        Fri, 12 Nov 2021 01:27:14 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        Bryan Wu <cooloney@gmail.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [RESEND PATCH v2 06/13] backlight: qcom-wled: Remove unnecessary 4th default string in WLED3
Date:   Fri, 12 Nov 2021 01:26:59 +0100
Message-Id: <20211112002706.453289-7-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112002706.453289-1-marijn.suijten@somainline.org>
References: <20211112002706.453289-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The previous commit improves num_strings parsing to not go over the
maximum of 3 strings for WLED3 anymore.  Likewise this default index for
a hypothetical 4th string is invalid and could access registers that are
not mapped to the desired purpose.
Removing this value gets rid of undesired confusion and avoids the
possibility of accessing registers at this offset even if the 4th array
element is used by accident.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/video/backlight/qcom-wled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
index 9bfbf601762a..c342cd8440e1 100644
--- a/drivers/video/backlight/qcom-wled.c
+++ b/drivers/video/backlight/qcom-wled.c
@@ -946,7 +946,7 @@ static const struct wled_config wled3_config_defaults = {
 	.cs_out_en = false,
 	.ext_gen = false,
 	.cabc = false,
-	.enabled_strings = {0, 1, 2, 3},
+	.enabled_strings = {0, 1, 2},
 };

 static int wled4_setup(struct wled *wled)
--
2.33.0

