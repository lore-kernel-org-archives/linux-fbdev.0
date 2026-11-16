Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784935;
	b=hWg/ATbmsABW8LzKQRvNIOe1DHt/6b0QOH1SIC9kSgE6Y7c8TWlb+IBmWOAukv3iwz+B
	 wwvNLuEZZd5DY9+dq4xSykBWiZ/xxDEuhuXWLxpbvonwPWAsg16D9GS0CsnQJWgKgwvlD
	 Vy1Rd6WYWKFd69sAIyhRNF3BtztR/3WbBsUhbU0iML0ViWBYfzo4TyE296UNHxk0L0bMC
	 y/nkgDtmi9HADiXUdP8JTO9Wl8hP0Ta0q3+qM4cu5YFxuEg28ldfJSdfpw0Pni2LtZ3d1
	 uOQKoj0i3Op5XYtTzikrI8QaNzjm86oNIN7lokbKDuyxCbMdZ97CiphUddWpTdgVpxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uREsKIEDczdDVdj720bXK/T41S+3ar5PxkrrHsI/TEM=;
	b=xkDdCvPvIDddeccBX1nmHKA0am5NQLJGg1nQOBfRHfVcP0bl8+RF+x7GuN50R72tvxZF
	 QOCW4mCiZ71jMoUUqwCUV3XYgUmAW9zG4D9/pxakPm4K0BXfY5VMVeMq5hdSdtZzd122k
	 BhClA2GPcqKDLY72S1NnwNdnwsaIJCjh4RqOpzdFssz0e4BJb4qgaPM483rv4fCKoUokj
	 30mFCLTIuABl4dBzRu7VwUctovLeJloY2OaS2YeNDSsmA8bi7LNN+/agflfawJ90Wnxn+
	 DskTmroh+crhw4gf45iCsvnQa33h+l9ntN8RAkEFuy9zWZTLCnlMDyTTocGD6DOllMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQkNrinm;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1F606A330
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 23:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3E1F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jQkNrinm
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so16748845e9.3
        for <linux-fbdev@vger.kernel.org>; Sun, 15 Nov 2026 15:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794784933; x=1795389733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uREsKIEDczdDVdj720bXK/T41S+3ar5PxkrrHsI/TEM=;
        b=jQkNrinmnyiH3DT7YlgTu03VUyhi7q9DOquQaVlWG2jLJQvITuOTfMsr31WXFI+y8G
         +Ms42TCNfD1X8Dl6ARmdwurW4X+BahBcgVm8UHxkrzd8kxbab0jv+ZArjfC5id5O4hdm
         GzWp+0uOyvdUhTypeyVI95yeEE2pWqOZXxXXhi8gCTsDd6ZjFC3cyM4MtwGcv3j1c2E/
         I84JM9NZjz4EQwQzv7fYTqHIxRyZ1rZX8ReX7qzYdCxIqdLajnu0wbev3sqsM13aXYpO
         PG+kJApuGBCqeDWtl3PDAywcNnmBGGlKcyWUwatKPfe9hZBUeNTrDbGmpnHeB+Dymb9V
         upkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794784933; x=1795389733;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uREsKIEDczdDVdj720bXK/T41S+3ar5PxkrrHsI/TEM=;
        b=vPw+/2skVNtIJVSOLCQt/VO45eRtYRyJdJwzojWlTmzZXmmHVFptRiP9Srd1J4ev7T
         NIAm9hE3jBnBjPBgAP25uVzfHDC+Jgg5wPOhShA619p6Nd/YFinZaH/VBUK+Sw1FtdFu
         FyWBDAk0gF4DXXKtw5LpqLwVK+y4nLZ4bmmZTWESK3gahOR0BdoiXTWJbXdnm5enqTeY
         mjAr9Tug6i1HCRAVJgNxJ3xQjDpiDxnbKLBkpFM2rHGBsHps13chZzt0BwQCSkh8BTxm
         QbZBw6Or3rcQKOlwdYzY9Xv5DQO2c+bN94y4joABjHBT6QlA0l1ZgfbgSbyj6meG9OEZ
         ceDw==
