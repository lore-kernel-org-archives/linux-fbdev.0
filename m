Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B9B1DFF7
	for <linux-fbdev@vger.kernel.org>; Tue, 23 Sep 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617038; cv=none; b=bkbDGhh+fIX32kpRrRTd8/1IxuWmL/6p1P2+evn2tMM2bOn0jpFnB2Un1GFpHeTudRtyuLGBOAoQ+ZcTRnJI5JG8ZghX8zejP4TuQwy34oigQFsZ/OcZwVTLdkv9Wc1v8VfO6Er0mE+R+ygIrOGbgYQkaOL8vXnRbFWoIzgHh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617038; c=relaxed/simple;
	bh=gy4uqxOCIGLwvs84h8NOCEWXZqQgcCRkqfRUYk238eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpbSZkR8YXVMsSK9HJrOHqqSmL1wwetXcMKJeJ5nEsHIBtdVFQG/ghpmSD6ngzyZdkK871XFn5mUy645BXwJ71S6/hZvmhDdYhmQ3NAWWigYutnWn0Y6IuzyHTTWL0SvnUth2Bcy2hugqd3kagGXBgEeOju2UiV1pCvIvhR9Ljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEYP3n4S; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEYP3n4S"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b28e1b87aa7so377890366b.3
        for <linux-fbdev@vger.kernel.org>; Tue, 23 Sep 2025 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758617036; x=1759221836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/mGp4D0/N7zj9lqu2hqSY2BaksNmyzuS6a+IwtNsiCQ=;
        b=gEYP3n4SnylJ6HmgLWL4EPmvr6WRgIuhlPf5K2vcl4Ce7Glm/itR9cPjv6/GdXk6Fu
         6H28K+0qOZ5wU0gpHf7O3Qox/eUrk66lozP2EYmY2BPI4u93mundKgwyga3mxoPw5VAe
         EoAs9tPOpiDl5TPDz30VlDU6M4HRBPUkKpGVjr1lNvME5sfjbCppZ4qJmUxqZ0qPxVtj
         KZ6STeMGCfDIH8OiTuQF4fM612dbjNx749DfXj/tYIdcBb/W/4UdSK9xqnp3fX2FDuZQ
         Dhd/jtGhNMHWsYr3Z8vNanPNV7OZogODuY+5qOuQfV1bjDO3mxR9jNEqKXg/lKu2nPgw
         UMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617036; x=1759221836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mGp4D0/N7zj9lqu2hqSY2BaksNmyzuS6a+IwtNsiCQ=;
        b=UB0OXLaITUdp9Wm3xfUqI9p5XW8Z/xjl1bgmo9eXDnika71gRsnNwMF8VPSje3aeHW
         nRwlpSIxyFxBjv+qqWgOjHGOO2cak1LUg1rvnJ2tIVGzXxTqM8PmOhoaz2H3w1BQN/BK
         yPCENzfkCJxgR0kPWdFVWXZ+pJZ6DkdrUTa7xn9e/4RHHVLdhrGp6iavS7n4Ca8NOROy
         cXKo+Alu826dtpd/izONdhKFZ5/Zn6osF9Ra/lLXddk/EkD6S+ciLg0aUkSwXN5upf7L
         NNU4zFZWoVpvySCs4zT1MTXOjHZXTeZo8sKXRq5oEkOOtzY+xCStZaxU1CCrelJj8HnK
         YuqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXomS1R89La/8hmKMuGzurOJ7wBocjRQEOfKwWwk9Um+ILigwZ1PBj+/2gbgfwcHi8mgU7Q/Ymbi7zkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUawIePPLKjbNiB0Oi6R9gkQaaMg7iVrpR3tFZr9Ob6n97SFrH
	RhoB8PSOM9o4SYqlaC77CjOL18HDcVa71InLne8s2DAZhX1Ym4/NXLIB
X-Gm-Gg: ASbGncvROrSarAimcuCNbKmdQdnEWfpDk98ye18ucUGBOzahC8nNeUPwE2/fxl2gHka
	Um/m4JoyDoZ231ajmCGd0JPA+N3D4ldobwBMrrvm5f0p7ZSen6zkT41u5s8IUV6E/1loWctcXi0
	xo2RMTpGVES2VcIBkavmW0xwRetEZmtNYxI8IC6E9n8/4ANDLwn5KWeaiFz08C7/a7fH8J69XJq
	HC4c0p6QSFWXVBw9MKgGIFCFshbUctmXE7qhyl1XGZAZZt6abXRXuEMk/kXc5pkTcgrk7jDhTVu
	i9cQ3coMEnhyFfqLN+Xz62MJjoIz6B9UDV2n6e8T6Kq7IHIxWy7r5DI6BkIWJsBCFaPY3WltMjT
	e6fqshDOkdTikw64mvEzKm0mNdg==
X-Google-Smtp-Source: AGHT+IHZf6TnZmvJ/kWnGmv0GcPcYtIPGdUTBRc/Tnmg6bn8o3PfdZRyuZLiArXHvkr85ZYF6HZWCQ==
X-Received: by 2002:a17:906:dc8d:b0:b2b:62f8:e490 with SMTP id a640c23a62f3a-b3027a4ace6mr168920566b.27.1758617035386;
        Tue, 23 Sep 2025 01:43:55 -0700 (PDT)
Received: from hsukr3.. ([141.70.88.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b261bdfe8d2sm943936766b.58.2025.09.23.01.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:43:55 -0700 (PDT)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Sukrut Heroorkar <hsukrut3@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER),
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Subject: [PATCH] fbdev/radeon: Update stale product link in Kconfig/FB_RADEON
Date: Tue, 23 Sep 2025 10:41:50 +0200
Message-ID: <20250923084157.11582-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous Radeon product page link was no longer valid. Repalce
it with the current working link.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c21484d15f0c..3037455adf48 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -949,7 +949,7 @@ config FB_RADEON
 	  don't need to choose this to run the Radeon in plain VGA mode.
 
 	  There is a product page at
-	  https://products.amd.com/en-us/GraphicCardResult.aspx
+	  https://www.amd.com/en/products/specifications/graphics.html
 
 config FB_RADEON_I2C
 	bool "DDC/I2C for ATI Radeon support"
-- 
2.43.0

