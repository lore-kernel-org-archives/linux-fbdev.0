Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9754DD3A8;
	Mon, 21 Sep 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006078; cv=pass; b=n5IgY9bIbsTf/loznuPPkT7H2A5I018HNE/Y4r8/Kahea+5PmFtPSY/g14zkBCpKcSzFa6197N8cxfr7MZqNRbj2e8nPw26P1Kfb0qxhAZ0FsBVj+7qQm6/5tI5ceO77pgGFwnpYoE8dTGBMu4qMeOeXxFQvdbhNeijhGT/fI28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006078; c=relaxed/simple;
	bh=z6GHbDkwPim4IeIve2OsuTqdxU7XFToO1raFQ1e8ZZs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/0GCVuGiNYR7ZM1/LLKKL4Qd7zeNwt2AdqBQQRbv/Zqu31He9o3ZioF6j3G9RMzsEHwzjrpJsIMVrkGQAmuBU9T6SW3xqffcvWTX2H8UwgLvMrCchYF0tMQ/8hdyixfkUpGA/9ZT9QrgjsZic/OmxEJszLC1P8fY0RnwV8Rfc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=Jgz6DvBO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="Jgz6DvBO"
ARC-Seal: i=1; a=rsa-sha256; t=1790006029; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bucFePsIG3sHaaq/2CBWDuM6TEQB5ZUvSiVK4L87uB8k+NTxy+ifG1BiI8b4jqBlbXCNYrQDmCA/4OGZvHfYxCui3ll5076Kw9Pybc26IofFFJAlIpftObLG2oOywgrWVuvUAZaPUKTEjZhkc9qVXqXJRdtyOTZhjyQ7I+cg+9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790006029; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1N1AnyMnsM3RPCrD9BtF496M7LSPX+hpmo/Y3tqyskA=; 
	b=iu3kjXMKrd5USM8jXxUw4CupgHeqjWdNt+Y9RDnUzADslvyhTk3jhiWYx3CZdpkEtPp1OD0R3Krt0Ixe8pasvpUlq+Y41zSNN62JwhWldKEe0CWNv0hJy1WutJTuN9LhFTsrXVJVPUUozy1zm0TUsIWuZq2TxVHcOIEmraV+eEY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006029;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=1N1AnyMnsM3RPCrD9BtF496M7LSPX+hpmo/Y3tqyskA=;
	b=Jgz6DvBOy9K+i2RfOAOPfYf7p6Y5KWJ1d4xUkaPCAHzfCYATKkhhFEz2coekjKsq
	pp87lncyTbEAsYCTjfRS7KVQQb1SMPsHoxZYEo3Qrl+ZltRJCRpZdwvnFwMSU2V39dY
	qzCVkuN7ulHwQJzmRYiR6hkfDv0aM0zLuFYZw5ts=
Received: by smtp.zohomail.com with SMTPS id 1790006028396815.1028205617608;
	Mon, 21 Sep 2026 08:53:48 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:45 +0200
Subject: [PATCH RFC 19/25] drm/connector: hdmi: Add QMS to VTEM EMP
 generation
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-19-2fcd7d011646@collabora.com>
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

If userspace indicates that QMS is desired, set the QMS related fields
in the VTEM EMP struct based on the connector state.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 7dbd678cf061..7237070fc9ee 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -897,7 +897,15 @@ static int hdmi_generate_emp_infoframe_vtem(const struct drm_connector *connecto
 		return 0;
 	}
 
-	vtem->game_vrr_en = true;
+	if (conn_state->hdmi.qms_enabled) {
+		vtem->game_vrr_en = false;
+		vtem->qms_en = true;
+		vtem->next_tfr = conn_state->hdmi.qms_tfr_byte;
+	} else {
+		vtem->game_vrr_en = true;
+		vtem->qms_en = false;
+		vtem->next_tfr = 0;
+	}
 
 	vtem->m_const = !vrr->dynamic;
 

-- 
2.55.0

