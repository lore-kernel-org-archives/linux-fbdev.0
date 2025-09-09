Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C503081D1;
	Tue,  9 Sep 2025 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403799; cv=none; b=tuxjl0PSALLcmt5nkQW79HQgKRt3caN68jPU8DFkRptzG2CCN4U8NKwOpygtQ/IIi8lXLJza0XIuXtMUNVZ3c4WKE5AtVAteV0XWIU32pWg+VGoCnx4b0PpCLHJ3qQrSj0dbARAiJZxaFgNuEvkWQ5L9RIApYWpQ6nHMr5pNtVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403799; c=relaxed/simple;
	bh=yua/wpv2PRKHIi8YtGOAbHnQH2z90+tQ6zj/5Nq7KV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZ3AEbrgwWWgT0aZ8vDXOFa1fkl2yJyl/RidLJ8xVEnI1MJFJxXbX1UR2F4xODBAu1cX/7ZJF/QrG58ywouZcjcApskzhz6NATAQnf9wk7QsF0Y/XkQMlKH+hky5BDUrH7e2KhZCV5fcvFtp28XoMwJQhQSafAPporppus4XiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf0CkDob; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf0CkDob"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f68d7a98aso6221850e87.3;
        Tue, 09 Sep 2025 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757403793; x=1758008593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AS7VNoPE31hVbngNYKGN2vb4znQT5BywBU8nWd9Q2tk=;
        b=Bf0CkDobTFk65le/6tASoywSLn8JVrwSt65SM0imMDwqbrFAcbcVzYVtRLymnMYIsQ
         AsQiPv44ldRKrIap2rrptChsewI0EY74+TVR1AL6Tqnq8WJLA1gxuauSz7MEdNjCg1Kn
         zMeFA6s4JoGAP6VXMmDjJyGygbDUoA5vxqF8kTODLiEkVkC/KUMC/FuoFmWzS9wHU0Rc
         R9MMvspg33hcfaScPqzZAuRjOqoOG004cJ9fJZwrNUJfpSJ5Ob4tfbs8HKQGNTHw37CU
         MBZigEp8m/9CVsGKRIHa7SUK+wTGtMUCpylaOOatuBgMqg7A2Af0ENnMH5F77gcpxAzd
         tDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757403793; x=1758008593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AS7VNoPE31hVbngNYKGN2vb4znQT5BywBU8nWd9Q2tk=;
        b=j7hCmGFvPIdj9QzVPR9+8UqLir6/obnE43tTVkiuj5RYcBXt7K5nUGQlOA2GdewXwE
         qwNtQWtpd/snBf6RmrcflBKnVAv+zHmVEjZMWY3XSNi+aVn6eeTMCCe8wil455JCaAJz
         ZMPO5UsDo+wXgJ4oqY7o6IUUrrT9Q26v6iiVrPb82ZyUjjdcIX/cNof+EiUeZZp8T/2h
         +/sO+X6cXlICq0/Fn8o3sVxDc9li0T+0KdAj7rJdaoJgbAcZkl+bk0y7pX3C8MIDh/mP
         H13vZ6wokyxtxcwnxHXVlbS3ryeFEMJpRqjYT4R/3xDeyhzVVlMdSdx1nJkoM+tTsPUE
         bm4w==
X-Forwarded-Encrypted: i=1; AJvYcCVvtnXyNNq8ldoUeeisIoBRdsSx7hZTvTasA3Wse5JYZ4+b2OB8pVRw7ck6YtfURV9UeOQXQ2IDrAweUA==@vger.kernel.org, AJvYcCXJ242kWUgRxfbFLAgvCfdZDPF+wED2wAR2knd6jiypvS8AvVDdA1/NacKwd12JvYlc/4MBXGk93lOEJ0tV@vger.kernel.org
X-Gm-Message-State: AOJu0YxvEmbuOCTmS6vATqCWyvFfPXwNvlpAaaeQy8RPalQNu/boqeTO
	1CVYGRreHdpRW7LEhhECGgiTNLEKs5DBPXDjCdpFN+3VQJr72/EPgabD
X-Gm-Gg: ASbGnctIS83whFeqVsgj8ya4HE5RakPIq4/tzD8KiFabSqheL+pRl9VMgV7N64/Jbsk
	hbhXAChoY5B/SP+eLg2MGvDkPtE+QWsDfbJnZ1pFC4UgT6/snWnYGaWxkEBBITmyUs+h1/Kx7rR
	JQxpV411YJVwahyrN99ZSTXG6r+icFZw3e9XANFpIiCHtwTMzb930T5cgawAbt29rUkFwNwuIWE
	ohuSL+8ayt42VOVIcFMy2yA7SiyqjL+ojEPvQm6QvmT3t575tAgLNUTq7Pvk8SWZs/7d5vtFf9k
	3A2r2imoRSDWc+1GPMbX9jSNfxbtHFACF6sFIyRI2iXUDqpMOR9KgrwZLf6ozaeBwrbiK88yc5j
	XwH30Ql6Lk+yV9Vs5Bw0vwUx9vjRvpZ6R1Aw=
X-Google-Smtp-Source: AGHT+IFVQZHqLjAbCZi2TcAKzcKwotgrbVRy+JcaKxU5U4GsAo4FHGFmFmjOR5+4JFXb0wcxlhDOtQ==
X-Received: by 2002:a05:6512:3a8a:b0:55f:3ef4:a0f0 with SMTP id 2adb3069b0e04-5625fed2778mr3793700e87.24.1757403792554;
        Tue, 09 Sep 2025 00:43:12 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681795d633sm333731e87.68.2025.09.09.00.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:43:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] video: backlight: lp855x_bl: set correct eprom start for LP8556
Date: Tue,  9 Sep 2025 10:43:04 +0300
Message-ID: <20250909074304.92135-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250909074304.92135-1-clamor95@gmail.com>
References: <20250909074304.92135-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to LP8556 datasheet eprom region starts at 0x98 so adjust value
in the driver accordingly.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lp855x_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index 7075bfab59c4..d191560ce285 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -22,7 +22,7 @@
 #define LP855X_DEVICE_CTRL		0x01
 #define LP855X_EEPROM_START		0xA0
 #define LP855X_EEPROM_END		0xA7
-#define LP8556_EPROM_START		0xA0
+#define LP8556_EPROM_START		0x98
 #define LP8556_EPROM_END		0xAF
 
 /* LP8555/7 Registers */
-- 
2.48.1

