Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700162;
	b=avaxqNjtqMBgSngD9o+le0RJXZanNI1hnvtmUXOx3PJYGjZVQYMjqdYJHOrzP9K0lSV1
	 o8Z4KK7HBUV+lbVUoql4B6ZfbZpRDuDhzCjVirRyO4xNcjDQceN/HoEBCIhVRMzzFpr3F
	 CK2E3d3akJq9SMF80o3rnl8Sv37cWkYiZ8lOCgcgro5WFU9fe5hdqazdBkFpgPIlxqN3q
	 JnMJJQo088efqwdhNLMbWeiNgbcb4YIk8NC9XoMkh0NeriJRkd2q7rICY7xEIF+w1uwbv
	 l0KeWRq4F79CdXo6eyStWEJPBrj9qDO4fm9mJMwRz5NXAM2q056VzTprokMDf54h04A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/L59GtHvh66Qoj8GKGfFbB0DmYWNSBlgqJLSXZ9x1vs=;
	b=osMsFi/vFv/+6N7uQCGssjvVB/UqPuQV+6OkhcQdJLYLSBoJ0cNL4N4Vs4LIWEGe47qh
	 pCxptgekHSvQvPvxtHz8PWmTnpTopMiYML7F36M8fUzhLwePi6Mm1tdRxnJQGKZSBErki
	 +svkcKZYjf9GK+kI7sR9dp/+CvRw4eaEJqLW8jUZ/FYTcTo4eJttZtDz4Wl4xk7SxR58I
	 HWmcu68brNAKRLJr1KSwhMBAxhgpoOWa83PLJD8vOgY8B9cSwe/OYSZsoySZ9sujjigLa
	 q4a9SIC5Mu8IEeCQ6jZ5q8Vq9XFN7ZJl4F6biwgNptGnF684y11TkzA4EVtopASMy+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWImdMzU;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B31B606A31E
	for <linux-fbdev@vger.kernel.org>; Thu, 26 Nov 2026 13:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B31B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWImdMzU
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3b41e627cadso4377258a91.1
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Nov 2026 05:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795700161; x=1796304961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/L59GtHvh66Qoj8GKGfFbB0DmYWNSBlgqJLSXZ9x1vs=;
        b=lWImdMzU1KImNUW8qT4asW+bHXqUn/R42L3XAwMpWQ3IPo5nIwxl7dT+aYhGDrk90w
         dPRT9/EbY3LZTjrvRDT5e4JGuPjxVbaal0c+tDOnbjcKJPSb1g7Ba5v+AGqB6GAzQqCZ
         xfDaaqKkYWNxWwKfh6nYVT8vpM1uiJPTWdBtkQMFTZyXz0eiFnmQ2aYuylpfL8qpSCrC
         nyLpGlczhkJ3RM2zQNzO/MHwj/QoiBfAXSroJN/jkfiqbW1i+WoRQAorXxlyX/1gpVcr
         DnRPIgx/KjjHp29vJ06+ecFXMUls7vGR6myfrE9FUJm4T+r20eGWLOnVHYYM9h2ocZ48
         pwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795700161; x=1796304961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/L59GtHvh66Qoj8GKGfFbB0DmYWNSBlgqJLSXZ9x1vs=;
        b=NovD9K/rZkWjsT2egOTyu+bpbpJWl3b2ngwDdFG+APKg2rkRkp99emK+5iwW10fD1I
         njvcweR/uw1FXp1MyjdyQWAfwLNtV4nTRtO6GmguNxM0d/KVeKWrRs0qEXwv72fL9oiN
         iArAVyfavDERIvF6kGLQzCtRPDQfo4sFb0tLPyldFVoNUBOwY5koybgnfpDxiK46pWY2
         mkphQZUYkIBkKLrEjfVhD42WbNuzwj6LBTze/jR8P2sOgwjb53GQ3b0VraJZ4i2RqSI9
         i+jm1ps8ZCKY+cgdefD942sgiaIdqCn4jaUE48sjmoQKjcqu98iBcuB1v/DmlVh/vukp
         ZUHQ==
X-Forwarded-Encrypted: i=1; AL+hErFOV23vREFGJ+CZiMHgjmGYSWDgTG6X3sH/z1RaVFc7x3yfN7+BlGGMTNuf0hGLFqXB2kh8ev9lsfn6lw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/RAGK1rWtBR4KiDDEcqeCE45B6POtgyC7spgXnE0jCJYSMcME7
	VbX9LFL/VY+lg8NmMKla3UX94elquxyQqtjj9dTkmmvsS+mvW77E/u4=
