Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2479A1C0DC2
	for <linux-fbdev@vger.kernel.org>; Fri, 28 Jun 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586123; cv=none; b=ZwphAEP75nyxzdA1fG1rcKyRCe5U4LkJnQQE3zeh601+nKQpiGuBetq7JAeRBznUt1wioShuWI8FDKCIjg4aGy0qb5rrM8aSOmKDqAgk3rPHj0mjvGUQbE91CUnJ+bn6kmhmAQNOuB/+84+g9na6FLbSdTN9IyRZuLV8qGGvlc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586123; c=relaxed/simple;
	bh=Q/6aXC/8+GSOxHhveuvUiLB8+gebFnjISImR+2r01po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRmIeSNu2Et1r4tgdUttKTpEx6z65t5e+iVZSuYG91jkY6Kmzeed7vxIgOFgawRW+86SetR7m4ouHWBXhWnbrh4ZFm4eVc3E4F0DdXK2yWsHu6LtfFwVjnE600kJZPgySS0xbNuO751GjX3fUhRf/Ti/b7N5mHg3U+oYoBp6jNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nIH4fxeq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nIH4fxeq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-424f2b73629so7036845e9.2
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jun 2024 07:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586119; x=1720190919; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYMEI/fziuNXffhOeErHosHLEBtp7W0eQI99xejXllE=;
        b=nIH4fxeqVNrqVL1Sv/VDbhWkEAVwTL4ZBqGZcjJwp6+XrWD7NPy0qP0WbL8ekFc1jW
         pfe+Pi+pw89o71JqvJURQroufVsSoOO9/IIoeETfevG0AReqahlcY6QdwMoObkKaLGN9
         cEl4YGe0D3DMILEztWd9vqrBBixVMuA0mqjOUeWYDCwvhJonAbnbx28PZ2SkQolCJpgB
         tPyB83h+zqQ+OOcNADgIVSI0EH43IuKh9irvrOyOGY1Rgh182hGUd87yPySiRB40P7iW
         ret4AXNHZkxilVgEOHGcJRXvJZK6dV2YTpzImPorNZR38Zv0nNTDXjvhKeCiBxuRk0Hd
         CbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586119; x=1720190919;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sYMEI/fziuNXffhOeErHosHLEBtp7W0eQI99xejXllE=;
        b=i4pOJF2xuim1szEzpfWeSeFvKfaVza29h8ouiLAWbrj5IqgKz+UCswdz1gummhXPWo
         xcAr8gtIQyokk6qQxrK8x4bQGlXca/I4CBnSMPkU51k0WILD0rNNLk6K4YAs5kgL1J/5
         VEFLdti8eZ55GhsQyQNBP7erHLkzNBxNA53iqc8sJ1rgGE3gWj7tVOJoUcVSZblaPTq/
         Mi/YsJIQFIgjDvIZiiWmDKMtHWqaduOxTE/QZ01Tfx0ycPXcRFNPfDXk5nWki8S7+l+V
         OXKCNwkWZYR4v/S1uldZQtxJ509b9xlz9PLuAWwO7am0YZ0B2fXEf4J+Ng8RUJIY1SKL
         b9Kw==
X-Forwarded-Encrypted: i=1; AJvYcCULrGvKM+zK6Oea+gogBfMTfDHfaKvX01qkH/mn008xN2AapaQTngVGFxJhFZMKVKLJeAjat2BkGDTFzu2/9im0bk/ZItFFvQjMPYY=
X-Gm-Message-State: AOJu0YyK6YyTgy2GVFw1z92k5MzKHxAHOD0cyEz+/kvUmf5ViioOv0R0
	VnHU8D+iGK2CT0FaDfxNn6EXb+Vgn+P94B7Qwe3w+mtiHV9dny9Wh87PACxklV4=
X-Google-Smtp-Source: AGHT+IFILz3MnOibJoF9YCDngKCqMwgGJJf7k5UXTYf47W6qKWVOpX3CUieTJt0QZHxktYEMu+FDvg==
X-Received: by 2002:a05:600c:4306:b0:424:aa86:cc2a with SMTP id 5b1f17b1804b1-424aa86cc80mr85713655e9.20.1719586119386;
        Fri, 28 Jun 2024 07:48:39 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:39 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:21 +0000
