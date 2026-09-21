Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938044C651F;
	Mon, 21 Sep 2026 15:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006053; cv=pass; b=lDYuU7sWYPvWO+4sAU/fhy8SyTHA8Fg7tO18qz49KIS4r6qnRkxs6nAXlWPH9nnf/CmdFuF5/ouFtz98NeEc6HRmyI1a2M0sjfkRsyoEv/ENuC+spEMq+2GkZdJb9Hd/mIRzppjE1kD40IcHyZZmZzxsE9DKZuOofQJWsiKsRvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006053; c=relaxed/simple;
	bh=O1W6VsCsNZ1ZwYBnqbivdpIQYLrQb27Ko83kNwPVyWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYTu7WJSprzviQuchkEjLlEhNqu2rrB6pgcoDUyVLR2ef6FVgP5+OvdQt/ECweMwjjZy/TTBXXqTZYMDv1CMcdpM48mGdjS5JsNzRYOs+wu+W6LqBi+CoxdwsTcJM872askxtony2hynNavkgCWZ6tgXYTQjOh5CcAeDLaQwY2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=a3AaHo/U; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="a3AaHo/U"
ARC-Seal: i=1; a=rsa-sha256; t=1790006007; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ngcSx7tEb9T4eSKiUPia8xy5VnT8S4gMkwpOI5+/OKpbDFPTx/YwY5JO5tyldcqZjCXry6MhYEddp6UvxdiDznsK70yz4KmeB6jZMjgP4kKJS6ucjl2mtaFG7+cERrw4DfcGV9I7c2KUixhvLqqISWiuDt1SD+f9TMn4MLXTvlE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790006007; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=53MU4wodU5McFdFA8f4erFf1XjxuC7banbaoGYK3RK8=; 
	b=OhC+ygNeEbKIliqfx1Igb0yeYHO1//55xpLvxp6mJkmDEMBmx5Aa/fNuCxXtkmz+qz5La+TzzoaF1+lodk9bR19T4xBJg6UN1mVmiLhMmgI6sxhbvxCa5n9+AuGrA0Ullr3WMcN8xxYufJJuD7P0qlinz2NV1TXHKJgIJWSfm/4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006007;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=53MU4wodU5McFdFA8f4erFf1XjxuC7banbaoGYK3RK8=;
	b=a3AaHo/UK2z7zkPs7JYtVfyLRknGywm+GDwp4vuHtWfHl2Ilvs9ny5uzGEAlOnCc
	gHTB1XdD2Y9vG7rYo9xkTMg2zIaaOJIP6+eUTtlNM7WSZKQCw1g8QeqQ3GsIITqlqcm
	w+Y6aLF953pelao+OvCTaLu0o5cq23i1+mGcK7xA=
Received: by smtp.zohomail.com with SMTPS id 1790006006273303.45353173764124;
	Mon, 21 Sep 2026 08:53:26 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:41 +0200
Subject: [PATCH RFC 15/25] drm/edid: Parse QMS flag from HDMI SCDS
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-15-2fcd7d011646@collabora.com>
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

Thanks to a GPL'd source code release from a hardware vendor that shall
not be named, which has since been scrubbed off GitHub, it's now public
knowledge how the HDMI Forum EDID extension communicates support for QMS
("Quick Media Switching") on a sink. Bit number 6 indicates support for
QMS in the same byte that also contains the CinemaVRR flag.

Add this definition to the EDID header file, and parse it to a member of
drm_hdmi_info.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_edid.c  | 1 +
 include/drm/drm_connector.h | 3 +++
 include/drm/drm_edid.h      | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index cc6f2ba8c9f4..5a7d3b7e65da 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6318,6 +6318,7 @@ static void drm_parse_vrr_info(struct drm_display_info *info, const u8 *hf_scds)
 		return;
 
 	info->hdmi.cinema_vrr = !!(hf_scds[8] & DRM_EDID_CINEMA_VRR);
+	info->hdmi.qms_capable = !!(hf_scds[8] & DRM_EDID_QMS);
 
 	if (pld_len < 10)
 		return;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index b147b8474f1a..c97cf0625fda 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -386,6 +386,9 @@ struct drm_hdmi_info {
 
 	/** @cinema_vrr: The sink supports "CinemaVRR" */
 	bool cinema_vrr;
+
+	/** @qms_capable: The sink supports Quick Media Switching */
+	bool qms_capable;
 };
 
 /**
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index a2617aa34edf..f1e2052cb08b 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -265,6 +265,7 @@ struct detailed_timing {
 #define DRM_EDID_CNMVRR				(1 << 3)
 #define DRM_EDID_CINEMA_VRR			(1 << 4)
 #define DRM_EDID_MDELTA				(1 << 5)
+#define DRM_EDID_QMS				(1 << 6)
 #define DRM_EDID_VRR_MAX_UPPER_MASK		0xc0
 #define DRM_EDID_VRR_MAX_LOWER_MASK		0xff
 #define DRM_EDID_VRR_MIN_MASK			0x3f

-- 
2.55.0

