Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5A4C9E11;
	Mon, 21 Sep 2026 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006078; cv=pass; b=bMnYk7WIuY3wBTCmWP6aARke/uAQwab4hs2DUzqApK9qbW5LaFNFHriqAOMtHILC4Mw9WkGBBceGkjCe5LUD5svZ9kGLVB/J510uz4lZOhhTVqDPrFumDMNj07iPQILuAVgZ9A63oWkdbpkdNaCHwZAST/QOo+ASMYi8ixvmPdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006078; c=relaxed/simple;
	bh=DXr0pthflIdTVKQ5DTod3yDrxBL7oMYdg/eFEDf/HY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrEPXuMHoZrtlRIX9Qxl3/kQPg6aetE6bylPfpRZPRPBwMpn3cezggGWesR71rFjIff9Au+t01hS6R3yRXysFnnMZzONAa01h59Kr7TmNJSfbEgTddZBGsQg/JRtNQeebCCjW9ZCKzryWuB5XuZJmq3LDmhQThxOqFbwzIwH5cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=XP2LsrtV; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="XP2LsrtV"
ARC-Seal: i=1; a=rsa-sha256; t=1790006023; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mNxYJPeTGHAGjPBxt2kG+O2omHs5iLPq053ahnUDuMDwCG+h/AgQV8SO1CcujSUd0RTs8zTxtr9YP1QcEg3zec8wba0rEkze1jbVLJaHKKMbgZ6SnL/2prDQmEPAgh8gxAwFEWhfnjYntkmJbR/+SW/NcMFAuYwgnBemfloyXpQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790006023; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hEhqBiuQL/MEW0Qf0v9yrljoDp5ccHOdzYzDtJ6My1Q=; 
	b=AOytYHd7RrtEEmEKbAFxraFjfljCZppLavxE5SUIhncMkLyUtMk5Srjanz6f7JFISOf4oT5zlcwpLD1vYKZB5YZLfbFTfZHF37WBaNo78Sjyox26JwZS4vCoQ2f8+ih1Nxq+eheV/GGQNjEYs6xseLNlRMiewqB4XLNxBmfdWPw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006023;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=hEhqBiuQL/MEW0Qf0v9yrljoDp5ccHOdzYzDtJ6My1Q=;
	b=XP2LsrtVFXpGYiWDKFgWo+6g2O3stDZB0BqRxuDntgCEGqi0Do7N4jm6/EyqlGNC
	6oLlKKzi9sX4i2Jc/xjliyQNMiEDC6h26bBrEf9cqdC3ZKmv1+VJQU9qPsWUWB8C2DV
	u2gQofzgkZkNipPBCS+uhTGbxA7JyecMz/KFnhNc=
Received: by smtp.zohomail.com with SMTPS id 179000602308953.27122495413869;
	Mon, 21 Sep 2026 08:53:43 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:44 +0200
Subject: [PATCH RFC 18/25] video/hdmi: Add support for QMS in VTEM EMP
 packing
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-18-2fcd7d011646@collabora.com>
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

Add the necessary struct members and packing code to allow the
hdmi_emp_infoframe_vtem_pack function to write VTEM packets with HDMI
Quick Media Switching (QMS) data.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/video/hdmi.c | 6 ++++--
 include/linux/hdmi.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
index ed9abc7ad228..c164f69a646a 100644
--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -1994,7 +1994,7 @@ ssize_t hdmi_emp_infoframe_vtem_pack(struct hdmi_emp_infoframe_vtem *vtem,
 	ptr[1] = BIT(7) | BIT(6);
 	ptr[2] = 0;
 
-	ptr[3] = BIT(7) | BIT(2);
+	ptr[3] = BIT(7) | BIT(2) | (vtem->qms_en ? BIT(1) : 0);
 
 	ptr[4] = 0;
 	ptr[5] = 1;
@@ -2005,10 +2005,12 @@ ssize_t hdmi_emp_infoframe_vtem_pack(struct hdmi_emp_infoframe_vtem *vtem,
 
 	/* This is where the VTEM part starts */
 	ptr[10] = (vtem->fva_factor_m1 << 4) |
+		  (vtem->qms_en ? BIT(2) : 0) |
 		  (vtem->m_const ? BIT(1) : 0) |
 		  (vtem->game_vrr_en ? BIT(0) : 0);
 	ptr[11] = vtem->base_vfront;
-	ptr[12] = vtem->base_refresh_rate >> 8 & 0x3;
+	ptr[12] = (vtem->next_tfr << 3) |
+		  (vtem->base_refresh_rate >> 8 & 0x3);
 	ptr[13] = vtem->base_refresh_rate & 0xFF;
 
 	return 14;
diff --git a/include/linux/hdmi.h b/include/linux/hdmi.h
index 71e2b36896af..8eaa127f0cb5 100644
--- a/include/linux/hdmi.h
+++ b/include/linux/hdmi.h
@@ -243,10 +243,12 @@ struct hdmi_emp_infoframe_vtem {
 	unsigned char length;
 
 	bool game_vrr_en;
+	bool qms_en;
 	bool m_const;
 	unsigned char fva_factor_m1;
 	unsigned char base_vfront;
 	u16 base_refresh_rate;
+	u8 next_tfr;
 };
 
 void hdmi_avi_infoframe_init(struct hdmi_avi_infoframe *frame);

-- 
2.55.0

