Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530BDCD6E7C
	for <linux-fbdev@archiver.kernel.org>; Wed, 11 Oct 2023 14:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjJKOiR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 11 Oct 2023 10:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbjJKOiP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 11 Oct 2023 10:38:15 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FA19D
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Oct 2023 07:38:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ad8a822508so1259687766b.0
        for <linux-fbdev@vger.kernel.org>; Wed, 11 Oct 2023 07:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697035092; x=1697639892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C0H21NAxHWpVVzgKPMwSiQ6VL6uuihpmAvcOM/Zucss=;
        b=Wnn8okJvAP5eYQOuUI7kpEqulH6eFdOl91edqDEdqHyX3bUJyachGoLbBWFVQA9h5k
         O+hQlynjxmhkJTrOQAeGBdNM0qZ/GXGEQbKZShmHvrfMJBrblLMTrIpKFFL35AkangEH
         VMvrretrkTPA6unvRbMi1tqk3LZuFBY6mze+4qc4JWD9hU0ofY0GTvUq8yBFoRqkhKo8
         eBTmUpJ+/PVewnLHRssKy1cFm0uZ7pd2lhh39s1VeZZ7ebAIjUf1+0KQEJv3fE2dfMIs
         ThXFyk3GkycVhV7vjFjWxbR0hwrnNcQQL4GLCJEdgWhzVs4tM1567SRVBJJ3+z3sLi4P
         M3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697035092; x=1697639892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0H21NAxHWpVVzgKPMwSiQ6VL6uuihpmAvcOM/Zucss=;
        b=hGfzuuEWByrUpUswW5VM++Z7HYTDG7UGzOTOZwXT1YHeklJKZftTAuSB20rjEBv8/u
         mVw4CDa7hjfeaW8hQTsPeg1vtJAb5LvmmzGN0ahHZTTgg+HXs+HNGPxGNZKvV25vI9Db
         hpIawinBLIpLJgMyRI0aiJZr3s7pnGI1M00i+qDyh4bWJTSu5pJNvVjLxkEoE9KmjNpd
         m0HaOONEG3O5nwoQo+CRY9PCvpZ1EmozRbxUaKFd58i8Hnr2ygmrfjOgIXC5OWZPShNK
         KbC4XQ6IgzAXZ8bpwp/hrNZBCaTnrmh+Gzq7K36KDE7vZ4w4YcB5QNU60mZ8E51af/IQ
         4EXA==
X-Gm-Message-State: AOJu0YxcvwK9eQsMoXMKYBAimNeId/GjlAu6VhkqHgu7TwXq7cdqeOcJ
        g4h9WoeIuswQn9EixVmj+lU=
X-Google-Smtp-Source: AGHT+IFkW31k/TJYDnRHJXlJQmJc6ZC0M1NnjX6UKAFzKEHalfSt4SHdlfpvmLIIIw3xese1yVQXGQ==
X-Received: by 2002:a17:906:319a:b0:9a5:9f8d:770 with SMTP id 26-20020a170906319a00b009a59f8d0770mr19331256ejy.46.1697035091924;
        Wed, 11 Oct 2023 07:38:11 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id n12-20020a170906378c00b0099d45ed589csm9842711ejc.125.2023.10.11.07.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 07:38:11 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>
Cc:     Robert Foss <rfoss@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] fbdev/simplefb: Support memory-region property
Date:   Wed, 11 Oct 2023 16:38:08 +0200
Message-ID: <20231011143809.1108034-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011143809.1108034-1-thierry.reding@gmail.com>
References: <20231011143809.1108034-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The simple-framebuffer bindings specify that the "memory-region"
property can be used as an alternative to the "reg" property to define
the framebuffer memory used by the display hardware. Implement support
for this in the simplefb driver.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/fbdev/simplefb.c | 35 +++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 62f99f6fccd3..18025f34fde7 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/of_platform.h>
 #include <linux/parser.h>
@@ -121,12 +122,13 @@ struct simplefb_params {
 	u32 height;
 	u32 stride;
 	struct simplefb_format *format;
+	struct resource memory;
 };
 
 static int simplefb_parse_dt(struct platform_device *pdev,
 			   struct simplefb_params *params)
 {
-	struct device_node *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node, *mem;
 	int ret;
 	const char *format;
 	int i;
@@ -166,6 +168,23 @@ static int simplefb_parse_dt(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	mem = of_parse_phandle(np, "memory-region", 0);
+	if (mem) {
+		ret = of_address_to_resource(mem, 0, &params->memory);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to parse memory-region\n");
+			of_node_put(mem);
+			return ret;
+		}
+
+		if (of_property_present(np, "reg"))
+			dev_warn(&pdev->dev, "preferring \"memory-region\" over \"reg\" property\n");
+
+		of_node_put(mem);
+	} else {
+		memset(&params->memory, 0, sizeof(params->memory));
+	}
+
 	return 0;
 }
 
@@ -193,6 +212,8 @@ static int simplefb_parse_pd(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	memset(&params->memory, 0, sizeof(params->memory));
+
 	return 0;
 }
 
@@ -431,10 +452,14 @@ static int simplefb_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "No memory resource\n");
-		return -EINVAL;
+	if (params.memory.start == 0 && params.memory.end == 0) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res) {
+			dev_err(&pdev->dev, "No memory resource\n");
+			return -EINVAL;
+		}
+	} else {
+		res = &params.memory;
 	}
 
 	mem = request_mem_region(res->start, resource_size(res), "simplefb");
-- 
2.42.0

