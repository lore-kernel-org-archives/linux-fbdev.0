Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A821C2323
	for <linux-fbdev@vger.kernel.org>; Fri, 28 Jun 2024 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719586126; cv=none; b=epEOa6DYwj7IhVhJdWj83u9YKnyTbCnLA595Btw71Jp8F+yeYgp+D90YyFOa9bMMsBeWM+nAvV4vvbSxHxXFqae5qki6fF9Ge7EbssmBt3Ti1Qzb9iXHe78s3VHc0/kMl/g2gaUxosyZQOs4Ahx3GxJEpQkbNarIK+W7C+Ub/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719586126; c=relaxed/simple;
	bh=6NkavYCS9KssnXRdhzuSjUIoOcS1DExNH94R1nY2LM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QbefIiYmkLL8M/ZJ4GSronjziHCmts4kRwq8MXgJYYQ/t7dCOfxKzkjiqihko7UPs5pVSD1vmTdl3pCM2u0959ZzGMmVCX/eVKpbgXQzNkhl3iEfCqG/qMuGC9gUSThF2R9B/dfREsR7iq9ghCubCPG6dy7SKkVzHom5xme5lao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Dpm+Tdhk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Dpm+Tdhk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42563a9fa58so5390225e9.0
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jun 2024 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719586122; x=1720190922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EMkuNs3gcVUwYniv00+omCdhvDWOdn0nkqiQ69iJTAQ=;
        b=Dpm+TdhkkAcNb1Epwv7L6B827Q5BMjzBqr8tcnLtjiG8F0df1eGrijZfC2WlSNZ0VI
         gj6SfEyP0AL/0oTVWy59qwd96CFuoUKB3iggjrDIWDaU+zHXinnTfjuO6MsTNzNfMHdZ
         GjNTw3Q/Ug2jju3bXoVaVbdXFRCyLiNOD2BMZcFdUmuggjuDsKxW37KCvI0Sy2bavmHc
         BMUE57oRLMH05a8uHD2hCdlcOgkd7/WsIQdfSKKwnPVMq5KxTXfUF3RRCZiQ3FtYhWaO
         oKr8eJ1vycOuWWDiPpmRaQnAJOIlj/ZRh8dCbyD60QXZ5XvHk2FscT/Cilw8ExbvybJ/
         sy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719586122; x=1720190922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMkuNs3gcVUwYniv00+omCdhvDWOdn0nkqiQ69iJTAQ=;
        b=i7Si4pbbeOv+vhfZOgf8sHYoLIqWM6E4kL0LS4XjyS0U3dqTYpujp/fgY2BDXA3UBw
         ccxIpyOllHuhGhylHg9O7NwFE+6EKygSqotGXhYJzZQ49hgoKQNqt+KUF3bfMnXB8ZOI
         kh0aJU6rMA22beLpGyR3mEvv/TUwzqA3ePZVe30MsTxMuMm5AmgJ6UGrEN/wLbetejxi
         egKRUkfMKiVwUUfbuoCCwgm8p/yJe4Qcj/LJC6rZxxTzgg+ysRZXFoIV3uLestlghEQE
         w1UFZ1GibCIvonxzX7tdpN9uPD7Tz+nnQSEhFa6LXJBRTzWHaqlPhyXHBqoQLAsXBm5j
         5jow==
X-Forwarded-Encrypted: i=1; AJvYcCUxcTQR1CdxxWGtl8LwXscWmIYauXvj238aAY6MaAmkNtlJcrGvd0woOy0+Mr/Mhv2Kp5m16jAL1dnmqzfBM1XyF3qEarQ+Drnuv/Q=
X-Gm-Message-State: AOJu0YzSbZQNbg6t9wQ46K1IcgLVc77KLWEKrGTsAAYp6Hp1LFH6IixB
	FW0CYRrIvj19ZdNFJfTCPfLUcOLuxoHVyCeqiZrtMRjjZL4EG4JSh0+ZJ8IvgXo=
X-Google-Smtp-Source: AGHT+IGv7t12CAtqBhXhRtWXm5NI4VGvGPgv75bfLG43FiWdKz+JsYKTuXkHFmGZ6kYlz0q3drnk4A==
X-Received: by 2002:a05:600c:1c8f:b0:425:5eff:7182 with SMTP id 5b1f17b1804b1-4255eff7411mr52274695e9.31.1719586121796;
        Fri, 28 Jun 2024 07:48:41 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55c0asm37972575e9.15.2024.06.28.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:48:41 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 28 Jun 2024 14:48:25 +0000
Subject: [PATCH v2 07/10] dt-bindings: iio: adc: adi,ad7606: add conditions
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240628-cleanup-ad7606-v2-7-96e02f90256d@baylibre.com>
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

Since the driver supports several parts that present differences in
their layout and behaviour, it is necessary to describe the differences
from one chip to another.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 60 +++++++++++++++++++---
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 626782ea00b3..f825a2c19a06 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -52,10 +52,11 @@ properties:
 
   adi,conversion-start-gpios:
     description:
-      Must be the device tree identifier of the CONVST pin. This logic input is
-      used to initiate conversions on the analog input channels. As the line is
-      active high, it should be marked GPIO_ACTIVE_HIGH.
-    maxItems: 1
+      Must be the device tree identifier of the CONVST pin(s). This logic input
+      is used to initiate conversions on the analog input channels. As the line
+      is active high, it should be marked GPIO_ACTIVE_HIGH.
+    minItems: 1
+    maxItems: 2
 
   reset-gpios:
     description:
@@ -88,8 +89,11 @@ properties:
       is tied to a logic high, the analog input range is ±10V for all channels.
       On the AD760X, if this pin is tied to a logic low, the analog input range
       is ±5V for all channels. As the line is active high, it should be marked
-      GPIO_ACTIVE_HIGH.
-    maxItems: 1
+      GPIO_ACTIVE_HIGH. On the AD7616, there are 2 pins, and if the 2 pins are
+      tied to a logic high, software mode is enabled, otherwise one of the 3
+      possible range values is selected.
+    minItems: 1
+    maxItems: 2
 
   adi,oversampling-ratio-gpios:
     description:
@@ -123,6 +127,50 @@ required:
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad7616
+    then:
+      properties:
+        adi,first-data-gpios: false
+        standby-gpios: false
+        adi,range-gpios:
+          maxItems: 2
+    else:
+      properties:
+        adi,range-gpios:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7616
+    then:
+      properties:
+        adi,oversampling-ratio-gpios: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7605-4
+              - adi,ad7606-4
+              - adi,ad7606-6
+              - adi,ad7606-8
+    then:
+      properties:
+        adi,sw-mode: false
+    else:
+      properties:
+        adi,conversion-start-gpios:
+          maxItems: 1
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1

