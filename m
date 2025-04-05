Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07D1BD9C5;
	Sat,  5 Apr 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743848510; cv=none; b=IQjN+bfdd0rQ6rWh3bCgqmLQgrEtZegrHO/mnO92d4067obV6xPjL/kYsvGFn4xQqMn9qQIJPk58+wj8dWotqI+vfXlKHrsFfrET4P5juv6mwtgs/OtOlWVZpf948IWlZXWoGy50y0najZhFFBn4HwyQUNjWzyBeHA0JoVvwtqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743848510; c=relaxed/simple;
	bh=gcvZnMhtR0XkyTMXHmFjgItkzTjcKo4d+SyWoFfroaA=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=ZwIDcaR9dm5sxyfCMMZe4q1vdl5pkyr+cH/3Z6C0Tui7bHqPyhZesUTKQiblNCO+QLTGuRguC6ytKQssiUcWHin4jW14Pu7UZuRX4g6C9kRPFBxKTC57HJOmy5j8ys5WHO5k49VG6yYaiQpkX5t6se9IdvRaC+SQ/p6xa8mSzus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnbZtIEt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnbZtIEt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43ed8d32a95so9489115e9.3;
        Sat, 05 Apr 2025 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743848507; x=1744453307; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZIIlDBSj3POSZxjDzaSA5f1J19DQOtsWmRISrShn7M=;
        b=PnbZtIEtoGZ8aEweVOnmG2BnbM3Cm0Wo1n+ZalxhyekOwStunHTIfnqom4xjDTnCDP
         STijKFqwmqTg4AH+pXt51InVB0sznxWbtOBsnQNshoonFu9awcW+ocC109fn+ZZAXPhz
         ok57hGXNBKvC+h5tzcz8prfwhd1IcfhTPaGvXdGSxF017m6tXvjmAsXVponP3hmi2H9v
         Sd7nC6Zw0aZquOqbX4IxaBicW00LgYWl8hkMNI0feWiCyyTZPfU7D/VEzoM+KrpxOnyD
         AyYSDfpA7Y3X9h1syJSO3OlIAG/2T5qyZ1gobfmb7GPi6TjkeAcK4CNTe/2T8XjSo/3b
         /Z/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743848507; x=1744453307;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZIIlDBSj3POSZxjDzaSA5f1J19DQOtsWmRISrShn7M=;
        b=PLgigkDuhd3A+ZGCe0k1ah7ub4sjAf+e9kF99PeDrhCILScEZg3Ilg/2lFKCGSEq70
         UClSqitrpxrhSKKqorFr9/SSGQYvKhhULuGhRYO/Kdnb1Ok05D20XX9FifKP8SZQitku
         NNT68IPyu65oyjAl5aBy5LABQL+c8ad8K5zeCTfx1x+wYHlaMzagGm2bUZ/TX4gTCx0v
         thPSYgPJmluA9eYGZEYIfoJIvTyWvH5WloMlcgoonHgvf1sirIMRP1VjjcEV7kaMQWwy
         wh3KN4UV3a/0enoIc7OPtG9l/SMePmqZ0kUBqkiw4YQpjRoM/Ht8OqAsoAYFtYUOE2j1
         2UKw==
X-Forwarded-Encrypted: i=1; AJvYcCUWBftMqUo/i0J2hRcmV7oHmx4/I2K/n4Gk0mrCuxPEK4Ret4yB9ntRrRXEaidZnD0m6QMIUJDMCkqQfQL2@vger.kernel.org, AJvYcCXqJgKKenoiKhjPzxGu7NiVJhpnFV7Lx/6uL3dX4Cduh05fVOPJu7q86HUSsXwpNnhTyZ7sHSffZIp+Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqyLhaxi9XlEMmNB6N2kWj5JFoNxo9n0SaDtZe/Cf0C0Bz8Xmx
	FyljlcOJa4WdO2u5reiphMKxaIVjzC+iVMVZvdoY93QpTYCeIVHOHJeBdkoDJLA7PA==
