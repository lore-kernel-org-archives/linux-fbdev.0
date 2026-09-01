Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB249551D;
	Tue,  1 Sep 2026 18:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288651; cv=none; b=G0muHGREjRwABe66EoQi+WYjii51S8Ikd1Vl7f/QPxqeyAJg4VRCq5PBuLs+RWtMa1D+iWbAUUXTu70s7R8pzCXXR2q9OfzXg6ommqcDEssBF8AMN78TRmJ4+T60Z53Web+jqwTq87tjy1ZW8UgxBHtgwgSVjNG9zEN21T3LsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288651; c=relaxed/simple;
	bh=BAVvQD/OYJFSVikOMEpkXJX6KCpXHOl4cE1A14fg7sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzBGBz+0FSVSP6oPxChoz6W/P4Ng7Kmqit+rSua0RwNiW5kXChJ0fYZ7dWX0+XBFDWGNVpx2VczNfc7ix63Um5lQ8W7XvYiYkW+3QWGYbPNYHMSzHuCmtRoHH+fqDhUUEv0r5qtpBwVQ3xS3ja63pb2qkKX5jwmw67NHYMwn9Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=g/1nQ/19; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="g/1nQ/19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288647;
	bh=BAVvQD/OYJFSVikOMEpkXJX6KCpXHOl4cE1A14fg7sI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g/1nQ/19FI8qMQMsk9TPW9ynbu0mqig+TqNGDDRAw/k24c6FZok7fnunDPNoLmHgh
	 0cx5f+PWo6cAPTpSF+2OrPQZo5RUEHo/2i1d+A9RHTUzHm+befbSV1BkoZp6qnpEIg
	 pi4juQIqA1C27pWAWTojnLpVpzR1quSuIha/16TI55yQ4VvzjXk/zn+E+RgjWDoqCF
	 McnvO81p9oSn7ttudROkCJr+BFIFsug1/RxsE25zKQ7OZ1n5uCm3WVb5zy5DsWAcqV
	 tWjrJTYCUf122fJw0re+8XFmroW7eUziqIDPHqEzKUrkoMPYNyKV/m6EmLJ+7dsrx8
	 aK/uWiAXh1wLA==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 00CD917E14D2;
	Tue, 01 Sep 2026 20:50:47 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:32 +0300
Subject: [PATCH v11 08/74] drm/display: scdc-helper: Add macro for
 connector-prefixed debug messages
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-8-bc12954a0688@collabora.com>
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

Introduce the drm_scdc_dbg() wrapper over drm_dbg_kms() to help getting
rid of the boilerplate around prefixing the debug messages with the
connector information.

Acked-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_scdc_helper.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_scdc_helper.c b/drivers/gpu/drm/display/drm_scdc_helper.c
index d00da20862fc..1e7c41d4f926 100644
--- a/drivers/gpu/drm/display/drm_scdc_helper.c
+++ b/drivers/gpu/drm/display/drm_scdc_helper.c
@@ -58,6 +58,10 @@
 
 #define SCDC_I2C_SLAVE_ADDRESS 0x54
 
+#define drm_scdc_dbg(connector, fmt, ...)					\
+	drm_dbg_kms((connector)->dev, "[CONNECTOR:%d:%s] " fmt,			\
+		    (connector)->base.id, (connector)->name, ##__VA_ARGS__)
+
 static const char *drm_scdc_frl_rate_str(enum drm_scdc_frl_rate rate)
 {
 	switch (rate) {
@@ -193,9 +197,7 @@ bool drm_scdc_get_scrambling_status(struct drm_connector *connector)
 
 	ret = drm_scdc_readb(connector->ddc, SCDC_SCRAMBLER_STATUS, &status);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to read scrambling status: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to read scrambling status: %d\n", ret);
 		return false;
 	}
 
@@ -223,9 +225,7 @@ bool drm_scdc_set_scrambling(struct drm_connector *connector,
 
 	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to read TMDS config: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to read TMDS config: %d\n", ret);
 		return false;
 	}
 
@@ -236,9 +236,7 @@ bool drm_scdc_set_scrambling(struct drm_connector *connector,
 
 	ret = drm_scdc_writeb(connector->ddc, SCDC_TMDS_CONFIG, config);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to enable scrambling: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to enable scrambling: %d\n", ret);
 		return false;
 	}
 
@@ -283,9 +281,7 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
 
 	ret = drm_scdc_readb(connector->ddc, SCDC_TMDS_CONFIG, &config);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to read TMDS config: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to read TMDS config: %d\n", ret);
 		return false;
 	}
 
@@ -296,9 +292,7 @@ bool drm_scdc_set_high_tmds_clock_ratio(struct drm_connector *connector,
 
 	ret = drm_scdc_writeb(connector->ddc, SCDC_TMDS_CONFIG, config);
 	if (ret < 0) {
-		drm_dbg_kms(connector->dev,
-			    "[CONNECTOR:%d:%s] Failed to set TMDS clock ratio: %d\n",
-			    connector->base.id, connector->name, ret);
+		drm_scdc_dbg(connector, "Failed to set TMDS clock ratio: %d\n", ret);
 		return false;
 	}
 

-- 
2.55.0

