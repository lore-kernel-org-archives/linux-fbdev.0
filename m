Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA54A64E8;
	Tue,  1 Sep 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288682; cv=none; b=F+QQ5MEOeUm2/LBPcQuwpmhBrbOtStzlA6gz/GTUWs6EtP5TF88V2qIkDZEFiKOOtYSXKIZECsU0XnBllXxLBX417aij1ar6XNUBlcAd7bNWjQCFBu3QVaWUE6U2GOIMTA59iMuOzg+lD6OfXoeb4uXs0V+U5adFWxpbQvMXalM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288682; c=relaxed/simple;
	bh=7TffjHT/FiznFowY3x4vtvfUjZAAe2Mb5KIXYD9cBBU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMM/dzz+znzQpIEAvCdKx/qOarsTlpDosx6sC8q+A4ep/WuWdH1hSt1s3nkHu9T/N0YqVQpdPeuUZkHhUyB8btKvanljCBwZXFTnAyEi3FlP7zCfY93JVnILgWcrZYqZN/7ZOeNNuBzRcqgS/mdo0j1rX8mIzBSV+BOtfOKBQs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dNQpFuO2; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dNQpFuO2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288677;
	bh=7TffjHT/FiznFowY3x4vtvfUjZAAe2Mb5KIXYD9cBBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dNQpFuO2JjXd3aIpv2AD5Fdlo87mTkfdOfX6Fog0LxsbkwpmiFqXuAcKGAoIh6tqX
	 kdGlN5d3oWVjVeogBMIUsaHRID3/XOKwWE4564YplxsbAhjkQAxuhWeEMwoeKLoSs+
	 hsQwlznCXZL7rQ+LOUxPjLN3UxieHJM4giristfeaa5YoAlpDoyjqpM/GAdM/9SMzX
	 0lM4Pk4+gM8j0T8qs1vTdIOvdvX6yJfE3cPsrGB9Bcr9QmzeZdAk6FEpBKoTyT/Mib
	 xT+Oh2ZR2YEddj9PlW4GJ7u2d10vOuljh6Nenl4os6ZN2rAf9GHh5cMxGLTWgyR9iv
	 gW3cJpIiyrEPg==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 27AF817E3C6E;
	Tue, 01 Sep 2026 20:51:17 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:13 +0300
Subject: [PATCH v11 49/74] drm/display: hdmi-state-helper: Drop
 drm_atomic_helper_connector_hdmi_force()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-49-bc12954a0688@collabora.com>
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

With all callers converted to the .force_ctx() connector helper, this
function has no users left.  Remove it.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 15 ---------------
 include/drm/display/drm_hdmi_state_helper.h     |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 7cdb7ca3dc12..d661385c3e64 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1441,21 +1441,6 @@ int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
 
-/**
- * drm_atomic_helper_connector_hdmi_force - HDMI Connector implementation of the force callback
- * @connector: A pointer to the HDMI connector
- *
- * This function implements the .force() callback for the HDMI connectors. It
- * can either be used directly as the callback or should be called from within
- * the .force() callback implementation to maintain the HDMI-specific
- * connector's data.
- */
-void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector)
-{
-	drm_atomic_helper_connector_hdmi_update(connector, NULL, connector->status);
-}
-EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
-
 /**
  * drm_atomic_helper_connector_hdmi_force_ctx - HDMI Connector implementation
  * of the force_ctx callback
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 965342f6bbc9..5c827409db45 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -27,7 +27,6 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
 int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					     struct drm_modeset_acquire_ctx *ctx,
 					     enum drm_connector_status status);
-void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
 int drm_atomic_helper_connector_hdmi_force_ctx(struct drm_connector *connector,
 					       struct drm_modeset_acquire_ctx *ctx);
 

-- 
2.55.0

