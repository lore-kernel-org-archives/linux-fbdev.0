Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD44A8A26;
	Tue,  1 Sep 2026 18:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288688; cv=none; b=hcfJRkSst3nXmCa6dDBfkUjIPVPcszFZ+XseCrgBkYiE2WB8DBpLY9m4an4AeqarrzK0MVYmvr27/e44jzUrch74SnXwI2QcsRLkdORCWibM0Y1NwlV60hxVgaBE7HGTbBKR5/pQ4K3ZwzD+ZhaMwC/oF9aXP30gIuUH1xRrH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288688; c=relaxed/simple;
	bh=eTwvcHzDahjPYHCtMEH5hOYZ7IvsD5Sh3bBiNe6fI+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vCqavYmp4tM+LXyUz0VFMtC6IXb/n8ElORkQgul+yU4gGOH4G52b3ZQKEabtHn6IhTiH4pWkXrw9wsPCX3yVqdyjRYAsVgPsNia7MFOmwNxfRor8MLD/6l8cf9dn1vun0aOFKgT7mbDXPFAkuvqX/F+3ej0Ngx+Bv6kpS/79/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W4Dr2V50; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W4Dr2V50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288683;
	bh=eTwvcHzDahjPYHCtMEH5hOYZ7IvsD5Sh3bBiNe6fI+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W4Dr2V50fcGATA3BlMN2dZTHzsCTva51cS7g3YJltBdKQqVmNCxpivDne3jYxhAMj
	 IdHzXLDAXcROyA4yKlviV5WVIQDblwOxH0Wul3CzAvAouKKRgpNXRGf7+Wys9+x6pN
	 CoNWo0ru1uTpvCoeT7ULCL8DasrcHW/R4uKDNpqA1ixgCyYaXHDn7aVOpJGNJcjR6t
	 2Xd/Gz07CsmE17BdkCKZZhPknfaLVcKkpSapw/n40M9fOHP8VMXr12YAJ5Kz4aQq2O
	 i3C+aSlTolESSnJkVxj24iwhfHyU2hh8LVkHNAoisVK/c7UQ3FpZ81ZtwhCDko6kpe
	 48dpPv/kbDTuQ==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0DD1217E3C88;
	Tue, 01 Sep 2026 20:51:23 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:21 +0300
Subject: [PATCH v11 57/74] drm/sun4i: hdmi: Convert to
 drmm_connector_hdmi_init()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-57-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org
X-Mailer: b4 0.15.2

Switch driver over to the new drmm_connector_hdmi_init() signature and
advertise HDMI 1.2 support.  The vendor, product, supported_formats and
max_bpc values previously passed as arguments are now provided through
struct drm_connector_hdmi_funcs, together with the new
supported_hdmi_ver field.

The HDMI connector helpers infer the 165 MHz TMDS character rate ceiling
from supported_hdmi_ver and reject modes exceeding it before invoking
the driver's .tmds_char_rate_valid() hook.  This makes the explicit mode
clock check in sun4i_hdmi_connector_clock_valid() redundant, so drop it.

No functional change intended.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index d98b6f12a7bc..6f4fe0c8efae 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -192,10 +192,6 @@ sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
 		return MODE_BAD;
 
-	/* HDMI 1.0 max TMDS character rate */
-	if (clock > HDMI_1_0_TMDS_CHAR_RATE_MAX_HZ)
-		return MODE_CLOCK_HIGH;
-
 	rounded_rate = clk_round_rate(hdmi->tmds_clk, clock);
 	if (rounded_rate > 0 &&
 	    max_t(unsigned long, rounded_rate, clock) -
@@ -253,6 +249,15 @@ static struct i2c_adapter *sun4i_hdmi_get_ddc(struct device *dev)
 }
 
 static const struct drm_connector_hdmi_funcs sun4i_hdmi_hdmi_connector_funcs = {
+	/*
+	 * NOTE: Those are likely to be wrong, but I couldn't find
+	 * the actual ones in the BSP.
+	 */
+	.vendor = "AW",
+	.product = "HDMI",
+	.supported_hdmi_ver = HDMI_VERSION_1_2,
+	.supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
+	.max_bpc = 8,
 	.tmds_char_rate_valid	= sun4i_hdmi_connector_clock_valid,
 	.avi = {
 		.clear_infoframe	= sun4i_hdmi_clear_avi_infoframe,
@@ -654,19 +659,11 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 
 	drm_connector_helper_add(&hdmi->connector,
 				 &sun4i_hdmi_connector_helper_funcs);
-	ret = drmm_connector_hdmi_ini2(drm, &hdmi->connector,
-				       /*
-					* NOTE: Those are likely to be
-					* wrong, but I couldn't find the
-					* actual ones in the BSP.
-					*/
-				       "AW", "HDMI",
+	ret = drmm_connector_hdmi_init(drm, &hdmi->connector,
 				       &sun4i_hdmi_connector_funcs,
 				       &sun4i_hdmi_hdmi_connector_funcs,
 				       DRM_MODE_CONNECTOR_HDMIA,
-				       hdmi->ddc_i2c,
-				       BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444),
-				       8);
+				       hdmi->ddc_i2c);
 	if (ret) {
 		dev_err(dev,
 			"Couldn't initialise the HDMI connector\n");

-- 
2.55.0

