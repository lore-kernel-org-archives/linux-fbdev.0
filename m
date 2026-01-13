Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A6314A89
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768338368; cv=none; b=r02sNmm2VHOW0wyrQhGnT+A70Kas5KsxwPkj20CPF3/0Mh7faZxIc9XciT7AzfSca3vthvGll1615qTLoV4ALqP03P/rDAozAZKDLltaTa89t/vBtmgOVZ28xKzqoormWdyAfTKC+vtID2xGAHQ1xNLmU5yLfDm+7nwXy4ynatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768338368; c=relaxed/simple;
	bh=jfWi2Vl3wrmFdl4z1GlpV7sW46Sn1lmQfia1Ea1G1C0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qgk4qnZf7uLMWXamKBhBywaqkHi1zgHOcm6TEcwgmvDkMq9G295Z83tDTqCO/FUNb3M/cuUbZuUh/OgSNHC/QUTJurqb01gz2wKXzkUxJUMuVSxZdHqrQ6EgbTIPptgcD87nCZet1lalS/RTGjj/o2gxiZL0r0VgkOfaE8tepmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6rZmMlI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6rZmMlI"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47ee07570deso4486675e9.1
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 13:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768338365; x=1768943165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX/Q3gJa9nyuedmUpH99IiHZs/+kDUZjSFi8hfs5S/8=;
        b=m6rZmMlI8bO8cV8LWC+QNfH+Hg5nkkac/toEbupOWpmm7sYVA0TCfMuZTzjF8wIgND
         A9B2ygI7suLn9F2YMFmYPEtGjXA+BoWxIG6rVQDMmo8cHxBHhFcCad6D6YjM4YT7Rjku
         0s9RsUwVqu7w5863Ukhd3ySiFN+zJFiR+cUbab3zBXFpHUcFVgbjRuA7/RE+FsitoTwE
         n0xL7D4UtoxbVRKRktoe4miZrJhcHpwWcTJRMXUo3KWWhcBuQ6og/z0ixkoQIRsQ6pLY
         upobJkc9SVFR+jZhfXdl+Bx2KmQucKj7pmS47MLA9WYBywnhURSoLsbPwtsW7JW3uD63
         DtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768338365; x=1768943165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX/Q3gJa9nyuedmUpH99IiHZs/+kDUZjSFi8hfs5S/8=;
        b=jWSVBwHVOY0mh2K5ANyHktX8ufhQA1HGq8bDRcviONSgcoFGt6IB7H9xJ4TCDFIf59
         jnwIM9elIvOVlmzpaXEac5ZSw0dTNCSnHfWg5sE2MTao23X/CRRkFXQZ1BiOF1rGyRrI
         NBRVHmG48Wkd5r8AJgotzvHmVEO3J17ddnNqPNpCFan2vAp+BZ0Zc9ZrqpfaD7pcPsKe
         MtgR+qqJS7+zojt+o0rBAtawfakxYp+ihboKQA1f1/+r3WnapYV+TXq/yEBYuEhcBd67
         /S7Oi5TFjYPK362jVOqJFnb+JxS+OmI1K+1Ybqdfe8ihr2Gpa31npsHMKDNG/uPbNPT2
         7SKA==
X-Forwarded-Encrypted: i=1; AJvYcCXTUb/n0rx44ppw7oOCoaIaTjZweRGW0XRfjqraofKesDVTMrjExxQi0P1LRe+P2F5k478dADjShoLNCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAhQEIwCJZO+Yf1JRelKURNreLijSlVFecMlrQ9PkTYIyFyKD4
	/upYs/tHMwubrf5XgdGgQQXVYvgkWy4Z/5hG0/an1CVfQiTT2LmeUGCU
