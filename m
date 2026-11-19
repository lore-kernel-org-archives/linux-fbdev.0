Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129709;
	b=GBSVH2stmrtIVQQPEM6y5R0y0NB4IGUylLAJZwq9EZ6g3/IHpjCKRsEoGId9KTRwpABd
	 ihZklR6woggtoF4XCMcGxkgCBzROs9f5xMpAZzR5MMKwjhG4qWKvS9WEK7MiMriyqQ9PN
	 FDJUiq243AseF3eW7iHklEzYvGmEgs/DxYDVsbhuy1xyOxCvPY4kvZNGXRPvjoxwE++wj
	 Picg8AqULYsGN3CaYuSpqbB3jnuN6kGXza0sf+yPwNkmu7rIVc0ddWth4u6F7LRvbhJAF
	 jwcUliVjFsMrx523HsDAU7St8mStF+23kf+ExtiUZQPdMd7BAv1yvzUievg9sDnuA/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129709;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=rsh2KTRK/R1JV+vEauWOvFrq+yryhYrhMT+xCpZt2HQ=;
	b=RthezlUQ/B7GdqwxyI5sLqBO0qyKfRljFHsuiWt+yz8bFW+xPuLH8ucsUkmnBxC/Hl08
	 Gf6seyF1nxWv1rucEHeF0IWW+eYIPLThLAyeLuiNSX+mrdGceQkwz3H3oT+w7xsh3te/W
	 I4bgl5JAGI+eGGk/1th7MuRH+shoBat+s/46PNqaua7ZKm22LCF28AXn/TWBG98BsQMoo
	 ofvnFU2Mi7cURfFok+VPEbHy3FcFqMAkEORQK9RcAvjCNeFx/y/3iCwXPjkyx/au1clWP
	 QnVkH4tFkM9+TsgIe9ud3pWeTNJL22VNPAUbQ7+i9W60wU0PWn1j1JIiKA5GV7m/gRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gM69ShwZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0E606A320
	for <linux-fbdev@vger.kernel.org>; Thu, 19 Nov 2026 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gM69ShwZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD891F000C4;
	Thu, 19 Nov 2026 23:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795129708;
	bh=rsh2KTRK/R1JV+vEauWOvFrq+yryhYrhMT+xCpZt2HQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gM69ShwZ/arbn84bjIMfukFnEeCDvit8iwoVhsL9rtfJWJpEQPonZSTIjOPr7Ya21
	 F0hvz7RiQ1c81y1RczT81KaXjaoq4daDW2jPrefHVVf0hqXzes5/qCdENd8fvs6dDH
	 XDAE6u4ASBZSo3gWou2IQ6ftxm/Ys/DL5HaFhp2oBy7UnuGABWHO/bf7iycxKsDWzc
	 vwLcIYdq7CD8kwUQgmDj9smrMLD8Azm+fMAlha7OGCT1uNiNtotdnMXayjc81RXOUY
	 voHghFK3vwByKlEePns3A/8/IoIs/EuwVLQc7+dGO1pXWfBsDL1Kk3Odm3rM6e22de
	 x5mFwdYnUf5Ew==
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
Subject: [PATCH 2/3] backlight: ktd2801: Initialize properties before device registration
Date: Fri, 20 Nov 2026 00:07:35 +0100
Message-ID: <20261119230733.790573-5-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=blum@kernel.org; h=from:subject; bh=X3UfGmDdORzBTTEw5zZD1B0MnJ69uQnII8949ArZlAo=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFn/Gx33q2dHlKjOLZr1N2DBni0zPNoeTymRcznadJ5tf Vn6rn8eHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjAR0w2MDHdnr3ywU3zH9Kj9 cd09P+OvTeaLVtsrnjb5/N1AgyNn539l+Kdgu9KnTLQ/wSkw5p/Kvh9Oh1YWN91YrvXZsWj9pf6 dZ7kB
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

The backlight API requires max_brightness to be supplied at device
registration and not to be modified afterwards. KTD2801 currently sets
it after registering the device, allowing userspace to read a maximum
brightness of 0 before the configured value is applied.

Pass the initial brightness and the maximum brightness to
devm_backlight_device_register() to set them before the sysfs attributes
become visible to userspace.

Fixes: a5554f1b5bc3 ("backlight: Add Kinetic KTD2801 Backlight support")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/video/backlight/ktd2801-backlight.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/ktd2801-backlight.c b/drivers/video/backlight/ktd2801-backlight.c
index c218ee55f253..ff149de36dee 100644
--- a/drivers/video/backlight/ktd2801-backlight.c
+++ b/drivers/video/backlight/ktd2801-backlight.c
@@ -58,6 +58,9 @@ static const struct backlight_ops ktd2801_backlight_ops = {
 
 static int ktd2801_backlight_probe(struct platform_device *pdev)
 {
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+	};
 	struct device *dev = &pdev->dev;
 	struct backlight_device *bd;
 	struct ktd2801_backlight *ktd2801;
@@ -92,15 +95,15 @@ static int ktd2801_backlight_probe(struct platform_device *pdev)
 				"failed to get backlight GPIO");
 	gpiod_set_consumer_name(ktd2801->props.ctrl_gpio, dev_name(dev));
 
+	props.max_brightness = max_brightness;
+	props.brightness = brightness;
+
 	bd = devm_backlight_device_register(dev, dev_name(dev), dev, ktd2801,
-			&ktd2801_backlight_ops, NULL);
+			&ktd2801_backlight_ops, &props);
 	if (IS_ERR(bd))
 		return dev_err_probe(dev, PTR_ERR(bd),
 				"failed to register backlight");
 
-	bd->props.max_brightness = max_brightness;
-	bd->props.brightness = brightness;
-
 	ktd2801->bd = bd;
 	platform_set_drvdata(pdev, bd);
 	backlight_update_status(bd);
