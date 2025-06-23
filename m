Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830F1E7C11
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Jun 2025 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661103; cv=none; b=WBJKBo19Jxesv7hsJGC7u8s5Bc4YUF1F6fJrjW6a6KOn56twcbV7dctTSjOQ+1UCL+vYx0hkHvnLZzTJEu9vBAbHsKjRE/HdT4Txj7d9e2+lKcn6ETk0WmuQkkun26MFgtEqtVvuOZSHpFOlzLqqy7tzh7271XLh8uSz36uNpQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661103; c=relaxed/simple;
	bh=WFGg8eJbYpqqu4c1SsExqGZhg0kBCQL20U67P0aKA3M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iyG71Q+5A/gccDZeHxNU9n7Ig94KKgR6jAosyKpOnN9UxSpIvSA57L+ww6m7isvmtiElI+qoldo6PvyxujTK0jmBCoyVNOgu0Jx1YUcOykD4xC9D1QLFDZW9JQunbbzFwSBkTeTZ+a488O5siyWiJ2/T6Adtkq8W+TwC3RXKsxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Bsjuqx3j; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Bsjuqx3j"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so616016366b.2
        for <linux-fbdev@vger.kernel.org>; Sun, 22 Jun 2025 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1750661099; x=1751265899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTpIpbsJT9oUXdYXUp1B/jgdIiWHQ6mEsslmG5LurCE=;
        b=Bsjuqx3jum8oP5iT0t8fOWb99ofC0hhCl+eoDrmXznEAHRLSqzv1cYu2YSrEwEK66T
         ZVx6Jc12n6EKwnHi4/8AkQQneFafn8iAVXDwDsR6LgE1N8gdw3QlG3W4oRPx34K0Mpv7
         3UDKrYU/l60nGSsoL5NkBxAQGDAKaxyPWh5PUFUUVfKoyOPdFDugzXDBqZ8Qi9DUjrN1
         OlbapX0uBGFZoVQQbbrmwm81PVqYtyYKOEUXBMMy/EvRvniaVA8eOeUTWH1wW9naYAjs
         2B6m98W1YfPSHqEWo87nBH9BCoE/x/jlAvRcH4mp7Zk9NiRGOm4kChfYnm4sVkhgv8JP
         zUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750661099; x=1751265899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTpIpbsJT9oUXdYXUp1B/jgdIiWHQ6mEsslmG5LurCE=;
        b=NntxY9Dj/sTUo77Xevto2ztqTmDOFV4AoajiLX3YYFob5mBX+uB6ZpEuFxWyDLdvG2
         x9A902jrVtpdrosq3WX+fdjIj9ni1iB50tw/sO066o3v6AtoT+4Kk4HAWetYNkQjbGhF
         DMqkiWVfjkjXxDRf/q4eC6y9OoCsiMUzP62WotPQGCKEGcr8CVcyTVl/0jspXOk8di2l
         Em2hAgxz3eTdFyV3mH32XI1xq8dDGPr7040oInU3gT+0rAUUDwS901ahTTCkj9NNrLC4
         Bpj/FnOKh6H/8d6p04hQFDztl4AfbUnb0QTRZS4X/ibMc7PYTugB/moPiY3zUQRNs7K4
         PRBQ==
X-Gm-Message-State: AOJu0Ywyyls8fFg//ab2u1D++ZErUpO/fj99Mocrf2LxF26mh9UfNv2U
	rG6903ezUoKMu4hwE9lDx+jEzjGd7HjUnDD+vgpSUcjTzuTg69WYKaz7J2qvhK8hPh0=
X-Gm-Gg: ASbGnctvGWVBFzYid4zywJ7fNEZNYUke01BnGi61Ro0IkL1DN9SxT85MixaMXRawtMI
	OjGKKG8eni4Gx7IPWGZ2tXiWIqN+DZqlPIDnOrQ/yau7ddGMf8OYGdm2tN3CEuC/DlyzWWaMuCt
	5f7BY+vMnRiRl0D5XqG1XcyflD+hduO/afPQsX6OKjUW5PRY1r8nKbY2VPKP2PM75QQNtqIJsKf
	RhumHBDVFJLiEfejZnNT4eWagpTeCVCOw7VrdrfKhAhUxUgY9rNeKyzb6uaY2BMs+DeU9fdD4Bk
	jArjmXmRNynGA++fMBWQ1Wy4yHyRqP0ALs5Gn1Sq618WbV0udexwCW48oz9xdxP/9F0k7f1fcmf
	uTb+9xRjjLY2EjZEpyiYVixxrIER9ahqU
X-Google-Smtp-Source: AGHT+IFz7kDahVsqdTj+a5KcPoxkKtMDN2hTfcr/X8jn9acL7zz5DDVx99WzLXxoM8vxkoixi21RhQ==
X-Received: by 2002:a17:907:3f85:b0:ae0:6620:7f with SMTP id a640c23a62f3a-ae066200670mr917673166b.44.1750661098692;
        Sun, 22 Jun 2025 23:44:58 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ee4ce9sm659258266b.69.2025.06.22.23.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 23:44:58 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 23 Jun 2025 08:44:47 +0200
Subject: [PATCH v2 3/5] drm/sysfb: simpledrm: Add support for interconnect
 paths
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-simple-drm-fb-icc-v2-3-f69b86cd3d7d@fairphone.com>
References: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
In-Reply-To: <20250623-simple-drm-fb-icc-v2-0-f69b86cd3d7d@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750661095; l=3575;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=WFGg8eJbYpqqu4c1SsExqGZhg0kBCQL20U67P0aKA3M=;
 b=KSAo2uksGIm/+/BS8fjSyT+6mi+LRF2bl6GllAefMrpSwVVulFaiF5Qh5JwSjHsRXFQF/0C8X
 JOy9miznMoGB8qCL+OMaXK0deqERRAc76ov+tdX6Ihv+2jk92C4Abk6
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Some devices might require keeping an interconnect path alive so that
the framebuffer continues working. Add support for that by setting the
bandwidth requirements appropriately for all provided interconnect
paths.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 83 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 349219330314e3421a6bb26ad5cf39a679a5cb7a..47d213e20cab1dd1e19528674a95edea00f4bb30 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -2,6 +2,7 @@
 
 #include <linux/aperture.h>
 #include <linux/clk.h>
+#include <linux/interconnect.h>
 #include <linux/minmax.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
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
 
+#if defined CONFIG_OF && defined CONFIG_INTERCONNECT
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

