Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129712;
	b=Dt40J2wLQRaywv3qPeYoBSfusn7//4U5GQyecwvTKG81y8TY2WnXzlEKoNitVF+c2JFN
	 bRMU8s4y4evjMuHED1cb9Um3KWUTQ1D9rGRnMSSGW81xnMJQJT6f/IjKRNcatOUh9fZIk
	 3yzNdMtyCRoiMdhs8JYjMVqrwUFQHFJXyo+WZ0OHP1Jezh3TaUqlvAAdQXu1TeKC2lCGm
	 2YVbN4UlPKpqvd9LMAyGpVPkMfJLukwTPrzDqfCDvvZfCGg+TYDDWIqCqSZ6pD0iOI0PP
	 61kxjAnOJgmM6NgWpgWfRnbDRaXbWQcTWqMmeY6hJ2KcaauBcenC/+unm8+0+qFIcjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129712;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=/4ysHwOj9VyNsiUkeERM0UMTiX4TQ0JEpcFVqMbAzVc=;
	b=LvOApjJYNEl4hnf4u3RQWIhF/yavat2i5oLTEMlg5N8e/dI1qRSOyn5nxsiMNbcpZ3MK
	 CzZ9TGjSbxhhhCHfDXLmulX7sbsXU8HrTIl34iqh4YK0VgzjsLdlXNlSyMNpc1Hh2Ismj
	 7/5U5PwSLHuEgalFeobU7mVMU8pApKnChv1CXfc2LlzQCC3hQGZSz7CrhKJi7vt0M4IBV
	 7V3bSFLLFOCeV3l2BVCY8knwzn1+ybFVX7RF0Cj2LYdeu/yKdccCtpB1fQI2PXsb6a6J/
	 HKsYYLYiGoxEG4uEuuoB+MJaQxwcL8g6Oxe71hd9HbiRDESIR3jmjqFgK4WKbwUa/AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOeFQGVf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214F2606A320
	for <linux-fbdev@vger.kernel.org>; Thu, 19 Nov 2026 23:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOeFQGVf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810A41F000C4;
	Thu, 19 Nov 2026 23:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795129712;
	bh=/4ysHwOj9VyNsiUkeERM0UMTiX4TQ0JEpcFVqMbAzVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OOeFQGVfjT9fXHkU3z9rMAFNgieke927Bp8pXweMlaOonJrcMn+19Ty+8QI8IiOIq
	 Qku3QhtUUsie9bahOs4i/uuMajM52rRgKKNBT+ZoScAyOHnal/hhEz4ccT+8iqvLoU
	 slkwfPKSsPBOn/au110C5Q9bmjmGmqEsWOsEa5+WL/ULvEQErbHnwzTc4Qw7czKp6o
	 t3S5eExiq6oy6oVf2d3lDG8QCFycnS54HT2xZrxDKNPhUQQtBatKkVixiUrTMjgCVU
	 xaWUN5D/SOQI47PZcu2eOhJVuEBcIhVGv42g/w5LiIPDlJx+W/eovCfOxuSrn/U0s1
	 36zFQ1ya6GY+A==
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
Subject: [PATCH 3/3] backlight: aat2870: Initialize properties before device registration
Date: Fri, 20 Nov 2026 00:07:36 +0100
Message-ID: <20261119230733.790573-6-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119230733.790573-4-blum@kernel.org>
References: <20261119230733.790573-4-blum@kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247; i=blum@kernel.org; h=from:subject; bh=tIXedyEHnkZ5OpiowWhKTFKxlhiNKzcv6ZOqLCNmbXU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFn/Gx3nLhe8ceJ9feT7jlOGr48tSnvnYhSar+DyKyHx7 mJfRs6sjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjI/wsM/wvL1p6eLufZ977G XLf5y7s6x13/Mzy6J3r+Cw1nnnK67STDfy+zQrteFfZazstvImSKM3bOTFZy0+I8svLhu8MfeX+ tZgQA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

The backlight API requires max_brightness to be supplied at device
registration and not to be modified afterwards. AAT2870 currently sets
it after registering the device, allowing userspace to read a maximum
brightness of 0 before the configured value is applied.

Pass the initial brightness and the maximum brightness to
devm_backlight_device_register() to set them before the sysfs attributes
become visible to userspace.

Fixes: 4b0d711be39f ("backlight: Add AAT2870 backlight driver")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/video/backlight/aat2870_bl.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 5af36d3784f1..fa854827e558 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -99,7 +99,11 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 	struct aat2870_bl_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct aat2870_bl_driver_data *aat2870_bl;
 	struct backlight_device *bd;
-	struct backlight_properties props;
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.max_brightness = 255,
+		.power = BACKLIGHT_POWER_ON,
+	};
 	int ret = 0;
 
 	if (!pdata) {
@@ -120,9 +124,10 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	memset(&props, 0, sizeof(struct backlight_properties));
+	if (pdata->max_brightness > 0)
+		props.max_brightness = pdata->max_brightness;
+	props.brightness = props.max_brightness;
 
-	props.type = BACKLIGHT_RAW;
 	bd = devm_backlight_device_register(&pdev->dev, "aat2870-backlight",
 					&pdev->dev, aat2870_bl, &aat2870_bl_ops,
 					&props);
@@ -148,14 +153,7 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 	else
 		aat2870_bl->max_current = AAT2870_CURRENT_27_9;
 
-	if (pdata->max_brightness > 0)
-		bd->props.max_brightness = pdata->max_brightness;
-	else
-		bd->props.max_brightness = 255;
-
 	aat2870_bl->brightness = 0;
-	bd->props.power = BACKLIGHT_POWER_ON;
-	bd->props.brightness = bd->props.max_brightness;
 
 	ret = aat2870_bl_update_status(bd);
 	if (ret < 0) {
