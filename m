Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276E24A8A03;
	Tue,  1 Sep 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288687; cv=none; b=u6gbmsmaS7/rA3NUsQrT51ZFF4jcQN3pWBauh7yM+GgHY9gHCAvatvU2L+/fkuZ6JlZ/OiBykcKxfOKKlscwDFMkpBx7r5hwh8yp7NVZGmMnObUVCfIVRwBrEDAOS58ZnOQfzmScb9I455RLR538i7qa5F8GoyCe9OqN4KbM7MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288687; c=relaxed/simple;
	bh=YQBgk0tCInjN78ZsmtnC8gQAxWhSMvfMlnsIg4WQmiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MwFNP57NadXsrl6DJjPnahMjYKLFGdxhi0rTOHXAPv/CzhYtsoJo2J6qUhjlp7W3sb/Od2tZVKI3yMvFS8s+xdAWAmSdirL+Qc2jz/1fNJMQJX7YAoIGbtB4rCztyLilfUTttd+KOIBEimIjyHHJzipe1skZ0QhQWTd07D+s8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U8xjbdh3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U8xjbdh3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288681;
	bh=YQBgk0tCInjN78ZsmtnC8gQAxWhSMvfMlnsIg4WQmiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U8xjbdh3G5kTDYHASjfYejz3nCp1ujP8CPZTrlxtIs9nj7IrI6f8i39K/Nrg6GNQe
	 s4Yc5OoPpAQRlqQ7fXYFL5JQzJZ5lsTKfHhNxExG1ZtiazUC4btBC1LzI7fx/ZJKlR
	 MGcaWV+OLiuU26ETBoP/BVJmR4nYa/xMPCEcuJXh7lL3ekYWn15R4DqQSFtN22sYYG
	 CUHCk9Cll8ZHrwiki3RaHokeXVCLFq+WLC9naV2hpAusXc07wM+UXN3bnGyn3h7V1k
	 +Frukvk8PWmTqdrUnBHu8cg/VIn80WzkD6c/knXnrtkNyCWMToy3hZJROMtywk1x3J
	 tyYvX2lE5Dpow==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8D5C217E3C81;
	Tue, 01 Sep 2026 20:51:21 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:19 +0300
Subject: [PATCH v11 55/74] drm/bridge: lontium-lt9611: Advertise HDMI 1.4
 capabilities
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-55-bc12954a0688@collabora.com>
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

Bridges using DRM_BRIDGE_OP_HDMI are expected to provide the supported
HDMI version.  This is not enforced yet, but will become mandatory once
the migration to the caps-based HDMI connector initialization API is
complete.

As LT9611 supposedly cannot drive a TMDS character rate exceeding 297
MHz, advertise HDMI 1.4 as the supported version.  HDMI 1.4 allows up to
340 MHz, so set the bridge's max_tmds_char_rate to ensure the connector
limit derived from supported_hdmi_ver remains within the hardware
capabilities.

drm_bridge_connector_atomic_check() calls
drm_atomic_helper_connector_hdmi_check(), which rejects modes whose
computed TMDS character rate exceeds the connector's max_tmds_char_rate
before invoking the driver's .tmds_char_rate_valid hook.  Since
max_tmds_char_rate now carries the existing effective limit,
lt9611_hdmi_tmds_char_rate_valid() is redundant.  Drop it.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 3ebd8992cd94..53444bc8326f 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/gpio/consumer.h>
+#include <linux/hdmi.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/media-bus-format.h>
@@ -952,18 +953,6 @@ static int lt9611_hdmi_write_hdmi_infoframe(struct drm_bridge *bridge,
 	return 0;
 }
 
-static enum drm_mode_status
-lt9611_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
-				 const struct drm_display_mode *mode,
-				 unsigned long long tmds_rate)
-{
-	/* 297 MHz for 4k@30 mode */
-	if (tmds_rate > 297000000)
-		return MODE_CLOCK_HIGH;
-
-	return MODE_OK;
-}
-
 static int lt9611_hdmi_audio_startup(struct drm_bridge *bridge,
 				     struct drm_connector *connector)
 {
@@ -1029,7 +1018,6 @@ static const struct drm_bridge_funcs lt9611_bridge_funcs = {
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_get_input_bus_fmts = lt9611_atomic_get_input_bus_fmts,
 
-	.hdmi_tmds_char_rate_valid = lt9611_hdmi_tmds_char_rate_valid,
 	.hdmi_write_audio_infoframe = lt9611_hdmi_write_audio_infoframe,
 	.hdmi_clear_audio_infoframe = lt9611_hdmi_clear_audio_infoframe,
 	.hdmi_write_avi_infoframe = lt9611_hdmi_write_avi_infoframe,
@@ -1175,6 +1163,8 @@ static int lt9611_probe(struct i2c_client *client)
 	lt9611->bridge.hdmi_audio_dev = dev;
 	lt9611->bridge.hdmi_audio_max_i2s_playback_channels = 8;
 	lt9611->bridge.hdmi_audio_dai_port = 2;
+	lt9611->bridge.supported_hdmi_ver = HDMI_VERSION_1_4;
+	lt9611->bridge.max_tmds_char_rate = 297000000; /* 297 MHz for 4k@30 mode */
 
 	drm_bridge_add(&lt9611->bridge);
 

-- 
2.55.0

