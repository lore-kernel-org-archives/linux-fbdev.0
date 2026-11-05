Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894094;
	b=jicOqbY3sPLL5ngxZIFQaul5lgJUHc9mbWBXn99oXaOaQPPOCmvBXsV0ZnAwvjcZ/igC
	 UZ+bBbuyP5ZBst5Rf9/43IPyuOq2ICJ4Apm7HO8WPvgnR5kkpYoTN3SuL8GMt7T4JGA+J
	 MLOu4uPb9btfBqS3CJFAOEpR4rr4Vu2nRusAlc2eREjaKE2wziCJc+iCXWvwimUWFD4rN
	 WnDhvIAVe1LVnxASSxIf9u/haG8gmf4mwGcbCf8QHQX+1ifXgPYMLDBdrQykBTqLtON84
	 YzD74ZfXSsMK7m9MrIq+DwWR9iMWzb24HrczmCS15UEP595O9eJ9KS1AdawXsVW+iFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894094;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=6/fwN93QKXlrtEMORZyL36eAUclAA0jiIqQ2lFOaVlU=;
	b=KcpmIGslvIhNgCeyFwSiYrHgt83tvM9lJXWWPPlqgpkiwve4apVPgQviRIktyXpMrjol
	 oAPlQvJTgm+QZigBpVJA/Yn47IYUWkUX4CzgL6Id6+j7Xny5aGZsjyhyCN85MSZpkSwgk
	 qDTAQ4YVyzt5irIq5C6jnQP0vqGOTxLzEy9dTdbsBrqi6irE8Jv17v41C6Z73/KuvGGHb
	 AQMo3b5kRDMU5tE7QA9Z6EKsMNNFvYBv2vfQMNhWPC7BqU2s3rgyL8kPq4KHHTGiAZO0o
	 uNBIu7WaOYDLS7ZP4MWKrj5O119ui4xHCbJPHuc673S8hoNdG1TWJCJatxJXCTPP4KQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Zt2iw1oW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE8606BE99;
	Thu,  5 Nov 2026 15:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81CE8606BE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Zt2iw1oW
ARC-Seal: i=1; a=rsa-sha256; t=1793894029; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=H02ZAr5Vw9Gs31CTvx+lICyFIHdpMWyn56zfo1ZbTp7MeBADqoWSOs6ixHiX/sSnD62iZCVlC4TjfnteMCo+TCy2DaFkpzf4rkEQEtAI4PK/7mK0w7txf5Pdf/0YiY/GPZXa3hXfSeBPwHCB8hYa1vRB54VgyujhAYrINnMP1x4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894029; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6/fwN93QKXlrtEMORZyL36eAUclAA0jiIqQ2lFOaVlU=; 
	b=dOwreIY/6IBxG4H2bL47N85ulMTOCgF9SbugYezL1iJsbP4uYRU4uVtFxjxztPXO8WY3koFNer3iToHObO5yjl8NIQEtsbxuq7ydJ/Tf9ATFcYFR9PhvMNtjbGwuLOCc6mUvWDgdS4ccEHU9t4qGWf5B6eeCFBjedfuE+vUwk84=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Zt2iw1oWLewd89zpH9+Ru/LuCDkqphfaszhoj0X6axcHoAWm9w9rzkjx2LXUNK8BMstv8INg2EZoLYvPS3UCz3nzr4SBSfIhhaj9bjGXkyFVSCmnQ2yzNVW1z1Vzf067eFDUfFDuzAiM1FZ1g6wwFwsC1uGliaLYyzycvto+82k=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=6/fwN93QKXlrtEMORZyL36eAUclAA0jiIqQ2lFOaVlU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894028283757.3938461427174;
	Thu, 5 Nov 2026 07:53:48 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:03 +0100
Subject: [PATCH v2 12/27] drm/rockchip: dw_hdmi_qp: Add VRR support
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-vrr-limiter-uapi-v2-12-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2

Register the vrr_capable property on the connector for RK3588, where VRR
is implemented, as well as the other VRR connector properties.

In the encoder's atomic_check callback, the vrr_capable property, if
present, is then set to true if the sink supports VRR. The display limit
properties are also updated accordingly there, using the helper.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index f2a1ea8dfefa..dcde50bca36b 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -89,6 +89,9 @@
 #define RK_COLOR_FMT_YUV444		0x2
 #define RK_COLOR_FMT_YUV420		0x3
 
+#define RK_VRR_DISPLAY_MODES		(BIT(VRR_DISPLAY_MODE_GAME) | \
+					 BIT(VRR_DISPLAY_MODE_OFF))
+
 struct rockchip_hdmi_qp {
 	struct device *dev;
 	struct regmap *regmap;
@@ -195,6 +198,7 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 					 struct drm_crtc_state *crtc_state,
 					 struct drm_connector_state *conn_state)
 {
+	struct drm_connector *connector = conn_state->connector;
 	struct rockchip_crtc_state *s = to_rockchip_crtc_state(crtc_state);
 	struct rockchip_hdmi_qp *hdmi = to_rockchip_hdmi_qp(encoder);
 	union phy_configure_opts phy_cfg = {};
@@ -205,6 +209,12 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
 	if (ingest_fmt < 0)
 		return -EINVAL;
 
+	if (connector->vrr_capable_property) {
+		drm_connector_set_vrr_capable_property(connector,
+			drm_display_info_is_vrr_capable(&connector->display_info));
+		drm_connector_hdmi_update_vrr_limits(connector, &crtc_state->mode);
+	}
+
 	if (hdmi->tmds_char_rate == conn_state->hdmi.tmds_char_rate &&
 	    s->output_bpc == conn_state->hdmi.output_bpc &&
 	    s->bus_format == ingest_fmt)
@@ -552,6 +562,7 @@ struct rockchip_hdmi_qp_cfg {
 	unsigned int port_ids[MAX_HDMI_PORT_NUM];
 	const struct rockchip_hdmi_qp_ctrl_ops *ctrl_ops;
 	const struct dw_hdmi_qp_phy_ops *phy_ops;
+	bool supports_vrr;
 };
 
 static const struct rockchip_hdmi_qp_cfg rk3576_hdmi_cfg = {
@@ -571,6 +582,7 @@ static const struct rockchip_hdmi_qp_cfg rk3588_hdmi_cfg = {
 	},
 	.ctrl_ops = &rk3588_hdmi_ctrl_ops,
 	.phy_ops = &rk3588_hdmi_phy_ops,
+	.supports_vrr = true,
 };
 
 static const struct of_device_id dw_hdmi_qp_rockchip_dt_ids[] = {
@@ -729,6 +741,24 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return dev_err_probe(dev, PTR_ERR(connector),
 				     "Failed to init bridge connector\n");
 
+	if (cfg->supports_vrr) {
+		ret = drm_connector_attach_vrr_capable_property(connector);
+		if (ret)
+			return dev_err_probe(hdmi->dev, ret,
+					     "Failed to attach 'vrr_capable' property\n");
+
+		ret = drm_connector_attach_vrr_display_mode_property(connector,
+								     RK_VRR_DISPLAY_MODES);
+		if (ret)
+			return dev_err_probe(hdmi->dev, ret,
+					     "Failed to attach 'vrr_display_mode' property\n");
+
+		ret = drm_connector_attach_vrr_display_limits_properties(connector);
+		if (ret)
+			return dev_err_probe(hdmi->dev, ret,
+					     "Failed to attach VRR display limits properties\n");
+	}
+
 	platform_set_drvdata(pdev, hdmi);
 
 	return 0;

-- 
2.56.0

