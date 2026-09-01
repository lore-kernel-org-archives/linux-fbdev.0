Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7464A3840;
	Tue,  1 Sep 2026 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288664; cv=none; b=aHRJS7bLPLn0NTzLl69AgyVx3TH7SKt9kOE0SDcwJCC2GG7HGOgsbpASPHZ7ZdCJstYFvIT6u/NTnJzwAQd7t4VSUfPZDozxW9oD/RIE5kjI7RNEommLaLmvAjdquQK7tGgvrDhGMX2v8Z53an17Y0+j+zw4BiXxuhZxAz2HQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288664; c=relaxed/simple;
	bh=RkfCwo+2xh2eA4ByQWj+OR0E04K3cBjBCK6HYgdmnC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3kD/4YJUAZEBZrK6q1hldA8dUTZ1xHF+pilhIuVZfd3L4eEQePO+qZPpiGBct4VgXQMxtTLjEZEdj151VR9qjjwbmMyvw0LBHvZyPtxvnzZXKMBY/ESHUUKnaydn0jQO279Ns4YnK4av89sEQriRGTAN41PPx0W5KiUTpanRzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e57Wp8BC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e57Wp8BC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288659;
	bh=RkfCwo+2xh2eA4ByQWj+OR0E04K3cBjBCK6HYgdmnC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e57Wp8BCxkaI3grdmHvLeFEzL34bcRhsPmJS/VLQ6NSOsAK5su60nB3bcl5H0C/fk
	 nh31JaIO157gB+AJ5utw8azvVZ5H4berfJoT3IUd2a3v7Chnu7ZMBRbxoskadxEYXZ
	 GalLCIzLFoE6OA7dpRgi1vEuhqNXj2ATFnSekxYS0yx7l9Fjy5my1w3hMTHXa+vJU9
	 0OBPLJZftdnFTMixnWZ+d4ardebC+7dO30nd2PrUieKTL0U6w6aszH3ZaXsrrIm4FB
	 LbeJ3wThzHrLRbw4lSnx7bkhUypGR4F/sIwgeraRhoXNzFA2C9QnlPwVbIBeZfec7s
	 dLg4LSiPPdg2w==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D9B417E38F9;
	Tue, 01 Sep 2026 20:50:59 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:49 +0300
Subject: [PATCH v11 25/74] drm/display: bridge_connector: Switch to
 .force_ctx() connector helper
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-25-bc12954a0688@collabora.com>
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

Turn drm_bridge_connector_force() into a .force_ctx() implementation and
hand the acquire context over to
drm_atomic_helper_connector_hdmi_force_ctx(), so that the HDMI connector
framework can reset the CRTC to recover the SCDC state when the sink
reconnects while the display pipeline is active.

No functional change for non-HDMI bridge connectors, which keep behaving
as a no-op.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index b5a6e2e8bcd5..707d7143e475 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -208,16 +208,6 @@ static void drm_bridge_connector_disable_hpd(struct drm_connector *connector)
  * Bridge Connector Functions
  */
 
-static void drm_bridge_connector_force(struct drm_connector *connector)
-{
-	struct drm_bridge_connector *bridge_connector =
-		to_drm_bridge_connector(connector);
-	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
-
-	if (hdmi)
-		drm_atomic_helper_connector_hdmi_force(connector);
-}
-
 static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
 					      struct dentry *root)
 {
@@ -277,7 +267,6 @@ drm_bridge_connector_color_format(const struct drm_connector_state *conn_state)
 }
 
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
-	.force = drm_bridge_connector_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_create_state = drm_bridge_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
@@ -329,6 +318,19 @@ static int drm_bridge_connector_detect_ctx(struct drm_connector *connector,
 	return status;
 }
 
+static int drm_bridge_connector_force_ctx(struct drm_connector *connector,
+					  struct drm_modeset_acquire_ctx *ctx)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *hdmi = bridge_connector->bridge_hdmi;
+
+	if (hdmi)
+		return drm_atomic_helper_connector_hdmi_force_ctx(connector, ctx);
+
+	return 0;
+}
+
 static int drm_bridge_connector_get_modes_edid(struct drm_connector *connector,
 					       struct drm_bridge *bridge)
 {
@@ -421,6 +423,7 @@ static int drm_bridge_connector_atomic_check(struct drm_connector *connector,
 static const struct drm_connector_helper_funcs drm_bridge_connector_helper_funcs = {
 	.get_modes = drm_bridge_connector_get_modes,
 	.detect_ctx = drm_bridge_connector_detect_ctx,
+	.force_ctx = drm_bridge_connector_force_ctx,
 	.mode_valid = drm_bridge_connector_mode_valid,
 	.enable_hpd = drm_bridge_connector_enable_hpd,
 	.disable_hpd = drm_bridge_connector_disable_hpd,

-- 
2.55.0

