Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643A4D0A06;
	Mon, 21 Sep 2026 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006029; cv=pass; b=tuXDRKFiZMo/ADd947Q9Z/SnMF0v65Qqzl9iZVdZOs8EGFU34DxaAmQ7mMJxLn578KVvr74MwUoHEc3tl06voIxr94Q7grG9dS4Xrw+vZx1Frfigc6L+NEUUAsGEAfUf90VKsa7o+HZI1o53B6OWRmx2QJTyo21ndNLsMBR8Vco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006029; c=relaxed/simple;
	bh=knCbAlkLfrhlmFv8jqU0VreZUnHNDuwUkvMrOyIXedI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZJnEpWUBBqAmEEM7wXOX7bC7C48Fo93LcWqjgET83UJyTbaxkuQuk80zic26NzAGQ5jdgOlDifZJObpvpCAQZ5e6p4ZgySwLSochBW5res430w+mV7pOfpgcNnr3lBdyR5VnZISjEirOmvnBoEW7g+omBxHQBm39bfQDi9tKYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ddZwLhNz; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ddZwLhNz"
ARC-Seal: i=1; a=rsa-sha256; t=1790005979; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JKwzUMbfxHQlGe/yNuKoHW9nf6Q0mAZtxOCgaXBRmARIhBVnMdwTkWrZCuuIUonC0Lfe2TfJ0BNdEP6HzXLKeMU8bSpYTkFm0pjDVLpTGIlzn/2ByAvNFHzyXp96lqgOWqtYS+aqeWCUIAp7g8tOQWhf0N2YZE1RAknclb5lU3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790005979; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RCTNkmpiPL3Ra0ipjPKJl1ubfsMjpTQk6YfOLEZoGhI=; 
	b=BSZvTTyoWSgKb3s04MrP2MNVo5RIgsBhCrYD7D0IpDPYeOq+L2Z/chVXRw4/YT3BJXOn3/wNS2a+5BWTyMhOJJZ4cvrtodewkSMhQpEJr56tlZv83lk+vpjK3jTOoko2ZgF3bd/mJ5TZNFeZdNQp1Eqtithr4w0PhQ93jql/+mg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005979;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=RCTNkmpiPL3Ra0ipjPKJl1ubfsMjpTQk6YfOLEZoGhI=;
	b=ddZwLhNzqWf6wD2hET1tRSxvLxp5nhVwL+oNjnYjeypbyEWOuOwR9OuTWQx7xbeC
	ydfnY3gG8EXraA7ywSp4OuySvdcft8BT3jClXhSw0EYqXUrc2wfUkmEL/i/+hgklufh
	OIQExfyKQExrHTSnJU3f5RSw23K0zsIfrLp4vKBk=
Received: by smtp.zohomail.com with SMTPS id 179000597774875.93524699372142;
	Mon, 21 Sep 2026 08:52:57 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:36 +0200
Subject: [PATCH RFC 10/25] drm/rockchip: dw_hdmi_qp: Add VRR support
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-10-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2

Register the vrr_capable property on the connector for RK3588, where VRR
is implemented.

In the encoder's atomic_check callback, the vrr_capable property, if
present, is then set to true if the sink supports VRR.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 9c4cf68d79d5..2b9432aa8c54 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -192,6 +192,7 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 					 struct drm_crtc_state *crtc_state,
 					 struct drm_connector_state *conn_state)
 {
+	struct drm_connector *connector = conn_state->connector;
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
 	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
 	union phy_configure_opts phy_cfg = {};
@@ -238,6 +239,10 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 		dev_err(hdmi->dev, "Failed to configure phy: %d\n", ret);
 	}
 
+	if (connector->vrr_capable_property)
+		drm_connector_set_vrr_capable_property(connector,
+			drm_display_info_is_vrr_capable(&connector->display_info));
+
 	return ret;
 }
 
@@ -515,6 +520,7 @@ struct rockchip_hdmi_qp_cfg {
 	unsigned int port_ids[MAX_HDMI_PORT_NUM];
 	const struct rockchip_hdmi_qp_ctrl_ops *ctrl_ops;
 	const struct dw_hdmi_qp_phy_ops *phy_ops;
+	bool supports_vrr;
 };
 
 static const struct rockchip_hdmi_qp_cfg rk3576_hdmi_cfg = {
@@ -534,6 +540,7 @@ static const struct rockchip_hdmi_qp_cfg rk3588_hdmi_cfg = {
 	},
 	.ctrl_ops = &rk3588_hdmi_ctrl_ops,
 	.phy_ops = &rk3588_hdmi_phy_ops,
+	.supports_vrr = true,
 };
 
 static const struct of_device_id dw_hdmi_qp_rockchip_dt_ids[] = {
@@ -695,6 +702,13 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
 				     "Failed to init bridge connector\n");
 
+	if (cfg->supports_vrr) {
+		ret = drm_connector_attach_vrr_capable_property(connector);
+		if (ret)
+			return dev_err_probe(hdmi->dev, ret,
+					     "Failed to attach 'vrr_capable' property\n");
+	}
+
 	return 0;
 }
 

-- 
2.55.0

