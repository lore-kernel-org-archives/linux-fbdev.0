Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7804B4A5C20;
	Tue,  1 Sep 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288679; cv=none; b=Qp/x2WWQSt9A8h5nnAwgmhbhzdfNgvR+Oz24VA5VnMepNk+JHwcQX10vGNX9InpgACLKg2QDjvlID5vWeH4aS8/4ehJWqMZYh8oIOamPQpqsWJJ3EMVbUqUZV94isO+UHNcdOx9uD/7bg3OhM0MnJObxKKRDkdrgECKRzKmeT70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288679; c=relaxed/simple;
	bh=Ib0VXkvxZ021Tl3KbWX279RZDAC5hW7lLH2AzR9DLTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kphHGNtx/f/Q500OcG2ylxxotHZrPCGw57t77xPfrUAKkv1MgUjmy4dkDp31IC7Uld8L21LOBSCreQQxh+3IE9xJVZkK7q9h7yUstrhysesGqWcUffv52KILAN/QZ0+ghJbRoYCetbUdx4Eg3pLo3l2iim7mAhDJEGbZSDAwDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P4QPhmQU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P4QPhmQU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288674;
	bh=Ib0VXkvxZ021Tl3KbWX279RZDAC5hW7lLH2AzR9DLTs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P4QPhmQUZWxgCCRFZOeWbJMjk7CAPeFPQXo6QaVcrMLoxO3g3sOKo3kKMvhrA3P2r
	 m9qIdkv+iZ0qtP8hHD5JtRG+fnSKZINZZP9MTaIZiuA7WS3LOnRQYX8mMD4tHE9KnM
	 3MQPLWFakDjq763WeQXTaZ3VEwoD1zM8rpkIDQK8YBNBbv/QCQhu1IllPtT+cTpbFR
	 8wwmz0za37N1Ezrl2PPIpvpE2xgixgDPfql03ghpXLe/SioaVg6Gt/6kHYFnP5az1s
	 hpCWgvXMsKSyXtKxEL8MXG18xAKD+4nUqueiffZ3K3iA/W2U5EmW9NrZvJ08799nKZ
	 N9gkqzbm7vMAg==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4BBD517E3C67;
	Tue, 01 Sep 2026 20:51:14 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:09 +0300
Subject: [PATCH v11 45/74] drm/vc4: hdmi: Propagate -EDEADLK to the top
 level
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-45-bc12954a0688@collabora.com>
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

drm_connector_helper_funcs.detect_ctx() is expected to propagate
-EDEADLK so that context owners, e.g. drm_helper_probe_detect_ctx(), can
perform the required backoff and retry.

vc4_hdmi_handle_hotplug() instead runs its own retry loop and calls
drm_modeset_backoff() on an acquire context it does not own.  This drops
all locks in the context, including connection_mutex held by the core.

Drop the local retry logic and propagate -EDEADLK to the caller instead.
This aligns VC4 with the expected detect_ctx() semantics.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 7c921a444e98..6bd5aa77538e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -344,12 +344,11 @@ static int vc4_hdmi_reset_link(struct drm_connector *connector,
 	return drm_atomic_helper_reset_crtc(crtc, ctx);
 }
 
-static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
-				    struct drm_modeset_acquire_ctx *ctx,
-				    enum drm_connector_status status)
+static int vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
+				   struct drm_modeset_acquire_ctx *ctx,
+				   enum drm_connector_status status)
 {
 	struct drm_connector *connector = &vc4_hdmi->connector;
-	int ret;
 
 	/*
 	 * NOTE: This function should really be called with vc4_hdmi->mutex
@@ -368,17 +367,9 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *vc4_hdmi,
 	drm_atomic_helper_connector_hdmi_hotplug(connector, ctx, status);
 
 	if (status != connector_status_connected)
-		return;
+		return 0;
 
-	for (;;) {
-		ret = vc4_hdmi_reset_link(connector, ctx);
-		if (ret == -EDEADLK) {
-			drm_modeset_backoff(ctx);
-			continue;
-		}
-
-		break;
-	}
+	return vc4_hdmi_reset_link(connector, ctx);
 }
 
 static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
@@ -416,10 +407,10 @@ static int vc4_hdmi_connector_detect_ctx(struct drm_connector *connector,
 			status = connector_status_connected;
 	}
 
-	vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
+	ret = vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
 	pm_runtime_put(&vc4_hdmi->pdev->dev);
 
-	return status;
+	return ret == -EDEADLK ? ret : status;
 }
 
 static int vc4_hdmi_connector_get_modes(struct drm_connector *connector)

-- 
2.55.0

