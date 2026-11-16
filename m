Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784937;
	b=wyNKmUMPkxrgHzXVAfMXdyje3MvmxjIgvAkIswhA1Dpu5gisQi3HFFXtHIekr9pZjWss
	 eZVlGpwAwnzt0bbQ8tMqYbinqX4by4KQcg6DFrXvpBgkU8scjvzirCU4WkJ9uPidiZnJC
	 GlGtjmi9YZ7x3HwQsXTV9dKTDsoo7ETojL+ZUIaZZPX6doa4AFZXCzjqaXyFUtp3WDc71
	 Da6Gco2b1sb8gxq5fIqVF9O0Ot2BKnjdPDe0UZw2CQ6WT/jqlt0bAm/xQ3Yg9uetV2ijU
	 C2v688pStRG237eOjXWpBHemAdqS/ptucIpnTjuSYkitG4WQ817I90OnCuTfB7cARIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Erdyei72788KVv8pLaqul7iSgCQZTDqlNCfVWoF2cUc=;
	b=Syfj25FTCfLp75nvrgXiwV5PUmZXtFuL1PG/PJayiKJtmtMtRUs+3ieOV28biuRoCP+8
	 HYDI75ZLWDyLIpSaNzhsV4bLCxE6q+x3Kn/QCKllem9Ns4ZR7UcA+iTM6UjVvhVLhj50o
	 pQoGY3MzRTN0sf8X48i3MGqG6Ym0XbN35wQRzcsH0DRdMlpydrYENK7q1HIpf6+VeXrV7
	 ruIGf/vTeycyEfSoJ6vdGc8Tg1TV+EfLP930rEdxBFMme8ss7nipBQBohQ0MpbfiVETIE
	 P053cyMEXrHQ/szqb6XHncIvKNwYlaNjf2jE/bp/Wq0MLJh5EwQiBr8LNkBLxdpGygA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LopHEaxb;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FED606A8B0
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 23:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94FED606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LopHEaxb
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so3653425e9.0
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794784935; x=1795389735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Erdyei72788KVv8pLaqul7iSgCQZTDqlNCfVWoF2cUc=;
        b=LopHEaxbU8qluG0bNr0X7YSDk+c0OsgMfGYigZ//YqyCiIDFOvvTCgvq4FYIvzWR5L
         2WxbabMKUv2GXxZwVT777BbykE9Pt73WrQ3c8jH0H6c+Yk/nSQLHK/ROeiv3Tw72dKXm
         8LOi/aISgXUGLQTrQ+bZsiW+vtc3Hlkwm+8czErJfQgaIxkrhqXzLcNubNchYhvq9ORX
         7d32GFh8QvbGh3Tp662n1q2rwQFnjBYjEYczFxotThVDzUblLAEP6ycMVbZ8UwQTCNZ5
         xI2aLRfs9lVYfboicZmB1tcl1R+v80EYEwjVpU7PH63NTXJXLv7CFu1m6U9UeZmjcqNe
         gZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794784935; x=1795389735;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Erdyei72788KVv8pLaqul7iSgCQZTDqlNCfVWoF2cUc=;
        b=YMbnI1TZCz41fDdg80DQe/8zTkc3yQQCqQXxqaQatlUaCm1lBwXF6PngU1Uj7svRNX
         xx3k0KUXH0yP1Pmpq/oEc/VT99J0MyfwTOOOPHM81Puowtk4DX80GjumSLGYj55Sa67p
         drNuPYSa0qfm9pZnJF8hVQgpbQl6/MEp6DuCjF6eOJCzOYu1gBstxrKv08unLiVeUPEu
         N80hyMwEA857mu7jkoiSWDTYx+OZ/VBM87sxM8fkv1oPTVTS+kAh9lWKSMrYWeo2/Kiv
         NzBuvUyTHSWdk/r8ZNwxtg8V9zNbQ+PuCA8mc3Cg0y5m3tW5UnhMakeAJAIu0P6UPq4T
         IKyQ==
X-Forwarded-Encrypted: i=1; AL+hErGyA1mRd0FlmOZ1hVXSThtsnetz9i3CXhb5llQCjVQ2Bf/VZ9dTmruQTqZAzGxnpnyTc2pW+BdgarORvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/A3LsuIMwxsffUdfn8X2a9KRLyRsLW3zAjKJ51LxDEkcmob0aL
	Je27YyMf2B84Qfk2WgJomxaulkp8OPOyvjEBcDMV8llZVcxFjTSlWono
