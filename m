Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB7285401
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Jun 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415500; cv=none; b=GP5mr1N5DJgMFGQ8489ItgZuhDO0M5QPjLb4fo+V6c0q7T4KBJkF0fGeMD1owkiyvkKXxlGw5dyJQclyd6TZ8Fdc3Vn4aSuobQBtlX0xUvxGuP867mzkknXudNw8zw+T67cmOBcQYk34lG73nQvD3PpD2TI8yEvWpZfjZ/G7Ycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415500; c=relaxed/simple;
	bh=aUgglQRYn7bTkMkwBI8lk1cjN4alca4VUVFQsxvzbtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ekUK6bJCEbW0BsfOnK1wMI6mNpOTb/smMDdMG9Mcuz8R9dPB1mVSYIi78S1jKyyHTelGDteHanCsqhWt5ghYvXQmYfluGfXgzXiArhmvY2uCNGywE7dAfYDOSYYjqjBQH7NP3IRDKPD0+lD5oPHzgqBgI0fRq3YLyFgXJaUe4Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Ef3hi0+N; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Ef3hi0+N"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ade326e366dso308612066b.3
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jun 2025 03:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750415496; x=1751020296; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rx+JsSfgW45704ajaCZP3Z6JsbN0dOsJusfnG4fSCwM=;
        b=Ef3hi0+N+Z5WWS/agg0jMBcgMKFfGfwH0xEmeaAAB+F68900rK3SVA8+qHojPbj1vZ
         9kKAA57TBZCuXc9TtEPev9+7udaZt8nVu6WbguIts1TCaqISdirKeEA5df23r0cbDzZG
         wm2mpvCiNeadzcJ9XhEMPqfGFE956uiqRL4P1AMQZCBEXqZ5mlyYU07S2fpMP3a/99a0
         jweoa3yIREfEDV/ARYmJja/4+IcGIATA/+fsBzg62Rzx4F+rV46YXxmJaYj5xKUfbncl
         V+aw5ViNlZ13q67WGo0PXRvSbLKj07mXaH2Q5oqhARu3RnZ00edtuE2oBHYFTGDumtyR
         apVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415496; x=1751020296;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx+JsSfgW45704ajaCZP3Z6JsbN0dOsJusfnG4fSCwM=;
        b=HD2/7/gJdHR9BdLJ2QV6B3c6/fsbv8uQMVsN3BCLYa8mvL5ZTMFzuooVjbUame123H
         XynUHjY4Y3owrtn3gt2E/NOD/7gEwFlnTyTbzFY2SfK9bHrtZ5oJ+fVPl6txSwHYcMWv
         zn50PFPYGMzSU27QC7khNkwlAQO868OeOZBQhdi/4MyTW768zGHWtEXETqaZwQR9ARU5
         S00+IxhaAjvJeBsdJaZYGIbbefc9KJ/lnLVxLjOqay68kIlh76/7eSbSe0QVWWT5Ct/E
         6iXbberTWQYEVbfMmihFrtRIv+7wBtErnwXK3BkTogTpX06pHFetL3ptLYKi33k8jEWI
         v9SQ==
X-Gm-Message-State: AOJu0Yzj9ASoHAMYHj9MQTeHdvw590gg33jkXHFXZKX2NjD2zHg8cJkx
	HTJTjoSOajbgpC7/OLZdE4SzfbzJC4ljjwcjujcFIN8nzG0eTG2tmRXexiO8LWx1CNA=
X-Gm-Gg: ASbGncv30dvlfcQrC3/oCdlgTnZFj6rGJ0qDOuEU3brt1RarR0rh5vSn/RjVlE5B+WW
	yApREMQzvnY9YI3ntVlPBEYuVd/RVs70Havc9XI58JBnX2+y1VuhhUagfQJGCr4lPD4q7dKdeBq
	+Qn1LrwBkSUOloP6pe3DNH8NYdv3i/iAYGvaLJirGLYocq16EgKcdCWwUW4i6RCFV9vwLbaT+AI
	TZ+UnIfI/YjufpavNVM3ZCHd9igGlbECtcyOG4W1dfZR87FYqgH9/xcAfyl7CZBbzGSmcXjo1G7
	1pa0ggy01jUZHTyk6WnT7+XdChWhb89ZeQTWsx8OAyDrTTAEp5LbpxSCLLvtO3JmmGHhmXtc/TQ
	tKWWVDRjgBYG3BLYyJcOWMpChBvwoVAQG
