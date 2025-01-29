Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA931B0435
	for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148700; cv=none; b=Oz6tzxIP9MME01i6hEaS/bhg7M8xnLXA2vl6osptpOyWS/prE5zP25QJaggkGxr4ORrOKsOSdPnx2CcmC6bVLSm20+kNrJIe2iwj87afXTRsSAFtfnnpyN386JDInctOytFCXVMibO5RGmXOfbznLLEXiHAnaLkTnCM6V8YtySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148700; c=relaxed/simple;
	bh=mj9E4SRlwU2+ogNUoYRTExcnrVD+/JKmUcsECqo0Q+s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WZSDgrh1YmH+Nj2T1Lz+lrSMUu3c9+hcecR7sftD6RjCIdunlFHLIKuDBJsFrjJ3E9wVG0FTrfpCRobspkkkeS2NuiYWaNxxpf3c27Nv7Ee//FCF37jR9BBmEWN0ra+P68KBEE+uTEfuP0Knvya0yxdPQc/03HjgbfNE7I9p2yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y1yZ65Vf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y1yZ65Vf"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43618283d48so47856275e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 29 Jan 2025 03:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738148695; x=1738753495; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bAU4GIvVmdt4JZJ7rSRSO2Uc+HtQ8JKsDSpEn0o2lz0=;
        b=y1yZ65VfqfBA01N5d0XT1yWr7ZYyaicCYt7dH7N0WpSVUZBhOG0AUiIbaeCMI9k6GT
         PKcHty/UiWrUTIzzEGoI9PFdAnzXUPvrXv88pyOGKST0iSG4KCCosdpT8QMBMQy6Co4c
         9hedDAtcImePtGKI5jqXRZd2SrrH8lEdfCXx2DmhJL58cVK6tJcSqQTg8DUtLJ1WCnQi
         nY2V2Ah4wxU2XmshVm5Asj8Bn7GMB0KgQBdsKtLm4uh61Unpy+dlSuZXMaA4Bdy3C+rY
         1qH0KqOPX/n3nOeFTdUwkMK6/jc5qwwfVhOtVFZQgMMHex/3pLASm9uYzyhGrO5j28lL
         B2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148695; x=1738753495;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAU4GIvVmdt4JZJ7rSRSO2Uc+HtQ8JKsDSpEn0o2lz0=;
        b=oCQuK6Q0crusgS/n3ZrcTe75r4+gghQ37wY0Epzg1oOTepsbM7FRsuP/tM29izubqa
         H9oI5lM/5c69V4QKROeZt8v7dpQBfdZn2D6ls30YZeL8DgpjvHO9VVjZRZHxWw+6tzow
         BA3ghzwhABmOOw0en0bKt14fBKUj8zIWhH8elobchkZRx2GIyeCLLePSa8QRsZ0HDKhH
         1F1ikPhunV5Zu80V19F5J+ifl3R74+jFC3LeFpbLwRn3YI4JmrTwXugzmPVAgaR6EUWw
         5DEPUGVLsi67kUB4z8NN5PrTTF+LGClmfcn7nXkLw0YSqfwg87ptobEX2DqxHxPT8AEH
         /w5w==
X-Forwarded-Encrypted: i=1; AJvYcCUt+4m2jbC3O1N10v6LTL4K8fWBB24fqF3FTYiABTlRK+GcnhDaB9xzcF8gdARMrUGhd1ZIHNg9wV/Dyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaafF9K0Zf730VKy5H2UemBWqLB+6I6Gn0+KnJ0Z0SnMAU4sk
	Y08RSqQmT0Xhj6zdvkDuipVqRgFRw82tL6jRoZqnBS9ibdjxOWWGKhanSOdFHVw=
