Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109247;
	b=eNaH1ndjRsteABZNwuZ87gYJqEBKdFXJcwx/P298moHFUBY4feJWZe/4bXOIYQJY3ZRg
	 hLDOUvcJ+ZStI4tHnkbYfWTYoReJW/JKkfbhYM7v2qywuzcOGl/KGDryOXpj5FADCIDLf
	 ZSDUIGhsdn1CFRgpa7oG0C6kA4+DRT3DCLnMIs/QtohT0gSrePQPXIo131nYEbYvDTLOU
	 8mseqadEycK4cUJNgjjQtCsgsZbN5qO9wTBC1XQwcYMhCqQJ4vhUAjN4WYTs90FZtrnIf
	 obE86wghXx/wHJjtbOkcX4rmiQceZEXiFy7pTQhTIxv2dKwY8meNYFxDBtnaWAlGDNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=x3TRWoAym08EDkUmxJbEElxgHRIsBB4gzy6Y/BELf6M=;
	b=dRybBAF2wZalmp4iNssiSyIYYRue757OWwCZby51BAy1vSEuRm53FowEq7D/YF+xe/qu
	 UL+ZQ2OanB5k8bMWpWs4DSCbKfKPK6LNi5bmTt8qJxoriy0sDJZ5lZfcW+Avply2EPVZY
	 ZiOPXbMjbIvpl4wlOmv28lvfPjGj6mZUY9ORxA8TZWj/A1vLyjs6aqZh4nbSF/1YLYFI2
	 lLrvdFE4uX3CVUD1yy1iQMgv/vbSTltQHtKNbTvbjbpYL0XZrwSoRHjPbJ7un+KOCU60j
	 ZFvy0ZWDco8Z+HtQ0JsUFSh1hpawlQvLGHOvFXBnphDtnQL7Mbq6a8TdLpPiaBtPrGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CXibKdWQ;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88A60A382D
	for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 13:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D88A60A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CXibKdWQ
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48c45111bebso1908960f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 27 Oct 2026 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793109245; x=1793714045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x3TRWoAym08EDkUmxJbEElxgHRIsBB4gzy6Y/BELf6M=;
        b=CXibKdWQ9F7anjrgC0VMM7aDjT7IZMsjrShnAhjebv9ylc+23J4tWOL8QvB+1moPRX
         +ccoc8d11rCpEb7OtfOrgtPIf/fT8tmb8PVCSRTYx4nbwMkcpY2vtHqVUEpb/OC3PRSX
         n0Ia7Prd8lLKUDe1UZtgqbfo5N4cIvFxQz6SXiyEYg+iyq3EZ/1FhxyWHv5iBM4l7xCx
         7F2ocwI8m+BeAbnle6aJRUD9PWHXDbHOYkGek9AI74WYQgNsj7qt8kMlhNAd0+KVokOO
         6MNd4RtF0WI/55ngrMNg6XmUK6c78cp3ggmzgkKmzUywXESizZ7nCpjNOly4WKzfIN4I
         Qk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109245; x=1793714045;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3TRWoAym08EDkUmxJbEElxgHRIsBB4gzy6Y/BELf6M=;
        b=lzdU16+SnS34FOwKxFTzAafa9ctYA9TGGURkreHhlHuleqSggpmMPyWTmLwlKaDpWU
         S+DDRWzTnQLxEQ4rZnU1gahQVCHdlFT5dEEfwqKZc0uGnACcKAMmneaEn3+YqscjEJoi
         /fEh+88pOimJ+K3a8OtMVus23KQSFntO+6jcaxRQwFU86rjS4O7PCKxBVxLBtAQmCS8v
         1U38rNZD2LQkjBqtjp7d16ZSKFwzU1wv5I1+b94FE07nhSTAv0Uv9XxQH4OUlgvNDvGY
         3+tgUsInIj2gWToXfGmr9NKaMAUfGuqca7jkBwVWUMv6wTcRzbkC2xyHRmYpHJfWBOxJ
         o+rg==
X-Forwarded-Encrypted: i=1; AKwUvByE+mFfH9Ymi6qwrJ7+nvDyyW2QzfsR70mh+rLXdx0E8z6kg96sAHw9NwLCWWg5biBSFofRAaQb3zhU7g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJwFU3JaMyV/69Mu9J9yywU8VlAtjcs+LSW0OOHEiSCljE68djd
	YQQEkyy/xU5rZTjpN5thmpApWfUhlFyF3YhkenAoXFOXJ+6DvVEr5OP/
