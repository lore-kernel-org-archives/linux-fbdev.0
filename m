Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894095;
	b=a+dSA3lBx3+KJsvQ9AWPR+U6aZ1Ik7j5ONRv4BsCW9XJQoC5HLROQw3eB792v0moml3q
	 I6KdWT5miybpay+XlUG3y7IOKKQ4x+ovtUcemHKTMa/dYdmlGNJkv1VQxyqNQ9UeKka6f
	 C28QxuFjqeV33jpbpHXhIpO56RvBmzJeZ0A28wB0+hyKvTqxlhxNSa49VlzQm4of9flwp
	 R/mjlMxwRrVo5cSc3uxi7mxz3L1o30RirYcMGXogroX0wpDMKel7Rd/fCQ5RZF7g1ARSO
	 lwgJmD9lCyI0IVzn3QLemKsWg+ry8xEzNTYduVMMDHINgjEHkEG6eHmNATp2FCF/6EQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894095;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=V8t12PM41qE6N0UG7txMe0AIGzNF1VgRYdq6fo7sYxE=;
	b=UTOwIL6aeaMJoSkfqJQiBmR/pXlB6gd95GUKgcjOcA64D05vv7rxP8StVgzw12+BZGDi
	 uyghs6juk3oLlmvtv1CYWLLWQNFhaO04EJIB1qi3YRG54ahApHsht2Sfgce3jU5y1VNaM
	 1O5YjX7xHjYExODlhONt0ptN2oj8rzEL5J1duYdxNzu9Zleikxc3oeqFGEZkQqTUYqceA
	 dkduRGWTnB57HTAYRLCANDZGc/WPN6jRgMjpkmLgcgJJPDWpAj51Q0qnvhwEwadSQvQFm
	 p6AIQ2wNLdw1+6PjtZHYlAIRKbyKH4ZyRDPsNnW3icRl+IpFv16SF1dKM/o5pDHGlPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=LQsqjdLL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F20606BEA1;
	Thu,  5 Nov 2026 15:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F20606BEA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=LQsqjdLL
ARC-Seal: i=1; a=rsa-sha256; t=1793893997; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XJieeeqpjbwGPg/ZncAQlSiJa5BakgVBSVtN48HC+RXXEhj/lrMV7tkoAjjTPpZ3nR4cv6JbOBCQybj3EYiACalGlpmG0j+bMSwOIkRUW1aEV9jqyCJC216YLppD9FfZZiQF26Bb6m8YQFy5JVvJYSb0+DG26uJQ8HB01heZuK4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793893997; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=V8t12PM41qE6N0UG7txMe0AIGzNF1VgRYdq6fo7sYxE=; 
	b=Jb6ao9UffGRio5LbBN5zSFpaqkO/JBpUn6c5VhsZ++0Wcsu/6lKmqrT0zE/8C0vZ4k2jrW9HeNBnCRqPl0jP7Q2MDfqbOnQ4qiUvqUv64EFtEeQGBfXK/xLxc6+/uj8EDVNU1TPJdsvd1mNw7/SJ81YsTP6EmMq+102xZ/38fr0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=LQsqjdLLLAYaTVElvIHyk6zk3CZoSN935Zwc//GRVsRjwWpwY6MoPe7GlKw11qQaSktgexFqMnIAoF5DyTI31O6du3gQ59ueMD4uVQ5WtmgYOjbDP52/CtvaCAz9B6Z7w+hAzv9oCzCfJPmPzsk+7GNW2LdtyAnh8THj7yj6F+0=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=V8t12PM41qE6N0UG7txMe0AIGzNF1VgRYdq6fo7sYxE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793893996571563.8882394295355;
	Thu, 5 Nov 2026 07:53:16 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:51:58 +0100
Subject: [PATCH v2 07/27] drm/bridge: synopsys: Add VTEM EMP support
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
Message-Id: <20261105-vrr-limiter-uapi-v2-7-55f4215be2c2@collabora.com>
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

Add code to pack and schedule VTEM EMPs.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 50 +++++++++++++++++++++++++++-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h |  1 +
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index b268c9376087..8b3f586dc177 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -689,6 +689,15 @@ static int dw_hdmi_qp_bridge_clear_spd_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
+static int dw_hdmi_qp_bridge_clear_vtem_emp(struct drm_bridge *bridge)
+{
+	struct dw_hdmi_qp *hdmi = bridge->driver_private;
+
+	dw_hdmi_qp_mod(hdmi, 0, PKTSCHED_EMP_VTEM_TX_EN, PKTSCHED_PKT_EN);
+
+	return 0;
+}
+
 static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
