Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2D4A2A71;
	Tue,  1 Sep 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288663; cv=none; b=a0HtJ3QRx3G2LGhbbwaPAmCCzPcyAlviH1sq9PMx53+vP4BhsC2oj27gPaQPK6xi1IHm3Rtkz0oQzT1K8x4+nuM9NjBRRNbgUu/+o7lDlJKWeUYgfVh3SIpwf7O30L2WCbQVkjWf5qj7/DE+DfZwSU4BeVwsA/dNw2OiovpWo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288663; c=relaxed/simple;
	bh=dHIKdEC5RHVqcHq82GjtYHGUUOJHjjeCBOpp724uoac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XjwakOkhrpWM4SvQCitBtoNnxI7I63s77TOI9INDMJ48jxpuogVy28BLIzp5zdPH9EuQF6fHvhgDWuoD8gqYFnRfviq1RnPGr6F2pJNQljFVOWE18TC2Nn+zo73jOOX2UI6NgTUsUHkEK+azk28vcNsEhWicvoKqnQuLFDWYBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ACW+ziuW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ACW+ziuW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288658;
	bh=dHIKdEC5RHVqcHq82GjtYHGUUOJHjjeCBOpp724uoac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ACW+ziuWAPd7zQm+209nems4I5iTQK8DxQhfTlIXHAZiHsFxLg+JqCna8mjW0HOHN
	 9oRrZAu3JtYTlX3chmx8L5lRyVfKDJ4tedh4UDnomz7Z4HGRGJKJa5A43vFlyVsXv/
	 vycrj6aiyTRjt+Ma0ToXjajA6HX6rGIme9LyvDu8Kp5+VSNbCpQIN5a4zfiNV5mZ6q
	 zFpBFLN1tNBMGnKm9AN+7aAcRv3xpxFheSMR+zKCIZQw6bAdCULapugytg0YfuNyk2
	 bFL3CtQHBlrTx1c1/d+SLHBsR7Dau2rqZ/MIlk75FrSmfC3ud9//gOm2Gq9OhGh1zs
	 zN5/R+JjtaJGA==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3137C17E38DC;
	Tue, 01 Sep 2026 20:50:58 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:47 +0300
Subject: [PATCH v11 23/74] drm/display: hdmi-state-helper: Sync SCDC state
 on hotplug
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-23-bc12954a0688@collabora.com>
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

drm_atomic_helper_connector_hdmi_hotplug() does not currently
synchronize SCDC status on hotplug events, leaving the scrambler state
potentially inconsistent after (re)connect.

Hook drm_connector_hdmi_sync_scdc() into both the connect and disconnect
paths, replacing the existing TODOs around missing scrambler handling.
Note that per .detect_ctx() contract, implementations shall return a
drm_connector_status value or -EDEADLK, nothing else.  Therefore, handle
deadlocks and just report any other errors.  For consistency, also
report the errors from drm_edid_connector_update().

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 34 ++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 8045b1d17d6e..1e269b203b98 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1362,12 +1362,29 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 					enum drm_connector_status status)
 {
 	const struct drm_edid *drm_edid;
+	int ret;
 
 	if (status == connector_status_disconnected) {
-		// TODO: also handle scramber, HDMI sink disconnected.
+		/*
+		 * .detect_ctx() can only ever return a drm_connector_status or
+		 * -EDEADLK. Handle deadlocks, and report any !EDEADLK error.
+		 */
+		ret = drm_connector_hdmi_sync_scdc(connector, false, ctx);
+		if (ret) {
+			if (ret == -EDEADLK)
+				return ret;
+
+			drm_warn(connector->dev, "Ignored SCDC sync error: %d\n", ret);
+		}
+
 		drm_connector_hdmi_audio_plugged_notify(connector, false);
-		drm_edid_connector_update(connector, NULL);
+
+		ret = drm_edid_connector_update(connector, NULL);
+		if (ret)
+			drm_warn(connector->dev, "Ignored EDID update error: %d\n", ret);
+
 		drm_connector_cec_phys_addr_invalidate(connector);
+
 		return 0;
 	}
 
@@ -1381,7 +1398,18 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 	drm_edid_free(drm_edid);
 
 	if (status == connector_status_connected) {
-		// TODO: also handle scramber, HDMI sink is now connected.
+		/*
+		 * .detect_ctx() can only ever return a drm_connector_status or
+		 * -EDEADLK. Handle deadlocks, and report any !EDEADLK error.
+		 */
+		ret = drm_connector_hdmi_sync_scdc(connector, true, ctx);
+		if (ret) {
+			if (ret == -EDEADLK)
+				return ret;
+
+			drm_warn(connector->dev, "Ignored SCDC sync error: %d\n", ret);
+		}
+
 		drm_connector_hdmi_audio_plugged_notify(connector, true);
 		drm_connector_cec_phys_addr_set(connector);
 	}

-- 
2.55.0

