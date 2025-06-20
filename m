Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13803284B49
	for <linux-fbdev@vger.kernel.org>; Fri, 20 Jun 2025 10:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415499; cv=none; b=Ew8vMVr3cqOFD2xxpVyuoD/sVRKIKMx79b4ALuppdMIprxIAg4TzeribIONtMJf9khZX+LUY+Q8YSvhGNNVrJCWCsc9ZOyciofLE71pRajdae/DLh3RCWym2GQ3JY2EZM043rBKsMZBusuBmizvFA+IehXl0lXzO4Dmz0iAyYKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415499; c=relaxed/simple;
	bh=d04Nc6/zavO+68KQ3Z8w4PpWXB7iws3XS1jyTPHwCgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AO/GqSLLjQl2RVNoI586kjJdKK/2XoGfNndyWuunJ2GteBBabmZe9as0vf1/fZJtntRUnVo33bd3eP+PjXdQG5GxL4PwyuFDO0h0c32Kp6yEwJAbhDfnCfpBiciMkXsGQcadH8LxR4Ybi67+kWKnW5ipiu7UVqHFFESM6Yiy73s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=nYBHb4TX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="nYBHb4TX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-adb2bb25105so279918666b.0
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jun 2025 03:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750415495; x=1751020295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2iMhnvf5EQaGrzDAr8D2TdFfXYKdA4ikA05GtxeBtI=;
        b=nYBHb4TXWv4Am7gyFjTEEPFBiof1UAdlu9k00l/TVyqsDz2Y8He+xWDpauNmlMmHM2
         sNOELYFOhvQUqP9gc0dKYaHcWL/TzSHXGJPpmIa9/b8zXAQht9RSKWE1uzaiG4SQtG6l
         1/uMlBEzYNZmvcBWDPZJEgj0KEGpdQ4hVa7SU8G1c9QSmP4qCg3tF1SrnFKKnyyMBCFg
         80bu26Ova4EsXjCTd/zbUqLN9W2Ad06711oCd5E9HzMdEEHav6gbOrf/tzp14G3b0M/F
         10K6YwHS/kqEBl/Ye/YVkcIAfijy+tAfFoYQ0VnzipOGFn00rvHh6W1yt7JdTL8kK73A
         Z55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415495; x=1751020295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2iMhnvf5EQaGrzDAr8D2TdFfXYKdA4ikA05GtxeBtI=;
        b=nbmXMWCCpwKeTP/4XqiKJR7THoOyN4I513+SuYdLXTH888WLI2g1rjgMljyzs+p62C
         4l1M+eriC1wTulV/HS7WI90qIkNqChKwy6V/GHHzAPFtLg/L0Hu53N/yvV2H2A+Fj5Ft
         kSsyxxlgV3azff52tXp5QSI3zEC/GPhpJsBSWo0Ih4LoQ6202tc0bnvbo3qEBGWhbS+b
         Xr36KGCfASbNd3/P0bp2VBWsp9mzh0RVxYkdbSeJQRNI0u11WBemsF8Wrh1ANBHFNuyk
         YQrChbA/5KXSOTVEVZlpj22PqeUqjOcBDsMFCKz2FrVCOWsdYwkno0JVx/+dUNq2/yn5
         ju/g==
X-Gm-Message-State: AOJu0Yz62Y5eJjjHq+aizebGvVV4nfeLYAbStJ8o+33cRTib+vGa2xpZ
	st+o8Mw4rR+JC4bNp0jL0F+HMldSW9L9veNelaMgGruaUlhXG2QA2KP0THUytdbsvODILDeh/DJ
	XWZVa
X-Gm-Gg: ASbGnctUkzI69lNhZbdSTFNbw7E99tObDQh651zneXUVD4bNcmrmVy1RiKIhDFxxH/o
	gfZ7Tk57J0TSK32hOWAw2i1H+2LsuFwGQ8Kn/7m7vxQBGux4OuLgFd2ra0/NoLKOw3+9LfMe0d6
	VfJug1fXS4VF1/RsnASQcBS5E9XSIx7daTONvbCn0q0FmKUbTHBe6L8hBIrnWxchjAypXxERqI+
	aR6S6EveJzjQ7WPe7SmNMr6Ujxrnu6sRIggNz2C/IuupSr1CiECN8rkOmprJRm6VVsvU1GF86Jd
	9eZ/jH9JlGbbtwBCh3nDN2AGgMQIMio4G+yx7IBl1rZ8liRu+7jJ67NpMa4p4udNSmnycBWusj1
	JnBy/6U7rWeeMyR8X3Yb4ryud+FOHIduhr1v2wdekJ/k=
