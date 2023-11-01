Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC84C4332F
	for <linux-fbdev@archiver.kernel.org>; Wed,  1 Nov 2023 17:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344743AbjKARVD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 1 Nov 2023 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344778AbjKARVB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 1 Nov 2023 13:21:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D1813E;
        Wed,  1 Nov 2023 10:20:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98377c5d53eso6937666b.0;
        Wed, 01 Nov 2023 10:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698859225; x=1699464025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCWX20pm7NUxv4hyK070ttliGC4ogoFW2BX+CCQgl0k=;
        b=ENKqDS1ma7w4GONjM2BAmjXsmoo0O9fOOOLhT3DkDVb/kxfTyGigj/A/z3ZuFbslM+
         dCoVo5gFmI+vbwNUkAEm0Rq216RcvrtqrL1iGfEH9SLPniYt2kEmBkEzIfwO1kNnmKoO
         oB0ShOzmB9lPznwFBJsuC69tUVPDhKOapAUA+UqWxtI7MRBJIsrochSKnU3zLeRIiJM6
         YOGzw2JvsaiPgyw7gd1Mr5nOeBydSfROkiWZ7XJPvkL7eXgyHF2xI2GRh8BkisaLNc82
         2m9qQqyx8RKILLHTcntZBOdlmi2wEXbjQBEOIotjwsNF3Gtm973twLUR1szcVBmHNiHP
         h7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698859225; x=1699464025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCWX20pm7NUxv4hyK070ttliGC4ogoFW2BX+CCQgl0k=;
        b=N1byOcS5DlYEte74EvGuteQH/Z8jmQLXswI6fbbds4UK3ONVC7w1zCvFckw3F0ffhc
         WnIl0pP6VjtFGS2ioXm2O1II9ipskCpRPQDIwuFDNZZTZ1qTsn3YQFrYg6XATXw9kuHj
         7IXa8zpm/1sGpggRZv8v30plWvVvFUaEMD3NQOQ6W0eDgH5bh9uTiymDMOny4nL86Fjd
         U6Jqc0z0HIPvo7cmxMDA7F8Y+WiK0RuF/Ko3zGJRh85e0ZSXhd125F+kD0d2lfDFKu3k
         BNtpqvoBCgik9qtBBgQEu15TK6o0dARqE51AF8C8Qtd8E7UsE+1lDzSyralQOukwo3qV
         GvhQ==
X-Gm-Message-State: AOJu0YxlhH4kQPFEOqvi+WhSPxpN/Rnp4scFlzPLLp+uucAsPOkTyjpo
        Z6PuZl1AVDSvyngzIKPv31Sjto9hOp0=
X-Google-Smtp-Source: AGHT+IELfHY0ppV6/oc/rv+QctOqXbA+B/dAZdJV4WnAElYHxcL5x8bScFtIyqNY3pUPUxYOY5G1GA==
X-Received: by 2002:a17:907:6d16:b0:9be:d55a:81c3 with SMTP id sa22-20020a1709076d1600b009bed55a81c3mr2300010ejc.67.1698859225126;
        Wed, 01 Nov 2023 10:20:25 -0700 (PDT)
Received: from localhost (p200300e41f3f4900f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f3f:4900:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i18-20020a170906115200b009ad8acac02asm160956eja.172.2023.11.01.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 10:20:24 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>
Cc:     Robert Foss <rfoss@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/2] fbdev/simplefb: Add support for generic power-domains
Date:   Wed,  1 Nov 2023 18:20:17 +0100
Message-ID: <20231101172017.3872242-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101172017.3872242-1-thierry.reding@gmail.com>
References: <20231101172017.3872242-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The simple-framebuffer device tree bindings document the power-domains
property, so make sure that simplefb supports it. This ensures that the
power domains remain enabled as long as simplefb is active.

v2: - remove unnecessary call to simplefb_detach_genpds() since that's
      already done automatically by devres
    - fix crash if power-domains property is missing in DT

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/video/fbdev/simplefb.c | 93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 18025f34fde7..fe682af63827 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -25,6 +25,7 @@
 #include <linux/of_clk.h>
 #include <linux/of_platform.h>
 #include <linux/parser.h>
+#include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 
 static const struct fb_fix_screeninfo simplefb_fix = {
@@ -78,6 +79,11 @@ struct simplefb_par {
 	unsigned int clk_count;
 	struct clk **clks;
 #endif
+#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
+	unsigned int num_genpds;
+	struct device **genpds;
+	struct device_link **genpd_links;
+#endif
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
 	bool regulators_enabled;
 	u32 regulator_count;
@@ -432,6 +438,89 @@ static void simplefb_regulators_enable(struct simplefb_par *par,
 static void simplefb_regulators_destroy(struct simplefb_par *par) { }
 #endif
 
+#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
+static void simplefb_detach_genpds(void *res)
+{
+	struct simplefb_par *par = res;
+	unsigned int i = par->num_genpds;
+
+	if (par->num_genpds <= 1)
+		return;
+
+	while (i--) {
+		if (par->genpd_links[i])
+			device_link_del(par->genpd_links[i]);
+
+		if (!IS_ERR_OR_NULL(par->genpds[i]))
+			dev_pm_domain_detach(par->genpds[i], true);
+	}
+}
+
+static int simplefb_attach_genpds(struct simplefb_par *par,
+				  struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	unsigned int i;
+	int err;
+
+	err = of_count_phandle_with_args(dev->of_node, "power-domains",
+					 "#power-domain-cells");
+	if (err < 0) {
+		dev_info(dev, "failed to parse power-domains: %d\n", err);
+		return err;
+	}
+
+	par->num_genpds = err;
+
+	/*
+	 * Single power-domain devices are handled by the driver core, so
+	 * nothing to do here.
+	 */
+	if (par->num_genpds <= 1)
+		return 0;
+
+	par->genpds = devm_kcalloc(dev, par->num_genpds, sizeof(*par->genpds),
+				   GFP_KERNEL);
+	if (!par->genpds)
+		return -ENOMEM;
+
+	par->genpd_links = devm_kcalloc(dev, par->num_genpds,
+					sizeof(*par->genpd_links),
+					GFP_KERNEL);
+	if (!par->genpd_links)
+		return -ENOMEM;
+
+	for (i = 0; i < par->num_genpds; i++) {
+		par->genpds[i] = dev_pm_domain_attach_by_id(dev, i);
+		if (IS_ERR(par->genpds[i])) {
+			err = PTR_ERR(par->genpds[i]);
+			if (err == -EPROBE_DEFER) {
+				simplefb_detach_genpds(par);
+				return err;
+			}
+
+			dev_warn(dev, "failed to attach domain %u: %d\n", i, err);
+			continue;
+		}
+
+		par->genpd_links[i] = device_link_add(dev, par->genpds[i],
+						      DL_FLAG_STATELESS |
+						      DL_FLAG_PM_RUNTIME |
+						      DL_FLAG_RPM_ACTIVE);
+		if (!par->genpd_links[i])
+			dev_warn(dev, "failed to link power-domain %u\n", i);
+	}
+
+	return devm_add_action_or_reset(dev, simplefb_detach_genpds, par);
+}
+#else
+static int simplefb_attach_genpds(struct simplefb_par *par,
+				  struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static int simplefb_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -518,6 +607,10 @@ static int simplefb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error_clocks;
 
+	ret = simplefb_attach_genpds(par, pdev);
+	if (ret < 0)
+		goto error_regulators;
+
 	simplefb_clocks_enable(par, pdev);
 	simplefb_regulators_enable(par, pdev);
 
-- 
2.42.0

