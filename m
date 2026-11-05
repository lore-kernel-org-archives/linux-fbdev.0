Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894096;
	b=xNGIVRW/gk9VGfhR5Iyp7VkfFULzPOL6Qo8O4V6TICLWxksgQhWFiZQ44UQCuB6bTX7Y
	 cd2QsvVKOZyyFN6VnTVu/cyPXiUbRUDCw8mAKIQEWNNJSOlxQLNSP9q+4vaMgpGmtfTzm
	 lu8LqnSR/evtJ+1JS3yuKMML/C8j2uYDd52j4aVOzbZ9WTNRXnoa+QIl25teV05gqQMWA
	 8KttSq9+l7ChzH6J15g5rzTo1ZFD3eN9Hh02y0vuTf6A++4Mu+av7kvagkTFmF5OcGmj0
	 ktbN/VaCBMGtrHdY8EHyJnA7k7qPSF/QE92MaYaVgjweP3xCIW7Bysp2nxkdhQrKZAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894096;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=+IFvGBiDHS/+wPz5FfqsRIQOtWki0vWdwd+Qq7+myMU=;
	b=zeMnbf0RJ9FAzq1ndYpLmAkcn4HOLghyw/xDm6Pa1pcMvhoZpsvDcbgLKDOT+fxPfu3S
	 MwxNqp/Tz6vzCB7ppD6pGzY7Oumg0AhSIdKahaQGHTYGDHeti/YYKdb/pg587EwS26y7/
	 DdSq3tZhA7gutz2BAfUdlbxHZuFMvfs7hTsZxL1uSuO8q0oiCfLKeGXJJCfpfk23nazEg
	 0ZYMzja1YH6EyEomhtiKw1Ko39cJfZWpMGl05yA4trpKhhY3Dvrdd8arVoFZiv+lYEGQF
	 t0NhCixGMcDZ6FSTU0jwVpdIo3pcgA5Ew+aS6Yo6xb7nOZ1dT1pknkJYVI+JONDbOag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=U2fsk3BW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC8C606CFAA;
	Thu,  5 Nov 2026 15:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDC8C606CFAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=U2fsk3BW
ARC-Seal: i=1; a=rsa-sha256; t=1793893978; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q4f3MSalRIYdWoS7JT1p0KG481TBRMDwOFO6clo9A38Vwt4ppRF0k8v19UY5nNgC9qUCpx1/0EIHoyr1pgamdJiiqL4qln4gRwTIHP7FkFbcgPvoRF9C9qjyfZHbJjT0ugoiez7BsqNOiwSGAmyebcUAEQki7UkKSFR1G2KUZkU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793893978; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+IFvGBiDHS/+wPz5FfqsRIQOtWki0vWdwd+Qq7+myMU=; 
	b=Bct4KT+KnNnFTsPOn8mDZSfKd31jQl0XZ6DYzsWEqVy8zeArCV/kXSzPw6uF/o0WBpFl+cmQwQ9SX6GZ0nDYM6i1pyhVIA1QPkrpZs0VQGGRtOePCL7f7BnbtPiWtXetA0OpZFlRDZAkM2F0SF+Po8c8BcFmko8fimOg9Vv7TCM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=U2fsk3BWPqJSZNdlrYflk1UxPTCQ+a7YwA6gblr+h1eeX+HofxfGLiPi2LqWBng5sjjJM7X97hbGlfKT5Fn0YCUKS4litw8vgMJiIV1zHuwLnjAE4GEzctcRGA1AN2q/qwh6t+fUv9iZOnLBMwFIKFnUZ54b/TQXvEXksU76iuM=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=+IFvGBiDHS/+wPz5FfqsRIQOtWki0vWdwd+Qq7+myMU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793893977295617.0780215669394;
	Thu, 5 Nov 2026 07:52:57 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:51:55 +0100
Subject: [PATCH v2 04/27] drm/bridge: Add VTEM EMP support
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
Message-Id: <20261105-vrr-limiter-uapi-v2-4-55f4215be2c2@collabora.com>
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

From: Derek Foreman <derek.foreman@collabora.com>

Add setters and support bit for VTEM emp to the bridge.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 41 ++++++++++++++++++++++++++
 include/drm/drm_bridge.h                       | 29 ++++++++++++++++++
 include/drm/drm_connector.h                    |  8 +++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 2202e6044444..0fbdba584c1b 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -611,6 +611,33 @@ static int drm_bridge_connector_scrambler_disable(struct drm_connector *connecto
 	return bridge->funcs->hdmi_scrambler_disable(bridge);
 }
 
