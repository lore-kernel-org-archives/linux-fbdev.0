Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7674A9D78;
	Tue,  1 Sep 2026 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288702; cv=none; b=IUITwY0lC4sGXE7gAWwROo7Yo5TuBJqQVMWy2aYkh+3r1VzWM240v9CL/q8Y1mz4mtWwUoiwYYou8Xn3oJIkyOReT60PmZJhQkbxgbxP59bTRxGYPURYg1EtcTntjEN9kzX8vMs3guoXciFDpj7UtrAlTCESnxJ7FTkyoB4exlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288702; c=relaxed/simple;
	bh=WvZHGQUwLNHlXVJXJUmzneooB/o/bop5PxCRNXVE6KM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cw9G08LL10HTcN1AHXN3IBd2gKVS5Ojzvh1emJuIw59ajQd/DKh1Ow4cvtg2ZCqyRwFxFijlA77+UsjihXygCeeV9WVdIFVUnWGcd7DuHGfHOzlZ5d3Ku3gKydNcpFHvtaZcg6ggUYa6mmRcKKFgRI1dBkofW6v+b7817yJvz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=br+Zi4pP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="br+Zi4pP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288692;
	bh=WvZHGQUwLNHlXVJXJUmzneooB/o/bop5PxCRNXVE6KM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=br+Zi4pP1ctJ5jk3Zd/d0C1FvBB8sGMDTi9ZzhwG+4N3JJYx6yxT/ho+eFIx6jwRE
	 S68UKJ6ZNbyhxXrJPvB1qfceuPZMkNcIUqlW0R4nW8Gp+41uwSUOGf9AXeU70BoxYK
	 JuoikA8BdRQinLW8CUxG4wzwrSLllB6g7HEsc11DsLwApx4dXil3f75cVOsycTs2K9
	 gruAPO8T/Vq2Vy/LUxYnSvRa9U4q+ofleEOlhmzkhdJs7MLLFXJL5ZxkQqIiBMjxJU
	 GxNZxUlSXeBN/nEQZS2n6X0+7P/LR+jrMVfrF7CDVRGNirXZcnGvoQguKkdyalkmBI
	 ILMT1zN1PowFg==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8A0DA17E3CA1;
	Tue, 01 Sep 2026 20:51:32 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:34 +0300
Subject: [PATCH v11 70/74] drm/connector: Drop redundant hdmi
 supported_formats field
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-70-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>
X-Mailer: b4 0.15.2

Now that all users migrated to the new drmm_connector_hdmi_init()
signature, supported_formats is provided through struct
drm_connector_hdmi_funcs, a reference to which is already stored in
drm_connector_hdmi.

Drop the redundant field from drm_connector_hdmi and point its users to
hdmi.funcs->supported_formats instead.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 ++-
 drivers/gpu/drm/drm_connector.c                 | 3 ---
 include/drm/drm_connector.h                     | 6 ------
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 289dce6c6281..687793c62d55 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -428,7 +428,8 @@ sink_supports_format_bpc(const struct drm_connector *connector,
 		return false;
 	}
 
-	if (!(connector->hdmi.supported_formats & BIT(format))) {
+	if (!connector->hdmi.funcs ||
+	    !(connector->hdmi.funcs->supported_formats & BIT(format))) {
 		drm_dbg_kms(dev, "%s format unsupported by the connector.\n",
 			    drm_hdmi_connector_get_output_format_name(format));
 		return false;
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 4d580aaec247..db4d8daacfa0 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -617,9 +617,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
-	connector->hdmi.supported_formats = hdmi_funcs->supported_formats;
-
 	/*
 	 * The supported HDMI version can be used to determinate the maximum
 	 * TMDS character rate allowed by the specification. Some controllers,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 182946279194..d0aaa87dad7b 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2192,12 +2192,6 @@ struct drm_connector_hdmi_audio {
  * struct drm_connector_hdmi - DRM Connector HDMI-related structure
  */
 struct drm_connector_hdmi {
-	/**
-	 * @supported_formats: Bitmask of @drm_output_color_format
-	 * supported by the controller.
-	 */
-	unsigned long supported_formats;
-
 	/**
 	 * @max_tmds_char_rate: Maximum TMDS character rate, in Hz,
 	 * supported by the controller.

-- 
2.55.0

