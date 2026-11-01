Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793558971;
	b=KksOe8IXuI14LpPKWHO1IfIfsP13S40PxSmE+J2cLeOX4z8veGVU8OxXyEOJTQWRx7ic
	 0p25yxiVnxysikRCFVBFqkormj7dWqx728zFK+iIGEW9IY+6IRP6ji/YiNVOO7J3HfzJq
	 Noa9G5A9gDr1QCQF/XDYXqm4uE9bhEjBoXIE7JRvnamhfR4wiLHfV20yFPya0/332rg2e
	 zr+bEm6jw/7lwMpk40rKomSmyRb/mc/j+ntxxRykrNoKlsyop/7ZV9piji15dK/BnhHoh
	 K4fFpzjrZhZI9XFHoq6Z1bzlO87DM9ATFS/Ol8MiPuAVVj1PuS/ebRTGJHBtq6kzV8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793558971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i4kMYe4pF05BAeSRiIgaVbEHMlhyZzqAIkz58RqSejo=;
	b=i7BsoFlRP9JczOvqHQ0vcOqXCC7gsAKIBjqN6TZTwUFI+IgitTNCV+qSoFJMJ4+5Fivb
	 I0FeKNikoVfku+9Mj9+sQy+pmTzgw9GdjpjlS+0imNg8+EOCRPqZCMNVk9wFW9fR+K5V4
	 PO1VbKSWw4Vx8we1g7SivZ70QEs1NjBZXpgZopz3Imv/onu2lfErNKoqD5CYxKqfHAccZ
	 4gxa8Gd77pP54bPbhGwUrAzFO58nbkL52aDNvBPnh8MwhyjAfBka1x0aenWvejRCjhMxO
	 2h9U99QioJAu3Ohtz9f/8738+GlAT0DJAKKz08AEapiPElmvbk3lRwmRXMLN9jhQH9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="T1Lt0/8s";
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915E0606A324
	for <linux-fbdev@vger.kernel.org>; Sun,  1 Nov 2026 18:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 915E0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T1Lt0/8s
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so1222974f8f.0
        for <linux-fbdev@vger.kernel.org>; Sun, 01 Nov 2026 10:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793558969; x=1794163769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i4kMYe4pF05BAeSRiIgaVbEHMlhyZzqAIkz58RqSejo=;
        b=T1Lt0/8sM6vsdHVtQUrrSjN+N+RGfd7oTw/E7Iem+qy3KEkUIPeeqSSNSFbKnZ2xWA
         gP/NJs9vEK0U1VSFD1vACyL62pGU+rvu7Tgzc08NI2GYp5APsDw7XQIu/XC8yOW0I7cf
         zqR2oxVp3FXmzSpPedq7wro6heKXVbnxubEjVnVnauasf9M4RLRAY87NZR5sVnm1Hupm
         oCMvcBmGfXi2tA2qJhRtG7YAYZKsvq4j5k2MBzw8NZZozEHTxDyyLypNZs8DdcL2mzCr
         3yTzJQ8JCh22d5NUpgB4CVuknomiJM0oB5kOZkCQLUElyv26pTWmIMbFUUkUwa/l9hPo
         BdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793558969; x=1794163769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i4kMYe4pF05BAeSRiIgaVbEHMlhyZzqAIkz58RqSejo=;
        b=wf8a/9BMOe6QwZKVuPg4+mXrtHYrUsEZmtfuDX/UdtPkdDsSpu2IAs67jxuO+C2uSc
         aAJef6/OU0oJOdgDXI1SlyVnNeZF1h6FUKdLkzXpagNa3unWZTeSEWDmaIVynewwrTOQ
         WDHSzodh4sf8IAGak0OF/5jXwNa1kog1T6A7ImdUNjkg6yo/fwHHshHoGaqhNDpzaQSW
         qCC+JKVnb0teji0ky8xO2/zAURE2gRabqeIhr/B95eyLN/CPmLTVq+acpJvzfGbHC97G
         6xhaKFWkjRi6iNxJpg6/7qIHYRP0rsKD5iqnSpN+TeUdAO6pN9qp2t5BZm2K30sh58Xe
         M14A==
