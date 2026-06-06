Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E430E85D
	for <linux-fbdev@vger.kernel.org>; Sat,  6 Jun 2026 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721917; cv=none; b=al9NFe8LPXUrtlq8I6nebTzzdl2e4nINPYcVfPMgFozJd3nU8RIGvHXRCM6rbwjJAF8ubpkGyBeCIbRaflK4FskgCbZlN+hBuGoriOVnYDhZXUt6Ufhv63/l+8QC9IHsvQzN9v+mRGR5vEh41QNFIvU0gH2UZ8wmeekLXza0pVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721917; c=relaxed/simple;
	bh=Uj/we1VRlh8Apf/xbTm9Cclx4UJKJna7Lcylt5N9akk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4/6ufigc6QI5YWm6IdiAFoaLlWJkrtE51xBZAVj2Su60IHjjilV04TUYZ84GEIH2qcnsokxgaotiMw4B16XABO/zaEpjjPt06PdYttRPwRT8rXtiFm7kV0yeBKBRB4aKbZ67IJsUKjTMIceF7ywb9CpVlLFLdZCRCIk/jTXabg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/unh+1k; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/unh+1k"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so4615270a12.2
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Jun 2026 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721915; x=1781326715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRUfH60NeaMpCaCx84KeDTGgGO9ytSJVg0ZaUrTfvB4=;
        b=A/unh+1kjipGI8XGzFvTj3U7czU7f66fZb60gWItRppp86TQsnJc+ZhnwwWkEztngk
         ZXZdFKYNLTDYIFhMAFv4yK80g28YjCSYosSXktQqcM1Xbvw2X13FKQbo8kgMlLNOZBkQ
         sfBU9e/miezAaRfQ2dXRIlGPPCB/hlsxZurDJx0phhXKefFiALFQFJ8cWwCLPlV7Jx0l
         pVbxBKCYwhIvUQ80WgzxZ78SY60O6A9sHgIXpvtbK+FXiyaRiJc5K41Oqxhttp6Lajhl
         urzHYMnon6ajDNumWML8ydBCUy1XktRrDxurAkQ1FYfPQtIWEa9x71i1AhNSPFdoEIKK
         SHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721915; x=1781326715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gRUfH60NeaMpCaCx84KeDTGgGO9ytSJVg0ZaUrTfvB4=;
        b=iGexOZK4ATqcdiMTJpipxBIjIBUgOV6dI2eExKtofEqH8wN9LOMx9OdMv+1xhQ+xCn
         iO1Gz10znEBKeSte5VuQzokHOM3nA80RRyoOx5TSpbNie3kAbe+Go+wn5JUKWChRV3OD
         bDssJJ9y9oPRBwm9GEDCaMAeIzzIdoeVxZ3NvpIIJdQyx33UlPjVombpzA3OZ8q86AoO
         X9iP7Ae2eCNkIWwvjKLFwsLAtThaF8UdDb0pA63M2MmB+JTYJBJLNmNhf5DmwvAOzMRM
         uFRyryOEM4wt+SIZ+wyYbG/3LFVpjnEZuHo5KQpZR+PArm1CWG0DqO/3N+fa6V5uv4zW
         2AEg==
X-Forwarded-Encrypted: i=1; AFNElJ+WqQWSWay7BMdeZsJ/aQAAF199hgqZiEWogTZx49+eRB6lIcvlahawPup19duaArOsyrkG2bVV7UgSAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/jGBN/s11BJ6QebThV88Jw4NsDJnIKhhrreryLnzQ8SdoMqvq
	B6+s7eW/FtDgI38ZcSrpRQroQMP+I8DoJkGzibKFwcTJY3v/d2XwCQaW
X-Gm-Gg: Acq92OG2JYtOnuuwKj49bOmCOs+Zr+ReVlMI9d4BUcxYaX+58LvY+X9l/aPX7kxPZE+
	DIQ1DR3Xea8UH+h8IND+k2Krr7eH9nOCTXu2AZPFC0J2aOg1G47MXmQwwvhl2Sgnxuj8tVmb9ZD
	/pMUgU7AvV+Apux9fA4HmhbA91W+HUYXiUn8a+Ub49xFBdrIRRZHjoIHk9PjkDnZtYV7Gb0pxCt
	wOvvy2aH6e9WUrrK6D7KEGaBzZXwQxcAn3kgKVH5AHqAQrms9Ce6rkFN0/CUr4TeQPH8w7BDq89
	VW55s/7Xyor1fu7fIofVFSZ1keTTA/t2bbPcB467qh6R1WvZP21IxYuYAPK+/vk/kxYekUpklqr
	VyuVVmmmGFMeLlNdkt0h3sdKUgaTsH7Mpe8UGusMPee0IUKsqKHKf51Vpz5pQf5/ywfZcJNd00A
	rGnrCVikWHGwx/eiqNC8X7nWc=
X-Received: by 2002:a17:907:e117:b0:bed:62c1:ec with SMTP id a640c23a62f3a-bf3704783c0mr169855366b.13.1780721915036;
        Fri, 05 Jun 2026 21:58:35 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:33 -0700 (PDT)
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
Subject: [PATCH v4 10/14] mfd: lm3533: Set DMA mask
Date: Sat,  6 Jun 2026 07:57:34 +0300
Message-ID: <20260606045738.21050-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
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
index 500cec3cceba..5d17da1d998b 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -489,6 +489,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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

