Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C824BE453;
	Mon, 21 Sep 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006108; cv=pass; b=LHZ5aERXQ9Iyyfh32iWQrKKJO9BYPHm7yfsubV5rTLRezPatnV3wllG/7TAcxJhSFx9Sey/XnnYc+njRUAb//8uDzP9OjBjJ0ON2mSBHU7YbaqvQIPNZzOpby8RvSegeIU5alH9dpoHYzcvW9/j0WPJhpjGNZtxPp0GoAB21asM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006108; c=relaxed/simple;
	bh=CIjfVGA4XAY4BoJ/G/bTJlJw1cAPRAD+CYvA8qmeKpU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkgK8TiM3oQWf4jYWhf5+QdcLDWpygtqGCcRtRm+9LVywMkv0Vk/s6WRDMKFuzWBD6nOZuJ40pk2NYCVJMWVJqWs3KsfM4vj120Uaa11PDMa9ougQE8NGloUIK0oDdHgLnsP9tQL1IzdsZ7FCHhXQavvcsJ1ZTcfGi0KENa8cr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=exKmfr7o; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="exKmfr7o"
ARC-Seal: i=1; a=rsa-sha256; t=1790006063; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MGzb9I3lJG6/w4sDzPIQ6G7X83UNuPF/21AZ37wkS0cD6MZAsLDH+2RVj+GViuQApJgXnJz6kQcLZeBcCf0tCdRumo/9Xb+Sv+mWRTZPOj0j/7+dN8N+LTU7yCIqQLkfsA5w+uodald0sikSmpjZDKOkqlxasF11BqHCGECqLEs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790006063; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OGTxG2oVwgVmmQXCyhauY5aLJERWACnLUbauLJungFQ=; 
	b=RDtONl1oAN8C6S/Cq55Tc1m4dhomRBMo4mf1LG9KKP7IurcK7hT377vIH9k6TLcmDr7htH9fKk2sn68KAGzMvTnXz7vWpiEmLyoXno57Lyl1lWNwffP3Rc2tcXuQMiLKYbl4d8h6a2nBfEtl7xUkScZg4j5dvDAHTY8oOos/oBM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006063;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=OGTxG2oVwgVmmQXCyhauY5aLJERWACnLUbauLJungFQ=;
	b=exKmfr7oIJcDNpqQCMBp9rrgcLlUYiMSTfS9nfwLh86y6S65UZLHp+fvhIiEWCHG
	TEEShdoUxY6van1eWLJKYcgd6yQulWugGCzWbYog1ny7I1guaz6OnP2GgXzs7aAvYnM
	t660TgiABNqt77I6LKuUOhvbTs9Dt9lx4mAyWIKk=
Received: by smtp.zohomail.com with SMTPS id 1790006061638752.154553168372;
	Mon, 21 Sep 2026 08:54:21 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:51 +0200
Subject: [PATCH RFC 25/25] drm/atomic: Disable VRR in helper_set_config
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-25-2fcd7d011646@collabora.com>
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

The in-kernel DRM clients do not know how to deal with VRR properties.
This means that a DRM client that does, exits, and does not clean up
after itself, will leave the KMS fbdev console non-functional.

Address this by simply setting crtc_state->vrr_enabled to false in
__drm_atomic_helper_set_config.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_atomic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9bb761eda59f..1d3c35f7788e 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -2051,6 +2051,8 @@ int __drm_atomic_helper_set_config(struct drm_mode_set *set,
 
 	crtc_state->active = true;
 
+	crtc_state->vrr_enabled = false;
+
 	ret = drm_atomic_set_crtc_for_plane(primary_state, crtc);
 	if (ret != 0)
 		return ret;

-- 
2.55.0