X-Google-Smtp-Source: AGHT+IFSpq+n0pTlSttcHCNoQdEWNKKFQKqrUEc9bXWtRz+fgibBvmNaNt5W95K1E/I9mpYWKSpYIQ==
X-Received: by 2002:a17:907:2d89:b0:adb:e08:5e71 with SMTP id a640c23a62f3a-ae0579930e0mr234979566b.17.1750415495176;
        Fri, 20 Jun 2025 03:31:35 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0541b6f5csm138047366b.122.2025.06.20.03.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:31:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Jun 2025 12:31:26 +0200
Subject: [PATCH 2/3] drm/sysfb: simpledrm: Add support for interconnect
 paths
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250620-simple-drm-fb-icc-v1-2-d92142e8f74f@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750415493; l=3566;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=d04Nc6/zavO+68KQ3Z8w4PpWXB7iws3XS1jyTPHwCgw=;
 b=OSCxYbk+zEmgHOxlnlJRAUggV3hgQS7+vk3wWQc+tTa51GNZjK7RbLR0z3Knt58EHBfB/eyny
 jamZmL7PXsQAdWIECU8g+Y44oAzAB4KcTf8rQG9xPOUXnsp8dcOdowe
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Some devices might require keeping an interconnect path alive so that
the framebuffer continues working. Add support for that by setting the
bandwidth requirements appropriately for all provided interconnect
paths.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index a1c3119330deffc9e122b83941f3697e5b87f277..9643f7c1734ab558d52779d7c45465dbe1d85762 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
+#include <linux/interconnect.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic.h>
@@ -225,6 +226,10 @@ struct simpledrm_device {
 	struct device **pwr_dom_devs;
 	struct device_link **pwr_dom_links;
 #endif
+#if defined CONFIG_OF && defined CONFIG_INTERCONNECT
+	unsigned int icc_count;
+	struct icc_path **icc_paths;
+#endif
 
 	/* modesetting */
 	u32 formats[DRM_SYSFB_PLANE_NFORMATS(1)];
@@ -547,6 +552,81 @@ static int simpledrm_device_attach_genpd(struct simpledrm_device *sdev)
 }
 #endif
 
+#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
+/*
+ * Generic interconnect path handling code.
+ */
+static void simpledrm_device_detach_icc(void *res)
+{
+	struct simpledrm_device *sdev = res;
+	int i;
+
+	for (i = sdev->icc_count - 1; i >= 0; i--) {
+		if (!IS_ERR_OR_NULL(sdev->icc_paths[i]))
+			icc_put(sdev->icc_paths[i]);
+	}
+}
+
+static int simpledrm_device_attach_icc(struct simpledrm_device *sdev)
+{
+	struct device *dev = sdev->sysfb.dev.dev;
+	int ret, count, i;
+
+	count = of_count_phandle_with_args(dev->of_node, "interconnects",
+							 "#interconnect-cells");
+	if (count < 0)
+		return 0;
+
+	/* An interconnect path consists of two elements */
+	if (count % 2) {
+		drm_err(&sdev->sysfb.dev,
+			"invalid interconnects value\n");
+		return -EINVAL;
+	}
+	sdev->icc_count = count / 2;
+
+	sdev->icc_paths = devm_kcalloc(dev, sdev->icc_count,
+					       sizeof(*sdev->icc_paths),
+					       GFP_KERNEL);
+	if (!sdev->icc_paths)
+		return -ENOMEM;
+
+	for (i = 0; i < sdev->icc_count; i++) {
+		sdev->icc_paths[i] = of_icc_get_by_index(dev, i);
+		if (IS_ERR_OR_NULL(sdev->icc_paths[i])) {
+			ret = PTR_ERR(sdev->icc_paths[i]);
+			if (ret == -EPROBE_DEFER)
+				goto err;
+			drm_err(&sdev->sysfb.dev, "failed to get interconnect path %u: %d\n",
+				i, ret);
+			continue;
+		}
+
+		ret = icc_set_bw(sdev->icc_paths[i], 0, UINT_MAX);
+		if (ret) {
+			drm_err(&sdev->sysfb.dev, "failed to set interconnect bandwidth %u: %d\n",
+				i, ret);
+			continue;
+		}
+	}
+
+	return devm_add_action_or_reset(dev, simpledrm_device_detach_icc, sdev);
+
+err:
+	while (i) {
+		--i;
+		if (!IS_ERR_OR_NULL(sdev->icc_paths[i]))
+			icc_put(sdev->icc_paths[i]);
+	}
+	return ret;
+}
+#else
+static int simpledrm_device_attach_icc(struct simpledrm_device *sdev)
+{
+	return 0;
+}
+#endif
+
 /*
  * Modesetting
  */
@@ -633,6 +713,9 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	if (ret)
 		return ERR_PTR(ret);
 	ret = simpledrm_device_attach_genpd(sdev);
+	if (ret)
+		return ERR_PTR(ret);
+	ret = simpledrm_device_attach_icc(sdev);
 	if (ret)
 		return ERR_PTR(ret);
 

-- 
2.50.0