X-Gm-Gg: AZFdTZfuYWVMvbTGUz7+fw6BmMy/hJCvUDRlwv7sQVJ1hVd2mjtfzgL8H871YzlrOb2
	bjZ3hH/oqpofnvmHzEsfyo/8j1iSZ0Z2xEjvCFlYnt7Q8bSoSwlG9VosiFOlNeuOBNPZHnSNCGp
	x0rgt3eadYZDEbQAAOpZvutDG88Hc4CEQV1PPEw7Jp9ovjBIaJDPhf/3NtbvPprCUnwTw0v3rxt
	VKRI0GsWLp30nhG7YC3Seq/AEwMA8lkpQLjGKppoPZr5Qji25/Q7mxmmVVb1eHyzpuXWIqH3kvm
	+jTG5YoTn3UtDWeS7FwibC0bSRX7XfagvCn7mqEAHbQ6NUqOEwlWdGgWwWSOEl1qDt3YRn6+rky
	iokdmVcguMK2FDUli82wCORu/n27RtzajC3htdr1hjXAcVgCi0YRjqevXzVogB2O4lwpYah+RVY
	PQWL1LCUP+RlA+VwC0w2azlgBY3Nad91CEU6tzGaY4MwqtVGN1N0St9/ricOnXDILza/c5qBpqM
	akrr1JplO9gTtafRSjFnm8uZ5Fx9wB0YbtpK9SiMUWFfONgd0qpZSQ/pMZTEhMgdQmxJESDaqSD
	dRZwKQrKyTlbGioY91z6Ly1wJ2elmXmAnoRoHnjsOkOlaUJiLPCPxQrMqKJ8yc9t+PVPnXTm/br
	h44i8UdimexEZ
X-Received: by 2002:a17:90b:3e81:b0:3b3:ff66:4097 with SMTP id 98e67ed59e1d1-3b41c92a1cdmr18216781a91.26.1795700161363;
        Thu, 26 Nov 2026 05:36:01 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a06e:23f:85ed:4cfe])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fe711sm14480336a91.1.2026.11.26.05.35.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 05:36:01 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Yige Jiang <yigejiang86@gmail.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: ssd1307fb: release PWM if panel initialization fails
Date: Thu, 26 Nov 2026 21:35:56 +0800
Message-ID: <rc-b1-20261110-vc-112-b07bbe936b75@gmail.com>
X-Mailer: git-send-email 2.50.1
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

On the SSD1307 variant, ssd1307fb_init() gets and enables the PWM
before it sends the panel init commands over I2C. If one of those
writes fails, ssd1307fb_probe() jumps to regulator_enable_error, below
the pwm_disable()/pwm_put() at panel_init_error. The PWM is left
enabled and requested, and its references on the PWM chip device and
module are never dropped. As the PWM stays marked as requested, a later
probe of the display can no longer get it (pwm_device_request() returns
-EBUSY).

The sashiko AI review bot pointed this out on 2026-09-26, while
reviewing an unrelated ssd1307fb error-handling patch.

Jump to panel_init_error instead and drop the now unused
regulator_enable_error label. pwm_disable() and pwm_put() accept NULL,
which covers variants without a PWM, so clear par->pwm when pwm_get()
fails instead of leaving an ERR_PTR() for the error path.

Fixes: bbc79089ae2b ("video: ssd1307fb: Add support for SSD1306 OLED controller")
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263%40kernel.org
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261109 (630059a5a632).
Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_FB_SSD1307=m, CONFIG_PWM=y, CONFIG_COMPILE_TEST=y; baseline and patched ssd1307fb.o, no new warnings.
No hardware or runtime test was performed.
The path needs an I2C write error during panel init on a solomon,ssd1307fb-i2c device.

 drivers/video/fbdev/ssd1307fb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index ef4bb920c6ff..dbe5dc67e044 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -403,7 +403,9 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		par->pwm = pwm_get(&par->client->dev, NULL);
 		if (IS_ERR(par->pwm)) {
 			dev_err(&par->client->dev, "Could not get PWM from device tree!\n");
-			return PTR_ERR(par->pwm);
+			ret = PTR_ERR(par->pwm);
+			par->pwm = NULL;
+			return ret;
 		}
 
 		pwm_init_state(par->pwm, &pwmstate);
@@ -794,7 +796,7 @@ static int ssd1307fb_probe(struct i2c_client *client)
 
 	ret = ssd1307fb_init(par);
 	if (ret)
-		goto regulator_enable_error;
+		goto panel_init_error;
 
 	bl = backlight_device_register("ssd1307fb-bl", dev, par, &ssd1307fb_bl_ops,
 				       NULL);
@@ -823,7 +825,6 @@ static int ssd1307fb_probe(struct i2c_client *client)
 panel_init_error:
 	pwm_disable(par->pwm);
 	pwm_put(par->pwm);
-regulator_enable_error:
 	if (par->vbat_reg)
 		regulator_disable(par->vbat_reg);
 reset_oled_error:

base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