+static int drm_bridge_connector_clear_vtem_emp(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi;
+	if (!bridge)
+		return -EINVAL;
+
+	return bridge->funcs->hdmi_clear_vtem_emp(bridge);
+}
+
+static int drm_bridge_connector_write_vtem_emp(struct drm_connector *connector,
+					       const u8 *buffer, size_t len)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi;
+	if (!bridge)
+		return -EINVAL;
+
+	return bridge->funcs->hdmi_write_vtem_emp(bridge, buffer, len);
+}
+
 static const struct drm_edid *
 drm_bridge_connector_read_edid(struct drm_connector *connector)
 {
@@ -656,6 +683,11 @@ static const struct drm_connector_infoframe_funcs drm_bridge_connector_hdmi_spd_
 	.write_infoframe = drm_bridge_connector_write_spd_infoframe,
 };
 
+static const struct drm_connector_infoframe_funcs drm_bridge_connector_hdmi_vtem_emp = {
+	.clear_infoframe = drm_bridge_connector_clear_vtem_emp,
+	.write_infoframe = drm_bridge_connector_write_vtem_emp,
+};
+
 static int drm_bridge_connector_audio_startup(struct drm_connector *connector)
 {
 	struct drm_bridge_connector *bridge_connector =
@@ -947,6 +979,11 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			     !bridge->funcs->hdmi_scrambler_disable))
 				return ERR_PTR(-EINVAL);
 
+			if (bridge->ops & DRM_BRIDGE_OP_HDMI_VTEM_EMP &&
+			    (!bridge->funcs->hdmi_write_vtem_emp ||
+			     !bridge->funcs->hdmi_clear_vtem_emp))
+				return ERR_PTR(-EINVAL);
+
 			bridge_connector->bridge_hdmi = drm_bridge_get(bridge);
 		}
 
@@ -1073,6 +1110,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 				drm_bridge_connector_scrambler_disable;
 		}
 
+		if (bridge_connector->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_VTEM_EMP)
+			bridge_connector->hdmi_funcs.vtem =
+				drm_bridge_connector_hdmi_vtem_emp;
+
 		ret = drmm_connector_hdmi_init(drm, connector,
 					       &drm_bridge_connector_funcs,
 					       &bridge_connector->hdmi_funcs,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a700d..6913662023ca 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -684,6 +684,29 @@ struct drm_bridge_funcs {
 	int (*hdmi_write_spd_infoframe)(struct drm_bridge *bridge,
 					const u8 *buffer, size_t len);
 
+	/**
+	 * @hdmi_clear_vtem_emp:
+	 *
+	 * This callback clears the emp in the hardware during commit.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the DRM_BRIDGE_OP_HDMI_VTEM_EMP flag in their
+	 * &drm_bridge->ops.
+	 */
+	int (*hdmi_clear_vtem_emp)(struct drm_bridge *bridge);
+
+	/**
+	 * @hdmi_write_spd_infoframe:
+	 *
+	 * Program the emp into the hardware.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the DRM_BRIDGE_OP_HDMI_VTEM_EMP flag in their
+	 * &drm_bridge->ops.
+	 */
+	int (*hdmi_write_vtem_emp)(struct drm_bridge *bridge,
+				   const u8 *buffer, size_t len);
+
 	/**
 	 * @hdmi_clear_audio_infoframe:
 	 *
@@ -1021,6 +1044,12 @@ enum drm_bridge_ops {
 	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
 	 */
 	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
+	/**
+	 * @DRM_BRIDGE_OP_HDMI_VTEM_EMP: The bridge supports
+	 * &drm_bridge_funcs->hdmi_write_vtem_emp and
+	 * &drm_bridge_funcs->hdmi_clear_vtem_emp callbacks.
+	 */
+	DRM_BRIDGE_OP_HDMI_VTEM_EMP = BIT(11),
 };
 
 /**
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 8699f35cafcb..184b10c89508 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1645,6 +1645,14 @@ struct drm_connector_hdmi_funcs {
 	 * optional.
 	 */
 	struct drm_connector_infoframe_funcs spd;
+
+	/**
+	 * @vtem:
+	 *
+	 * Set of callbacks for handling the VTEM EMP. These callbacks are
+	 * optional.
+	 */
+	struct drm_connector_infoframe_funcs vtem;
 };
 
 /**

-- 
2.56.0