X-Gm-Gg: ASbGncs3kKVBXyzSB/cruwVkkpSAJt8b+H6NE5fQRO3I1VHdioJSyI3/anS6Iam1YBs
	5m4ASQ3XVOJdK1rTyl6Fbft6yYQ8umrVVK5sqOzpd6ZPIUL5JfkKL9MSip8dcQS5VK1dFO7ZEwX
	Qzr3tLE0PbQGcr9ihnUXjT3gvSoKM/92UAd6p4LoVRJcqGSwwJgw9UjbZhS1rgYhde37yHl26il
	L0BBOYlW3/CjtHpbBXKK0PoHkB8q2ybJTVf0kT07CwUtVPgnxDZOiGQki4/EBpGWjt0T81tjrs7
	kpOlZA1sTWBnUkKfMs7Isf6m5Z1mcLdtxxyFwbKvfoyMNhOhv1AjmIlJMLkoqt9fjJs23q4=
X-Google-Smtp-Source: AGHT+IGoJE2bH4Lrk+kyxraLibRytPNA902qZKJwBAr0z2UhRf6p4L2iIn4biM5sloY+TAdsS9ECKg==
X-Received: by 2002:a05:600c:3b94:b0:434:a929:42bb with SMTP id 5b1f17b1804b1-438dc3cbb71mr21327205e9.18.1738148695417;
        Wed, 29 Jan 2025 03:04:55 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm17107364f8f.32.2025.01.29.03.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 03:04:54 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v3 00/10] add support for Software mode on AD7606's iio
 backend driver
Date: Wed, 29 Jan 2025 12:03:01 +0100
Message-Id: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUKmmcC/x3N0QqDMAxA0V+RPC9QU+zQXxmjRBNn2FalhTkQ/
 31lj+fl3gOKZtMCQ3NA1o8VW1OFvzQwLZweiibVQI4611KPu204vpDlGlyILBJHnp6aJJY9vld
 RFCHizoXgZw+1s2Wd7ft/3O7n+QNHOVHAcwAAAA==
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

The previous series added iio_backend mode, but the configuration for this
mode was only possible through GPIOs (Hardware mode). Here, we add support
for configuring the chip using its registers (Software mode).

The bus access is based on Angelo's ad3552 implementation, that is we have
a particular compatible for the backend (here axi-adc) version supporting
the ad7606's register writing, and the ad7606 is defined as a child node
of the backend in the devicetree. Small changes are added to make the code
a bit more straightforward to understand, and more compact.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
Changes in v2:
- Improved descriptions.
- dt-bindings: improved descriptions, added exemple and additional
  property for the custom IP.
- Reworked some macro commits to avoid changing order and associated
  diff artifacts.
- Various cleanups and formatting fixes.
- Link to v1: https://lore.kernel.org/r/20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com

Changes in v3:
- add some fixes found while testing,
- general commit meessages fixes,
- codying style fixes,
- dt-bindings: add some properties as requirted,
- use iio_device_claim_direct_mode (and release),
- rename bus read/write functions with "bus" as done for ad3552r.

---
Angelo Dureghello (2):
      dt-bindings: iio: dac: adi-axi-adc: fix ad7606 pwm-names
      iio: adc: ad7606: fix wrong scale available

Guillaume Stols (8):
      dt-bindings: iio: dac: adi-axi-adc: add ad7606 variant
      iio: adc: ad7606: move the software mode configuration
      iio: adc: ad7606: move software functions into common file
      iio: adc: adi-axi-adc: add platform children support
      iio: adc: adi-axi-adc: add support for AD7606 register writing
      iio: adc: ad7606: change r/w_register signature
      iio: adc: ad7606: change channel macros parameters
      iio: adc: ad7606: add support for writing registers when using backend

 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    |   1 +
 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |  70 +++++++-
 drivers/iio/adc/ad7606.c                           | 152 ++++++++++++++---
 drivers/iio/adc/ad7606.h                           | 111 +++++++++----
 drivers/iio/adc/ad7606_bus_iface.h                 |  16 ++
 drivers/iio/adc/ad7606_par.c                       |  69 +++++++-
 drivers/iio/adc/ad7606_spi.c                       | 145 +---------------
 drivers/iio/adc/adi-axi-adc.c                      | 184 ++++++++++++++++++++-
 8 files changed, 541 insertions(+), 207 deletions(-)
---
base-commit: ae62b72e76b72f98a4955580cb1a46095fda7d8e
change-id: 20250129-wip-bl-ad7606_add_backend_sw_mode-dd22a50663f3

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>