X-Gm-Gg: ASbGncvoW9/q0yngjBnfOT+erE17yImzRorrmp0vG5wosBdgjRrEX58rO1Wp/GJZtHy
	IkErO+/iGfNMW3e9gIdauK75hadRma9Fm4c3IrQFvsMkUf/2Kg0gA+/SN78BJ+4izIxft+Vnotr
	slFf9PSavX/fwVYHBbYrLBYNBPxYdirTLKNP71M6kDcADjcTGmMrEZvF6jn0i7Yg7Cl/83WOcC1
	RY11CQvAxmSHB0m+mN61HINe5Rp2mUZeuZPa7m3++Zu7vFb9DlC+bgJ3AmEn12mYSOvN1kJbjAd
	ksi5BHbhNNYY15evapvy+HEY7eCNUetwe3vbPq4hDSM9BQ==
X-Google-Smtp-Source: AGHT+IFX2FgU3KYdXbaa36WOLfwPuuMmwTH6yElauBd+O8zkOzKMJ0wadJJuG0+BEJMaktWStARE/g==
X-Received: by 2002:a05:600c:b89:b0:43d:7413:cb3e with SMTP id 5b1f17b1804b1-43ecf81bb90mr53955755e9.1.1743848507281;
        Sat, 05 Apr 2025 03:21:47 -0700 (PDT)
Received: from parrot ([105.112.71.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1698081sm71621805e9.17.2025.04.05.03.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 03:21:46 -0700 (PDT)
Message-ID: <67f1043a.050a0220.2c342a.1767@mx.google.com>
X-Google-Original-Message-ID: <Z_EEK9K_bR-W1n2i@princerichard17a@gmail.com>
Date: Sat, 5 Apr 2025 11:21:31 +0100
From: Richard Akintola <princerichard17a@gmail.com>
To: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
	gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Cc: julia.lawall@inria.fr, princerichard17a@gmail.com
Subject: [PATCH 2/8] staging: sm750fb: change sii164ResetChip to snake_case
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change camelCase function name sii164ResetChip to sii164_reset_chip
to conform to kernel code styles as reported by checkpatch.pl

CHECK: Avoid camelCase: <sii164ResetChip>

Signed-off-by: Richard Akintola <princerichard17a@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c    | 2 +-
 drivers/staging/sm750fb/ddk750_sii164.c | 4 ++--
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index 3fb14eff2de1..6dee95e60a6e 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -18,7 +18,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 		.get_vendor_id = sii164_get_vendor_id,
 		.get_device_id = sii164_get_device_id,
 #ifdef SII164_FULL_FUNCTIONS
-		.reset_chip = sii164ResetChip,
+		.reset_chip = sii164_reset_chip,
 		.get_chip_string = sii164GetChipString,
 		.set_power = sii164SetPower,
 		.enable_hot_plug_detection = sii164EnableHotPlugDetection,
diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 223c181dc649..284c32f7e9b4 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -250,10 +250,10 @@ long sii164_init_chip(unsigned char edge_select,
 #ifdef SII164_FULL_FUNCTIONS
 
 /*
- *  sii164ResetChip
+ *  sii164_reset_chip
  *      This function resets the DVI Controller Chip.
  */
-void sii164ResetChip(void)
+void sii164_reset_chip(void)
 {
 	/* Power down */
 	sii164SetPower(0);
diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index a76091f6622b..7a71f94a1e9b 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -31,7 +31,7 @@ unsigned short sii164_get_vendor_id(void);
 unsigned short sii164_get_device_id(void);
 
 #ifdef SII164_FULL_FUNCTIONS
-void sii164ResetChip(void);
+void sii164_reset_chip(void);
 char *sii164GetChipString(void);
 void sii164SetPower(unsigned char powerUp);
 void sii164EnableHotPlugDetection(unsigned char enableHotPlug);
-- 
2.39.5