X-Forwarded-Encrypted: i=1; AKwUvByCz3WN0W5sspUtBcE/g9S+O2Kh+97mb+qx0bSSBFtsRzCUivXpnEfsUIg+HiH1/8NKmnIeNjCM5AefTg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/SLfaQmDft5syui69EECsTsODkbCQv1TTGXzDOD2yNzODHjXJB
	YJfLtdh2AwYq4UD93NLcHLdCNWK9oHMn6UxMA/gDJ6xw4Icxy0uNrvE=
X-Gm-Gg: AYBFou0uejjK34wBiRpdOBEtkooRLCwjwg30qhgElSz40C3WyiCqnqtS+iNJx01OTSX
	JpPB4AFhdz6wTHxZAToc5AtvZ2nOoyHW8zAowDY5RJbBn1ac2j4iqrFd3XiqJJkAmzg6xRgQeU+
	c4947N/FXEFgOse6COLLfTB85AG50uPiulGJl0qOWa9TI5nqrH4/2EahaQw3eZc1+grzndtd3+4
	KT5avaF+GLa/Zo20o2OjkGLZxSN4nqDGUMeOJDehGGq1d4M0BWHxc38NGU47Co+ad6/j66I7uOQ
	X+/ExhDg70QqriK9tp5pF8MHgQVXzapxq3a7cTaqjOE4LTA8JmN/FUWx2uV27soV7D6rnbYQTR4
	dKvhHxddwB6ea26ig/FdlmJle2I/bqToCzd4+Shqi/uVOdGi66zpp06sNsKw5EtaXTU9i0eRhAU
	N6eieTkX/jL890LTOZNCUghaE33juQu/Y0PKpcmy5R5/CZOFCL/TwMyL8EiU3hvb5N5iZGFka8Z
	+lKHhtWHYLbYbpPzycVVkQ4bL+N7FXuMpg1x9B3ZiLtBdJZ5ldM9YQRO4LmvYbQrWhzBUmO01wR
	yFOJcuIIhVx/aY8FJlbL/S5UblNf0hqM9U3ZppSk2euIpflE8SkJHGH8Y/hE9j17sf7oe12ry0n
	P8YWSzgvIrltc6ktY6lVUFldpkfhpd4VgyTvJrQ==
X-Received: by 2002:a05:6000:4012:b0:48e:678d:396e with SMTP id ffacd0b85a97d-48e678d39eemr26985417f8f.9.1793558968758;
        Sun, 01 Nov 2026 10:49:28 -0800 (PST)
Received: from localhost.localdomain ([81.199.56.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7270asm15530548f8f.11.2026.11.01.10.49.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 10:49:28 -0800 (PST)
From: amit <amittibi123@gmail.com>
To: andy@kernel.org,
	gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	amit <amittibi123@gmail.com>
Subject: [PATCH] staging: fbtft: remove unused ssbuf member
Date: Sun,  1 Nov 2026 20:49:15 +0200
Message-ID: <20261101184915.33899-1-amittibi123@gmail.com>
X-Mailer: git-send-email 2.54.0
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

The ssbuf member is documented as unused and has no
users in the FBTFT driver. Remove the unused member
and its kerneldoc entry.

Assisted-by: LLM
Signed-off-by: amit <amittibi123@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 40a7567df..3b58bb9d7 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -155,7 +155,6 @@ struct fbtft_platform_data {
  * @pdev: Set if it is a platform device
  * @info: Pointer to framebuffer fb_info structure
  * @pdata: Pointer to platform data
- * @ssbuf: Not used
  * @pseudo_palette: Used by fb_set_colreg()
  * @txbuf.buf: Transmit buffer
  * @txbuf.len: Transmit buffer length
@@ -192,7 +191,6 @@ struct fbtft_par {
 	struct platform_device *pdev;
 	struct fb_info *info;
 	struct fbtft_platform_data *pdata;
-	u16 *ssbuf;
 	u32 pseudo_palette[16];
 	struct {
 		void *buf;
-- 
2.54.0

