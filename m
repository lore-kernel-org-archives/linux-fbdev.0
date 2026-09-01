Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2E4A0F08;
	Tue,  1 Sep 2026 18:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288657; cv=none; b=FaIb81X4y3erFVUAl4OHNF4Dmq8HEvnQOW7kiV8EN77LLCdn34WwU/Urwc3rirrqxdB5OibnsQg2sAer6nO4mEcqMtGHFHWVlrj7ONAsUxdlAGIfFXcyXvJWFSGRS23MypGlqJ9Zq5HponF2h2/umLaOwixhkEHm6GUuh8EbXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288657; c=relaxed/simple;
	bh=q5EwAZk5tThfOFfPU3cHVXQvyZ71nTre7ie20f65OJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HbKJNpnB5+QCIWG2Yrk0cC7tI5vX4Xyt35YOfGnqLXS5kKSBu2AjhbDqFUlkR3Obg5kiGs4Rr54yidgV+BjpbDW3rKJhGTuZyl80+g6sJhsT6Y6GUjuSitpb7ZpI9mZXm+3SusU0lI3vmFYh9zhKSUo4SvJBw2vzuLFzVcw3Bdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J2Njq9Vi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J2Njq9Vi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288653;
	bh=q5EwAZk5tThfOFfPU3cHVXQvyZ71nTre7ie20f65OJw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J2Njq9Vi4JicstBaFOmx64tiCSCfNhZmvrwUjq8IOZnqHv47VAxHqWQZkFzY7rLh8
	 vX1QUhcXIcdWtaHcY4YrYQzVyIu0Yc4tiCw1el/rEM33TmPVaMuPJyZ7EHJzZ3wSl7
	 STYLGxcHUtUidmoGGwMURTfPKLNUcyKU799VoOiuSuA+MrPsqTdpAKQTTtC7TsVR/o
	 WMc1rjvZdcoQZYPd9JuCpp28ILBfkwHekbR6EezLLDmXWr3gqJ+XMORG5nadKxl3fs
	 DAY4fV9OzvpeKRrZLhu0n3ZKgE8l4wCo9b/kRYEYW9fdw/Ape4mkxZH/DW3P8I2LHO
	 S7LzOEenNGkWg==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0335A17E36FC;
	Tue, 01 Sep 2026 20:50:53 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:40 +0300
Subject: [PATCH v11 16/74] drm/bridge: Add bridge ops for source-side HDMI
 2.0 scrambling
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-16-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2

Bridges advertising HDMI 2.0 must be able to enable and disable
source-side scrambling and the high TMDS clock ratio when the configured
mode exceeds 340 MHz.

Add .hdmi_scrambler_{enable|disable}() callbacks covering the
source-side programming only; sink-side SCDC negotiation remains the job
of the HDMI connector helpers.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 include/drm/drm_bridge.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 5a5a25995471..77b3ffe69230 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -561,6 +561,41 @@ struct drm_bridge_funcs {
 				     const struct drm_display_mode *mode,
 				     unsigned long long tmds_rate);
 
+	/**
+	 * @hdmi_scrambler_enable:
+	 *
+	 * Enable source-side scrambling and the high TMDS clock ratio for the
+	 * mode currently being applied.
+	 *
+	 * This only programs the source side. Sink-side SCDC configuration is
+	 * handled by the HDMI connector helpers.
+	 *
+	 * Mandatory for bridges that set the DRM_BRIDGE_OP_HDMI flag in their
+	 * &drm_bridge->ops and advertise HDMI_VERSION_2_0 or later via
+	 * &drm_bridge->supported_hdmi_ver; unused otherwise.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise.
+	 */
+	int (*hdmi_scrambler_enable)(struct drm_bridge *bridge);
+
+	/**
+	 * @hdmi_scrambler_disable:
+	 *
+	 * Disable source-side scrambling and the high TMDS clock ratio.
+	 *
+	 * This only programs the source side. Sink-side SCDC configuration is
+	 * handled by the HDMI connector helpers.
+	 *
+	 * Mandatory for bridges that set the DRM_BRIDGE_OP_HDMI flag in their
+	 * &drm_bridge->ops and advertise HDMI_VERSION_2_0 or later via
+	 * &drm_bridge->supported_hdmi_ver; unused otherwise.
+	 *
+	 * Returns:
+	 * 0 on success, a negative error code otherwise.
+	 */
+	int (*hdmi_scrambler_disable)(struct drm_bridge *bridge);
+
 	/**
 	 * @hdmi_clear_avi_infoframe:
 	 *

-- 
2.55.0

