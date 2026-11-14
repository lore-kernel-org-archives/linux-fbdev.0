Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794650548;
	b=SdhnmahsTx5i4W4fCf0tfU/PiUEaejdj4zZuDwsULSLpigxkMA4VzYe3x4dFW7h+L//G
	 rTVLNlCPSAXMuk3NJNhAaatlDR2WIz0P0X3+p6ivyEISMZJb7GqRVoQkTCAOnewtl3XjC
	 s5lP09OQ/d4DNO0xa5f7GUrCoPNyjo5kkqEN6QJvZO52cdgUq2N0VOivaVrfbD3fYj08Y
	 0732F8s46++fWOtVBvvvJqTnTm+qWcFLPPXWspJ23S+++egdqE2VHlh+dMWv4OPM1tASi
	 GEbb3BCyz9UNcdaBrRTG3DlC8eYLIAt++LLQPdSOSKWEnq+f+Eew340XTlT/cEODDCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794650548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fcsL6m/fL6wR5N1Uy9uUPHQ01kHmtdk2koYY4a/ebJg=;
	b=dyXm7LMxDhmhXDz+C3uuyTc/Lq5zQ86vqEmbf4sJ4Eeu1aw6evill9/C5Rm2iMKnBCdf
	 oMt4f/OP5PWnqIgqBPfuNGX+96gyd3K3H6xtBjd9OIChTcg8kVv4Mbrub5BY4LNoxfYwx
	 79jFzwFD0OOPA2G5zJl+YczWWr0efjQS6WpnxhO6Gwk8Az9A7NqE+oytfrH4hZ+NY+ZQJ
	 AZ//X+B5EWeHXjxkFmaEwCK35jyYZ6rir9NRbhMLSssFiWzumivGjON3jKfvF4aekvaid
	 w+SwaGJ+69xy2HGjSC14M0zVPQbe43j0NloOP+LyAhXQK0o4dJU+cfZ6Xjz9ATK1IIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hcnM1uH/";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E46606A89F
	for <linux-fbdev@vger.kernel.org>; Sat, 14 Nov 2026 10:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E46606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hcnM1uH/
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490a0e72588so756562f8f.3
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Nov 2026 02:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794650546; x=1795255346; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fcsL6m/fL6wR5N1Uy9uUPHQ01kHmtdk2koYY4a/ebJg=;
        b=hcnM1uH/JOdRNdBD3zWRDS4dvhdMJbui9acV8z96oiZw+LB0SBPGf/JQg6wlVwTvQW
         4WPmL1OqCHep94fEp4HD3VDowqvNn0x+D6KNbtJhkpf43gQ++KJGx213zxovxXSpUf+K
         +c13zd8GE39FfrjEny5bGBbiYopQEpxh4+vfMFmrF/baOaPJDgZBuXNEq68KzNvutXzM
         YLrlSbhubbFsWd4aPaUSI9iorB8vmnsEg97/Wi6SHZh+3OaQdDtodpNi9XH2dGZe/kPE
         5GCC/oxTwUhQ5DEdFRmGe+uUvHXP98z7Gh7eaFk1zb8Ghw9drbXMY+QgQSLNtTrtuW77
         NlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794650546; x=1795255346;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fcsL6m/fL6wR5N1Uy9uUPHQ01kHmtdk2koYY4a/ebJg=;
        b=Gi4pBZ1NdXxgmxJbubUkuJIM5FYtoHNJVWJZIPCOUTJLRKiPgzzkfAR5WoY7bfbcQC
         j2c4YOcy3CnmFXjWen2nF6CLT8gru0K9MJ3yA6XJfl3sN7mpTTW8LM70VNmHryZk0Xuz
         rYh5sMjO4J/M8aB3BlpqLt98UwCq1FIj1VguPEiZTH30zgVQDQIAl2l5iAY9jnp+LyVG
         hh+4txBgRczF4+Y7ZvYuVlvaJDvNxCdPWYfH+Q6CvjXxLiGQgujRzO8mCkGLVIt3hVLD
         4Pim8rhNDccmP62KhaD54B8v8cg0e7me0qWTPVf/TuB8kabdiUktdlWGaisomsA+cnqO
         6WLg==
X-Forwarded-Encrypted: i=1; AL+hErE7RI7fmDHO2fF0PJ06+lS8uqz8BjEcY5mxNeJY3QeQf5azFhjcl6ocaINDMYFFC504NrsMkVSA1hvnIA==@vger.kernel.org
X-Gm-Message-State: APuU4Z89Vx0w0n9L4M45mUi6R+IrhlAVw4aMviXfaupgCY19vKlLoP32
	cbPSwnlRjGYh3AbzifxxLABHDkIlsImEZZOAJ7PBZVaN9KYAvjvjMOWq