X-Gm-Gg: AY/fxX4bTJCTjFpIm3S7+ifXAkwlw4DOlFigHPhdbnaplo9qLSVzhk+z6ItYz+dzuTc
	9s+4MYrYdwtJePgRrzrvRsotJ6wTr0x5RSFPS8PNese0xNyV1IeWgpT5f4Mkxpum6UZ2TJO3cNy
	50vYah7w9G4xZVA95YGq/ytihYHNeYoeMmeMEB1jsYrqv6Y+x85Saz8/oInD9ZTcixuAkCN5fc9
	a6gKN1krHvO4zufRnioalp111NvFqBUyfG5O/j3oB+jjyfmReR4nYEibMaqCjuDTRhRLHqgO2dR
	G5KpnV89QQHNz+0ONJPzU4li787U2QICJx5V6Y+zWryS+DhPUrXqI05faw+RIjLpBa5r1A+8I90
	FUGhJqjPV1DhWDfF+ad1KKLUD03wZzQ8Vxk4cTcvUnQG78tsswzScB8rAfqqpjuYG2tFNQU5uqM
	AtaWUq7dQBWsO+vfkwN9+KN7AhyZzgnkJTW2i+kvsWVkyfOg==
X-Received: by 2002:a05:600c:528e:b0:47e:e20e:bbb0 with SMTP id 5b1f17b1804b1-47ee32e011amr5733565e9.6.1768338365266;
        Tue, 13 Jan 2026 13:06:05 -0800 (PST)
Received: from ubuntu.localdomain ([154.161.44.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ed98abad1sm59042205e9.10.2026.01.13.13.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 13:06:04 -0800 (PST)
From: Gideon Adjei <gideonadjei.dev@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Jianglei Nie <niejianglei2021@163.com>,
	Matthew Wilcox <willy@infradead.org>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gideon Adjei <gideonadjei.dev@gmail.com>
Subject: [PATCH v2] staging: fbtft: Change udelay() to usleep_range()
Date: Tue, 13 Jan 2026 13:05:59 -0800
Message-Id: <20260113210559.3020-1-gideonadjei.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace udelay() calls >= 100us with usleep_range() to avoid busy-waiting.

The delays are used in init_display() callbacks. These callbacks are
invoked by fbtft_probe_common() during the driver's probe path. the
probe path runs in process context which already uses sleeping APIs.
This makes usleep_range() safe to use in these situations.

Signed-off-by: Gideon Adjei <gideonadjei.dev@gmail.com>
---
 drivers/staging/fbtft/fb_tinylcd.c   | 2 +-
 drivers/staging/fbtft/fb_upd161704.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/fb_tinylcd.c
index 9469248f2c50..ee8d6b10374a 100644
--- a/drivers/staging/fbtft/fb_tinylcd.c
+++ b/drivers/staging/fbtft/fb_tinylcd.c
@@ -41,7 +41,7 @@ static int init_display(struct fbtft_par *par)
 		       0x00, 0x35, 0x33, 0x00, 0x00, 0x00);
 	write_reg(par, MIPI_DCS_SET_PIXEL_FORMAT, 0x55);
 	write_reg(par, MIPI_DCS_EXIT_SLEEP_MODE);
-	udelay(250);
+	usleep_range(250, 400);
 	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
 
 	return 0;
diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
index c680160d6380..aed5cc7cabde 100644
--- a/drivers/staging/fbtft/fb_upd161704.c
+++ b/drivers/staging/fbtft/fb_upd161704.c
@@ -32,7 +32,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* oscillator start */
 	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
-	udelay(100);
+	usleep_range(100, 200);
 
 	/* y-setting */
 	write_reg(par, 0x0024, 0x007B);	/* amplitude setting */
@@ -60,7 +60,7 @@ static int init_display(struct fbtft_par *par)
 
 	/* Power supply setting */
 	write_reg(par, 0x0019, 0x0000);	/* DC/DC output setting */
-	udelay(200);
+	usleep_range(200, 400);
 	write_reg(par, 0x001A, 0x1000);	/* DC/DC frequency setting */
 	write_reg(par, 0x001B, 0x0023);	/* DC/DC rising setting */
 	write_reg(par, 0x001C, 0x0C01);	/* Regulator voltage setting */
-- 
2.34.1

