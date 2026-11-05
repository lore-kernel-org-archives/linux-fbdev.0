Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894132;
	b=dH/yAewzZr+cClQMhCRrVa41AZSGSo4M6Io1eaGL1FuaujQDszENJ4RjtLuo/2d/zB99
	 CAmejhLoDMoldjSHmVplYwLBgYcBO2GUOsG8RkfwBWhqUhRzs4kR+84EryzSuM7+4TmtE
	 3woQ/C+sxXF56huecxwyBO5OUW36Qwk9vBtJ9WLEUolN8///ekZ8Fx/TVnw7yP55jjZpU
	 BX2YWsWc/fM+igs5hmlu0J5VhNdRBTTNzlzAmCK6V5jFIqyjzpEJu2dOmwxuqDQ3tRhF5
	 qfdEBliCRDWu0sZ2rcNk9Ver8LK8gKntHd7fWNxEBwmIwBnKhhafL3ok7MSX7FO5flg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894132;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=ZsJGxCYDJBtgZ7PbKgRI/o6Iaz0hRbnKlktFoA+H35M=;
	b=l4CPkQF6Empp/8A95nUflpHIsyMZVfr9Kq+uWWOlwJ65u+OpD3sJHQZLPkapJZ6KCaTb
	 flDzr+bD4ewcYP/dgOo9IEuTHBjAw+zoJWoCf6t29y42GfQYF05bsh7HaPWN3N4t9qfEK
	 1woR+VyxRCJ1t5N8tg913j7FHLd5JgEkWB0GBtrvlk2v2YRC2vNwLk1FcSIEa5iVYd9ms
	 2uNG0op16FzJVrDysYQ7WPg5G3XCBMdhtVvUO/Mc139BcPmb0p2WfuziMRoHX9gE4NLGa
	 XYW11MrVe6enGj20LIdiLfKlgemBHS5Jz0X8PhIKUvxGOf3BZyD/wIzAtaAgPjqxi9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QGh8+D0s;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFF606D82C;
	Thu,  5 Nov 2026 15:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9DFF606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=QGh8+D0s
ARC-Seal: i=1; a=rsa-sha256; t=1793894049; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=igjwL76ycM1L/XPcKwK03cwIOheRnkepJ5YN3E4hC+0CbQFVDDgRlnuVtQukFdWyCN2KxuDSlRBQSNVEH5iApDDRz8jTrXX1e7M7pzpx9ELOP6AH6g8V0v7jKwV0D+DXnNmawTAmG+nbinOTcgwQbePOfmR7rSyLXbr8+QQWq9Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894049; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZsJGxCYDJBtgZ7PbKgRI/o6Iaz0hRbnKlktFoA+H35M=; 
	b=OKvKHyQ8LpQyWO+0F3ZQFjiq1QDch598myawKpHryQeOi98S0nKAVPVyKGcolNcQg0iodwCyMcTkTNLqQUrfgUeLH2h2ERlycFfL0HKe92H79p5hoG41/3veNxoEv6ryjG9f5y4ZDMdYSCZ2vq1SktKKUjggNlYIvmGe8dWQTKI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=QGh8+D0stNKdIwJFTAYChBePG0mT95bYJ//TTLFpnzP69Mr/EL6tLE9D+YlAyVbJcIIJbOJuWcyUZCGNhSp7/x/1Rmh92oj7wTOnlW5tzLLbzuAZtI67rNlw3gmoUs2fMN+3GkAJxo63Rw82fmGpJNnPJDrzYXvyjyQKPVxmHZk=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=ZsJGxCYDJBtgZ7PbKgRI/o6Iaz0hRbnKlktFoA+H35M=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894048143143.84427994378188;
	Thu, 5 Nov 2026 07:54:08 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:06 +0100
Subject: [PATCH v2 15/27] drm/edid: Parse QMS flag from HDMI SCDS
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
Message-Id: <20261105-vrr-limiter-uapi-v2-15-55f4215be2c2@collabora.com>
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

Thanks to a GPL'd source code release from a hardware vendor that shall
not be named, which has since been scrubbed off GitHub, it's now public
knowledge how the HDMI Forum EDID extension communicates support for QMS
("Quick Media Switching") on a sink. Bit number 6 indicates support for
QMS in the same byte that also contains the CinemaVRR flag.

Add this definition to the EDID header file, and parse it to a member of
drm_hdmi_vrr_cap.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_edid.c  | 1 +
 include/drm/drm_connector.h | 3 +++
 include/drm/drm_edid.h      | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 3148038747b6..d439928caacc 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6224,6 +6224,7 @@ static void drm_parse_hdmi_gaming_info(struct drm_hdmi_info *hdmi, const u8 *db)
 	vrr->cnmvrr = db[8] & DRM_EDID_CNMVRR;
 	vrr->cinema_vrr = db[8] & DRM_EDID_CINEMA_VRR;
 	vrr->mdelta = db[8] & DRM_EDID_MDELTA;
+	vrr->qms_capable = db[8] & DRM_EDID_QMS;
 
 	if (cea_db_payload_len(db) < 9)
 		return;
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c0865a2547fd..830a33fb5301 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -291,6 +291,9 @@ struct drm_hdmi_vrr_cap {
 	 * VRRmax values having correct values.
 	 */
 	bool supported;
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
2.56.0

