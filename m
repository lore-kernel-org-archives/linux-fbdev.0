Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913392;
	b=pJ8Az9tJ/FOPrdv7wvyypxNydnCklfp1hqweJyE7tqGxE8mr8Le7MX6D2P09y3Vd8Jbk
	 J8Igtp0Q56zr7v6glFJQx7NTtvzHw2Wc2C984iu3mc1Z03oExdQysqoLuirQf/Y5XETSs
	 ndyof+pd93hZaXQsOJbZaZLCEgPEnb0JqoMGqR5ECfpmmMaHeKL4yZ9HbmBqLer29IXIz
	 e9HvyL769uLWQR2YqF2KbQ7HKeCh1XektdjJkTFWZxef8sZLZe9XyRJYsnmvySktrlqsE
	 GbzTeLY9DVpfFT9vaMK28V6C35IEJ9pxd7xkaN6nHmse0WeCSpvEuHaHya3HHVQ5Ahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xRj+1WgN1BrmQW8Cu7h3hEln/8iUG3pzDfaG3KwvBw4=;
	b=zLT0mcH9Lw9LavIQFxa2xp/5fLZDzO8PVhjvYqPFlTVoPBQYzxzkWm9YZqbNC6W777Ep
	 5j37bu1O1FM5zWr1bYFgE1ClDarMsuCK9TjMqniTwwYKyEQ4kUgjrD6sprOfccukSAkYT
	 v0BvDXdQed9RjWd16CZd3RRp0LCbPhImz5D6apLOsjNbvCa5sEJ8vLSTsoa/EwFw+YZjR
	 IzaVVczAxmo0CFF/BbyckD2A90T6mooNtHSVyrLrXpraKRtYgPKiO3a3ILLg4g+PMko6w
	 EFizvmP+WsU2AhHmByvyEiwcCqC/vhhOLv7Sd/4EW/IS/NQHbRwRsxMMX0Wqw/e+1rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+UsAmZG;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BA606A329
	for <linux-fbdev@vger.kernel.org>; Thu,  5 Nov 2026 21:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D35BA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+UsAmZG
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a208d93758so27705815e9.3
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Nov 2026 13:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793913390; x=1794518190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xRj+1WgN1BrmQW8Cu7h3hEln/8iUG3pzDfaG3KwvBw4=;
        b=I+UsAmZGmbl+fJKyfhrjvbUQBr+vmNGkYXN3MA9J+7vqCnUOTn4liWlg7hvRpAAgsH
         y6YitFWx9cfFARQzlbDFXco2Jk/g8SrZ57Zro8m83yT65BYaQW5QTE8/EsawolbKZq+h
         ahWyPZ5BtdZyK2a0H2aFiACQKXOChfpuV0N+M32dfOcHmOt9KrOgHM8SL5t2KG8uZuVL
         aeLjYiqlYl/fkpBqZGuI4TdKlgTlrDs8kuvahyZVurywY710MpNuTQ6VKuttnmUHaro7
         H7xStlaPX6R2ZZ7VAkKznSwQj4U/Oeq7JnbtrY3nboOhZ0viwX8HwQ1hWnDClj5WYKUx
         oIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793913390; x=1794518190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xRj+1WgN1BrmQW8Cu7h3hEln/8iUG3pzDfaG3KwvBw4=;
        b=lVtGSnki2X7g6xbnEFWzYc1qDZXUXEoXvC98ASNO/Il1PCXbelQQ5ldNx38u7qJfny
         BuBxe0tJwYV4l63KeixPsPyNQhweUTU58JQJEvjLRC3TsztW185H3vY9N7oZdrJUZ5jy
         T0uzFAKgYz17nK8rpy8Y9VfS7ffV0rM0JZuKsLPkFvix1/oMk2d28GIaedI6Fr7vip/V
         tRkfcN2Wk6ieSqtU9O63WbWu9PHh/YO7GALJSawO5InFbwGKhUYUNatD2vTUc1Sn+q4F
         9VIY2oS8C1HUbyHTNLEinBXmmqpFuh3cFbgYvj2iILVbMm5w+ygwl7mYyk5WqbyroUTK
         ZAWw==
