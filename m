Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222344CA795;
	Mon, 21 Sep 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006078; cv=pass; b=agPQaZAaDZ6ZJy436fbZvjUn8ong/NpARoAMMdfSh0rX1T/NNw3k435ly9Kn1xvcnk3ayyKyiTcFZQK3TQw734psWvlsxvyYpzxSpTNbVs5+R7rcm6+5ekacZ5gNtQ1U3FYIQs9XjeRLvCwUTeyGJAP01X9egU2igygTcp5+UZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006078; c=relaxed/simple;
	bh=QNY6uZrjC8F03odc5ARblg1qa0EwLcfSwYBjObj/uGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PdpfKrlihK0E6JwrrNVgZAB3dk9GixnWQZJ4+pSfhwpTrfRyIr/W+s0Tl8hF9/I2PziYOWvO5TvH+x3AZhKrSHzPy4yA9LA+UlXTu6FJlJ8IhLm5gxKJ06GV2eZ2iFf1soTZ1yYjKb4+w3z/gPoCsXpONYxZLNs5DPxUCPvqNyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=ko/84+RV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="ko/84+RV"
ARC-Seal: i=1; a=rsa-sha256; t=1790006035; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qm70zm2P7Z3dLQEsA8wBm3JW+mpnGUIIXH2wYf8nn1LCGxEKVpcSav39j6zsVLlpiLYNDK+bTANoGSAOuZOvePK4LrQ+v5rDEZOQO2FxHnSmaa5plus13wmzwYsXtxdLUs9WUGwom2eVGSma1EfbqC5tvsM5J46L6C8WpPYO+j0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790006035; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=I5L+bsoWmPLekEYM66FjXrtQ+U3z611xrc5MNXFSuEI=; 
	b=lOP9Cj+YJLxWf1N5VgiRomX/lqnO7uNB+42y+RG1F4Qt/A4czPYGAI2qjys4z2/Hr1Kz82zrjihmw0Y2fYToeSZ0E10ebYaQ1+KcEkI7/lUv8Wsu0gt83Ago97pkJc3meG+cvbTsWM274fyPyUavP+ZgGGWwG89EygSkAwI5NTA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006035;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=I5L+bsoWmPLekEYM66FjXrtQ+U3z611xrc5MNXFSuEI=;
	b=ko/84+RVAHXZLFMZhNu3TYTpih0LU9lzYu2K3dwFnPB4HL+Ii6QQI364DC0w3kaY
	NValglXTbMlKMbtRRk3hka1UNayLjTXrmobdhsIw8kroXnQ6Pb+c7hEAWAD/xME4dTH
	uQkeVtPXduSDJPpW6jeinF6lTdCAVNC24RnNsBOI=
Received: by smtp.zohomail.com with SMTPS id 1790006033715880.1589251682541;
	Mon, 21 Sep 2026 08:53:53 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:46 +0200
Subject: [PATCH RFC 20/25] drm/connector: hdmi: Add QMS state validation
 and computation
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-20-2fcd7d011646@collabora.com>
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

Add the necessary code to the HDMI state helpers' hdmi_validate_vrr
function in order to check and derive the state necessary for HDMI Quick
Media Switching (QMS) support.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 103 +++++++++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 7237070fc9ee..d392ae2908f9 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -2,6 +2,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/export.h>
+#include <linux/gcd.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_connector.h>
@@ -950,6 +951,26 @@ hdmi_generate_infoframes(const struct drm_connector *connector,
 	return 0;
 }
 