X-Forwarded-Encrypted: i=1; AL+hErFlAjFTJ+QuFABg1+k6GDg34jNhEqKU1nVLAkMYxMveHnEgmN6G31QpvjJ8rSP3LUBP23qKJ3F3927Reg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+hXwyi11zJezWjr311faO/PVBZfqVqimDPoV+a6DIejZOpl7dr
	dTvkvJ901bhzyc5Q5QjFt935w5v/U6FJAIayjjmhXHZ7Yy5PAzF3/8jb
X-Gm-Gg: AYBFou11JVbIL/d2r/z4S0JI9pQLimFYYJRG4WlEEWGXiyZmZSODQ8k4WRwYK/jW82K
	6SEanWTpmvRB1KBEjzvR/vQjk/0lrSN333+bv6NIX11Z13iqhfIQNAQujPEPTa5sfDdEGpXwLUW
	SblbKdZ0R2fw3MJDsiSUjke4rHTdHU0V0N5E7agUYG9HP9JU/IZG2+uluFcpT3uGltzT3Lwzre+
	5A2bT5YMwDyQ+/N+WmK8estMwANYzwgwI9mXc740bg13mZrO0IirbqvcqFk6T8VwI7V7dsS60xk
	RNLZLtrISqI4cecJDGq8um34YkQWrq+ayeJ3LV5LdoN7Api4jCKxPps7x15gR1OMxwbmGTTgblr
	8MlJPGvZffWc3RHL13jrtbX2KpMUhswjbQMXhoTru/8tEQxLM0wVuZ4UcMFC5LFdvTh2HbRXg/y
	GGGc6MnU4a0mYah1TDgcUizUILRowUGwmNkUNvPcSvIAiQ59B0LVjR69vyptYGo/3ioxzBX43wN
	Lm5OhzpAR5PCyMkzhAKKBTI99zomQECxH3B3MjRlg6gPgnwRU2s+9ObFGkl/DWTGFaFPGQDztxa
	60yL5dq4p9+wIHKGtI6njM8pZL73Ey7TG6Y+KXpX/wrLic3PPnHfsng=
X-Received: by 2002:a05:600c:34d5:b0:4b7:6942:39bd with SMTP id 5b1f17b1804b1-4bb55ab1610mr175771075e9.26.1794784932986;
        Sun, 15 Nov 2026 15:22:12 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571f976esm127920955e9.3.2026.11.15.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 15:22:12 -0800 (PST)
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
Subject: [PATCH v7 5/6] drm: docs: remove bootsplash from TODO
Date: Mon, 16 Nov 2026 01:21:55 +0100
Message-Id: <20261116002156.1027726-6-maximpedraza@gmail.com>
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

From: Francesco Valla <francesco@valla.it>

Now that a splash client exists, remove the bootsplash task from the
TODO list for the DRM subsystem.

Signed-off-by: Francesco Valla <francesco@valla.it>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 Documentation/gpu/todo.rst | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index e6d36f8da086..5e987e18bfcd 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -756,23 +756,6 @@ See drivers/gpu/drm/amd/display/TODO for tasks.
 
 Contact: Harry Wentland, Alex Deucher
 
-Bootsplash
-==========
-
-There is support in place now for writing internal DRM clients making it
-possible to pick up the bootsplash work that was rejected because it was written
-for fbdev.
-
-- [v6,8/8] drm/client: Hack: Add bootsplash example
-  https://patchwork.freedesktop.org/patch/306579/
-
-- [RFC PATCH v2 00/13] Kernel based bootsplash
-  https://lore.kernel.org/r/20171213194755.3409-1-mstaudt@suse.de
-
-Contact: Sam Ravnborg
-
-Level: Advanced
-
 Brightness handling on devices with multiple internal panels
 ============================================================
 
-- 
2.39.5

