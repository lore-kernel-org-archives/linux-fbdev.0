Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894140;
	b=u1+a483UmlnwY6WvmgIEHIRCMV8F4Z6z/T/EnBENFWytpTehpXIs2V8OGb38aM/3ieYv
	 yc6uKACsHUhboA/wGUE0rWbV7weU0/uTeNymt8GI3QPXP4mIw+zoNLaqWHBvFaDO0ta5O
	 Ofwc6Gcy6cW7IseKx9AK9pEc2JNAN0MK0gKBmc/+p/PFpw+SITSfpgX+4qlZZN7lraDNI
	 x5+XRZTGcCdAr41Kr6iruhtQg2DFwZm8nH5vA3MRU+H/RV+yFeHgu6/ZT3dYvu2nNG6Zi
	 6FF47Y44MHbwNZXhxtSeQtWjBeA36/QGbC3Jequq0GBXa0ygZp4B2Yvj2pBMTpR+J8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894140;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=igQATVU1Yc1Mn+dz931w/tbusWSL5LcSoV79LRLrIvI=;
	b=n7yp4Em8bJBTUOPu31TJodEPT+qZJrp1DrucPx877wGZREQeHEa0i0hbN3ivjxu/H4xx
	 O+bY1b8w/qYtmQXMpQCNUGmHgjRf+aOhO7Ia7lX6fd3CZxSH+YMnDyHQi1FSNqXpM2AWo
	 DkB21Ablnl2gyvp90DHqKqc4FaMol2U6iaKcB8tli+lMP79n1sraHHM3SIkmI6jOH8Rmn
	 ivAxPib9/CRkUvuYTyZJ3/Ma1fE3u4U2jaa4J1bZaq2hPVm5kYVK5DwSnr1Gy/lwNPgyI
	 ilDVLI1cjkKef6MTfLDcj1qCPOx5+6S7O5WyGuVrWc+GSB3QpRVWYn0KIkYbjhRVmaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kJ6f17vw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E5B606F97F;
	Thu,  5 Nov 2026 15:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49E5B606F97F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=kJ6f17vw
ARC-Seal: i=1; a=rsa-sha256; t=1793894085; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VhskGWTmhRP+s548VmCcgGW+MDFRplI3W1sF9BzPT0OBohPMTdFqEPjYnvB5TPTv741uWvGnYRMVAJCmU5K+9eYNdCvNSa/j0aahyGMcY7HRGIQBFvLzr9VjC72Febj93pHnBfADk852RstJlv6Y9T+juGJRdhY3wGcYzcJqtFU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894085; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=igQATVU1Yc1Mn+dz931w/tbusWSL5LcSoV79LRLrIvI=; 
	b=NGUgAw30ItGE+Kb7RWCydoVWwEgBxhxjdzLz5TUlW022cNoDK/OBPxKPG8OD+RPm+Eajey62DiR3bCLk/TWDvyShghb5SGKQTyGzEpJpFJ8jcFDwOelvu+aN2sP3/DI/Rj/mf00w3dHy1TRKR1STprfRPE4plrRAqsTIRaLvlsI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=kJ6f17vwJuXHaq/0T1adxJqc2OOuiy9DPWOKBi//vAoyjUQRSrp/wZEOFzoco3zytHJmmr4JMrNt4uRkltIjTzsH13FI6SkX3l3VCfgReumNM96fPFRemug4lGJ8Bw3PCjfayyeccPKwOmj249szHdkf4rmqVYxMUif2MB5RRoQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=igQATVU1Yc1Mn+dz931w/tbusWSL5LcSoV79LRLrIvI=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894084835140.54892489016675;
	Thu, 5 Nov 2026 07:54:44 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:12 +0100
Subject: [PATCH v2 21/27] drm/rockchip: dw_hdmi_qp: Add QMS support
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
Message-Id: <20261105-vrr-limiter-uapi-v2-21-55f4215be2c2@collabora.com>
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

Add the "Media" VRR display mode to the set of VRR display modes being
registered, and set the qms_supported flag in the connector's HDMI
sub-struct. The actual QMS functionality itself is implemented in the
common HDMI state helpers.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index dcde50bca36b..215cf746dc41 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -90,7 +90,8 @@
 #define RK_COLOR_FMT_YUV420		0x3
 
 #define RK_VRR_DISPLAY_MODES		(BIT(VRR_DISPLAY_MODE_GAME) | \
-					 BIT(VRR_DISPLAY_MODE_OFF))
+					 BIT(VRR_DISPLAY_MODE_OFF) | \
+					 BIT(VRR_DISPLAY_MODE_MEDIA))
 
 struct rockchip_hdmi_qp {
 	struct device *dev;
@@ -753,6 +754,8 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 			return dev_err_probe(hdmi->dev, ret,
 					     "Failed to attach 'vrr_display_mode' property\n");
 
+		connector->hdmi.qms_supported = true;
+
 		ret = drm_connector_attach_vrr_display_limits_properties(connector);
 		if (ret)
 			return dev_err_probe(hdmi->dev, ret,

-- 
2.56.0

