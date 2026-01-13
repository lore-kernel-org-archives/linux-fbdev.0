Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CF350293
	for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325293; cv=none; b=jf+Fh/Dn6jMMaTmff40/qnGudFuaHWyH3GdnqPtR2KnX84huwtI5+mPaGk3rVYo3CeiOX3Nu+NNKufUJEwfjJzoujPOZg24LQsBxafFUJhRNJL9gWSdWBYdJMSqQnuZLl88ml4Ytne6Swe/8VsjIOstcpAWfWBGJNzImQleFi8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325293; c=relaxed/simple;
	bh=A+qpwwqEuPU9LQ7T9Nr8Dk71iIlwHSWsYGXp/8jp8Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M4Zi95NiGH4nINs32HZHwaS6QtcmzkbLlSNuIak75nIQiMgT9EWgAnCMGjObcB0F7/VEKxqNmQWIPnj5Rs+csuzhuJWqmBAFg52qPBAPq6S45rHiEupISkQmzIkNc4t3T1fFVnTDCgHeoRgUYKDJ4EdxBUyntJjMfUAPiF4nrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMpIFqqC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMpIFqqC"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43246af170aso31983f8f.0
        for <linux-fbdev@vger.kernel.org>; Tue, 13 Jan 2026 09:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768325290; x=1768930090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEEjpAa0hiVuWSNQpUBIYifaKxqsQfJ6JiXcZAA+XqM=;
        b=AMpIFqqCWDhCZXMsDFIY0kSZ4SA7JUjfedDfNYv+dBPGtaoyenhrh6hVxZxXxIB/H8
         iv4vZoUFcWAQn9IjU5IViDYFC+YSFc+Wc4WU60jopI+ocRhaEyYGILc4SfEwVWHgGOGU
         i3mVUuRwIt+nRrGZZznphg2y8sgWOgWYeHtUM/T37Nh7hQlZDCbcd3QeTh9TTIqrRIjw
         Obm5UUOPjdWnfs0vq4VXpDpmBDJ91PinMzpT1VdBDyhPNzE6aA/n7KRcXd1URe5WmCE8
         m2Pi0ZCIuYa6Cqh5X/pk5ANr/bbdT53+xKJADFzZFpVhr3KHo/3u9vmgYPKWX8vPaPpu
         uEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325290; x=1768930090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEEjpAa0hiVuWSNQpUBIYifaKxqsQfJ6JiXcZAA+XqM=;
        b=adBHyXhe3M0xzQdoald1GlQGbL1lWgi6gqiqP+IM6nUykwnkb8Ek4PoOaDzqOzW3tt
         r38/dCx3cu3hoQLm0h5LOkAvRtl2DYZKOKIyEIMl2KMGuJx+YkwxN1HSvMChP0b3CkPz
         xkg47HSr7dE0uA0zrSx2DABHBVgGbszLu0zl44H7nXlxXZ322tkAxn29ML1pWJ66gBUD
         wBeLBhY2v/HtDkURpfXSEMShUaZ4aqEzSviHTO+jCGQ0bPe217TQCLW5HqzoYKn3O8aQ
         0ABbGePEseK7dGCbBDRfVVwtOYCo4ZKhi69QEBszqIFKmImENKdtyDRahPdbgeKxhRve
         1/Xw==
X-Forwarded-Encrypted: i=1; AJvYcCU7tltvux28kl4wkJ7v1ymnapH3Qmohy9DLir7WHTm+D9yYC35JXXp5WB7bP/QgMLeBBO/Mk+AnuvbSqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/CXgr2bqpJnptEQJiAoV1qi77oSJtxgefX54R/x+Tj8iD7Zd
	FO8g4ryFY96bnGzwKy3f+JrkQuZA3PoinX7J/lAGhFONoYRU11hE2yLi
X-Gm-Gg: AY/fxX45rl4SK9ZqbZV8hk3SD7XTQGDnPOgsH7XnuQqxspeOdNcyakg6nt00l1DSpZU
	bGDBpxOCs2b6RheM1h3JBmApKdTQ9CQ6j6j4c2vXf3CqtCKhL4O8UaXXavmt12nqyZ+LIGP0ICi
	mR+07015+6kNBYByik87PNFFXoggvQbxag2F9zbAwzy5sPS11DiTVSRGHPLfGvO9mYGHB9SueAU
	0jUzmO0M6VxCk8QS7QdgsrFlZ7NVp5f+cGPJktB+8u9shC5UnMp6QMJwBpGKp6qXoQQsuGviOL6
	PxW/FWfpJNYb5giJXnZRprx5GmawL+GqJtWHtkOIKqJ4culT1btCGn3juo3QMO9UR8LNQs2DHRm
	SALWW8gBPA+wGBkT2ND+r7kT3V4UrDvP72KvdObW8fN6wfj02wLJZbuwa/36Cz+7JgzkZO1Gy1R
	O9IC8foItE2Nf1FPFVJjUS8sQAYqeZ58aFbzipT0fZVWaG
X-Google-Smtp-Source: AGHT+IHH51cskQ/rWPUY+DHYeuVH4jyvuoMluFfD7D37fHpkEs8+rYtzPOXZVsHRQyZzJD5N1Wq29w==
X-Received: by 2002:a05:6000:230c:b0:42f:f627:3a88 with SMTP id ffacd0b85a97d-43423e77f7bmr4931500f8f.4.1768325290175;
        Tue, 13 Jan 2026 09:28:10 -0800 (PST)
Received: from ubuntu.localdomain ([154.161.61.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacdcsm44792388f8f.1.2026.01.13.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:28:09 -0800 (PST)
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
Subject: [PATCH] staging: fbtft: Change udelay() to usleep_range()
Date: Tue, 13 Jan 2026 09:27:56 -0800
Message-Id: <20260113172756.14744-1-gideonadjei.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace udelay() calls >= 100us with usleep_range() to avoid busy-waiting.
This allows the scheduler to run other tasks while waiting.

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

