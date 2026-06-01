Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB03DD85E
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327162; cv=none; b=leiLbW5Ulzg3xa8IDaWcWZnFB51Zf9SsoQ8LYvtYjnvpc4Sj1TzPm6R3izRTPhcI7J6bzRT+27mdE5v8uIRar8mwzK7o9jlSK2YlViYlBzye6j9IpP6dvAm6T7PDVBfhV1LCdOLWDY+4z9F9UrjRrB9YNXaWdPTxYw9KF1MNTXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327162; c=relaxed/simple;
	bh=x5K4xFRFiQMCHrQaFBke2R9ygwO72RPNpHJKJvM5Ef4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfnmpCmPlbHScjLiiWNAXWrE4iyZ9deGs/N76MjrJ4Dex5OhU0BmBlkGi0zZeI+5dt9hlPaMuPJ91QRcIcuQLBmrLsThMJoPv8PNHnyXCEWq7wd5BgE0FVGgwNfWgRRxp5c0VWJznOsJ0FCpPyPOD2wT/thTyAatq9GHGnwQ9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=li2x1C4P; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li2x1C4P"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso1306563f8f.0
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 08:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327148; x=1780931948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p24QeWuEOdkZHaL1V7uOjlrxK/vJ1VAKn0KvK7P92s=;
        b=li2x1C4PiZsuigqBQgmGPTakdR5fFV/3WLVzPcpYVZL0X2xEi3lq6jjWq3+Q3M/IXr
         TTP7uawhaRSjKjbM8dUWLmlb4yohmVNpvKZQTpaFlkWfZEelDbjdJ889AMRWxE8qvUCT
         oxMYi69LCvHXYT1VM0MnARsd8KMYysw5y03KBEqL20D4mYbzSXKfOBr0+gFqg6ClMtiZ
         KNrU3KI9U8zQhcBvKkNkyoFAE7HZ0YeljoE96sV1UEmTk075TIt3UJ+0GYausJlaFDT0
         YwxrwQFSnyHWhL33LdSAlI7TmHVST9XlMXOkieaO6s0q11zD+zTfF0M9Da5VohrOsnJJ
         biTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327148; x=1780931948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1p24QeWuEOdkZHaL1V7uOjlrxK/vJ1VAKn0KvK7P92s=;
        b=f7YpNOxIOTQyB7bIZ1+5fXTsF3BahXjJ9Ap14yUYgqimCsRMJJ/v101/h/NBZPIw01
         n61oPKFfr6YTodZtLIcRzRBKtipdgBwQUDbToX8+KD4P+FsyKvmIWhXC/6G2QsNJr9v6
         kxZI34wIkvJ3esoDB1dsT39JlD705Evnk4aisPRJ4mQ6pWYThZwyNeks2w3j/1+yv3lE
         RHkVEYego0Dr9bscD+L++xdsfp8ZeuLu35etI5hhy2mCidOhvGrZVuIWgz10u0o71a1K
         vMk7L5GvGDIrY19txSoqU4g7h+gHUwFbTPM7KQixpDOaPaIbCassUK/Tka7GbMsCmI80
         /GTQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Qlxnst5wnth4/Eb6lAVd9GD2JlySbWlBwHT96lP4Xx8meF/Zc67FclUFcYnWkoGWGMtkvtM6sSrguFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQOab9cufKaPoBPEKOOCtJQeqeF7TmjDwZnbsZa3IhIPApKuM
	HkhyhtSoM2478fS1X0zstQf9/LTzuRX8qnZSaVSiy/yCNXIvSW3Julqb
X-Gm-Gg: Acq92OEYlIc/KNT2g+lXXwf4dESr17ea0IbKsmP0TUKIC43+7PBHWKBbtjGI0sO1XfT
	xBVpVuD7qj+ayWiBub63Je+mPVh0T4PKxtqLXH9HgEKICGLJpq7J2uI4ovf9+uW3QQSue8YJeX1
	QQkeA7jd4blAYQRN55mW295C53fIM02JbLM6GiFfeLklS+Mgqaryz4bRGBTuwGuzSZXPcPfv05m
	U8PjcQmT5wlEPigwnb6PG4yBQn2ECROco6gwnbfq6m2SS1kCggKXEl792T6iXX6F/psFqYuPvS+
	PfKnb/EmF+L5jat3zukXVnH18Fg1rdYyl8bVehFihiLkhSrBr4JjFuasHgTCd19K8f1E/5aH8gw
	BRAefYCQgL8YGgOof+VU7MY9xB6k0AR+SecAIyTQtyzgOWFklxEMDN23cjpTNlfyxth8dbkss9d
	z4nzkpZzwFuPz/7cQtlja8asg=
X-Received: by 2002:a5d:5cd1:0:b0:43f:dd91:b022 with SMTP id ffacd0b85a97d-45ef6b791f1mr16538591f8f.35.1780327148356;
        Mon, 01 Jun 2026 08:19:08 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:07 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v3 07/11] mfd: lm3533: Set DMA mask
Date: Mon,  1 Jun 2026 18:18:27 +0300
Message-ID: <20260601151831.76350-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601151831.76350-1-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Missing coherent_dma_mask assigning triggers the following warning in
dmesg:

[    3.287872] platform lm3533-backlight.0: DMA mask not set

Since this warning might be elevated to an error in the future, set
coherent_dma_mask to zero because both the core and cells do not utilize
DMA.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 4dca5641b774..b597d338d6f7 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -491,6 +491,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 				   LM3533_BOOST_FREQ_MAX);
 	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
 
+	/* LM3533 and child devices do not use DMA */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.51.0

