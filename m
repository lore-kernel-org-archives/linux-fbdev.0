Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2A630C15E
	for <linux-fbdev@vger.kernel.org>; Sat,  6 Jun 2026 04:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721907; cv=none; b=cgVsKaJOGqcwVY+BoibGCBacZGexlfYZYg+kqsX/tw/WMqDZ/hNOpHfjAx1qfwMqnfRgBq4eASA2ba6Yy4XGZshx8wk/+CC2uupEwXv4PO+8CJ5YQGFE5Le/P0gHJyrTA42d1QaXLuKk0F+c0vMZugukmxpS62d/A2T0LX+S2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721907; c=relaxed/simple;
	bh=O+IQDDaskjpiY9H7vh3SwWeHCbOSEhzjDI8laqLbRkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEP0UT8N8b0VEZp3kSe3DqN2zXnrYOhYatFa1kScaHfXjz98bLX3r6Rv/FkdjG7VxTYlTa55oqz0pVIhHw6a7avOMXOEDEGRGINm+BUpSKNvwNnBqHHasozLyakxMBOdGNMMtQW4H0+iEEiSd3RZ6TETwMIuIFLyWC6seUJbseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E49JGrj4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E49JGrj4"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so370079266b.2
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Jun 2026 21:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721905; x=1781326705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN9wV+nrusoIiZXpR2QbLHADEoHUVVuow5fDPzDOfKY=;
        b=E49JGrj4Nx+Ge9LGt1wMJ1FmPcIKiAT5nYDYu7F9BK3kHL0NhPX2bABzkD+KSEC8RB
         93lXRNaJatpao2sKzCk5RD79L4Yl258IZmVVwamxpPPt+dO3kkIjHxXMsDhraXFC48IU
         rNgDAP+LGeSrph0vwpHhNvlyvoc1d296v+wCYoZmhV9RiREZo5Vh4LiHsdSIK6BliRJ6
         WBjPVEojKkPX9vEejLxNAD8i5HDk8AhZfNpFWR1U70JBk0pImX1mjGOB1OOf5lMvIBoj
         veErV2Ym4lq8fJxmk3eCyJIJxIfREbGEF1nvE5p8j7PxYJw0u8utWfkudGYdkYdR1Q25
         B9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721905; x=1781326705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yN9wV+nrusoIiZXpR2QbLHADEoHUVVuow5fDPzDOfKY=;
        b=ETrKuzMBxZtIo/xUqjn2pKEfKcxISSkLqpB1nRArhZv8CZuWHWAHzdsUYQx3ig44Pg
         xsmkLN5bp6cc5Kbkp0bQDIQ4umgI9NU6o+knGF3RoiDaKSlt3Kl6aC4vjKEYELQbRTPH
         KVlbjBOMFkltspG4FRfP89gXLVsBufjYT4m5MHgPaexE0vLds+4StBsewsf8SCuTCO1H
         903/2XmK9CA3Xgnd6pO1hO5j14C5BPosJVK2Opv75iLLMNfS7M6YItt0mRhofH/sduII
         6Kfapn5WtT/4rIFp2ZxYrRzCGRGqrcegGghY2hgAtsYPORzFtiSAcxm3ff0bNyCaLQbY
         YtRA==
X-Forwarded-Encrypted: i=1; AFNElJ+nUTnS2wJEOlHx9AVCjZL6PRUUddnD/XyNSdMIcdz//AuPDdZLSPp0sKC0eeTgl0KSxGBNlsvxojHYFA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa9ECEXeUNHMFQajx7FjoOQ+cug/oGdO5mCkHfO1A+u070GD9w
	PbSgUc94AMgt1LlerNjh/CKPwRtGm+eT3J7aFw1C4eRYqgd1juEzfxk8
X-Gm-Gg: Acq92OGnISswgh96QIb2rjn/JWRsEY44Q7R1PVxlD9dgOJEBLKGqEm93aYa/mUFVznv
	ML2wHmrlTez4RJjXJk7pm+HnevU/WeJUgMag/480p6yezFdl3dUu0FqERK8O1V3ZT+cwdvo/ke9
	GCTREGOoXpCQ+TC9crfXvvCXlmmfV7jJLW5DeX4CehC3kggl05m12NEQO8DfxKdsV5yr28oZ8Bi
	jCBU3FLelo7qsvWc6QqLKKih5yGfO03+bi/ne2qSwxQzxzZKWQhr7F0V2T+EtDTKM7djXB0CNUn
	tnwMtm8JFDpxIH7as2u/KR6CKgMKof//hMMp1eLS3C7wyHg9VFz5w5M8EnSqidh7bPya5GQc1gU
	97+sb7ajTpaZU8Xe/l67bgjYMbKzycH7Xg42rxbwZZyzdpWIosdw8Y8vJ3wp4WdmheQJ3j8KG9M
	Gn/GIFh5ZcrkChPeepbFeZ2HM=
X-Received: by 2002:a17:906:f58d:b0:bed:5d12:db5d with SMTP id a640c23a62f3a-bf37135e498mr329022266b.4.1780721904690;
        Fri, 05 Jun 2026 21:58:24 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:24 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to device_add_group()
Date: Sat,  6 Jun 2026 07:57:31 +0300
Message-ID: <20260606045738.21050-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from sysfs_create_group() to device_add_group() including device
managed where appropriate.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c           |  4 ++--
 drivers/video/backlight/lm3533_bl.c | 19 ++++++-------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 45e7f7481aa0..e3efc9f6f348 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -416,7 +416,7 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	lm3533_device_bl_init(lm3533);
 	lm3533_device_led_init(lm3533);
 
-	ret = sysfs_create_group(&lm3533->dev->kobj, &lm3533_attribute_group);
+	ret = device_add_group(lm3533->dev, &lm3533_attribute_group);
 	if (ret < 0) {
 		dev_err(lm3533->dev, "failed to create sysfs attributes\n");
 		goto err_unregister;
@@ -436,7 +436,7 @@ static void lm3533_device_exit(struct lm3533 *lm3533)
 {
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
-	sysfs_remove_group(&lm3533->dev->kobj, &lm3533_attribute_group);
+	device_remove_group(lm3533->dev, &lm3533_attribute_group);
 
 	mfd_remove_devices(lm3533->dev);
 	lm3533_disable(lm3533);
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 39f438114c48..b4363a30b2c8 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -304,28 +304,22 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bl);
 
-	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
-		return ret;
-	}
+	ret = devm_device_add_group(&bd->dev, &lm3533_bl_attribute_group);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to create sysfs attributes\n");
 
 	backlight_update_status(bd);
 
 	ret = lm3533_bl_setup(bl, pdata);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
 
 	ret = lm3533_ctrlbank_enable(&bl->cb);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
 
 	return 0;
-
-err_sysfs_remove:
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-
-	return ret;
 }
 
 static void lm3533_bl_remove(struct platform_device *pdev)
@@ -339,7 +333,6 @@ static void lm3533_bl_remove(struct platform_device *pdev)
 	bd->props.brightness = 0;
 
 	lm3533_ctrlbank_disable(&bl->cb);
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

