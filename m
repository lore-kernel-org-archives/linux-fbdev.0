Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016CA3CC9F3
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645762; cv=none; b=L6iyMDPDq6hjV79sY/kub6RZtsiJZNonumGJgBaxVkHu29coFw1muIfELv7Ym8+dffkHTcNBqzk+Z/vInnYM94anUuH/+z2S5gZOdMQA4Ipom5D1JIV1o1fS2ur4MnIsRruTW/tMZu6nKiHhA1Y8n/0x0DsMDbeoMVBc6cYMDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645762; c=relaxed/simple;
	bh=P3RWSgaNEweBva02qPe7Yoe68GpbgepTxng62JJRc1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JPpMRujgpGVDrv37nDqTCuo/XyJd02Cym6UnLbJ+DkuY411T6PAO6de7UbiJnW739vtnTWTCfw0dAkBGf2b0ORUBKp6mAvtaEZERKFmcGyMeAyU/MlYNk+GZX92dJICRchq8oGhZBaRUWBbYrdRmhdc3Cxy+KL+Mpqwhtb2i/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8nfebyG; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8nfebyG"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c73874b3ae2so43505a12.3
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Mar 2026 09:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772645758; x=1773250558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8GqwX18uDR+XHlbxuX2mrRGPI2OBZOF06h+p3yCHrqs=;
        b=K8nfebyGJ9GGRSiyTi0wAyBrxBZYGvYfQMcdZ+wn9CEik3LZ1aC/tKcL7l1QBJL0I5
         7oc3NoslAl7CBsaUDeosib4Z0QE7GLvVvef0V1xyJIRVUpSRWz3hPQ/DlFQApTPStqMd
         y6/JYX4Pv8tiWKVFGq/LVPqle2KR61/7mpFNWxuEDxYrBYhY4QCGogVyWZ6vrncAu2Dm
         EhedvSRVPVRWtkfpAzi06MDQqYL92rNqgVgZpRXOBOQR1l3uqO/5CHZzEOVS9pemcW4I
         /7rmW8CVYIrtfXv5KGS8IHwIFTiLf7sLhp5FQ3KP5XKUt8EY4DCRLNqRl43KIGkNqIch
         oNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772645758; x=1773250558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8GqwX18uDR+XHlbxuX2mrRGPI2OBZOF06h+p3yCHrqs=;
        b=a+qArbK5tmbMOhgXNheiHTB+t6pmbrMOgPRuxX5E3Plit6D7q0m8t5XRWhYJXozJ0x
         JVLE/PqJ4XaA7CVh0Fnpo8eTQXOJFCTB0iuAqsDy6zaDdxGx9HkeW9X45vHA8S106p0U
         7UNI1Omr+VZ/mLwIH544XM+5ujYQpMygl37s7yuqDBZmy43W/ryyssE5wJ3nZSQ1ypet
         pT1xcrupgxacPJoRdv+1iJFSdcIGJPuIXwWS4gMFLeqHHn+fHUJkHNiWdNBMSdq6Ua/2
         lNixZ2O5UX7nbTu2cL5ecYCREZOCXj0K+O7e9KZdhPXDTPfCXJl3YF8aAynLTBVerxIV
         3SRw==
X-Forwarded-Encrypted: i=1; AJvYcCVhR1+kqZBlseNhR8R9cnm26uXKy9Kp9lhu1IcVGNekT3XlMOWphM05NQXXDiStYE8p9ebHIA3diYpc9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQGdOLkA4lKvpw1YniqGmMfMNCAAStwv17QVVG6Xc8PB2n7mba
	JvRcKwzn2ONsqoQoF31nmjoVq+5d+K6gPFyEAKFQwI/jpIpFdgl6M/js
X-Gm-Gg: ATEYQzwMztyff8Ynu2uWucLLWrNpBbSAOjSJz9zhON9sqM0aMIDSqxuaEbglesx4YRS
	QOr+MBSJENrTlB96vvclFTm0Z8QTryBXyHLythrTQY+7YRiTpHxALzhsvyvufLpHykbLEr2/9kB
	u7MLxgMmvj48wSV3q4ttEfk7wKEmxsGCqJtFb++N5BGvUBp+kTLVHEkiOTAbCgV40kETa0I+qns
	xvfMxWV69IZaiD5wnMKToOHwenhNKrlcPPdLr4KRKGndHdVYeX5zVFaiULnwk2rwv+W3agTAj10
	gaIROBYTAf1z0rcFZU8oltWWzG+XP0nLBGNUXs4wdnw1TUYphf0WrrixW5U9iwQv9HjfqTi4h5L
	PhpAUGV7KJu+g7xLRHu1Nm02GzLkK/dXs7QJQfmq5pA2n80DixEZvYBki1xGXDeoIF4tKhEZNqR
	7DBgh3lqXs0dp845dHeiX5o0KffQ88f/ytEy5bRlA7RORW97IrV/EYezq2kq8VN3L0cTTRWTGsa
	GeMewQUJE6Ty34=
X-Received: by 2002:a17:902:cf04:b0:2ae:3f3f:67c4 with SMTP id d9443c01a7336-2ae6a8c0867mr21923665ad.0.1772645758234;
        Wed, 04 Mar 2026 09:35:58 -0800 (PST)
Received: from cute.. ([2405:201:31:d01f:950d:ab7d:5e5c:5244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4bbdec99sm136901955ad.64.2026.03.04.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 09:35:58 -0800 (PST)
From: Soham Kute <officialsohamkute@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org,
	Soham Kute <officialsohamkute@gmail.com>
Subject: [PATCH 6/6] staging: sm750fb: sm750_sw_i2c_init: return -EINVAL for invalid GPIO
Date: Wed,  4 Mar 2026 23:05:29 +0530
Message-Id: <20260304173529.192067-6-officialsohamkute@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304173529.192067-1-officialsohamkute@gmail.com>
References: <aaVT1mSeKrSSlrha@stanley.mountain>
 <20260304173529.192067-1-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return -EINVAL instead of -1 when the GPIO pin number is out of
range. The caller ignores the return value.

Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index c73943341f66..46599be8d6b9 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -344,7 +344,7 @@ static unsigned char sw_i2c_read_byte(unsigned char ack)
  *      data_gpio     - The GPIO pin to be used as i2c SDA
  *
  * Return Value:
- *      -1   - Fail to initialize the i2c
+ *      -EINVAL - Fail to initialize the i2c
  *       0   - Success
  */
 static long sm750le_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
@@ -382,7 +382,7 @@ static long sm750le_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
  *      data_gpio     - The GPIO pin to be used as i2c SDA
  *
  * Return Value:
- *      -1   - Fail to initialize the i2c
+ *      -EINVAL - Fail to initialize the i2c
  *       0   - Success
  */
 long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
@@ -394,7 +394,7 @@ long sm750_sw_i2c_init(unsigned char clk_gpio, unsigned char data_gpio)
 	 * range is only from [0..63]
 	 */
 	if ((clk_gpio > 31) || (data_gpio > 31))
-		return -1;
+		return -EINVAL;
 
 	if (sm750_get_chip_type() == SM750LE)
 		return sm750le_i2c_init(clk_gpio, data_gpio);
-- 
2.34.1