X-Gm-Gg: AYBFou0cxzoLHkwAMicPYJgC4FE7EnlDJsP1BdRLoJ6MqP9P4GY+odgAKcyR9iQMSam
	6Irpl59mMXOm4SMGNO6KLCLlxadi2uuCAkxGwDEz4MejX0c2pWBYc/9D5d4a0w7fTtki5Dkdp2D
	3nNOARNB2NRmmQiu4NPC1TALTd8tlXekFjOxvHRFv1paNuYRbnv6GA9KOYlNcv0EIaIj4bOxMH5
	fCfO/Q/DCBRLTVQtffgoWmUilyb3+4S9HoMmeWyUENWcOWwZWIrU9UEezgRHlazwA2IK7C8kDEF
	KIKko00T0Tix6Qohk1TUkdL71BI4xkaHLj2kpBvOWMNyaVFN2NpDdS7kRZRa961w5kPPN4HWrLT
	QorBEVSnjqrBDT6KoETSWOCR2gP7ri4doWPwNLfujmcKf8b2VM0Nw3oAp8dqezH9oergGrJqUav
	ewfekbGJ5fudjLggDkwy31L9PoexW5BAimnkJPw0ZPwLZ7tYQFzWS3FNCTN06+nZutoguabw/s5
	+AmM5e84nuJ1SQDNvloeleQoxTnTLt4kyoDd8YTQUntoru5F2nDgKKkW2tm6Dm2zTFHmnPSjSAH
	nOGHbz66Bp73RLrAFql6iLJbPhOtC/+SBMmi9UEsbjaeEIMfLl7NqAQ=
X-Received: by 2002:a05:600c:3509:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4bb559f2cc3mr183275325e9.2.1794784934909;
        Sun, 15 Nov 2026 15:22:14 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571f976esm127920955e9.3.2026.11.15.15.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 15:22:14 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Helge Deller <deller@gmx.de>,
	Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	dri-devel@lists.freedesktop.org,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-embedded@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/6] drm/client: splash: pick the image source in one place
Date: Mon, 16 Nov 2026 01:21:56 +0100
Message-Id: <20261116002156.1027726-7-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116002156.1027726-1-maximpedraza@gmail.com>
References: <20261116002156.1027726-1-maximpedraza@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The client chooses between two sources with a boolean: the BGRT if the
firmware left one, otherwise the BMP loaded as firmware. A third one is
coming, and with it an order of preference that a boolean cannot hold.

Name the source in use with an enum, picked once by
drm_splash_pick_source(), and have drm_splash_image_load() switch on
it. No functional change.

v7:
- DRM_SPLASH_SRC_FW for DRM_SPLASH_SRC_BMP: the BGRT is a BMP too

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 46 ++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index d54cf628cf17..fbbdc034e417 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -39,6 +39,16 @@
  * a static image.
  */
 
+/*
+ * Where the image comes from. drm_splash_pick_source() sets the order of
+ * preference; NONE is zero, so that a new splash starts without a source.
+ */
+enum drm_splash_source {
+	DRM_SPLASH_SRC_NONE,
+	DRM_SPLASH_SRC_BGRT,
+	DRM_SPLASH_SRC_FW,
+};
+
 struct drm_splash_scanout {
 	int id;
 	/* Modesets scanning this buffer out, by position in the list */
@@ -91,7 +101,7 @@ struct drm_splash {
 	const struct firmware *fw;
 	void *map_data;
 
-	bool use_bgrt;
+	enum drm_splash_source src;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -439,7 +449,7 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		return -EINVAL;
 	}
 
-	if (splash->use_bgrt) {
+	if (splash->src == DRM_SPLASH_SRC_BGRT) {
 		x_pad = efi_bgrt_image_offset_x();
 		y_pad = efi_bgrt_image_offset_y();
 
@@ -509,13 +519,31 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
 				 size_t *img_data_len)
 {
-	if (splash->use_bgrt)
+	switch (splash->src) {
+	case DRM_SPLASH_SRC_BGRT:
 		return drm_splash_bgrt_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_FW:
+		return drm_splash_fw_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_NONE:
+		break;
+	}
 
-	if (!IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_FW))
-		return -ENOENT;
+	return -ENOENT;
+}
+
+/*
+ * Pick the one source the image will come from: the BGRT is whatever the
+ * firmware shows, and the BMP loaded as firmware is the fallback. With
+ * neither, only the background colour is drawn.
+ */
+static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
+{
+	if (drm_splash_bgrt_available(splash))
+		return DRM_SPLASH_SRC_BGRT;
+	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_FW))
+		return DRM_SPLASH_SRC_FW;
 
-	return drm_splash_fw_load(splash, img_data, img_data_len);
+	return DRM_SPLASH_SRC_NONE;
 }
 
 /* At unregister, once nothing else can use the image */
@@ -858,10 +886,10 @@ static void drm_splash_rebuild(struct drm_splash *splash)
 
 	if (!splash->source_picked) {
 		splash->source_picked = true;
-		splash->use_bgrt = drm_splash_bgrt_available(splash);
+		splash->src = drm_splash_pick_source(splash);
 
-		/* If no other image has been loaded, try to load a BMP as firmware */
-		if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_FW) && !splash->use_bgrt) {
+		/* The BMP loaded as firmware is the only source that arrives later */
+		if (splash->src == DRM_SPLASH_SRC_FW) {
 			ret = drm_splash_fw_request(splash);
 			splash->fw_requested = !ret;
 			if (ret)
-- 
2.39.5

