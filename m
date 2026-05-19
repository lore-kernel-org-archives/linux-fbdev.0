Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD423EAB7
	for <linux-fbdev@vger.kernel.org>; Tue, 19 May 2026 00:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779150993; cv=none; b=C2rGEiXktBMVjKRUj/6gv/h8Zx+rRXYsrtMWtWQd68424X53J0rISc/4dD0XTGsNVKOJeblwJw2zJzT8B4qZtxel4kbpDl1Zei4h3sIRojMhOnmkRlF6HN2XAOiB7tv80VKm/PXIqMEe3vOdRuE9mSz7P6qpc/NQYbSRz2uWIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779150993; c=relaxed/simple;
	bh=qfV2GMXwHI1BJq1nSZ+HGs00s2U/3CrqGIAvEgY+jNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PEPQSXq2RL7HTX4rt09S5WPv1WJB61LPYtav99CqX6u5LytF5bbipXfg1Cd4UQ3paM5W9T0pdH6JuB+EXnxt92tebnpAqsuzBdm3oHpUrdFWeTyuiv1k6yd7Fxe8Aqpw04+Bepd1OZN/c7BzVuOHZIpqIPF9ZU+tcHaSV5LFxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNDY+RkI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNDY+RkI"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c8095d7d75bso1028503a12.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 17:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779150991; x=1779755791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zIbP4h9WDI9+Yz7sY4YHYJ+etVo6kSOqTkbaLsufTQ0=;
        b=oNDY+RkIXB0Ub+/77VfzNlGKFMhgK5NPcOsHDKSK1/DLHy4TqXbmyk9YlI5qrI8hIx
         NKyZTdWjlqZ9jW0rgBOV2wcoer1vO/c30Sp70F/qXHco+jsz1ToatruEk4yrVbr6641t
         wB3jgynKxUKNv1OO5QcXwSM9AWjB9kIrtWu+e0fYA6ND+EcOQNMt3KRr5ZpM1+vHN2bP
         Yr5smMoJ960ZcYPw/tamFzXmk3nKenFUh2E92NaXbbySUq6mm3JT5Wy1yYAW6CrIMLIq
         qun3F7qeJXj4wPctcCxT02/6Ng26ST9szSvbuZpk6h5Yj6RoemWH7N/OqBUPASdlDnnw
         kEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779150991; x=1779755791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIbP4h9WDI9+Yz7sY4YHYJ+etVo6kSOqTkbaLsufTQ0=;
        b=Zcots7/CMzCsaM/eYFmG+MI2j/yemBVPdj+DlvuZMm5dTdCraGNwPIR59I9ihyXRMN
         4i0nTQJEbgNv0PSIT4+lB8GdaKv4febK2Mse7kUImg893Wq3z/bkdj8ibHW5TmT4dab/
         VyKP42y/AyH8gYZs5MWsS2IZvSkEleQfWuOMAjH0Z0CYCKrzp8M4wVRqT1v5YCWnXJHm
         UUMk/kENiXPUAl2l/3e+ej5GbrhGBiygd6dlDYA9aRBzpzVvW6k98j1tP4OWcCAeU4xb
         cKltyYpuAAIyX1j6zuBUoTg84TvzpsQ2SVG8iHwn4axMjGtI6iabtvI/75kaGxiihuHe
         nmBQ==
X-Gm-Message-State: AOJu0Yzx8rqChn+ZB7S3IhBRATKM0u6B2Lyy7urttEYUveK0cfu5kWuh
	Mx5tp/6x9XFWGDDiO9ckzsXPiA+u1IijWs9k/xIgaz20kBjL9DhEM860k+jn7ty4
X-Gm-Gg: Acq92OFDLb2VJ6ff3dqwLBMqdRvw4JNnUL6lLAdtl52BaVwVedFjhrxhWAROjIwqeaw
	UVwtjkP4uElo/rPN1dIrwisw5gBDgybPUTXEl8n7OK2HW/ZNVnMO98wG5//H2APeKaUtHgJm33h
	FCiouMrEjcxKqz4tXQdqpQFjIW1gO3/jux070aSWw5YgtHSfAVW30Ajav2dJdjHJ2yeqKyrwB2R
	04RDFHxfnszYu11/dbo5GQuTT5vJTFAGhtccA5EyVj2dERyTQss9e9SKQbANtH+vUPNDokq9+R9
	JrR7xOZD2Pazvdioi6ZQUGCdKP32sS5C+8trE5/7S4tM9yJE4Ela5Q1jKRGVFfOTgzvG3ndZGf9
	U7+8qqAdurc4PLFIK8Jfll0i7xz3+fnm9MGw/s0W24l4RKUPPooAoC9FW8v+n4WI0adHs1JapbN
	lU54HEefS6S5IhKA5acCHkKE0uMzOH64iQ+kxBnBaNCi1S9twrzrZ9vkhzqdhgHirEzJYw2PNAl
	KMEs0xngow9hn4NIBqSrEfRmnGQEH0SAcY=
X-Received: by 2002:a17:903:2ce:b0:2bd:6cab:85d with SMTP id d9443c01a7336-2bd7e782281mr180580205ad.3.1779150990945;
        Mon, 18 May 2026 17:36:30 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe6b8fsm170619925ad.46.2026.05.18.17.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:36:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Helge Deller <deller@gmx.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	dri-devel@lists.freedesktop.org (open list:FRAMEBUFFER LAYER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fbdev: atmel_lcdfb: Use of_device_get_match_data()
Date: Mon, 18 May 2026 17:36:13 -0700
Message-ID: <20260519003613.626271-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_device_get_match_data() to retrieve the driver match data instead
of open-coding the OF match lookup and dereferencing match->data.

This also removes the deprecated of_device.h include from the driver.

No need for NULL check as every compatible has a corresponding data
component.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 9dfbc5310210..87406a5a2dcf 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -21,7 +21,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <video/of_videomode.h>
 #include <video/of_display_timing.h>
 #include <linux/regulator/consumer.h>
@@ -56,7 +55,7 @@ struct atmel_lcdfb_info {

 	struct atmel_lcdfb_pdata pdata;

-	struct atmel_lcdfb_config *config;
+	const struct atmel_lcdfb_config *config;
 	struct regulator	*reg_lcd;
 };

@@ -930,8 +929,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	int ret;
 	int i;

-	sinfo->config = (struct atmel_lcdfb_config*)
-		of_match_device(atmel_lcdfb_dt_ids, dev)->data;
+	sinfo->config = of_device_get_match_data(dev);

 	display_np = of_parse_phandle(np, "display", 0);
 	if (!display_np) {
--
2.54.0