@@ -791,6 +800,42 @@ static int dw_hdmi_qp_bridge_write_spd_infoframe(struct drm_bridge *bridge,
 	return 0;
 }
 
+static int dw_hdmi_qp_bridge_write_vtem_emp(struct drm_bridge *bridge,
+					    const u8 *buffer, size_t len)
+{
+	struct dw_hdmi_qp *hdmi = bridge->driver_private;
+	u32 val, i;
+
+	if (len != HDMI_INFOFRAME_SIZE(VTEM)) {
+		dev_err(hdmi->dev, "unsupported vtem emp packet size of %zu\n", len);
+		return -EINVAL;
+	}
+
+	val = buffer[1] << 8 | buffer[2] << 16;
+	dw_hdmi_qp_write(hdmi, val, PKT_EMP_VTEM_CONTENTS0);
+
+	val = buffer[3] | buffer[4] << 8;
+	dw_hdmi_qp_write(hdmi, val, PKT_EMP_VTEM_CONTENTS1);
+
+	val = buffer[8] << 8 | buffer[9] << 16 | buffer[10] << 24;
+	dw_hdmi_qp_write(hdmi, val, PKT_EMP_VTEM_CONTENTS2);
+
+	val = buffer[11] | buffer[12] << 8 | buffer[13] << 16;
+	dw_hdmi_qp_write(hdmi, val, PKT_EMP_VTEM_CONTENTS3);
+
+	/*
+	 * The remaining registers need to explicitly be rewritten even if they
+	 * stay at 0, as per the hardware documentation.
+	 */
+	for (i = PKT_EMP_VTEM_CONTENTS4; i <= PKT_EMP_VTEM_CONTENTS7; i += 4)
+		dw_hdmi_qp_write(hdmi, 0, i);
+
+	dw_hdmi_qp_mod(hdmi, PKTSCHED_EMP_VTEM_TX_EN, PKTSCHED_EMP_VTEM_TX_EN,
+			PKTSCHED_PKT_EN);
+
+	return 0;
+}
+
 static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 						   const u8 *buffer, size_t len)
 {
@@ -1035,6 +1080,8 @@ static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.hdmi_write_hdr_drm_infoframe = dw_hdmi_qp_bridge_write_hdr_drm_infoframe,
 	.hdmi_clear_spd_infoframe = dw_hdmi_qp_bridge_clear_spd_infoframe,
 	.hdmi_write_spd_infoframe = dw_hdmi_qp_bridge_write_spd_infoframe,
+	.hdmi_clear_vtem_emp = dw_hdmi_qp_bridge_clear_vtem_emp,
+	.hdmi_write_vtem_emp = dw_hdmi_qp_bridge_write_vtem_emp,
 	.hdmi_clear_audio_infoframe = dw_hdmi_qp_bridge_clear_audio_infoframe,
 	.hdmi_write_audio_infoframe = dw_hdmi_qp_bridge_write_audio_infoframe,
 	.hdmi_audio_startup = dw_hdmi_qp_audio_enable,
@@ -1154,7 +1201,8 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
 			   DRM_BRIDGE_OP_HDMI |
 			   DRM_BRIDGE_OP_HDMI_AUDIO |
 			   DRM_BRIDGE_OP_HDMI_HDR_DRM_INFOFRAME |
-			   DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME;
+			   DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME |
+			   DRM_BRIDGE_OP_HDMI_VTEM_EMP;
 	hdmi->bridge.of_node = pdev->dev.of_node;
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.vendor = "Synopsys";
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
index c07847e8d7dd..6ce87064a267 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.h
@@ -210,6 +210,7 @@
 #define PKTSCHED_AVI_TX_EN				BIT(13)
 #define PKTSCHED_VSI_TX_EN				BIT(12)
 #define PKTSCHED_EMP_CVTEM_TX_EN			BIT(10)
+#define PKTSCHED_EMP_VTEM_TX_EN				BIT(9)
 #define PKTSCHED_AMD_TX_EN				BIT(8)
 #define PKTSCHED_GCP_TX_EN				BIT(3)
 #define PKTSCHED_AUDS_TX_EN				BIT(2)

-- 
2.56.0

