Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3248319B5A7;
	Mon, 24 Jun 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243055; cv=none; b=Tv5c0n79h3Ringl6TYuJF6rxomBEP25iAV8r7hLnTnbmCyK8ahzu6IFjngtTGn+jGAnDcrG8NTsAV3zp25bklOIU3lFX157OLjH8xdqExL0ip21ujf/7KRc63i+jgcZBhsn6V/shTiAYuy5350WRDq5h/vHvFoz0LjExCRDl2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243055; c=relaxed/simple;
	bh=Jkeimj0HklVuSImq8IB7VcmxLmbEpZozN1KItY60wHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Xz6tv+5Hpr+JdX2K1KWJKMYqBjDpzg/NQ5adA7gxXhWcpIlZzWMLTiebCA8gBHblGtFqorG7fWDO1ved1ePPD/LH8+8EOybX2bKy4ecITKHEhUtWPxNKtx5sabr14wyQc4zjl7qleuB8xJtxihbZYtQIOZOlV76Zv3A1HHuH8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NY/QOOtA; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NY/QOOtA"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-366dcd21604so1685982f8f.1;
        Mon, 24 Jun 2024 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719243052; x=1719847852; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Wh7xrbjfwGsyfIEZVLHT3Izn0pKIYJ7wtYXXb68AeA=;
        b=NY/QOOtAcIJ5OFg9GJBfzUu0H2l1o78byHFCtYf5Ca55Mr368hALMqz7mYFVqEbeRW
         LpbXUGQ8Xn5pCPcpOTDygrf6txblJsDWxJZFyOmfbz/0ZKCQyzF1bvfmCzsu31w8hGN4
         OXdkEB9dBLtQvYK+OfdfM6Q72C9XWpuCQEhsEreHz5dAY1YkWCK77NvgAmkBnMD0LRBO
         E7xMww+IwlOSIDM65d0Va9Q3F/0sGKdn1sm0U5gKULEijpo3XNmrKNIjJRkIpIJjPWwK
         cuK73LLsFtflyMhYSeEU/FfJ1FHrMUcO5VOt3SHmuQX8D2bPIr2JVaZXFBlPxLnFTyYK
         9eoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719243052; x=1719847852;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Wh7xrbjfwGsyfIEZVLHT3Izn0pKIYJ7wtYXXb68AeA=;
        b=J2sfRPhzDSjo2vUwji1/bVsUCu0WXt9sMPJoVCz6K8ce2A2bfpidkTKIJ7mZDSxKJj
         ez9WdUYaiAjkLf3ivZguCMiVjI9SROzW5yd9PMkjRhSU9sspJjIjGUvnOhWDieKRhZHz
         chfJsURen4tyCBj16/cew0uAOTJO6Ees+GJO3xwwfps0JiEHmM2F//ah0XeiDPoK1+jq
         nfCTMjBmzl8i2jbLNDfpx5cyXmCbBRxlAm3YWVjbi4uoJVnucRs17DLtXzjAtpcCDY2X
         EOui1RwGr2i3tE9bBzTT0O2m953BZjt6El7oiMuuYJEUSzmOjX+sKJ1/9l4C2QEtIzo5
         cK+g==
X-Forwarded-Encrypted: i=1; AJvYcCXWDID5nob8HRZ5ZHDtSyZrT0FS7MmkPvx/gwqePU+kgwgYxGX0NctbrP/CobFSoLd1dtRlOgSLPB68FiOy0r+qfOgr/Z1oVAgd4QRQWTx6UcCw6jvMZZcL/P1B1BGkjaUax0r8zra2vxg=
X-Gm-Message-State: AOJu0Yz77/hqSwgiQm2B4gkUP2IZ9jQdz6UFxiqVBOmIifEPBbUO7jPu
	YdmcmfrOc53q2V9/23TcbEMrj4WpCXH9q3426pGGN+C93F0Te8WZ
X-Google-Smtp-Source: AGHT+IHupmj7SCP4Ewzmje7FjrNNDa0FXZUj53f7H62eDvPdjfYU4zbcbpHiI4rU495sq99AOfQkuQ==
X-Received: by 2002:adf:fe83:0:b0:363:341:1cf2 with SMTP id ffacd0b85a97d-366e7a1bf24mr3680117f8f.22.1719243051993;
        Mon, 24 Jun 2024 08:30:51 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f65bcsm10300418f8f.13.2024.06.24.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:30:51 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 24 Jun 2024 17:30:50 +0200
Subject: [PATCH] backlight: lm3509_bl: Fix early returns in
 for_each_child_of_node()
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-lm3509_bl_scoped-v1-1-ceba9df38f23@gmail.com>
X-B4-Tracking: v=1; b=H4sIACmReWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyMT3ZxcY1MDy/iknPji5PyC1BRdc1NLC+M0cwOjxNQUJaC2gqLUtMw
 KsJHRsbW1AMX6te1iAAAA
To: Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Julia Lawall <julia.lawall@inria.fr>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719243050; l=1581;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Jkeimj0HklVuSImq8IB7VcmxLmbEpZozN1KItY60wHY=;
 b=dLuEs9T9Fo7tpWo0a2PCCOune3MeuOXpQnuPNcFgGP/8HLubrH5V+/hb65u77OmE18D/kkEUv
 dvDLEsZbEFgDtOpUEjJpH8cSXjKhih53IfobyhxwhHWOKeHvu0f7wWc
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The for_each_child_of_node() macro automatically decrements the child
refcount at the end of every iteration. On early exits, of_node_put()
must be used to manually decrement the refcount and avoid memory leaks.

The scoped version of the macro accounts for such early breaks, fixing
the early exits without the need for explicit calls to of_node_put().

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202406172314.2vVgelaS-lkp@intel.com/
Fixes: b72755f5b577 ("backlight: Add new lm3509 backlight driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/video/backlight/lm3509_bl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/backlight/lm3509_bl.c b/drivers/video/backlight/lm3509_bl.c
index c93cdedff5ad..7a36f5c08640 100644
--- a/drivers/video/backlight/lm3509_bl.c
+++ b/drivers/video/backlight/lm3509_bl.c
@@ -157,10 +157,9 @@ static int lm3509_parse_led_sources(struct device_node *node,
 static int lm3509_parse_dt_node(struct device *dev,
 				struct lm3509_bl_led_data *led_data)
 {
-	struct device_node *child;
 	int seen_led_sources = 0;
 
-	for_each_child_of_node(dev->of_node, child) {
+	for_each_child_of_node_scoped(dev->of_node, child) {
 		struct lm3509_bl_led_data *ld;
 		int ret;
 		u32 reg;

---
base-commit: f76698bd9a8ca01d3581236082d786e9a6b72bb7
change-id: 20240624-lm3509_bl_scoped-75983f702aed

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