Subject: [PATCH v2 03/10] dt-bindings: iio: adc: adi,ad7606: normalize
 textwidth
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-cleanup-ad7606-v2-3-96e02f90256d@baylibre.com>
References: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
In-Reply-To: <20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com, 
 dlechner@baylibre.com
X-Mailer: b4 0.14.0

Normalize textwidth to 80 columns on the descriptions.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 50 +++++++++++-----------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 00fdaed11cbd..32caa9fc00e4 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -40,60 +40,58 @@ properties:
 
   adi,conversion-start-gpios:
     description:
-      Must be the device tree identifier of the CONVST pin.
-      This logic input is used to initiate conversions on the analog
-      input channels. As the line is active high, it should be marked
-      GPIO_ACTIVE_HIGH.
+      Must be the device tree identifier of the CONVST pin. This logic input is
+      used to initiate conversions on the analog input channels. As the line is
+      active high, it should be marked GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   reset-gpios:
     description:
-      Must be the device tree identifier of the RESET pin. If specified,
-      it will be asserted during driver probe. As the line is active high,
-      it should be marked GPIO_ACTIVE_HIGH.
+      Must be the device tree identifier of the RESET pin. If specified, it will
+      be asserted during driver probe. As the line is active high, it should be
+      marked GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   standby-gpios:
     description:
-      Must be the device tree identifier of the STBY pin. This pin is used
-      to place the AD7606 into one of two power-down modes, Standby mode or
+      Must be the device tree identifier of the STBY pin. This pin is used to
+      place the AD7606 into one of two power-down modes, Standby mode or
       Shutdown mode. As the line is active low, it should be marked
       GPIO_ACTIVE_LOW.
     maxItems: 1
 
   adi,first-data-gpios:
     description:
-      Must be the device tree identifier of the FRSTDATA pin.
-      The FRSTDATA output indicates when the first channel, V1, is
-      being read back on either the parallel, byte or serial interface.
-      As the line is active high, it should be marked GPIO_ACTIVE_HIGH.
+      Must be the device tree identifier of the FRSTDATA pin.  The FRSTDATA
+      output indicates when the first channel, V1, is being read back on either
+      the parallel, byte or serial interface.  As the line is active high, it
+      should be marked GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   adi,range-gpios:
     description:
-      Must be the device tree identifier of the RANGE pin. The polarity on
-      this pin determines the input range of the analog input channels. If
-      this pin is tied to a logic high, the analog input range is ±10V for
-      all channels. If this pin is tied to a logic low, the analog input range
-      is ±5V for all channels. As the line is active high, it should be marked
+      Must be the device tree identifier of the RANGE pin. The polarity on this
+      pin determines the input range of the analog input channels. If this pin
+      is tied to a logic high, the analog input range is ±10V for all channels.
+      If this pin is tied to a logic low, the analog input range is ±5V for all
+      channels. As the line is active high, it should be marked
       GPIO_ACTIVE_HIGH.
     maxItems: 1
 
   adi,oversampling-ratio-gpios:
     description:
-      Must be the device tree identifier of the over-sampling
-      mode pins. As the line is active high, it should be marked
-      GPIO_ACTIVE_HIGH.
+      Must be the device tree identifier of the over-sampling mode pins. As the
+      line is active high, it should be marked GPIO_ACTIVE_HIGH.
     maxItems: 3
 
   adi,sw-mode:
     description:
       Software mode of operation, so far available only for ad7616 and ad7606b.
-      It is enabled when all three oversampling mode pins are connected to
-      high level. The device is configured by the corresponding registers. If the
-      adi,oversampling-ratio-gpios property is defined, then the driver will set the
-      oversampling gpios to high. Otherwise, it is assumed that the pins are hardwired
-      to VDD.
+      It is enabled when all three oversampling mode pins are connected to high
+      level. The device is configured by the corresponding registers. If the
+      adi,oversampling-ratio-gpios property is defined, then the driver will set
+      the oversampling gpios to high. Otherwise, it is assumed that the pins are
+      hardwired to VDD.
     type: boolean
 
 required:

-- 
2.34.1

