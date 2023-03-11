Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A3CC6FD1C
	for <linux-fbdev@archiver.kernel.org>; Sat, 11 Mar 2023 17:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjCKRhk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 11 Mar 2023 12:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCKRhj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 11 Mar 2023 12:37:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C1D3D0B0
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Mar 2023 09:36:57 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id k10so32948414edk.13
        for <linux-fbdev@vger.kernel.org>; Sat, 11 Mar 2023 09:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SdFkCAcFYqQLXuQPZJF9uuUIlYRjbN5Fnk2tHbR0J8=;
        b=nca4nmWy7yHFMhDtV3c+p/Kye64HqiZQuzZIXlLLzjri/qA6FSvaLyfCYSlKh3GCuk
         BLGlxDwoiuDwDLgIXFYWi4QQOT6fsTUT9h9nJnarMgheiTCTlQDvKfNwDYC8eLfrWmDF
         BbXu7JEEuwW1m3w6tk2DCDKSnImHgssZDSECgzHDGyGmQjU/xlGj0nS2Ojer3sFAX35+
         B0YtRFHG7Zov4jJRXj8MU308l+XRztSSV3+zHCxQPqqk0t5FHG5bQJFpTO2gPGRM0PkU
         npOPbc0IAAKbsFEv+XxwK+Lj/azJqSz+uk77N/qyeHmyhQdnn1qndci4TL7dWrKirSYQ
         BiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SdFkCAcFYqQLXuQPZJF9uuUIlYRjbN5Fnk2tHbR0J8=;
        b=mgGRSaWJ1Kuauav0u4/UEFzfzw30t3aZlUrMPnf32QhhOQTAA1e/zGc6LTt1+DAA/K
         7jsFKk0G33cPfAZNZJUnvIvphfELm9ie+WAE9oGzvOUEqTw674EfearZGU67fHr/zwdW
         SbiOw9MmLOGrjlYOhhGIoVBBpOPDRFkZmRyCgoLBT/pm04YwbqsSE6Tne7KGMnhZVwC2
         sBmrDC8TkBVqa9o05spC+5yDhUdppuxdXE0kSj3uHF3tSNYGbLpznQ6HhqWZyb3dwPtO
         Eautwa7AE7YIDx97P4HbhZxyoN4VC25FQWDj968+PQECUk8hYOIcJZDCaSc0DQXCUWrW
         VtCA==
X-Gm-Message-State: AO0yUKVmGniL9NrKht05lN7/Gr/41V9qQpGmZGCJ0jBxjm6d8bDbjhXq
        jtpFJQsVAmVUyqC3Ei1Y7G/feg==
X-Google-Smtp-Source: AK7set86+WXFwkkusoMVVsyn8I7uNiBN0R7q/0pN4r39ds7FYdWwNeye1wjlNOjhatU/gopp2H8RKw==
X-Received: by 2002:a17:907:3e91:b0:8b2:b711:5e62 with SMTP id hs17-20020a1709073e9100b008b2b7115e62mr34928132ejc.52.1678556161242;
        Sat, 11 Mar 2023 09:36:01 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id o26-20020a1709061b1a00b009240a577b38sm245423ejg.14.2023.03.11.09.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:36:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] backlight: arcxcnn_bl: drop of_match_ptr for ID table
Date:   Sat, 11 Mar 2023 18:35:56 +0100
Message-Id: <20230311173556.263086-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
References: <20230311173556.263086-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The driver will match mostly by DT table (even thought there is regular
ID table) so there is little benefit in of_match_ptr (this also allows
ACPI matching via PRP0001, even though it might not be relevant here).

  drivers/video/backlight/arcxcnn_bl.c:378:34: error: ‘arcxcnn_dt_ids’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/video/backlight/arcxcnn_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/arcxcnn_bl.c b/drivers/video/backlight/arcxcnn_bl.c
index e610d7a1d13d..088bcca547dd 100644
--- a/drivers/video/backlight/arcxcnn_bl.c
+++ b/drivers/video/backlight/arcxcnn_bl.c
@@ -390,7 +390,7 @@ MODULE_DEVICE_TABLE(i2c, arcxcnn_ids);
 static struct i2c_driver arcxcnn_driver = {
 	.driver = {
 		.name = "arcxcnn_bl",
-		.of_match_table = of_match_ptr(arcxcnn_dt_ids),
+		.of_match_table = arcxcnn_dt_ids,
 	},
 	.probe_new = arcxcnn_probe,
 	.remove = arcxcnn_remove,
-- 
2.34.1

