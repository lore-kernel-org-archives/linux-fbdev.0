Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722326B96E
	for <linux-fbdev@vger.kernel.org>; Tue,  1 Jul 2025 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751361771; cv=none; b=L/DBhfMNnC8sX1Bdr222VLEs+tZVSH5yoQd0wfgyWrTWxq4ZRffZWPCe5ZUbErCjvDo6Cub5H+beLesSOIOmo8RICKoR5g8ST4vwSW2ZKYR3Jafzga5SaIxB/+na/Iind20P7HYbn336K92vpzCZLAC0CyW0tmNdT0oMmNL7dwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751361771; c=relaxed/simple;
	bh=SvqlrEMtz9LJbvaRV1nJwjGYDMDWrjXzaQ+j9PwbG0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqOEgLc3BCmLnmp/gp5/mBNYBDYFv/dWDi8YfkJjkRMLyHcMlqZI3P4KfpqE2l4Gv8gWHS9K3ak+n//H0YJWsENmpXdIepPZKLiL5AC/pmx58ORTZijtJdbCV6mf3r5S/fl2n9nMhtall13tJoex2dO7IQt2AdqVeGVMNSaHpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TEzv3KZx; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TEzv3KZx"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60780d74c8cso5286796a12.2
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Jul 2025 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751361768; x=1751966568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUCqoUDneJro7iETMW+UlVbrddPjh3TOFBSvfBqoW8s=;
        b=TEzv3KZxTEHzS7lqpQFWWiF/wQmrCcmuUTb+HomviDvAtAR8oTlq4dPXvAw4G6NFqv
         YYL6urn5cxMOgXPOQfQCOn5obJ8hY6U3cjtmHXfyPWL/h7JVwcGHcCe6gUtPzHSPzXEy
         9o61JB5602Clome/HwssaqIrMAWfLTY35OdoTVG6PZDmLLNI4fq5zKP5Xo4Q+aO7ko8w
         sxGp4C1XMfqzlDs8I7/mL/SdyYU4GLu1o1sMQv7Sa5DBCYES7FnBcoc7mhM1OIHcfeaH
         nHnONiBhOtIdyCcyExKOMxeRY/4C72RGsOAHFo2Xr85/iiiIPmLBjGwkMu17Rxz6iyAN
         9N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751361768; x=1751966568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUCqoUDneJro7iETMW+UlVbrddPjh3TOFBSvfBqoW8s=;
        b=l1eq8bhu/u9OjhvIqYVi9MRJy81op+zrP+c50ZeRzwu41b9HQApKZFLcRCZXkA5QwX
         IP9fud4y/zlsFZAKDUEP/KcN+micL2gzx+F1mZVn1VeyWhH9W3vx2eslMo0ubiGH1MF8
         KiokwpedfVhIRGJVgrOMGHTDGSObXJA9Adidzfybgs0jfMlG33Re6pfNe+u8y4y959+H
         z3VpqWD68aN9IUemi2FJfOHtymVAu/aMIwkGznrsK3Pf969ivZdxbkVd5zzJXDWtmQXt
         PsXeJzRkEWVHAm/yXE2+cLTlzPxff3Pf76Say0L3/1+c2j9nu4ILb8Us4fJT9snT3/T4
         i4Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVNIz4t6FOcNe1x1YCbjLIZtj5qvX53W4tP75mlzNANpJ9EpE1Dsqthidj+FYI6k/utJct30Nj1QdJy/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Kjk+j6Xzl+36d8LC/qT1OrAWYjadFj4MASCHZCqQWqmWABvL
	WkbpTvsZ+f8tODjZIzl/CFntWm/ngSdxB00x459pswV5TuButhR0HsPVXlvCAPhH2wo=
X-Gm-Gg: ASbGncvxosljXpHQPtmLe/T5Vq0cm0L+9toL0vEFnX94/94bXk3k8D+xH4vFmfqcLun
	FAiYoEC3SMGR9UXaDN1l9k0qB65hsFcjVE8c3X7BhzQb3qvsi0wXEU4xu9Khq4IcqPv1KUt/jpM
	r3d46C50bW4b91E0rnBR1zkUiVilFpVUCoM0S5NAW1ztbVMCyXR6PyHDoMf79z84rCKtnw8ggf6
	TkqBw7kvMsqaCmCNruDQdn2Vq6N8KLjkupBaDAEHzdIQJI9HkPQLsRzMYAPF0nE+fuNwa8cXfFA
	knZWAnTkceILMgtigBog/Gu8xDSqGqtSYqfqzVBlYe4E5I+cJFnaDlW55GY7EbNhVXGv0AuMPk2
	HaKoceVpC91C2ebgXdw4j3d6s1zmjO2P7fFM5tFo=
X-Google-Smtp-Source: AGHT+IGNkPdEmpZwCcvrjMGu50yM0BpyZDVCekNrVk7CymZh8/DBYnTbl8HbewnLrBo3HK0iDVXJOA==
X-Received: by 2002:a05:6402:510e:b0:602:3e3:dada with SMTP id 4fb4d7f45d1cf-60c88e5a42cmr14195974a12.25.1751361767850;
        Tue, 01 Jul 2025 02:22:47 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-60c828bbd34sm7180438a12.9.2025.07.01.02.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 02:22:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Flavio Suligoi <f.suligoi@asem.it>,
	Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 1/2] backlight: mp3309c: Drop pwm_apply_args()
Date: Tue,  1 Jul 2025 11:22:36 +0200
Message-ID:  <2d1075f5dd45c7c135e4326e279468de699f9d17.1751361465.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
References: <cover.1751361465.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=956; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=SvqlrEMtz9LJbvaRV1nJwjGYDMDWrjXzaQ+j9PwbG0E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBoY6jeSs2B/0GJOrfWXLz92STYcWG2LA50BuCvG U8iwJaqxvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaGOo3gAKCRCPgPtYfRL+ TtCpCACgUCBjnISaJ0LkEDzhTx366kGo8zu/zHb/myUGbmjg6BgfBCJy4XZXkJDlIQBFAxZfesh PTnwXU3MU2tOeKGrPvp8LR1qJJG3Fumu4/DUeHHhGFEZtO+qTd3v+i3mHPvcSuEt84mHh6V33bP AcAN1Ztvh8XA9M5ocRF9Rm8r/CIGDjbLOtNyHdySYlv+cI3Q5VpL8YgQBTmIqHg2T+XVBDcZYAW cxQsd1vvYQswRzBzdLMLjLjWqK5hvzBN6qOES0NqnFT4XJbVjvUQPfs8uzsT4n69IrWYT4lAFqp luD1DXSLkvLh0e5U6iLEMkqIT3xAORapXP89g/Y9sG+iBpb+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

pwm_apply_args() sole purpose is to initialize all parameters specified
in the device tree for consumers that rely on pwm_config() and
pwm_enable(). The mp3309c backlight driver uses pwm_apply_might_sleep()
which gets passed the full configuration and so doesn't rely on the
default being explicitly applied.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/video/backlight/mp3309c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 372058e26129..bb4e85531cea 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -222,7 +222,6 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 		if (IS_ERR(chip->pwmd))
 			return dev_err_probe(dev, PTR_ERR(chip->pwmd), "error getting pwm data\n");
 		pdata->dimming_mode = DIMMING_PWM;
-		pwm_apply_args(chip->pwmd);
 	}
 
 	/*
-- 
2.49.0

