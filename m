Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894172;
	b=WehwsgkZFTYU/iCJabVNkRh92w2rCqbGSR4oWgKgIemXwBHvVakh/c9rlQcjKvZjjtG8
	 vJ9BQUhVohWsZtE26G9CY722uoI06V42EjpaHhIvN7QEx2fI2DocUgrFMwmnfuztqKv92
	 F69OhI9yS2lBSpFcO5ghZ6M7koo3dfpzmAnhk6+hHeki3iD/du3qBcFZ4F1nPnJSvsTFM
	 vFiCDDH+La2ci8sY2WlBxGo6WRGetVzhjwFSFm3n+cZzEZunfZl2aDmzCjeLGix+I6xrQ
	 9WaBDaT3ygdDWzxoTf0e6nDQeNVO9caxxiTSl/ffT1JWgDvG7Ft2B7v7ETM42chHdkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894172;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=tVNwYKMhk2/WnrIZ19upJetFcNs7CUL1Pr30OK/rV9s=;
	b=RryErX2PHF+ZmCfJ9J/jLGuNR+uvBpJUd2Uj7zHEgYlhwBWD/iinTkzhKozLpO5njJ+m
	 nnd3a8GowCEmJYBw7bpbW50VLuSG4zGo+qUgvdDz8vXnhR4XoEoceV1bnVXkzSnadq1yg
	 8Sp3g2O+VIHfDPzalMEFqAf3tLB+aJ2KRScne9ozovC8uR4UWS0wZol56Xd0bmwSTcRpW
	 593j6r59InKuYAq6P8n8jft4A3GfH/KDNNqe5ijt5sAt8utROlvOa9fslbUUcn2FxL08f
	 ZVgOC838l+CMuXZSs/gWnA0xLMlqyyFZXYvx+3vGs9+J1Kz2zgi7vsg1fctoX9ECZ6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=B8xpVXrr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB3606E571;
	Thu,  5 Nov 2026 15:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28DB3606E571
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=B8xpVXrr
ARC-Seal: i=1; a=rsa-sha256; t=1793894117; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CR2pennS5hSbWsFNmP77+NJWpOZsPJC0Uaj/YPAW2kmnuMLpFxNpTTH6KmvOyxKYUGxAkMEdf8zScqXRVRhdrnfaoBQuJL2NQ7TsWZO874UDtW+Ro2YqBs7tz2rsJaYL+OuYZ4syfJeyy0ReXS7oIrMt/JQYFr/rLs5NnJ3kjk4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894117; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tVNwYKMhk2/WnrIZ19upJetFcNs7CUL1Pr30OK/rV9s=; 
	b=AJg3rcecPL1vPnfYJ0PawUJipTuMxvcOJLJH7RoshWzWPz+mLoREmsbs43PAWxVKj1IHiVwcj3pgH6RCv/P9EFXKeKp04LHbpa3atUkgPDSZH1XyImOIZo71CVOUQpx9iyPwcD7TbXJoEsI7gIAC3tgloDNTX6gfU24cZnih2eE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=B8xpVXrrrydEK2W4qItNLZsmWHehtPHQN+tJwM9U4qG2heDbFs7i7woYk2Yet8XdDGgIoM7KWsGZUxBdl8sg9rk9Khy8v87trvQ8+8fDQMZsMrGITRsnAItDXAeD4jHvIryGuOKTE95+/Imq54Hd77b0G0vlcSklkUqn7KY3bzM=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=tVNwYKMhk2/WnrIZ19upJetFcNs7CUL1Pr30OK/rV9s=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894116497649.6985151835922;
	Thu, 5 Nov 2026 07:55:16 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:17 +0100
Subject: [PATCH v2 26/27] drm/debugfs: Expose HDMI VRR in vrr_range debugfs
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
Message-Id: <20261105-vrr-limiter-uapi-v2-26-55f4215be2c2@collabora.com>
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

IGT requires the vrr_range debugfs file for running the tests, for
better or worse.

Since Commit 014da1db5e64 ("drm/edid: parse HDMI 2.1 gaming (ALLM/VRR)
capabilities from HF-VSDB") parses the HDMI VRR minimum and maximum
numbers into separate members and not the display_info.monitor_range
member, this debugfs entry needs to use those members when the display
is HDMI and does HDMI VRR.

Add this special casing, and also protect accesses to connector->status
and connector->display_info interruptibly with the mode_config mutex.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_debugfs.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index a72f9723d3a9..476f44642ac3 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -586,12 +586,26 @@ static ssize_t edid_write(struct file *file, const char __user *ubuf,
 static int vrr_range_show(struct seq_file *m, void *data)
 {
 	struct drm_connector *connector = m->private;
+	u16 min_vfreq, max_vfreq;
+
+	scoped_cond_guard(mutex_intr, return -EINTR,
+			  &connector->dev->mode_config.mutex) {
+		struct drm_display_info *info = &connector->display_info;
+
+		if (connector->status != connector_status_connected)
+			return -ENODEV;
+
+		if (info->is_hdmi && info->hdmi.vrr_cap.supported) {
+			min_vfreq = info->hdmi.vrr_cap.vrr_min;
+			max_vfreq = info->hdmi.vrr_cap.vrr_max;
+		} else {
+			min_vfreq = info->monitor_range.min_vfreq;
+			max_vfreq = info->monitor_range.max_vfreq;
+		}
+	}
 
-	if (connector->status != connector_status_connected)
-		return -ENODEV;
-
-	seq_printf(m, "Min: %u\n", connector->display_info.monitor_range.min_vfreq);
-	seq_printf(m, "Max: %u\n", connector->display_info.monitor_range.max_vfreq);
+	seq_printf(m, "Min: %u\n", min_vfreq);
+	seq_printf(m, "Max: %u\n", max_vfreq);
 
 	return 0;
 }

-- 
2.56.0

