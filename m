Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB58BC32771
	for <linux-fbdev@archiver.kernel.org>; Wed, 21 Sep 2022 21:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIUVvK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 21 Sep 2022 17:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiIUVvJ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 21 Sep 2022 17:51:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51733A6C0A
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Sep 2022 14:51:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id l65so7312079pfl.8
        for <linux-fbdev@vger.kernel.org>; Wed, 21 Sep 2022 14:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7Ccja+Ag2s+Qx2euqE4TqyyHiW0JG6WL4KMv9BkP7TQ=;
        b=o27w7GMus1TONUU/SoB082WN/uf+lNQ2Iym3idx65q8KoSHVUQQI8jsvxpawcZrJci
         k8NDe2y3UPCg8TbAVh6bLPDvuqVEd+QBeGxByeSpsAVQ6Uan8L7A/5nNjU67BJ5uDBUZ
         uf8lNM2DETblxnOdpYo9fo9/XXJ11XvrVlp3DyGl9XHicGA14ZFW+dzMO/YFe88QE4OC
         UfrtYOlByYtcvY4n+Cx8lB0v/pTQ5EFIUDx2B4vUm8Y2lPAqKLKurwbdsqXTzrI4T0c9
         VjhxcZ/exPeRS35ntaalmQzh7Rbvxm3jL2HnKbbwvHb/K5VD8QBzART3+A4Sc65Ba5oa
         cp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7Ccja+Ag2s+Qx2euqE4TqyyHiW0JG6WL4KMv9BkP7TQ=;
        b=arikUamPySjCON2hagQNMpjv2rgUPpxKbmu/INZwjSvmPUddZpdtFzCq8xaoqb3xQx
         T6++NyXKG2YJPVesZoiFS1nH/9tXqa/xWdcE0kGggA2tvzkKCM1g/SAWmxdWsJ7FNE20
         B6QLsYdkqruPqbZzE4zbcP42RkvMDpxs9rlFlkcuLV1/IfhValS84FlJk1dJ69MbTj4+
         pqUrITe+afKinVjiaaWY+IM2ZwuT7lYCsKprDKSs0WTM2eWoVdI8tOpsQ6OJwRbyid9/
         nnSTI70RKpG6A6MgDMm76zCGxwa1VRlPCjUagzfp1yJ2G58lNvIGmGvdDlYrJmnUSXyc
         TnHA==
X-Gm-Message-State: ACrzQf1+wZRsI7BYGwD/GvFcOAlr/kZclP7z2Z1BrHBIsE4K8mYrCf2p
        fKcopLHFeMBjBuV+RPZAwUI1iZLnia/caA==
X-Google-Smtp-Source: AMsMyM4amkubcVbp27k9HQ0LdyI21SlkbR+waW6/7V2e5QqwqFFQ6NLWGW5B04PVH9BcWFGZQ/CMLQ==
X-Received: by 2002:a62:8403:0:b0:540:c1e4:fb31 with SMTP id k3-20020a628403000000b00540c1e4fb31mr239166pfd.85.1663797067443;
        Wed, 21 Sep 2022 14:51:07 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id f1-20020a170902684100b00178a58f0ad5sm2582707pln.33.2022.09.21.14.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 14:51:06 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     deller@gmx.de, jingoohan1@gmail.com, daniel.thompson@linaro.org,
        lee@kernel.org, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers:adp8870_bl: check the return value of adp8870_write
Date:   Wed, 21 Sep 2022 14:50:49 -0700
Message-Id: <20220921215049.1658796-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Check and propagate the return value of adp8870_write() when it fails,
which is possible when SMBus writing byte fails.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/video/backlight/adp8870_bl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index 8b5213a39527..0eb4ae2ff592 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -567,9 +567,13 @@ static ssize_t adp8870_store(struct device *dev, const char *buf,
 		return ret;
 
 	mutex_lock(&data->lock);
-	adp8870_write(data->client, reg, val);
+	ret = adp8870_write(data->client, reg, val);
 	mutex_unlock(&data->lock);
 
+	if (ret) {
+		return ret;
+	}
+
 	return count;
 }
 
-- 
2.25.1