X-Forwarded-Encrypted: i=1; AKwUvBwexANDkg7LpKYCfD8vxGWiQUrG8mfn/DzdLOXQTIvdH5f9mPRdeZdUP+fEHxhulsMmaitd1imUyqNXXA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+9Q0SCDgjE3XzNcSsiCnOnkjhtG7ryoq7SlmLzjrkp1X2gL3T1
	YtBQgqMx/0/1KazlXyfK4XzU3R2vzfXeBfqMXmJ69jqs1FHr2EnkueU5
X-Gm-Gg: AYBFou3crHRjVRq9tKjHhxr23A/vozi/jkfJj4kskXzy/ZPWgko+DvGRiXe/32M3ZO6
	+ubVtnZHY5Pq7TIFNLk/xqUzSFl32jn1H8xkkW7sHxsqjvSFYahrCCmUso3e+cNc1gyACmGO6ml
	jYmU8GzL0D1RikvQqeQGF9v6P1uqvuImhUgNvdwTLddt6v+Z8n9U3NOtc28gYUxelm8IG3ZrbrS
	jrM/I2sohfe2wn+MdAfl6WogQjvd4Y4X37hqXnIsa5BlxaI6W1QPKZ2B4vjIyntl72aJHIJ1ha6
	dM3dpsN7D6SgBeZepcujHWlxsO5aMBUOuC3t1bvWqDrxR5b8Dyu3QKeX6GzMAWgpFmUBLiRy6Iz
	QFI7mcyr4aCnpkOczYWYi1YK2VJYrLK1x/9qfPwRosxm+siteC11wwShjdfMJw+aRIBFaprhZLK
	EsVKKsgTMh+rfJP+kTiMRF2u6rfmTqpaM0yofRrigV3tVWf0ojOd53l9zhFJSDDvrL1gn6ATKKP
	472d/D9DHNhqGiWM8bZfUQtHalMBfxEY2uZtQLWJqWtIlX6MHe5P6kiR19EOIiQVNb6alg24yia
	qVAonHh3UvLRYwCiwvju1Qx3wUn1Up1BNVyB5P1wdkHwzLX1IzoEp59EOxaki/x1NJhC7qZPcDw
	=
X-Received: by 2002:a05:600c:8b05:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4b6e0172847mr5899255e9.32.1793913389982;
        Thu, 05 Nov 2026 13:16:29 -0800 (PST)
Received: from localhost.localdomain ([87.13.215.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fedc09675sm11703458f8f.55.2026.11.05.13.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 13:16:29 -0800 (PST)
From: Francesco Giandinoto <testata.nucleare13@gmail.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Francesco Giandinoto <testata.nucleare13@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fbdev@vger.kernel.org (open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER),
	linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] staging: sm750fb: make g_fbmode constant array
Date: Thu,  5 Nov 2026 22:13:16 +0100
Message-ID: <20261105211344.17532-1-testata.nucleare13@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The g_fbmode variable is used as an array of constant string pointers. Add the missing const qualifier to clean up the source code and adhere to kernel coding standards

Signed-off-by: Francesco Giandinoto <testata.nucleare13@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 21e310274..47d2917cc 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -12,7 +12,7 @@
 static int g_hwcursor = 1;
 static int g_noaccel __ro_after_init;
 static int g_nomtrr __ro_after_init;
-static const char *g_fbmode[] = {NULL, NULL};
+static const char * const g_fbmode[] = {NULL, NULL};
 static const char * const g_def_fbmode = "1024x768-32@60";
 static char *g_settings;
 static int g_dualview __ro_after_init;
-- 
2.56.0