+static const struct {
+	u8 tfr_byte;
+	u32 rate_n;
+	u32 rate_d;
+} hdmi_qms_tfrs[] = {
+	{ 1, 24000, 1001 },
+	{ 2, 24, 1 },
+	{ 3, 25, 1 },
+	{ 4, 30000, 1001 },
+	{ 5, 30, 1 },
+	{ 6, 48000, 1001 },
+	{ 7, 48, 1 },
+	{ 8, 50, 1 },
+	{ 9, 60000, 1001 },
+	{ 10, 60, 1 },
+	{ 11, 100, 1 },
+	{ 12, 120000, 1001 },
+	{ 13, 120, 1 },
+};
+
 /**
  * cmp_fraction - compares two fractional numbers
  * @a: numerator of the first fraction
@@ -988,6 +1009,69 @@ static int cmp_fraction(u32 a, u32 b, u32 c, u32 d)
 	return 0;
 }
 
+/**
+ * hdmi_validate_qms - Validate HDMI QMS state
+ * @crtc_state: pointer to a &struct drm_crtc_state to run validation on
+ * @info: pointer to a &struct drm_display_info of the accompanying connector
+ *
+ * Validate that the drm_crtc_vrr_state.vrr_min_numerator and
+ * drm_crtc_vrr_state.vrr_min_denominator are acceptable for HDMI QMS, and check
+ * that the display is HDMI QMS capable.
+ *
+ * Returns:
+ *  - Negative errno on failure
+ *  - the corresponding QMS signaling byte for the target frame rate otherwise
+ */
+static int hdmi_validate_qms(struct drm_crtc_state *crtc_state,
+			     struct drm_connector_state *conn_state,
+			     const struct drm_display_info *info)
+{
+	u32 rate_n = crtc_state->vrr_state.vrr_min_n;
+	u32 rate_d = crtc_state->vrr_state.vrr_min_d;
+	u32 min_rate_n, max_rate;
+	u32 g, i;
+
+	if (!conn_state->hdmi.qms_enabled)
+		return 0;
+
+	if (!info->hdmi.qms_capable)
+		return -EOPNOTSUPP;
+
+	if (!drm_crtc_helper_vrr_is_fixed_rate(&crtc_state->vrr_state))
+		return -EINVAL;
+
+	if (info->hdmi.qms_tfr_min)
+		min_rate_n = 24000;
+	else
+		min_rate_n = info->monitor_range.min_vfreq * 1000;
+
+	if (info->hdmi.qms_tfr_max)
+		max_rate = info->monitor_range.max_vfreq;
+	else
+		max_rate = 60;
+
+	g = gcd(rate_n, rate_d);
+	if (g != 1) {
+		rate_n /= g;
+		rate_d /= g;
+	}
+
+	if (!rate_d)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(hdmi_qms_tfrs); i++) {
+		if (cmp_fraction(min_rate_n, 1001, hdmi_qms_tfrs[i].rate_n,
+				 hdmi_qms_tfrs[i].rate_d) > 0)
+			continue;
+		if (rate_n == hdmi_qms_tfrs[i].rate_n &&
+		    rate_d == hdmi_qms_tfrs[i].rate_d &&
+		    cmp_fraction(rate_n, rate_d, max_rate, 1) <= 0)
+			return hdmi_qms_tfrs[i].tfr_byte;
+	}
+
+	return -EINVAL;
+}
+
 static int hdmi_calculate_vtotal(const struct drm_display_mode *mode,
 				 u32 rate_n, u32 rate_d, u16 *out_vtotal,
 				 u32 *out_denom, u32 *out_frame_err)
@@ -1093,6 +1177,8 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
 {
 	struct drm_connector_state *new_conn_state =
 		drm_atomic_get_new_connector_state(state, connector);
+	struct drm_connector_state *old_conn_state =
+		drm_atomic_get_old_connector_state(state, connector);
 	struct drm_crtc_state *new_crtc_state =
 		drm_atomic_get_new_crtc_state(state, new_conn_state->crtc);
 	struct drm_crtc_state *old_crtc_state =
@@ -1113,6 +1199,7 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
 
 	/* Save on the expensive vic lookup, if nothing else. */
 	if (!new_crtc_state->mode_changed &&
+	    !new_crtc_state->connectors_changed &&
 	    old_crtc_state->vrr_enabled &&
 	    old_vrr_state->vrr_min_n == vrr_state->vrr_min_n &&
 	    old_vrr_state->vrr_min_d == vrr_state->vrr_min_d &&
@@ -1143,7 +1230,9 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
 		max_vfreq_n = mode_refresh;
 
 	is_fixed = drm_crtc_helper_vrr_is_fixed_rate(vrr_state);
-	if (is_fixed && info->hdmi.cinema_vrr)
+	if (is_fixed && (info->hdmi.cinema_vrr || (info->hdmi.qms_tfr_min &&
+						   new_conn_state->hdmi.qms_enabled &&
+						   info->hdmi.qms_capable)))
 		min_vfreq_n = 24;
 
 	if (!min_vfreq_n) {
@@ -1165,6 +1254,18 @@ static int hdmi_validate_vrr(struct drm_connector *connector,
 		return ret;
 	}
 
+	ret = hdmi_validate_qms(new_crtc_state, new_conn_state, info);
+	if (ret < 0) {
+		drm_dbg_kms(dev, "Invalid QMS rate: %pe\n", ERR_PTR(ret));
+		return ret;
+	}
+
+	new_conn_state->hdmi.qms_tfr_byte = ret;
+	if (new_conn_state->hdmi.qms_tfr_byte != old_conn_state->hdmi.qms_tfr_byte)
+		vrr_state->dynamic = true;
+	else
+		vrr_state->dynamic = false;
+
 	if (!is_fixed) {
 		vrr_state->dynamic = true;
 

-- 
2.55.0

