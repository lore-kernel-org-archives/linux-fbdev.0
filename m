Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FFC1AB8EC
	for <linux-fbdev@vger.kernel.org>; Tue, 18 Jun 2024 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719362; cv=none; b=Jk/v9O6ua7EGIs/O0ujf5kn9JD8c22wx7nsRJBDagbYau01CEyrXBkSZSPRivy5gf2fxrZXxK9goZqifBDaJJ5WkAcp2ecETp7drfjClK0Ibjwh5KWrjBOMwRxy9rHqNK3afKgfqJICpnO9r4Kd2BR/DA0WmcBayzoqwBoHBrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719362; c=relaxed/simple;
	bh=A6kuif+EaXqoEMG7xaj25XS2KcSl5ZJh9WVTl3nCKxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BSrnPma6BcmxigZrU8/ic1rMjd5nw9mrEwawJoEt7+yIzIzr8miLO8q+Mkf3wp4eigdxq8ByNkZnea0xydegWYrgG2ocH9/YuC7Cuur6qk2keKR3KdqMDXSXlKMl5pImgFdwao5036Q8zuVQS0023d18D4EkueHSCRHjDzt5bV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XXddTLld; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XXddTLld"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f1e35156cso4723014f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 18 Jun 2024 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718719358; x=1719324158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7A2H1vn46bs7vzUe2mxoJ5kUKOzuhCfRLK3RT+N/4k=;
        b=XXddTLldNAA7MBCQpQPNTn7HWZjIRyinpb8AAxMUtd4gElKlQhSMTx4sSi3d6SMGcB
         z7vi3z2cl2NYZq1NymiN6u2YL/rWVYuJjka+SYKf2tQfF22dC9yPlXnSccHDjmzkl7mS
         Z0ffF6IhwVK/EdtDeF7FwyIcJEUoZ3GTSIPuhNzdYkWli7lZxYopsnJOWLObllj4Ggt/
         8Grns8DyRYzKSI54ZGrHTRbaF9VgIsvfu76RRVV4yylQBheSVSHy13QxSWEjg65A4By6
         ypdzTTvCkfXBZ9Ap8xqb4JxXuhiuQqcIu4u2+3j9o4ThnXgUbas7su7/TNhT/4XFYW+3
         dskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719358; x=1719324158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7A2H1vn46bs7vzUe2mxoJ5kUKOzuhCfRLK3RT+N/4k=;
        b=JXCQ0UUFw7LjccSsecBt3x7C/feKbbP3YnGqmZKLHblaeF4aAfTs26TRo4M4xPkptX
         uVEraSJeVb3688LaIDiwU7w5Bt8h2tqg4E8fqYXs94FDXL8v1cxybLRmDTD5yVaNE/X+
         qpz3+cSlrAguXvpwUxjiDDmwqJ9ZxWYaY8unBfEsyGKD7n2ZJZcinaznwGUWoTjA7nvw
         FLGHp3yUmNOOq25MT526JbDXKNKyICOwVYKHykfSHq6DzRcT7sTbdazzz0l0ZRqB7Kks
         dpTu8bzOun7tKju9EIjd8slwsP1DdPJWY5AzziyocY3YRlq20XlMxMAKdS9MkJy5AIZy
         6lqg==
X-Forwarded-Encrypted: i=1; AJvYcCVcs6yb2IeQ8IXPgd1FgN1oNaUczwgFMjus4AXlZ/eiSEaicBOs7kfikDA8Y/CmW0lEpwOG4yVS6Exi2JDhtgh+//7LKquANfs9Ack=
X-Gm-Message-State: AOJu0Ywqinv7RHcqpC02P9SUWD/yd6KPYraCNfhZNu3mkfRzrfruMQWN
	KxhpZJUzk+3ghHeBCjwNswRKtTD23J1aEAfmclJ/oT0tUcU1BUpaHpR1FtPW36Y=
X-Google-Smtp-Source: AGHT+IFveMAeeYnGXlbgaKPbEE636y3oEz+xbQvRxeYUKyvxdbSUC2rC5BJCZhSUrFoLatWxvWuhBw==
X-Received: by 2002:a5d:6901:0:b0:360:8269:5690 with SMTP id ffacd0b85a97d-36082695cdamr7690748f8f.17.1718719357775;
        Tue, 18 Jun 2024 07:02:37 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f22absm14412546f8f.79.2024.06.18.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:02:37 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 18 Jun 2024 14:02:38 +0000
Subject: [PATCH 6/9] dt-bindings: iio: adc: adi,ad7606: fix example
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-cleanup-ad7606-v1-6-f1854d5c779d@baylibre.com>
References: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
In-Reply-To: <20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com>
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

Example uses adi,ad7606-8 as compatible, but adi,sw-mode is not
available for it. So remove this property from example.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 65d6ca5843d7..a8fb0d926859 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -198,7 +198,6 @@ examples:
                                            <&gpio 23 GPIO_ACTIVE_HIGH>,
                                            <&gpio 26 GPIO_ACTIVE_HIGH>;
             standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
-            adi,sw-mode;
         };
     };
 ...

-- 
2.34.1

