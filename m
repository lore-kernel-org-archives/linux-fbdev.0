Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2934BB282;
	Mon, 21 Sep 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006062; cv=pass; b=sP3GIwejOSAsuYysgdyAh/kNyDqrHxW9x0I1BGHBTbnmHfLpqCjJHTz4gJBLUDvBMQzrC491191aCUD41+5yHlDDmeCnnbBZ1b2va8RKpvnOKflELuH2Rhx0tiaJJw/Iqvwwr5f2237GDxk38REjnLNm/q676OWtWszTaw+aY7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006062; c=relaxed/simple;
	bh=9cFQpY0yIO87qIUyReDYrG9xxNE4tGwYPF9f+CuztTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3z4GdHcDozmM+KiO6B3emwjyJu5gJr8aRgGtYyiT4/VN75njGLM/r+ctxhDq5hELLQvjF20Ah/GC6BF5vAkv+FYvlFGjxA/QPztbEFvL2TTo4Ozly2HfU1iIi+57ezZUp3fRvBmvQW76es6RIsE84eRQiU4L2jOsyKQh13xTLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=asM16uei; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="asM16uei"
ARC-Seal: i=1; a=rsa-sha256; t=1790006013; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mhxCIXPZ/+yEWUs1KgkZV/vPnjfe7MnmXqHd3FK9x+cOipio3AmrlBcvB623LhMN5Ee+IioCcYq+8mOPzQ9uJrJxg24Yv/otVDnPAZ4SIr6IRAtzue/HL4ZEjq4+xSylwUzGnCHVDuF2IXXtC/jqcye6GYmFbW0pacWgmjHQIzg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790006013; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7klLKTxAqVvbufalhg35HG2HNYZ1gcqMNTnMqVx0mHY=; 
	b=NW3OjKIFNJPYSqRYjjDTpZIeT4IE4hY60OuBMDKc3ZHjU388vwZtknP7N4QwyaAmGYIAnaXxsh/3bXoVMclnGIETLsYEdXNXaAorN229eE+fgiZoxGBvZBJQ06L1Xh5GlY2Ge/E3eAQE6OjjFt0xt4BCunbTbgmWSdLux3Mowsw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006013;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=7klLKTxAqVvbufalhg35HG2HNYZ1gcqMNTnMqVx0mHY=;
	b=asM16ueiap+8yleJX486m23IDB91JBay041dbXpcDeJ/7nc2/i3hj+SS107jzWyW
	keL71rS8GRFqp6ndLhaG4cifBJggDHseN1xiG7ezsg2trvX7WdLrDD7pMBxZPIofX0S
	/9wl8xIW2JWWkEO1cqISCDU+sEzA8hosb7wWDlzw=
Received: by smtp.zohomail.com with SMTPS id 1790006011932527.0501784463283;
	Mon, 21 Sep 2026 08:53:31 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:42 +0200
Subject: [PATCH RFC 16/25] drm/edid: Parse QMS TFR min/max flags from HDMI
 SCDS
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-16-2fcd7d011646@collabora.com>
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

HDMI has two flags in the SCDS EDID extension that signal which minimum
and maximum refresh rate the sink wishes to use when doing QMS ("Quick
Media Switching").

How to parse these flags, and what they do, has been learned from the
publicly available libdisplay-info source code.

Add the definitions of where in the byte they are, the code for checking
for them, as well as two new booleans in drm_hdmi_info to store the
result.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_edid.c  |  6 ++++++
 include/drm/drm_connector.h | 12 ++++++++++++
 include/drm/drm_edid.h      |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 5a7d3b7e65da..4fe754328b1c 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6332,6 +6332,12 @@ static void drm_parse_vrr_info(struct drm_display_info *info, const u8 *hf_scds)
 	if (!range->max_vfreq)
 		range->max_vfreq = (FIELD_GET(DRM_EDID_VRR_MAX_UPPER_MASK, hf_scds[9]) << 8) |
 				    hf_scds[10];
+
+	if (pld_len < 12)
+		return;
+
+	info->hdmi.qms_tfr_min = !!(hf_scds[11] & DRM_EDID_QMS_TFR_MIN);
+	info->hdmi.qms_tfr_max = !!(hf_scds[11] & DRM_EDID_QMS_TFR_MAX);
 }
 
 /* Sink Capability Data Structure */
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c97cf0625fda..8439c82db905 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -389,6 +389,18 @@ struct drm_hdmi_info {
 
 	/** @qms_capable: The sink supports Quick Media Switching */
 	bool qms_capable;
+
+	/**
+	 * @qms_tfr_min: If set, the sink uses 24/1.001Hz as its minimum rate
+	 * for QMS. If unset, @drm_display_info.monitor_range.min_vfreq is used.
+	 */
+	bool qms_tfr_min;
+
+	/**
+	 * @qms_tfr_max: If set, @drm_display_info.monitor_range.max_vfreq is
+	 * used by the sink as its maximum rate for QMS. If unset, 60Hz is used.
+	 */
+	bool qms_tfr_max;
 };
 
 /**
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index f1e2052cb08b..d339acd9ee52 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -269,6 +269,8 @@ struct detailed_timing {
 #define DRM_EDID_VRR_MAX_UPPER_MASK		0xc0
 #define DRM_EDID_VRR_MAX_LOWER_MASK		0xff
 #define DRM_EDID_VRR_MIN_MASK			0x3f
+#define DRM_EDID_QMS_TFR_MIN			(1 << 4)
+#define DRM_EDID_QMS_TFR_MAX			(1 << 5)
 
 /* DSC specific */
 #define DRM_EDID_DSC_10BPC			(1 << 0)

-- 
2.55.0

