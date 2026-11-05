Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894150;
	b=n5cZsfjjBOGniFhxxt3HvC/5tP+nbqIvU3FZELxmdynQVwNPBoi/Nb5rF6Pmf5eKKMah
	 EeW4W/2kJWs+t5JMXdkQxZmE77B5zTBSDW8qB2AJe3AfpuseUR15Tbwy+T9t4df7oMxOf
	 XuBqd4Zhkpg97QagSKs+oA/rvDxuEZYUft9d06vTY095j58o45aGGts6RKy25NxE3yEvY
	 WcH1UBKzO8aCegmjfzgKrY2CpXSKfMnwpGOTNVqdczGJ9EYYY9YdOG2zkac3p8YEur0xr
	 ZCHo0HwowqPNOQWtPN1S1AUZbc8GmtiNEx8AK4D7ZP4FlqJQm+a8CWdvLob0M3qL/Xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894150;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=D9Q6ltPzRDAGZTP9KvplqGWiiX1MNDXa/TA4BfosyDU=;
	b=uOcJsmSEa2bjGNA+WVHh5NtqbWTPKZ10vowVbVBmGT9pbapnkmaO31H64tn/X6+Zw398
	 0txBe1zXVr85HdSKu3gPi2oJt26u4yZ7uPRRPevyaFm2t4yeyR4ihvjsmVNg72skMWfMC
	 0fMtKQdDFoHU00C/C12n2sRnnLQvaqIuo10HoMVsY1d9V5H7jhsPZqE4I1YUm+CSTjVhX
	 uOzWGd0gpUy8IUmXmeiyx6WNumlt+OtTUkj8vJrfP5aY8I4C1HFgFSosI8nmCIuVLAxo5
	 5HOr0bUgm3v3CRkVyBbQzDkd486OiMsgfTwU50ggnXC6z5mjFcUBedog25V13bl0tAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IHa4UePH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344B606F953;
	Thu,  5 Nov 2026 15:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9344B606F953
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=IHa4UePH
ARC-Seal: i=1; a=rsa-sha256; t=1793894055; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NFUXusQC27zP569hLgP0cdoh9f+qrlEtWyONZqM4Gw6pGB2LD5mkHdgot0OmJbrL+w2tTGQmmh1+HkJPNQ2Ox0Gr1FsZheEyCc3U17IQVtBcpExHmfrKBe/67O+gd5GWvo8Hnf+TCLNKug3e3F1+dqyev/OSd/b8ky5Bl+eYNqg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894055; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D9Q6ltPzRDAGZTP9KvplqGWiiX1MNDXa/TA4BfosyDU=; 
	b=bm4Ag9jHrBUOrFKjsWWXC+qMjQEmLLKcEm5olUwa8UmIh5L603ZcF4ZKqwgkcJTvkf2nESJcpj41tMrYSPymeQCxRK2Y0/gmL6CS1MosIml8US/6wJTqlfnXht+arSD3GePC0kpgeRX6Wl9kxFEndFjwjLTN0Jq1GQ3oTuSPWM0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=IHa4UePH77lklrOObaKvOF/sEC5UoyvMJ+KdEaVG6EZ2Jq2tUgtQxXm6vA53+czMBs6hGIWcrqg4x5jsV7SEUDbqFiWwD6NR82OoyraR2lAIlkE6KMjO8MWCI+OPMXlZYloeFd594NtVqKltqzpB7rmxxfhLAn5C824Xc3xdhGo=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=D9Q6ltPzRDAGZTP9KvplqGWiiX1MNDXa/TA4BfosyDU=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894054250895.1994089470402;
	Thu, 5 Nov 2026 07:54:14 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:07 +0100
Subject: [PATCH v2 16/27] drm/edid: Parse QMS TFR min/max flags from HDMI
 SCDS
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
Message-Id: <20261105-vrr-limiter-uapi-v2-16-55f4215be2c2@collabora.com>
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

HDMI has two flags in the SCDS EDID extension that signal which minimum
and maximum refresh rate the sink wishes to use when doing QMS ("Quick
Media Switching").

How to parse these flags, and what they do, has been learned from the
publicly available libdisplay-info source code.

Add the definitions of where in the byte they are, the code for checking
for them, as well as two new booleans in drm_hdmi_vrr_cap to store the
result.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_edid.c  |  6 ++++++
 include/drm/drm_connector.h | 12 ++++++++++++
 include/drm/drm_edid.h      |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index d439928caacc..39b5c01309e2 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6237,6 +6237,12 @@ static void drm_parse_hdmi_gaming_info(struct drm_hdmi_info *hdmi, const u8 *db)
 
 	vrr->vrr_max = (db[9] & DRM_EDID_VRR_MAX_UPPER_MASK) << 2 | db[10];
 	vrr->supported &= (vrr->vrr_max == 0 || vrr->vrr_max >= 100);
+
+	if (cea_db_payload_len(db) < 11)
+		return;
+
+	vrr->qms_tfr_min = db[11] & DRM_EDID_QMS_TFR_MIN;
+	vrr->qms_tfr_max = db[11] & DRM_EDID_QMS_TFR_MAX;
 }
 
 static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 830a33fb5301..4801bb2769e1 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -294,6 +294,18 @@ struct drm_hdmi_vrr_cap {
 
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
2.56.0

