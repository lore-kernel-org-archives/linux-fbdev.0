Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C2B54758
	for <linux-fbdev@vger.kernel.org>; Wed, 25 Feb 2026 20:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772052377; cv=none; b=ZqXo2abvlU62zKvK6nh8sMZs2pWGG58DC54X5EvZWTVhB96zUEqfTDF8Qpy6k1soUyUEyMG/TOrqE2WvukDt+t6FxyigQPYFx1AEruQfmcXFZZQsRxHyGQPxSNIxPRxSJSNi9KkceV9R76RilI6+H8KzUYLwXopYD3Vq9Eo97Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772052377; c=relaxed/simple;
	bh=zZVjrpzWzNlioVSKQIgwdOHhoXVrxoCuP0INzaxVxXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czB4Ok6k2779N/djA1LgTYQQmqV+1WYRpYhnbElUPZ3NrE+OVdxJIODHhn8qy+7MWKV25iR9/7MXKA2X1nM42vHSbAFIJ/cvjCyJsiArhr5Zb/q6ZLKHuJnp8+tIzWB25RoD5S8OKWRW2IWJrywy3OyuSwMjqHFsA92HGgo9wfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGsNYA+X; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGsNYA+X"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43990ea3fbcso94959f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 25 Feb 2026 12:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772052374; x=1772657174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hPPTw/h663gwEv5xV8CJ9bDxaVjouGUNI0NHoKIgjD8=;
        b=bGsNYA+XCuwuFqyL8+hQYjGNZkt2s5On3n/4AjnFiuqGZEb+55L60/6s/tY0cOyMTD
         1/kCgcovBrEAoHgKCmMvgR3AbwdBCki3U0d86qWYw/MroW2W5gEx1ct5IVCgT9CL7OmO
         bzS3H4u7Mjf+rtES/obVJXtgRZQWOMrG0y5O/40tMSK1i8LUn3cGb/bL6i6w5Oj/APor
         Ubl9+OvF1paRZAXTFzEcl4OZ/bauyfzYrItqwYofgc4mdPeYsNybaOJtMfvy14G8NHlU
         TrRIzQvhcCUIDPpfbyKuQerESGVADeDMTKwa31Yx3XA7cviCF4aJ7kaLrgfFm+bkdBve
         1HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772052374; x=1772657174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPPTw/h663gwEv5xV8CJ9bDxaVjouGUNI0NHoKIgjD8=;
        b=ozflx+4teStpQNfJssXroBDfzPF/zMZlTzGGURG8xHqbZrJSDyfw5v2SELmUUnzSvy
         rnz32vVAkj/P6oOzAB6MxG/tw4q3TXmdsga2xGxtSSb1HfpQC007fado2Ed3GjpJDNdJ
         kCzMviO+uRiCC6s3KK3/zsu2o6c9gJlelBcXIxihqdUDT/Lyrn/UO4tVfT/KeKMUiZZ2
         GB4P3s9JUG6l5kouOzPjbw9+vCTodYWAjBGUVQWL/o8BGBTX6BN1KoCHMV4yf2FDehnP
         bJHWPFS4dL9wmB+Z8i5wLe3Xc4XsJKrhjaDIZFWbUc3TXuMHLNP1dvrF0EPfn28yB9EI
         MMzg==
X-Forwarded-Encrypted: i=1; AJvYcCUUpCqiain+yjSd8RINKR7PmkgcNo1PrO2XfYNE/CaNn+QdOQUoj+KwuWPJ+usdU5YwgtznuAA70MMdkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUiK0YL409NnrHB7RhzFSHJ0K7aQSJXk/oePeO/md6bjXWDEVx
	TzYXHtYvkUcP3Isaanc5vS3YIm0kLwcU9UqN6zxyJTVL0UpfgT6///hQ
X-Gm-Gg: ATEYQzzWWfeOQEJAX4wb0BUkkJSXFxDtjkO4l1OpopOhxlgcOGIjLSb8YVRcLHgmOxi
	gZj/Mxr8Km+WR13LerdRibAjT2MC9FFWXMVXz4ytz7vPAzp5saEoTiO/CggNGLMB8mSoeXZt8wC
	Th1E3Dfs8UEAr/mBz8gTcNfm5NqJl5M9AhU9lu682RNvKhx/mlIWD72M5sVIfkrjdh7UDZjMGLk
	RG+4AzFsbCv2nfZsFaFFw9y8vz+LuQscQdLfzoX8JT9uKzrcmd+i4jW78VPtoc57VJsHzNVYsG6
	0vzdvekQctSKCht/+N7mG/YS5tSh/qil4YbqmCHJPq1f2UGYR3FtxwS1wF40kcCyNp4ExnqNs4k
	LfzKTRp4pa6O7HNlIJGqXZAStJ9MCJ5BgDT61V3eQul1w+4ZFdahGlIx7sJ8WF/udEu/GeOBDOT
	KvMFSeLXEgllKLhMDflOYCACdkHkHw1EenkkRg1dI=
X-Received: by 2002:a05:6000:4312:b0:439:94da:1aaf with SMTP id ffacd0b85a97d-439971b2b03mr838964f8f.13.1772052374120;
        Wed, 25 Feb 2026 12:46:14 -0800 (PST)
Received: from localhost.localdomain ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00d95sm34711357f8f.13.2026.02.25.12.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 12:46:13 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	azpijr@gmail.com
Subject: [PATCH] staging: fbtft: fb_ra8875: replace udelays with usleep_range
Date: Wed, 25 Feb 2026 21:45:59 +0100
Message-ID: <20260225204602.134218-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write_reg8_bus8 function uses udelay(100) twice to wait for the
display controller. For delays of this duration in non-atomic context,
usleep_range() is preferred as it avoids busy-waiting.

Update both instances to use usleep_range(100, 120), allowing the
scheduler to utilize the CPU during these wait periods.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
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
2.53.0