X-Gm-Gg: AYBFou1YM6v5qgZ9vJvM3qFUlD5gbdRzVOOw/S044LR5VWyLFWnZkbfFcwp/9L3KkWI
	miUHOrwa36io9gfy3Qya3kXdyCYXlLQoi6/FOwo9aIOS1QQhfPgMFFOaoZNSZnbfunSgWit5YS0
	Mw84Qa9nHl0BHurPIKpNa7YMJPD3nmYxKDWYjjUhw9dG7Nel4Hv02AGPQJU+iPEy4UmFm9l7Wyv
	r7jscb/oz6V06GKtbLXoCDJEvrEBdvhiHPqRrOtPsBFaNVS8NzGT4JpIFNbXiCLhPbx019hfGj7
	pCfYZ1JrfUrlqxHQzzQsbAqoOm+pkfqV9a/kM3B3CO3eW9sWTxxawKTAyZjQpOEVPZUDxwC8zbX
	VzxkpDopiarKQeEFlwRIgMGB+68eaJxtVY3e+GwlfB6O0H+NWrizbqgFc2NwaAWI8WvE9wMOV8z
	qxFGPwdf1AfWHIlEMzGT4lkT+0TX9UulWATDC+CvcjAjdaM5hkn1eG+zedkkVFi52ii3AmfQS9X
	qCVKqKdKhvXPHHY4bB4ytPcqPMmWLoDwLlF4FiM0eqfJ/Mt9bHAEoxN/Iqjy1m0ldpb9bI4+Zks
	BTMwXVnQgWTFGsPmy7cD4xKIMwruT0jbrw==
X-Received: by 2002:a05:6000:250b:b0:48e:5e20:1371 with SMTP id ffacd0b85a97d-49c6dc01593mr9674006f8f.4.1794650546159;
        Sat, 14 Nov 2026 02:02:26 -0800 (PST)
Received: from DESKTOP-TMG47OE ([176.41.25.224])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c608cf46dsm10520184f8f.43.2026.11.14.02.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 02:02:25 -0800 (PST)
From: =?UTF-8?q?Ali=20K=C3=B6se?= <shroot1337@gmail.com>
To: sudipm.mukherjee@gmail.com,
	teddy.wang@siliconmotion.com
Cc: gregkh@linuxfoundation.org,
	rppt@kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: sm750fb: Remove empty software I2C acknowledgement helper
Date: Sat, 14 Nov 2026 13:02:07 +0300
Message-ID: <20261114100207.9124-4-shroot1337@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114100207.9124-1-shroot1337@gmail.com>
References: <20261114100207.9124-1-shroot1337@gmail.com>
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

sw_i2c_ack() contains only a return statement, so calling it has
no effect. Remove the empty helper and the ack parameter from
sw_i2c_read_byte(), along with the parameter documentation.

Update the only caller to use the parameterless helper. The GPIO
operations and existing I2C bus behavior remain unchanged.

Signed-off-by: Ali Köse <shroot1337@gmail.com>
---
 drivers/staging/sm750fb/ddk750_swi2c.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index e63f3b00ec4c..54ce355e535f 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -201,14 +201,6 @@ static unsigned char sw_i2c_read_sda(void)
 		return 0;
 }
 
-/*
- *  This function sends ACK signal
- */
-static void sw_i2c_ack(void)
-{
-	return;  /* Single byte read is ok without it. */
-}
-
 /*
  *  This function sends the start command to the slave device
  */
@@ -300,14 +292,10 @@ static long sw_i2c_write_byte(unsigned char data)
 /*
  *  This function reads one byte from the slave device
  *
- *  Parameters:
- *      ack    - Flag to indicate either to send the acknowledge
- *            message to the slave device or not
- *
  *  Return Value:
  *      One byte data read from the Slave device
  */
-static unsigned char sw_i2c_read_byte(unsigned char ack)
+static unsigned char sw_i2c_read_byte(void)
 {
 	int i;
 	unsigned char data = 0;
@@ -326,9 +314,6 @@ static unsigned char sw_i2c_read_byte(unsigned char ack)
 		data |= (sw_i2c_read_sda() << i);
 	}
 
-	if (ack)
-		sw_i2c_ack();
-
 	/* Set the SCL Low and SDA High */
 	sw_i2c_scl(0);
 	sw_i2c_sda(1);
@@ -458,7 +443,7 @@ unsigned char sm750_sw_i2c_read_reg(unsigned char addr, unsigned char reg)
 	/* Get the bus again and get the data from the device read address */
 	sw_i2c_start();
 	sw_i2c_write_byte(addr + 1);
-	data = sw_i2c_read_byte(1);
+	data = sw_i2c_read_byte();
 
 	/* Stop swI2C and release the bus */
 	sw_i2c_stop();
-- 
2.53.0

