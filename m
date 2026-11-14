Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679468;
	b=BRYagJxlaNLenbhfG0DectIACXJwNM5ISr3B4i7KXMghLK+BNlyFLaERzLRAJlExBpVs
	 9LoAWo1ITk3FeeJb+vss4W53S26FxqrForsnEWGvOrxzVjkp+GbSLGnu90TDxDEglYD4W
	 6EJYqY4K0H0ISU06l8nI+nI9MAKTZYAQcyaf40KA9nIZzENZ3dzo04Tlz7xagm/5dECd+
	 Ddo9pqjhYnaN5s1TZVY9kQN6oU2AG0ywzYARgF8BuInL3qQa1ZDJ0vAoxN08wXEoYtV3j
	 aSkSHyN9bOGsepcaT/gplvHoUJopCp6Y9lIuD2r4K5CN9/xYHjasUXfBTtwN4csdKyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679468;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=vKvyFSSR/5Ksq4dTL61APESefVgnjqQrG44vv1NJvK0=;
	b=PlztacHPMVNp7Wj06jCiziUdVLu4vFIZEhu8G7EcLgh/evsGdPAKB/UxDIYuhpAuuA1W
	 mP7+7fy4PckItmaiX+NvaQsN7yL14SeVw+zYOcbNd8bXTMR64QRYhlDYVJ0WMQ3lwJqJk
	 7nzeTEdsuwpKJC136HeM/phuax43Q5+6U2frqmP6YmStdBc1mzV9lGJcrhl+HXzeikEFJ
	 xHhA9Io0qTqoS+GSSLF1qbIc0KuhOh4LmgPhmsZa94JnuPVveOFT5vqDKkz+jYLT1aPP1
	 KcawgAWzWCdDlvzoG3llKYxyzsg6whiYrfqneCTEPQ637nD9hY68STOkbYwsogBJlBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GuC7YZw+;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543C60A2607;
	Sat, 14 Nov 2026 18:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5543C60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GuC7YZw+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679464;
	bh=O+60358tIvY1UQJe6wfwALoe9EIRxZdOzbQbGuY0aLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GuC7YZw+WelMNqvBLGvpo9VxrpJcKE9rvOIrQ8pVqZwJ3G+v4+fpZ2ZmprgaZw/qx
	 N2CdeSLBHsbLLabHvn8aMHAJ6xe9OS1MUsZOhPNEr0Ys2qQCbS6QazGWXBs20s9OzY
	 98c4/9a8A2QcRq21CXdRvBw6jv/nmI1WN8k0TR0Op9WkzgLhB8lcgeRB6SVq8FwfAx
	 al7R6Gilf6/CzU/LXi0X4TW678FYbSJoVM7IzqqgO8FsXtHk6iMru0hFBq7o+dMo5V
	 m0eZEJMUChY1j8y3914s90SxO3jYPZyd227r0ESs6qwa+9WkhkxUhyN0EASAKgzyQJ
	 7ab6h7s/rYAqw==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 04ACB17E15E8;
	Sat, 14 Nov 2026 19:04:23 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:33 +0200
Subject: [PATCH 09/25] drm/connector: Drop redundant hdmi supported_formats
 field
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-9-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 =?utf-8?q?Robin_R=C3=A4ber?= <robin.raebi@gmail.com>, 
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2

Now that all users migrated to the new drmm_connector_hdmi_init()
signature, supported_formats is provided through struct
drm_connector_hdmi_funcs, a reference to which is already stored in
drm_connector_hdmi.

Drop the redundant field from drm_connector_hdmi and point its users to
hdmi.funcs->supported_formats instead.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Robin Räber <robin.raebi@gmail.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588 Orange Pi 5 Plus, dual HDMI
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 2 +-
 drivers/gpu/drm/drm_connector.c                 | 3 ---
 include/drm/drm_connector.h                     | 6 ------
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 0e282abb118d..97027dd17276 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -427,7 +427,7 @@ sink_supports_format_bpc(const struct drm_connector *connector,
 		return false;
 	}
 
-	if (!(connector->hdmi.supported_formats & BIT(format))) {
+	if (!(connector->hdmi.funcs->supported_formats & BIT(format))) {
 		drm_dbg_kms(dev, "%s format unsupported by the connector.\n",
 			    drm_hdmi_connector_get_output_format_name(format));
 		return false;
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index b1b7662c575b..2fb6fc0243b5 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -617,9 +617,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	if (ret)
 		return ret;
 
-	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
-	connector->hdmi.supported_formats = hdmi_funcs->supported_formats;
-
 	/*
 	 * The supported HDMI version can be used to determinate the maximum
 	 * TMDS character rate allowed by the specification. Some controllers,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index c75bf65532d4..312638824918 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2180,12 +2180,6 @@ struct drm_connector_hdmi_audio {
  * struct drm_connector_hdmi - DRM Connector HDMI-related structure
  */
 struct drm_connector_hdmi {
-	/**
-	 * @supported_formats: Bitmask of @drm_output_color_format
-	 * supported by the controller.
-	 */
-	unsigned long supported_formats;
-
 	/**
 	 * @max_tmds_char_rate: Maximum TMDS character rate, in Hz,
 	 * supported by the controller.

-- 
2.56.0

