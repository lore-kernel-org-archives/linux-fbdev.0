Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894172;
	b=nwvAO+EQb2tC2Eammhu/VT5ZyrAh83TTyfD8B4/HbSavVGoK0ugDSQxO7T1XPjk7njdS
	 bHRdql0W9G9zTD0QSShn6D4OgcW9x1n7NZqGV54PpF1fCsqU4C+Rb1v5eQgjbEMQWGZdq
	 qM9M1iQbyJYGO0NWHql3dvYwBL+I3M27nPihCitRoRJrrIGhUuqLdbwEU3AxXWaAE9C0I
	 o3K/GxJjLcQiYcEZlLtHnqpibkrFc4dUJHY5OBymfXzgJPb6t5PIAkjCl8YG8KfpcxcmS
	 P55nnb0si5yU+kBgYMLkcwv7/PF9oYAcw3GqCa9Uuoqq3OqRfYNi+XM4bHD/IzCthqg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894172;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=Uvc1syTMYMFSpAE/jbDqVyGXDVUt+Vo4SRVox0ytqLo=;
	b=oe1aDM4cU6fjlEC1hoJ0bPF4EI5uDQRqx3p9EJRDCNbOWzLwIhK+/sr9tbdHpo+q3LRm
	 cBPwUau6k+1KzQTOUVbvUfzufNRQAP707XKh68UL8GX4QssZD8+n32x9rzmGTJCQA2NJK
	 3e/aqRr5mMQ5i/KcBuijIt3Ba9kRN+yPJ/FcR+tOzgrJaRy8j1Ru0PqfKj+lWh9FDprZG
	 bkFKncRUq9134ZVHh1rpEqiSeq94sDQpGFe8vNWWBNpsUGZGaJ74WoatNnNKPyubpjLAh
	 V86sfhUbH/wyAsLC5AULDGENqh0u8r+LM6lc5EYiQON/zHONdQCwIfo7T486nKboSXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ZCRyGZHx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4E606E559;
	Thu,  5 Nov 2026 15:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24C4E606E559
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=ZCRyGZHx
ARC-Seal: i=1; a=rsa-sha256; t=1793894111; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ka1WdsZYDV7Nc8mJ45DMVednrFj/Ynh/2SabZ2ktijh2mdWr/y3rsvmrW+uvCuEbS3Kq8FKozSEf4eNMV9zPf3CVmGCM8oQI3ONhq+BCt4QjxoII6cjuOCxLjk+OgAOBJDST/gPxrfBsIQHYRM+gqikA3EOK5OdsAp1I2OGcYW0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894111; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Uvc1syTMYMFSpAE/jbDqVyGXDVUt+Vo4SRVox0ytqLo=; 
	b=d6FAgzzB3SMiLTQgxUroXw1PHe7mS7Nq/0q+KmnjwsRw0Czt224TSb9jhrpb61whFy/Uv2yCgfZIWYNDGnG1MJp9VIqSyPxyayR0iV28pO4WBEHlsxZOCLurHod0sfQS+exRBKir/1CTtgAApn+DRaOpjkxKmjFCUX7fhFq3gyY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=ZCRyGZHx9txJ5/f9hAPaNM9/ummNBIU4meVhihPTHbgDWQE+YQKJ7DsbsaNpSbtHg+I/9TuGds8z9FCPzQ9/A4KUfvF5xBsNAcyhSCVxMtWMgcjUHTUBrf3rLyGZQBzQ+e91Mn37K/Vp9WLY2Zc16iAlzdWx0/dEUhrYbypVYI0=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=Uvc1syTMYMFSpAE/jbDqVyGXDVUt+Vo4SRVox0ytqLo=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894110107971.9612430908318;
	Thu, 5 Nov 2026 07:55:10 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:16 +0100
Subject: [PATCH v2 25/27] drm/connector: Fix docs for cnmvrr and cinemavrr
 members
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
Message-Id: <20261105-vrr-limiter-uapi-v2-25-55f4215be2c2@collabora.com>
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

The member names in the doc comments are inexplicably prefixed with an
"m", which does not reflect the actual struct member's name.

Drop the "m".

Fixes: 014da1db5e64 ("drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities from HF-VSDB")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 include/drm/drm_connector.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 41f272afbb1e..021ab07a1d9b 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -265,10 +265,10 @@ struct drm_hdmi_vrr_cap {
 	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
 	bool fva;
 
-	/** @mcnmvrr: flag for Negative M VRR support */
+	/** @cnmvrr: flag for Negative M VRR support */
 	bool cnmvrr;
 
-	/** @mcinema_vrr: flag for Cinema VRR support */
+	/** @cinema_vrr: flag for Cinema VRR support */
 	bool cinema_vrr;
 
 	/** @mdelta: flag for limited frame-to-frame compensation support */

-- 
2.56.0