X-Google-Smtp-Source: AGHT+IFojvse3lqX+gqKA0HNP3nkQ76ONpxVInRK6fKU0+nbCKCU4x5vFpvTAQSlT7CHl0bt8sS96g==
X-Received: by 2002:a17:907:3ccb:b0:ad5:4440:23 with SMTP id a640c23a62f3a-ae057f21fcdmr207244766b.50.1750415496144;
        Fri, 20 Jun 2025 03:31:36 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6f5csm138047366b.122.2025.06.20.03.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:31:35 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Jun 2025 12:31:27 +0200
Subject: [PATCH 3/3] fbdev/simplefb: Add support for interconnect paths
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-simple-drm-fb-icc-v1-3-d92142e8f74f@fairphone.com>
References: <20250620-simple-drm-fb-icc-v1-0-d92142e8f74f@fairphone.com>
In-Reply-To: <20250620-simple-drm-fb-icc-v1-0-d92142e8f74f@fairphone.com>
To: Hans de Goede <hdegoede@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750415493; l=3509;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=aUgglQRYn7bTkMkwBI8lk1cjN4alca4VUVFQsxvzbtU=;
 b=q76OcxFnlNqs8zk3v5IaY0TIGBj4kLjAwREPukb0aGjW2/MaP/fIm50kqwa8fh+iuaE1x69fK
 +4EOmwW3pikCwZOl7W1EI5MmfpyvVdzGesSDUA4icHlf9y6PepTL2jt
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Some devices might require keeping an interconnect path alive so that
the framebuffer continues working. Add support for that by setting the
bandwidth requirements appropriately for all provided interconnect
paths.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/video/fbdev/simplefb.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index be95fcddce4c8ca794826b805cd7dad2985bd637..ca73e079fd13550ddc779e84db80f7f9b743d074 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -27,6 +27,7 @@
 #include <linux/parser.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
+#include <linux/interconnect.h>
 
 static const struct fb_fix_screeninfo simplefb_fix = {
 	.id		= "simple",
@@ -89,6 +90,10 @@ struct simplefb_par {
 	u32 regulator_count;
 	struct regulator **regulators;
 #endif
+#if defined CONFIG_OF && defined CONFIG_INTERCONNECT
+	unsigned int icc_count;
+	struct icc_path **icc_paths;
+#endif
 };
 
 static void simplefb_clocks_destroy(struct simplefb_par *par);
@@ -525,6 +530,80 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
 }
 #endif
 
+#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
+/*
+ * Generic interconnect path handling code.
+ */
+static void simplefb_detach_icc(void *res)
+{
+	struct simplefb_par *par = res;
+	int i;
+
+	for (i = par->icc_count - 1; i >= 0; i--) {
+		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
+			icc_put(par->icc_paths[i]);
+	}
+}
+
+static int simplefb_attach_icc(struct simplefb_par *par,
+			       struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret, count, i;
+
+	count = of_count_phandle_with_args(dev->of_node, "interconnects",
+							 "#interconnect-cells");
+	if (count < 0)
+		return 0;
+
+	/* An interconnect path consists of two elements */
+	if (count % 2) {
+		dev_err(dev, "invalid interconnects value\n");
+		return -EINVAL;
+	}
+	par->icc_count = count / 2;
+
+	par->icc_paths = devm_kcalloc(dev, par->icc_count,
+				      sizeof(*par->icc_paths),
+				      GFP_KERNEL);
+	if (!par->icc_paths)
+		return -ENOMEM;
+
+	for (i = 0; i < par->icc_count; i++) {
+		par->icc_paths[i] = of_icc_get_by_index(dev, i);
+		if (IS_ERR_OR_NULL(par->icc_paths[i])) {
+			ret = PTR_ERR(par->icc_paths[i]);
+			if (ret == -EPROBE_DEFER)
+				goto err;
+			dev_err(dev, "failed to get interconnect path %u: %d\n", i, ret);
+			continue;
+		}
+
+		ret = icc_set_bw(par->icc_paths[i], 0, UINT_MAX);
+		if (ret) {
+			dev_err(dev, "failed to set interconnect bandwidth %u: %d\n", i, ret);
+			continue;
+		}
+	}
+
+	return devm_add_action_or_reset(dev, simplefb_detach_icc, par);
+
+err:
+	while (i) {
+		--i;
+		if (!IS_ERR_OR_NULL(par->icc_paths[i]))
+			icc_put(par->icc_paths[i]);
+	}
+	return ret;
+}
+#else
+static int simplefb_attach_icc(struct simplefb_par *par,
+			       struct platform_device *pdev)
+{
+	return 0;
+}
+#endif
+
 static int simplefb_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -615,6 +694,10 @@ static int simplefb_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto error_regulators;
 
+	ret = simplefb_attach_icc(par, pdev);
+	if (ret < 0)
+		goto error_regulators;
+
 	simplefb_clocks_enable(par, pdev);
 	simplefb_regulators_enable(par, pdev);
 

-- 
2.50.0

