Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984034A0EE6;
	Tue,  1 Sep 2026 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288684; cv=none; b=tyVg1Mstjo4BYsTAI2lyl63NgIdR/eyCWTGSSwgsFUouHRKuB/LrCxPMAjB10mpml4HoK/4/gI4T0LFsjET0S710wzeehzoZrNOYX1unNBH9SpTEcHUk6mcn2kMKUI4It4oNdjiHyVCVaiPmXsg4fb2lwl8IxHpVzlKVu5qE968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288684; c=relaxed/simple;
	bh=FjNG/FbAfUxNWdfXcasZdzMERNWbRLC78jj086GTy6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvyprW4BYt0KlBMcwHfkIj82mhD13eBahSF+tctEHCN0N0/7AkYhiclzbPIByZQYB7Fg26HZHbMtjNFP9fKb3hoh7aFAEAIBW/o2G/dsYZBlHri4V9TwBO78Ilrb8l+A9YXW+2m9h7YaLFCasm8LzT96k/NRkytKmwn7oY1jAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HlwRPzYa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HlwRPzYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288679;
	bh=FjNG/FbAfUxNWdfXcasZdzMERNWbRLC78jj086GTy6I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HlwRPzYap1glbrJnfLcC2NFINYYovF4JW9xAFw8W9qLlGl6EWvWK2n8rAGAdp5KTj
	 1u9SAoOL7rxv98kkUC7LlkTDd8EckVpWMweCGAf7hqHXPCN0W5Fa8lU6r9fJVEUpqu
	 HcfrsNPLGkvpAClhVhVkifq7lbTgSLHNxY0GXk5tae8jpQwZz/dY2ijuOAweS9n9OL
	 fYB/xbkSULb1AzZa/aEmlhkI7Sq7GTTNRAtOyObl3H0yD9CQTK6831bqRwjN32eWQf
	 C8dnwTz6j2J6nvtsvhiqFUTD7lmXbPOQpk9fmU7aWaz3xVTwyQA+Ra7lzDnOJH6NQC
	 Ca/Zx61fzEfTg==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A3B817E3C76;
	Tue, 01 Sep 2026 20:51:19 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:16 +0300
Subject: [PATCH v11 52/74] drm/bridge: ite-it6263: Drop redundant
 .mode_valid hook
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-52-bc12954a0688@collabora.com>
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

Bridges using DRM_BRIDGE_OP_HDMI expect connectors to be created through
drm_bridge_connector_init(), thereby relying on the bridge connector's
.mode_valid hook to invoke drm_hdmi_connector_mode_valid().

The generic helper computes the mode's TMDS character rate and forwards
it to the bridge's .hdmi_tmds_char_rate_valid callback through the
connector HDMI funcs.  This covers exactly what
it6263_bridge_mode_valid() does for 8 bpc RGB444, but due to being
output-format aware, it also handles the validation more thoroughly.

Both the connector and bridge .mode_valid hooks are invoked during
mode validation through drm_mode_validate_pipeline(), so the custom
bridge hook is redundant.  Drop it.

While at it, remove the now-unused drm_hdmi_helper.h include.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/ite-it6263.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 21ac8e58b9d2..550999491086 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -15,7 +15,6 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
-#include <drm/display/drm_hdmi_helper.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -669,20 +668,6 @@ static void it6263_bridge_atomic_enable(struct drm_bridge *bridge,
 	regmap_write(regmap, HDMI_REG_PKT_GENERAL_CTRL, ENABLE_PKT | REPEAT_PKT);
 }
 
-static enum drm_mode_status
-it6263_bridge_mode_valid(struct drm_bridge *bridge,
-			 const struct drm_display_info *info,
-			 const struct drm_display_mode *mode)
-{
-	unsigned long long rate;
-
-	rate = drm_hdmi_compute_mode_clock(mode, 8, DRM_OUTPUT_COLOR_FORMAT_RGB444);
-	if (rate == 0)
-		return MODE_NOCLOCK;
-
-	return bridge->funcs->hdmi_tmds_char_rate_valid(bridge, mode, rate);
-}
-
 static int it6263_bridge_attach(struct drm_bridge *bridge,
 				struct drm_encoder *encoder,
 				enum drm_bridge_attach_flags flags)
@@ -831,7 +816,6 @@ static const struct drm_bridge_funcs it6263_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = it6263_bridge_attach,
-	.mode_valid = it6263_bridge_mode_valid,
 	.atomic_disable = it6263_bridge_atomic_disable,
 	.atomic_enable = it6263_bridge_atomic_enable,
 	.detect = it6263_bridge_detect,

-- 
2.55.0

