Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C434A0F00;
	Tue,  1 Sep 2026 18:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288653; cv=none; b=GYjORYMvsYFVLJgdRR4Elg8wHNBvhRuoPmwQYn8F7/gRFkDTc5TLD057rVhJNBORzh8FrFn11Gz4+CXT+wSFzyldT/Ud2f2on/d9TExynNzbZ5dypdKN7wnbLSc0+HbFH7wPWDcbHFWGZRtSZxB2gMEtgdqkMLC0U3B/HlltE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288653; c=relaxed/simple;
	bh=w5z+v+gxUQnZVHvuiXlsM23VWLX++xiKjUuBeHJS2yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQC096iXCNjKGyLqpo03qNUlPNzZoavGmK1vIoFmKvazgdyx7hjxh1uSqhi5zFUCDaL99olNcmlTtdT2RjhUrS0P8aWqGxLvvGvy8vqoqW47bmmBvnOFPm1F8z4rANS1VcSLsjCImR8WomqHg+n4ZqpmK4uns6+lAxotvddkmOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pxj5cmLO; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pxj5cmLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288649;
	bh=w5z+v+gxUQnZVHvuiXlsM23VWLX++xiKjUuBeHJS2yo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pxj5cmLO9tJDPHL9OMqZB4ZEQHQyV0h9rhdpXeDEaisBaU+B5Z2btLTzImKAjn3PQ
	 2zBB9xyOTrHV6tYrPWB7ZyskjBcRkaupm9JEZ7ESOn21n3dwSgu5qxtEdTzjCRw9L5
	 QbnKi0rbxqqT8GqYa1+QxZV3DLB+p/k6T/Vhu2SJTiH0mWMUqk097lI2+TldakqWpN
	 qEQTKIk40n6v/fv4uzy5bLy/rboVms0Jtv1+1d+dEWsgrCQZp4ZFU2chLGN6lK8OF5
	 7PQPqR4YfcElImYwwvjsDerDY3m7aJ/PBsx2sboKuyTuIONLjMDxjGBSYDCcgiFvOb
	 HanDMOzZHrxwQ==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4195D17E35CB;
	Tue, 01 Sep 2026 20:50:49 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:35 +0300
Subject: [PATCH v11 11/74] drm/display: hdmi: Advertise SCDC source version
 when scrambling
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-11-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>, 
 Diederik de Haas <diederik@cknow-tech.com>
X-Mailer: b4 0.15.2

The HDMI 2.0 spec advises that compliant Source devices report their
SCDC version in the Source Version register.  Do so when enabling
scrambling by calling drm_scdc_set_source_version().

Failures are non-fatal: SCDC version negotiation is purely informational
and does not gate scrambling or any high-bitrate functionality, so a
flaky DDC bus should not block scrambling setup.

Acked-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/drm/display/drm_hdmi_helper.c
index bf1c7963b984..f85cce3d6254 100644
--- a/drivers/gpu/drm/display/drm_hdmi_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
@@ -16,6 +16,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_property.h>
 
+#define DRM_HDMI_SCDC_SOURCE_VERSION	1
 #define DRM_HDMI_SCDC_POLL_DELAY_MS	1000
 
 static inline bool is_eotf_supported(u8 output_eotf, u8 sink_eotf)
@@ -556,6 +557,12 @@ int drm_connector_hdmi_enable_scrambling(struct drm_connector *connector,
 	if (!connector->ddc)
 		return -EINVAL;
 
+	/*
+	 * Advertise our SCDC source version. This is purely informational and
+	 * does not gate scrambling, so failures are non-fatal.
+	 */
+	drm_scdc_set_source_version(connector, DRM_HDMI_SCDC_SOURCE_VERSION);
+
 	drm_dbg_kms(dev, "Enabling scrambling\n");
 
 	if (!hdmi->scdc_work_initialized) {

-- 
2.55.0

