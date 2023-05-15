Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4D9C77B75
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 May 2023 10:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbjEOKdF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 15 May 2023 06:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjEOKdE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 15 May 2023 06:33:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1869C3
        for <linux-fbdev@vger.kernel.org>; Mon, 15 May 2023 03:33:03 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f475366522so36973255e9.1
        for <linux-fbdev@vger.kernel.org>; Mon, 15 May 2023 03:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684146782; x=1686738782;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VLsqNqohQaSlzi4qCFEM4zyQpH9q5HKdLX9afXF2oaw=;
        b=KQVEDxj2SBeTF0e5HSoVKmXTQNAm6vP6/NPwYxfOORJkDSyvrzQfj8AWV+9e0h0wjZ
         M3g0BJYfp6p9eZ1w8KY7CoIIIA/pNyZM1yCZVhZcTgc8f1n6iikO976qqN2Hv3rqpMmG
         pZNDg0D4WRny5FjsQ9kWnrf9TSQOhMP/BctuABfwkDdndzajkAaUTiG4P5uTNVWJBPLK
         NrsYJ6QRkWPA6E6VM2Ixr1ftSh4MPARusAl9+vbbbfu/OW1Jk0Z/aJISlymVxfQttEFE
         7ulZK5ca8wG36lGNpuSs1ArYaXGiiRJ+0AHT6e1RRk5hHqgN94TF/UjmPJPXOifDDNOq
         oBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684146782; x=1686738782;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLsqNqohQaSlzi4qCFEM4zyQpH9q5HKdLX9afXF2oaw=;
        b=KuvLTMXdMbAcj5hWOSYpNElBj6xXmTOSqFCgmBw3NL4NTreCkCI2k7YTGaS++bUTAF
         Ta1aBNNPPPDAGCsCc8/gtgMwIQ3y4xtBkBOJ9Qn4WMnoY1KKvyIMkdxbraUI+pJrZWk8
         FSp0WGNMX72UnCHorNSbuomE1zRbPsDZoABu529dJA5wFqNkcKQ7hUNivV5ZKH7kKC10
         5nFM2l+HAotaPib2xn+epR5A0SMJLGFCAAnEDOQcrlUTxqKeG4oFHHWKtd1K7iIVN0fl
         0JQwCEORBL2SwQcYXUuueEuizy1OYmuWis6qlK8zUBFYVc4EGuVRPLu8ddlufNlvYeAJ
         BCqw==
X-Gm-Message-State: AC+VfDxfUXMIRGkgOk75ZzT+3of3nw12EYi/HDCLjwnsPY6qCzgbnOAK
        v9oMzu2yrcyzh6XfSiuME/O6CQ==
X-Google-Smtp-Source: ACHHUZ7KtZCye39Dr+WYjRXdcXbUksTilRBAuhufweF558lW2QerbCdOooNF2e7tBbAgKxnnqNFsPA==
X-Received: by 2002:a7b:c314:0:b0:3ef:6b97:f0c3 with SMTP id k20-20020a7bc314000000b003ef6b97f0c3mr23631619wmj.15.1684146782068;
        Mon, 15 May 2023 03:33:02 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e1-20020adfdbc1000000b0030795249ffasm24511774wrj.92.2023.05.15.03.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 03:33:00 -0700 (PDT)
Date:   Mon, 15 May 2023 13:32:47 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Helge Deller <deller@gmx.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] fbdev: omapfb: panel-tpo-td043mtea1: fix error code in
 probe()
Message-ID: <6f80089a-9223-4434-8da1-c071dd9367b5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This was using the wrong variable, "r", instead of "ddata->vcc_reg", so
it returned success instead of a negative error code.

Fixes: 0d3dbeb8142a ("video: fbdev: omapfb: panel-tpo-td043mtea1: Make use of the helper function dev_err_probe()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index 1eaa35c27835..477789cff8e0 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -491,7 +491,8 @@ static int tpo_td043_probe(struct spi_device *spi)
 
 	ddata->vcc_reg = devm_regulator_get(&spi->dev, "vcc");
 	if (IS_ERR(ddata->vcc_reg)) {
-		r = dev_err_probe(&spi->dev, r, "failed to get LCD VCC regulator\n");
+		r = dev_err_probe(&spi->dev, PTR_ERR(ddata->vcc_reg),
+				  "failed to get LCD VCC regulator\n");
 		goto err_regulator;
 	}
 
-- 
2.39.2

