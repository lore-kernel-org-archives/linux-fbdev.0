Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129705;
	b=iuby33blaO1vJzH8nDNmhn+5IuZYO3pxyg/iC8ICZbdGzIR8OUjaXIuyZB9xCsMPijOM
	 unEC1xCV8E62b5GYEh3LAPVeyYdKiF41RJ25vbCKPqvER6s2f5jHnazCWV61VniQkGr2R
	 sTqgZWWNuaxsNj9GhJyqk29Rlqc/QZRsyLMXBbj7JBqh6ve2tzAgo1aJkOEzVqsv810+J
	 VBsw2Mu9lIjDKlJWxb2094mZhYy8KpHKVsqCA8yo9ujVPAvY4V2bAqpV8CUp5Qj8MCAhQ
	 njxZZwyw0ZIvJ/dy/fLcBYFC+RKrsd5/XnSOUu/HuePdywcK9FqCBuhJSxjcire0q4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129705;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=BmejuJqQk1LKC4c2xj88W9TXrHdHdf5/PDc/zgOa/LU=;
	b=V8GcEyWz93pBQ5Dc9ZUGlsY7eqtN5eQ92GVAYWvy9hSdDL66qGZIcC4XXcalmpoA1iyH
	 eFwoeW3c2OQrXqL49tCWesCvoqOPnDmLfsK2zH3sE7YcxO0SNqfJdtvsmOLfEOrvkGw5S
	 BdIZVHsGjRv2UO0kx6jvr+kq2UtNGhMSWBPimStNehT6DA31LxxdsCf8ge06R9JR5u4rj
	 SaLZIOc4fCvm+AR9kDK+5vWD+06Fr32lqsY3RMGZPKsWhkcsmV43Nd7CXA+Ko0NysClAY
	 jULXkxegjbsXrUBWzYHK6ob/ck45erlPbSO2VazjsmG2I7HhgvsYrcciQf8Jls1yDXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F53/0xTQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92417606A320
	for <linux-fbdev@vger.kernel.org>; Thu, 19 Nov 2026 23:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F53/0xTQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA5B1F000CA;
	Thu, 19 Nov 2026 23:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795129705;
	bh=BmejuJqQk1LKC4c2xj88W9TXrHdHdf5/PDc/zgOa/LU=;
	h=From:To:Cc:Subject:Date;
	b=F53/0xTQ1j0y4T6PYC35h/6uVrH5WC13zbOZv/IgUKR4i1AkStM6Pdeu1X0Bt0beo
	 zMRxsJdjU7wFy3bkP8cWM3DEZhP6UvC9/xfUn0SxDJQtd0Mz1cK/ZMjIkxLwjAliPI
	 LOKEFwZgT0PMuoau5A11r1vKOGawDbLJjreopqkXOgbdlB5wGqJ/CorAlaqdZx3f/Z
	 L+kTBzAd/jsvYKwx/7FhnziTHqFK4oARdcQMP8mNq03NkKFFlaPKHkFm7N2IoV5yUA
	 tHegfdxJY+MyzIIitm6uHMbJfcUeB6XskC85MW7AQtRttDIWNWOxYfbBYEZN5HxRlF
	 sJSM7RiQv4G9g==
From: Thorsten Blum <blum@kernel.org>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Linus Walleij <linusw@kernel.org>,
	=?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Jin Park <jinyoungp@nvidia.com>,
	Samuel Ortiz <sameo@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	Thorsten Blum <blum@kernel.org>
Subject: [PATCH 1/3] backlight: ktd253: Initialize properties before device registration
Date: Fri, 20 Nov 2026 00:07:34 +0100
Message-ID: <20261119230733.790573-4-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=blum@kernel.org; h=from:subject; bh=kc5+O90pUjknLmYeQlBUB9W5BSzJMr1ZVMWcsFX/mfI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFn/G03j/6tXP774e908h9d5Cn0SfH3n/XkWmoWsr3f79 3qFzCfdjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIzM0M/1SVO60a0+Tez+2M /zatNrBBdVUIU/TEyx3MPnX7f0su2szwv67I5W7xopqTZb/nfovf6M6+eJFAn+vlhSZFHLveyRm xsQIA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

The backlight API requires max_brightness to be supplied at device
registration and not to be modified afterwards. KTD253 currently sets it
after registering the device, allowing userspace to read a maximum
brightness of 0 before the configured value is applied.

Pass the initial brightness, maximum brightness, and power state to
devm_backlight_device_register() to set them before the sysfs attributes
become visible to userspace.

Fixes: 5317f37e48b9 ("backlight: Add Kinetic KTD253 backlight driver")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/video/backlight/ktd253-backlight.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/ktd253-backlight.c b/drivers/video/backlight/ktd253-backlight.c
index 8091c7e085e8..5fc29c858a4b 100644
--- a/drivers/video/backlight/ktd253-backlight.c
+++ b/drivers/video/backlight/ktd253-backlight.c
@@ -141,6 +141,9 @@ static const struct backlight_ops ktd253_backlight_ops = {
 
 static int ktd253_backlight_probe(struct platform_device *pdev)
 {
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+	};
 	struct device *dev = &pdev->dev;
 	struct backlight_device *bl;
 	struct ktd253_backlight *ktd253;
@@ -179,21 +182,16 @@ static int ktd253_backlight_probe(struct platform_device *pdev)
 	/* Bring backlight to a known off state */
 	msleep(KTD253_T_OFF_MS);
 
+	props.max_brightness = max_brightness;
+	props.brightness = brightness;
+	props.power = brightness ? BACKLIGHT_POWER_ON : BACKLIGHT_POWER_OFF;
+
 	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ktd253,
-					    &ktd253_backlight_ops, NULL);
+					    &ktd253_backlight_ops, &props);
 	if (IS_ERR(bl)) {
 		dev_err(dev, "failed to register backlight\n");
 		return PTR_ERR(bl);
 	}
-	bl->props.max_brightness = max_brightness;
-	/* When we just enable the GPIO line we set max brightness */
-	if (brightness) {
-		bl->props.brightness = brightness;
-		bl->props.power = BACKLIGHT_POWER_ON;
-	} else {
-		bl->props.brightness = 0;
-		bl->props.power = BACKLIGHT_POWER_OFF;
-	}
 
 	ktd253->bl = bl;
 	platform_set_drvdata(pdev, bl);
