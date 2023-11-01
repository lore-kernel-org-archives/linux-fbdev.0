Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FD5C4167D
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Nov 2023 17:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjKARU6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Nov 2023 13:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344693AbjKARU5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Nov 2023 13:20:57 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42513A;
        Wed,  1 Nov 2023 10:20:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3c8adb27so5743566b.1;
        Wed, 01 Nov 2023 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698859223; x=1699464023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MES5GqV7TrvEk7NAdheCC8mL6C1jpFNBBuLO0wdyWF0=;
        b=XEqWZ+GTzlUj56YMsjGKZlADA+MwhnmiOQfjH63Ug/we8T7c2wAFKH6lqgLMHE80LO
         J7coDU2UsxflkyIcmMSBcHRAG6xx5ftz2ZoFinN5hQvblND8cdWseExVdIP5KpEG8M/s
         VCAyZVkfjPLERVcXkpBp3O4Q28w+oPNP3jvs0f6AZjfJLQ5vEz7kk5FeVshXTT1v1SyO
         UZbYB6ub/asXXEDaWSKvP6mTlUUcd5R2FX5wNnrkE29cNCS0CPdI7dbPfiJ6lKz0fLPs
         s4KPtCtH/uuG8GLHsE9pljJGzf7RA+B2n3mZAO9LRGt8+yKGIZP3PWYQiXUo8up62Wus
         tCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859223; x=1699464023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MES5GqV7TrvEk7NAdheCC8mL6C1jpFNBBuLO0wdyWF0=;
        b=iX5NdM/beMkFpIeDD74csd37iAbcm70il4z1ARGWR9QSN279WZIoFpxa7SyFkO1zcR
         em8OFrvHnjT0fRRg6U1wFAWtVop8OVFS8rx+rEGNEAyDcynX0Xcm2+xaHVQLp3AWDEoJ
         NPc10DxYFXpqlZOXzRHy6ppYYHI7rFYq3d5K9pLVdhpYTqAleCYMHDUDPVpU4srIWrgQ
         /OD9bh9QwVuTGDUlWtMO2EXCPAsp5X2elbcJrTDFjQ97oZZjzMwm9jmGu7eHi4NfEvYa
         Q56UHt7Pkn3SPlLVZiSj8zRj+Cb8muWWpEukOcgKUt81nyKD4bGBh9rv71x0L7o25dFJ
         9VxQ==
X-Gm-Message-State: AOJu0Yw4P9wQlNb72E2dvGr+yy/afGPdVtlMjOXph+QxzS1nsxqROCYL
        YUxuCeymqJpi+coEiceajO4+mTsbZhU=
X-Google-Smtp-Source: AGHT+IGz0MS81PMDRbPIhLnqVUjvRxWV5C5P9/qd8vePmVYHlptWcpeqp+orYnQX/HZMMyiyB1u7hw==
X-Received: by 2002:a17:906:fe45:b0:9ad:e298:a5d with SMTP id wz5-20020a170906fe4500b009ade2980a5dmr3275899ejb.19.1698859223483;
        Wed, 01 Nov 2023 10:20:23 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id t24-20020a170906065800b009b2b47cd757sm167671ejb.9.2023.11.01.10.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:20:22 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>
Cc:     Robert Foss <rfoss@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 1/2] fbdev/simplefb: Support memory-region property
Date:   Wed,  1 Nov 2023 18:20:16 +0100
Message-ID: <20231101172017.3872242-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101172017.3872242-1-thierry.reding@gmail.com>
References: <20231101172017.3872242-1-thierry.reding@gmail.com>
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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

