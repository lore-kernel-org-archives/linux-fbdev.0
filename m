Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A853D3CF0
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683269; cv=none; b=j1R0Rf9P3GRPc2yH8PDj35gQbyGx9YlfHHWxHJGc73jxB6/HhJP+nA2z+730YvuhooMFkeQelLawJfG0F7rDWoppVtfPU2rmH3fCb8Q9Vy+gZ1AdPA5rRjIVCRhE5i+TO6Ga3/O8K+IQCU/Q7o0M0rmOnmGl3nFMe+RsWckhpzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683269; c=relaxed/simple;
	bh=Gwi2SEZRxxZPvrxGh5xpiGuXapIPqlS3eMFp/EcaCRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnqdfJ+2L4w8DzD7tRMrXm4vFKi8VsewdblNXX2ixvOeJkkbGYQL5FlHO2DS61NrB6DBfd1jAtAOFpzi0bluqmGVNC3TpS0vQMM5oV9Gl9+iAojSzNNQkDpwSu7BP+gXcBA2C7Bz+GsdgsrO5OM8Q8q0a6cvBhCWhdRPS1TrXAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIQvHTqP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIQvHTqP"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so758346766b.2
        for <linux-fbdev@vger.kernel.org>; Wed, 17 Jun 2026 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683257; x=1782288057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BStSfLs2cVd2uwZhDXiQO2uYMri4qNRZ0wt5dxl+TLw=;
        b=kIQvHTqPC5VkRUDrpLCtRDZpUvjzaV9nTZdILVN2cxG1d6Oyz9pmvLEnPozk2o1wZo
         h474uWl/pxK41XGij4r2JYew0UA6KoyoxQyE/39flbfeBxwMwXhYAEAHsyC3c9bNRhP1
         hRr3qJGbvH9zCnmKdb3R9hNRrpLxPW/VacDkgecOxXmZSBQ8kPoudHAR/EX9uG1CyiS6
         NJk6FGJaTTV2K/HnXKVsolYx0wJUUfT8zwDCCs+ywLPBRJoikv2gWxnYjkov7uKaoG1/
         hM5lhI8hzdqZfKo+c6549baqe6L7LV1jel4GgJ+pMV1Q2AF3z9JapDJG+5i7dDswNJkF
         cUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683257; x=1782288057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BStSfLs2cVd2uwZhDXiQO2uYMri4qNRZ0wt5dxl+TLw=;
        b=jnc1IXGZ81Xj3aPFsIEdyjyiMN+HvGbwiml7Tn/CzOfxamXEcbwLfvz2cHMyyk2TAL
         TseHCG2Crd/HsP1TtYOFiy1VPJe3SdihniDGD4NniQhmVrdtwW4ZsYBh9xQCn2BPR88+
         yjhNnqvQRvJOVPq6NC1PYJd15DZgtAOtE9vTxi5/CGP13iLlSfHMS4OKmiWKLSLe80F+
         iL4DIGbh1hfa8x4XGUjeC8czZ1kn+qvkywae4SkijhOgmZnd0Na4LnGVvUPPAQjNBgrN
         o5kyIPdOqDJngdRHZXEgJrFdiUtqsoaL4QAn0xihPqSBJoTBNApjffQT/KedNHiylwdo
         Q0Dw==
X-Forwarded-Encrypted: i=1; AFNElJ+4umH20qILmk9DlO1NTokZurKmKjdsApElDaMWpvOS8SdxHYOfdPQFNMk10Hk1owh/Qg7je3ZllMaDQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuXAZTwEN4p9Bi8MaRQLEkhycrFSm7M0+jl5Uuu/+Z1uyzJgd
	vFNel9Sf1NgOdQIfUK6dr2e9BZoZ5+1GwK0WWXYOtgR/kaDz8GATYfQ2
X-Gm-Gg: AfdE7clMf8zJT9AUHcYGLuLJ3eCpqNj/FRV5c7zh4vjJio+zmCr9beKBbYkWkj6GxAV
	kectvUkTEAW0WNcPnP3lXHa1JcGWuzghGio06ega5IEaU1SdeJhVfD0a60+LMQOo1hDEL+Us4Y6
	7rgyBpM40USJd3W1fWm1uOqEdGVILPDAVBjN8WqVJm2lWsKYCdVPmyKn1BDu6j6bCy5fuxAbkm2
	nBXaYV1Et1ofushhwEjlKCVcQKuGzINfnnUO0rsZWEiKBAbkMhWs7k1kJAAJr74xRcowAgsivwH
	9t4wT7e7yX7DjLNNpXFE0FKJ/JuVsMULJ7CQN7B/Mf3v1vRHi1ChL1tuf+Cxh2/OyleKgdkDytr
	ElXd8A39/i/9FIKK7RkL5pG8sVzah6ulw/vNOnQ9mm0RoG2xMAR4uVhNrFo8MY6W3gXIxEP6Mjt
	Ht9g==
X-Received: by 2002:a17:907:928d:b0:bd5:405c:7964 with SMTP id a640c23a62f3a-c05a5219b56mr201079366b.48.1781683256443;
        Wed, 17 Jun 2026 01:00:56 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:56 -0700 (PDT)
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
Subject: [PATCH v5 10/14] mfd: lm3533: Set DMA mask
Date: Wed, 17 Jun 2026 11:00:27 +0300
Message-ID: <20260617080031.99156-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
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
index 4b5d94e9ed27..db8581d1b073 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -480,6 +480,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 				   LM3533_BOOST_FREQ_MAX);
 	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
 
+	/* LM3533 and child devices do not use DMA */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.53.0

