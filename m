Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894132;
	b=5Avq8SLYQQk+uioShfXQs9P5m5MX1yU9a5SSP/hm+VjSq7dutouXv9TUM8PhA/EWDz5a
	 eH4F4t2vDQXcTfZwV3ysYcfy3KFX4WkzM79j2ATMTsq/8DEz0HNvqsDFOCwvQgokeKtM/
	 QSy+xX/pR9GvEOLWfLRFO11bVItRHOeV8Gd+FKh+jAsf3N7f3qWRfv8NfmQQNJfBjwMBj
	 OMBAw3uVrn2xODncFWuLJsS2EU7VyA+wmgzOgeAhVXD1jDCVuMdNy/8U1qpVXdXA/iauc
	 A/awpml4TCqoQ5igB5AznrTmW3mxAj4vmytadZ81UvDZB1bvU2qno+D6FRYYXYKp51g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894132;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=sXVdw7vU5ofz/MC7RbWYsGV4+QyERagQ3Me77tggaqA=;
	b=TSq+8q5197C2kZBvxwUNuUPO8RP4EkBjifMITNtElpLBvV5nS76Os5MxiAYvqFsCSdLP
	 wHuxYQX9WnrKc9auzxJOsXFKnPQGDQSKSV7vZCMjFaIJpomcekdRYOBjWPrwy9gFX1aeS
	 m7sDZgcwU6PDT9aCpxX3GsdpP214CBTTV4hfItYzWxzkSK5p0bdjUUJYq4u165fw2fivJ
	 NuFG7A7uUDMmTvzlQXdxO7RcT14u/zW3wX6VUHivUmOYk23q9jSDtlU+M4MZLL+eaKzw1
	 HH9JNgknbxzKhg70Az2jap+LgysIwwAWwkaIS/ajKfajEYdBPP4wyxOKWW6epw/KrxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b="Da0wH/cG";
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E116070782;
	Thu,  5 Nov 2026 15:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E116070782
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Da0wH/cG
ARC-Seal: i=1; a=rsa-sha256; t=1793894005; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R7uf2llnfIu0oqpbnc9sVETu5emQPBr69ahcUBhDgAgKf7TgqdbSkw+oYDyF4JOdNOKwBuwVfsZI/d9c/nE1eLBKB/NlVeC0O1QiIL+b6MtkQHBqEDg2M6TlFyJUF6jont21YyNmG66ZBR/zOaqPDIamx321zrfI5keTmIM2qcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894005; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sXVdw7vU5ofz/MC7RbWYsGV4+QyERagQ3Me77tggaqA=; 
	b=DsNrNti6LrJiJzr7cUcac6V2ny95DWA5mJfQ8d5ezJgpFH7oRH80dMv+w3fB5M7XGgUWvGvQ0RHH2Vk8deSwxwJe94UsoQXQUgx+wHJ99iCXsL1e+xAaOwbOhabVhk2IiUNM8zkOyD4P6NIqaEOxCf6MHpnj1gGdro+XUuK4y3M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=Da0wH/cGyb1nyuZoG2Y+e2i436r0rCOAR3nUQui+vXs3iDVpWmjqAxKTNDi/II5cva0TJDNNg3LnWDDADgT9cTrh3Zon0XUYukoaE6OSqBkPWArm4iJ26EJ69jV0vU9Az86uzcr2gHr3f+eXo4vhmRtcXl2EhnNg8cBEezQmHbo=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=sXVdw7vU5ofz/MC7RbWYsGV4+QyERagQ3Me77tggaqA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179389400272574.3566153246461;
	Thu, 5 Nov 2026 07:53:22 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:51:59 +0100
Subject: [PATCH v2 08/27] drm/connector: Add
 drm_display_info_is_vrr_capable
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
Message-Id: <20261105-vrr-limiter-uapi-v2-8-55f4215be2c2@collabora.com>
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

Add a function to return whether a sink, as described by a
drm_display_info struct, is capable of receiving VRR signals.

For HDMI sinks, this can just check the HDMI specific vrr_cap.supported
field, which is set by the EDID parsing code. For other types of
displays, the generally agreed-upon method appears to be to check
whether the monitor range's minimum frequency is above 0.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_connector.c | 19 +++++++++++++++++++
 include/drm/drm_connector.h     |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 65c14b6e47a6..a44afba8c5ff 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -1378,6 +1378,25 @@ int drm_display_info_set_bus_formats(struct drm_display_info *info,
 }
 EXPORT_SYMBOL(drm_display_info_set_bus_formats);
 
+/**
+ * drm_display_info_is_vrr_capable - Check whether sink is VRR capable
+ * @info: pointer to a &struct drm_display_info representing the sink
+ *
+ * Check whether the sink supports variable refresh rate signals.
+ *
+ * Returns:
+ * - true if variable refresh rate is supported by the sink
+ * - false otherwise
+ */
+bool drm_display_info_is_vrr_capable(const struct drm_display_info *info)
+{
+	if (info->is_hdmi)
+		return info->hdmi.vrr_cap.supported;
+
+	return info->monitor_range.min_vfreq > 0;
+}
+EXPORT_SYMBOL(drm_display_info_is_vrr_capable);
+
 /* Optional connector properties. */
 static const struct drm_prop_enum_list drm_scaling_mode_enum_list[] = {
 	{ DRM_MODE_SCALE_NONE, "None" },
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 9df745ecff92..5b6920c1a996 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1078,6 +1078,8 @@ int drm_display_info_set_bus_formats(struct drm_display_info *info,
 				     const u32 *formats,
 				     unsigned int num_formats);
 
+bool drm_display_info_is_vrr_capable(const struct drm_display_info *info);
+
 /**
  * struct drm_connector_tv_margins - TV connector related margins
  *

-- 
2.56.0