X-Gm-Gg: AYBFou3RyEren/OB1LIIHug67dhmmt9ZD131SMF8RsqJWu6cKuAU1oHDnuziyxYZrue
	bfNiyuoEV949S9eBkI8HEWm4bwm/EpwNiPoi5LuBFUMb0oZqUg4TfHGLVBQhhtDJu6qisPv4BC/
	gqYTV/5UY4PSFRGHJ8EkoTkvMlJu820yKMpq9cIGtMGgK7R8Ju9hHWaoKNt/+hoglW0xXwSxMEm
	ujbB14vHm90linAs9u8fpG4tavBbvdy5KabMoEPzuMcptbAj7VB5i7rwcgjF5Ys9ydrJWh/FmIZ
	5/Hr6IYRzlMkjiepynSF/+E24Y0eZM2cYQKENjXLUar1FkifV4j6rz4HO9vS/h8tyPYOjTCpzMG
	AlhVvTFRte0sv8m/njvPfV16vKVbiTmzpKZl5OK4cVnLt44exUsMQ3IKN+cOiOklAGmn43F9HRl
	qo6auDrrDNMmx7uDH+WvL9VpFb0vaiUS2cQioOljzk/U9vvG7e8cys54ex/LpD9mLdfMQysq3Uo
	pW6yo1JkNrbKvJlcT0CkpO94T0GUQnZnvGnXIUXr2bXGuVHkZ/48NYIpzypADBOkFVIZTGMEt+j
	pnQtVS/nKLhZnKdDfubI7rEgU5vy
X-Received: by 2002:a5d:5d10:0:b0:48e:1c72:abc with SMTP id ffacd0b85a97d-48e3eb9890amr18924302f8f.35.1793109244645;
        Tue, 27 Oct 2026 06:54:04 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:54:04 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
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
	devicetree@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-embedded@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/15] drm/client: splash: pick the image source in one place
Date: Tue, 27 Oct 2026 14:53:35 +0100
Message-Id: <20261027135342.2003632-9-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
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

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 45 +++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 337c7160c4a1..911149b92a52 100644
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
+	DRM_SPLASH_SRC_BMP,
+};
+
 struct drm_splash_scanout {
 	int id;
 	/* Modesets scanning this buffer out, by position in the list */
@@ -87,7 +97,7 @@ struct drm_splash {
 	const struct firmware *fw;
 	void *map_data;
 
-	bool use_bgrt;
+	enum drm_splash_source src;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -429,7 +439,7 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		return -EINVAL;
 	}
 
-	if (splash->use_bgrt) {
+	if (splash->src == DRM_SPLASH_SRC_BGRT) {
 		x_pad = efi_bgrt_image_offset_x();
 		y_pad = efi_bgrt_image_offset_y();
 
@@ -498,10 +508,31 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
 				 size_t *img_data_len)
 {
-	if (splash->use_bgrt)
+	switch (splash->src) {
+	case DRM_SPLASH_SRC_BGRT:
 		return drm_splash_bgrt_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_BMP:
+		return drm_splash_fw_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_NONE:
+		break;
+	}
+
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
+	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
+		return DRM_SPLASH_SRC_BMP;
 
-	return drm_splash_fw_load(splash, img_data, img_data_len);
+	return DRM_SPLASH_SRC_NONE;
 }
 
 /* At unregister, once nothing else can use the image */
@@ -818,10 +849,10 @@ static int drm_splash_client_hotplug(struct drm_client_dev *client)
 
 	if (!splash->source_picked) {
 		splash->source_picked = true;
-		splash->use_bgrt = drm_splash_bgrt_available(splash);
+		splash->src = drm_splash_pick_source(splash);
 
-		/* If no other image has been loaded, try to load a BMP as firmware */
-		if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP) && !splash->use_bgrt) {
+		/* The BMP loaded as firmware is the only source that arrives later */
+		if (splash->src == DRM_SPLASH_SRC_BMP) {
 			ret = drm_splash_fw_request_bmp(splash);
 			splash->fw_requested = !ret;
 			if (ret)
-- 
2.39.5

