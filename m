Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6491DF72C
	for <linux-fbdev@vger.kernel.org>; Sun,  7 Jun 2026 20:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780863444; cv=none; b=sWjsqYYLPnbkR7zBC77T35c+7DE12DeiaJKQYvs1coov395ovR1jmQTZcUzMEg5vk8rJ/5Zkvc6y+AnMLUPx5+NqQptTOIMbSUTEmfep76qpMXQW4EJrsf7WRUcvJZQi+edKV/JRaOSTNdFh82hDUv4ZbVTGz4Jp8TQ69LRHelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780863444; c=relaxed/simple;
	bh=wBL5gFM/RSITeS5F1awXPhfYxnemAdgCB0HVANsqQVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QHXBYAAfJulKjGUx6Uxy9zJfabLaX2MTjpCagD846D286/S24/cuvcr9M88e5PEj7EWYRBUjbuMwA8BXOFxY/ewVzAkouWolJGjzOXJBPmCPwNMCwHTY852wroUfjNGT1eBt6nOeqGeYiOkW7TGoKAd/iR8QWk/Pd5rvOSnmrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsFu07q3; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsFu07q3"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa7a7c9711so4080574e87.0
        for <linux-fbdev@vger.kernel.org>; Sun, 07 Jun 2026 13:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780863441; x=1781468241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UI+ati8w10fcpvRpL/lKOmhNvyhEWhByMfjT0Pq9pcw=;
        b=AsFu07q3lev0It8vSGa/xLaEGMOZH6L6ASprpz5VWNiZFmnmY0RK24N6cB/fDlzYYP
         Uw6Z2WXwcCVJ5lx6AxhHBooBkscEKBh8N8CJmtzppAj7tOUt42P4x8/hvqKy/EEW2NJI
         OqWiwnPD9VZqF6LYL7ihJpdv6gv38I0jHHyx9eH7AmXiXicpZTUsrj1spcCyg/UjEWjm
         juVQkZCO3KUxIQMRWNHcg/MMChDAf7JQV0CDumgxdZy7vBgny0BzPItDvT9LU6CC1e8b
         p+nSx5bLMHG5Jo02hOzQQ+8zNpgy/crN5ymS1U/XQ98vDxi98s/b7lVxfPqvFKzp+/WH
         Knkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780863441; x=1781468241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI+ati8w10fcpvRpL/lKOmhNvyhEWhByMfjT0Pq9pcw=;
        b=RZt6HSox6Ydt5bw9rKu6mvcYRG2wTXVEXxr8pMvGf98bU7RI5QeeJ7R8mkjLXAO3XS
         0uR4eSmdCPNYWs3VKOvRvT0TW+7umTC5QeRokQE0HlqbPr7DpOHURKrWm6KVCSbq2vE8
         1MUGIVjoAK8QpNMGFv/uhYEZspPMa2KVS85V7u/71+VmsLmKXSAwZfwxurl9cUzdzKXJ
         RfchCPANyZancfUg6Kh1127S3SmvfqKaxgavh3SsR952l5AC3pfHNFRPNn00sTv2bV/f
         7ySPBeiExnaz5LVFTPcGEuvwhgbkrzaW81FqNBgeiOAK8M4Ntcg58cuyt+ESLCUVTVPw
         vPYg==
X-Forwarded-Encrypted: i=1; AFNElJ/yVHOU9Auo1q+StRd9mhxoGxcHFlaSyT0/c7NXI3KpgChJ1Nza8wRMR+N1yJTVNaLKMrS3Ucp8f9BKzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGhJF9l8AchEPc3qx7rffD5SFU7gUk/jf7hiwFXewxIqnRlXe4
	77xD9pnucZwGmUy7S9c4e3AJqCqyo/j/KEsStUEI4gCs4wibR05YU9F1
X-Gm-Gg: Acq92OGgcDGNEco8CnU1qZEWmRRnCEDX/zbQYr6N+qa4AHvKnv7VZ0W40iR0CDqHxhV
	7+YiKYbiv3kSG9DhAv5a/lD/uZfQc1CQWYFIVkn+hQKSfX0sJVOIeH/fu5ZkfzyLc31zj3S/ufU
	0S1M8XxAhQQ6vZXI/m2k0yGrRnAOEkysM/4h6NF0XWlyFCzi41KYjITtpiIDmckln+LcOfzYleP
	y7ePB7I3UdQlyi4tVIAhy/7X2/36yy0SBxHfaOggt0Q7uSvlCjgatJuakmnp/yKCMVallqT80nw
	Babuaa6uubHPJZTLiMs7EiPWQn7huGoHuc7LRZJUU3MBRk6rhLl0+XF74SfUR6FIDiEDy8gPmZO
	IZJGFBOlIyfOwutRPIwrM5CH7PZJmuKEzQwxf6rCooJTmv62+KnO0M6AbEzT1Ab4KZwijpwCpQ+
	A7XmfYXtYUD26L/9dz7Yh0Y5hOx9Ih2qg=
X-Received: by 2002:a05:6512:2c08:b0:5aa:5f5c:9546 with SMTP id 2adb3069b0e04-5aa8865e0d7mr2689095e87.2.1780863441167;
        Sun, 07 Jun 2026 13:17:21 -0700 (PDT)
Received: from fedora ([37.113.99.0])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b907269sm3276268e87.34.2026.06.07.13.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:17:20 -0700 (PDT)
From: Georgii Druzhinin <ilovelinuxgames@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Georgii Druzhinin <ilovelinuxgames@gmail.com>
Subject: [PATCH 1/2] staging: fbtft: fb_ra8875: prefer usleep_range over udelay
Date: Sun,  7 Jun 2026 23:17:07 +0300
Message-ID: <20260607201708.88644-1-ilovelinuxgames@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace udelay(100) with usleep_range(100, 120) to avoid busy-waiting
and allow the scheduler to utilize the CPU during the delay.

Signed-off-by: Georgii Druzhinin <ilovelinuxgames@gmail.com>
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..6058934e2ca2 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;
 
-	udelay(100);
+	usleep_range(100, 120);
 
 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 
 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	usleep_range(100, 120);
 }
 
 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
-- 
2.54.0

