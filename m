Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.240.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759726;
	b=o7GwWL6REcW+qZArZ0er8xpCyrdexTe4Hxf3w4kLAFHmLJa0NMoiVadJ2Bs8PmaSe2zB
	 +VC0+IQj9jY7u5HwtYAbjDKZuyuhaxkH/nD7MK4o1tFVMXlUcjd6oSJ2R+3hW0nxshjwd
	 Lp+6EajtqMkciNRMlhscWAL3wSAEpk1yWgePDNWGmjj/i0pN84XiE6T50kMQouK1c/UrZ
	 AtzSP6FOKz3YbLZ95LEu+8Rh94khoA6186qjjQrtkTqTD7mZtG2qY4CLHLSL9DLKtKC0U
	 2UlcnFjDFhzCUEFTCdooJ2WPG5j6woGvcOEHfKIFUhZM7n3ikvdOt7Nxo6xm2aCw+7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759726;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Sender;
	bh=IpYn70lR33jDW10VpIO53zmfQAfz7L33gePUEh4ddh0=;
	b=NrtZXuYuXufKEY2+Nwsji4bqAqO5iSR+Xpb/SxUv9H/rXAY3dwMYq4iCT4S4Amk9kW0p
	 /Y2MbesLsFh42FLwGPyVVC5OfXuBvBiKbWAhYPHPAT1mvQCiUZjll0/xnezraWkM52STM
	 ZQNgizXKPkl0O/9ixwwLFmkzqjuji9N8siMCnn24dMWgNSe48r7Wf74SGwMOKyj4G0Z9w
	 l2o29YxKj8YY9Yf+6GsK3UHytxiI05+uSnL/UfCbLIh1/o2PFJ0B86kIx5xKzgerMJV47
	 dgEc2snkG0/t7p3vMIIQLDJPjZY3SZ6CJKu8s1jlice5Xh3K5bedT3EATKuRBTw39Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sraa.de;
	spf=pass smtp.mailfrom=sraa.de;
	arc=none smtp.remote-ip=85.214.240.192
Received: from sraa.de (sraa.de [85.214.240.192])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2236606A326;
	Wed,  4 Nov 2026 02:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2236606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sraa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sraa.de
Received: from [161.142.148.162] (helo=localhost.localdomain)
	by sraa.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <basti@sraa.de>)
	id 1xOQqJ-00Akzf-U7; Wed, 04 Nov 2026 03:35:16 +0100
From: Sebastian Raase <linux@sraa.de>
To: 
Cc: Hans de Goede <hansg@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Sebastian Raase <linux@sraa.de>
Subject: [PATCH 1/2] fbdev: simplefb: Add mono framebuffer format
Date: Wed,  4 Nov 2026 10:34:49 +0800
Message-ID: <6c207278c23d11f2c17cee383d422c3295cc7d97.1793758480.git.linux@sraa.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793758480.git.linux@sraa.de>
References: <cover.1793758480.git.linux@sraa.de>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: basti@sraa.de

Add a new simple-framebuffer format for monochrome 1 bit-per-pixel
framebuffers. Monochrome framebuffers are not true color, so their
visual is set to FB_VISUAL_MONO10 (set pixels are bright).

Signed-off-by: Sebastian Raase <linux@sraa.de>
---
 drivers/video/fbdev/simplefb.c         | 2 ++
 include/linux/platform_data/simplefb.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index 60e5dcec201f..4662101885ec 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -583,6 +583,8 @@ static int simplefb_probe(struct platform_device *pdev)
 	info->fix.smem_start = mem->start;
 	info->fix.smem_len = resource_size(mem);
 	info->fix.line_length = params.stride;
+	if (params.format->bits_per_pixel == 1)
+		info->fix.visual = FB_VISUAL_MONO10;
 
 	info->var = simplefb_var;
 	info->var.xres = params.width;
diff --git a/include/linux/platform_data/simplefb.h b/include/linux/platform_data/simplefb.h
index 4f94d52ac99f..9b6d822145c9 100644
--- a/include/linux/platform_data/simplefb.h
+++ b/include/linux/platform_data/simplefb.h
@@ -15,6 +15,7 @@
 /* format array, use it to initialize a "struct simplefb_format" array */
 #define SIMPLEFB_FORMATS \
 { \
+	{ "mono", 1, {0, 1}, {0, 1}, {0, 1}, {0, 0}, DRM_FORMAT_R1 }, \
 	{ "r5g6b5", 16, {11, 5}, {5, 6}, {0, 5}, {0, 0}, DRM_FORMAT_RGB565 }, \
 	{ "r5g5b5a1", 16, {11, 5}, {6, 5}, {1, 5}, {0, 1}, DRM_FORMAT_RGBA5551 }, \
 	{ "x1r5g5b5", 16, {10, 5}, {5, 5}, {0, 5}, {0, 0}, DRM_FORMAT_XRGB1555 }, \
-- 
2.47.3

