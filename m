Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782B2C21F1
	for <linux-fbdev@vger.kernel.org>; Wed, 25 Feb 2026 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772062878; cv=none; b=N7MpIlLxEGa4VezxOSKpvyCR8fhu6inM1ZqsZOCK4Dfos7dBZPKCjRUqIkifa8HSxViTXeecw6O4ZHldBVgkHT0KxUfpSa24nZ+s1C6DOKRXzKhrbAriBz3/nsp4tOUP2KStFWTad4Ie/Zfb+1v26kpSKxswqd9kVzKyApO+KHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772062878; c=relaxed/simple;
	bh=k48kyUfLRMJqJEgYLACBc4tu1ckGof4OXrdgbzaFsjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVsLaKlszXu+SdKvrye6OIO4BDqlyH4tXudr2N2ignBWww4Uc8VYMfxgdAO8lNp7H4DmbfOXV5sDWpMtcq6s5VhqBy786GoMndPugmXJPZHzs9eQYHGatNAIXVZFt2OCOK1+CbAMiY5aXGYWKPkjjDTdPnPQ02mn9yLWztPHUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gb0b17iw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb0b17iw"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436e8758b91so146961f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 25 Feb 2026 15:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772062876; x=1772667676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=896H1+Wxt76OuddQ568kaIniMJJA3risn5GSiPmJdUU=;
        b=gb0b17iwh1Rk+h/02HjK4kVnYkL9PiyI7+pJgeHXJPsx1AylQKM+D6cHxsoxCnCVBu
         i9BEYnsGzFz6E2ISvXRkkW9W/tyBwctktyCARpSwNsO4DzSox583dvnbW4es3wh44SkX
         QLAyZHRWpe1XNQhw5JeTf02Hmu1l4zvPjUAPuPLPV+jTtEfguMaLacAty32W6sYnUYAd
         QqvdCpWMCxd2SNrfSLwj65XZHidH6MNVRm8sHOsKVjPV9W5TTzBO6TXIUflNaAJdYq6+
         ZBjAmgxOWlJUdxJTayxuFAbzSJIRI8yfFnK45Pg6ylAgxBs3Wpjk1pL/STAOIes3rcka
         Qw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772062876; x=1772667676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=896H1+Wxt76OuddQ568kaIniMJJA3risn5GSiPmJdUU=;
        b=jK83TojONIGinjDplfJRkyrVWa21s/tz3H/UdC9rUClFdY6FzAQUsv2f0zXkuP30SA
         abTOXPtYYA4cRXCblKHT3S2UwYbGJFfDV111+aLq2unhoZJRH9luTQnko8H6NqpC5Gj4
         9T0fdawjMeGCb1oRjp/EA6zvnMhcEITqOYBfolcqIJFEPZ9zxqo/BvMVCiLacfxn0orv
         1virw2IlbzmdCLFCEq04nMObRST3wB+ovgfNJGUwaaXUFqLo+puHGGrMAffeoi+6ZM0t
         mZ8UxptM2VOJ13FvpS+Wjg6QFBzcRlS+s/gjWE8EL8QhaD1HhR/BKSC4LsfTK8jTbpVX
         8o8g==
X-Forwarded-Encrypted: i=1; AJvYcCU+N/DMqIiix5mh6du3dLsoN3iGv+OmRXlWt+9L1/gSpQUhHQoW0M2ztPA5KibN/1bB+mLDCo3qb38gfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyspzk2ZnPAUxIPAz4U2L5aISXR8PNpJyU2+ZqcFiyECDNgKVWD
	xKnfE8T061MfLAZ/igE5taqa2oX0AlGdgZwpWlPa0kfNpkbKJP7ApbkP
X-Gm-Gg: ATEYQzz7uq4JEvH/NR5mQxQl27awKVbGuDanLxvfJ6jkJiZ3jM48ugNEf8FdgdVcofN
	LrzUYTDgU7e6jin4B0A+98lasv/T2TSCze9qH7RMNvxDf5rBraXFymT1hqtd8O8PsrvPNafsav3
	DmO+AMYkGsmMGIL5YRvyu03kjql6ZB2pnzV6WDAoAALsvnSnt5M+kpQH5iFXAznZpCd9axQVCLJ
	woVZlRYiIhwCdjfZZTGfY65YbYPCEwVenHjVy93u26BstBwtV1DEon91qnVIeRQcTx6I/10/Eh0
	oQ5BUf10J1aBh7Ce7lkLKBQCvWc+fVNZocM+4YDCklHwmmUid3MJVroexOu5SB0e1jAhGbhp404
	8SQKlemS2fVfaVPIZdOxRczur5Ei9zRkC+IpGTP8GRH/1t2yNxXmZlldxgBzIR+jrlBn2S4DjoN
	dtcvo6b5vpcJqZ1SROM5+Hqh+hbdfP5AzUzuzFODI=
X-Received: by 2002:a05:6000:2890:b0:439:938a:3de1 with SMTP id ffacd0b85a97d-439942aa1e4mr4235351f8f.16.1772062875848;
        Wed, 25 Feb 2026 15:41:15 -0800 (PST)
Received: from localhost.localdomain ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3fc12sm35307352f8f.24.2026.02.25.15.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 15:41:15 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: "Jose A . Perez de Azpillaga" <azpijr@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v2] staging: fbtft: fb_ra8875: replace udelays with fsleep
Date: Thu, 26 Feb 2026 00:40:36 +0100
Message-ID: <20260225234100.152320-1-azpijr@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225204602.134218-1-azpijr@gmail.com>
References: <20260225204602.134218-1-azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The write_reg8_bus8 function uses udelay(100) twice to wait for the
display controller. In non-atomic contexts, fsleep() is the preferred
API as it automatically selects the most efficient sleeping mechanism
and avoids busy-waiting.

Update both instances to use fsleep(100).

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
v2: Switch from usleep_range() to fsleep() for modernizing delay calls.
---
 drivers/staging/fbtft/fb_ra8875.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb_ra8875.c
index 0ab1de6647d0..fe95ec6da064 100644
--- a/drivers/staging/fbtft/fb_ra8875.c
+++ b/drivers/staging/fbtft/fb_ra8875.c
@@ -210,7 +210,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)
 	}
 	len--;

-	udelay(100);
+	fsleep(100);

 	if (len) {
 		buf = (u8 *)par->buf;
@@ -231,7 +231,7 @@ static void write_reg8_bus8(struct fbtft_par *par, int len, ...)

 	/* restore user spi-speed */
 	par->fbtftops.write = fbtft_write_spi;
-	udelay(100);
+	fsleep(100);
 }

 static int write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
--
2.53.0

