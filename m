Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEAE24F5A0
	for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203969; cv=none; b=R2lpzCwD1wHlZBle3wzJCcpE5Rls6dKaZiDatgP4cHGKTWHGepgPzo0024Q/sBjVKIC6i3AcLk9RDVUyK53b/jWCBTIfHIvpuWpzu6f1RzViNceRx/4+y43nQyC/ftS7vCaNaDMmcjgm9JgzdmKuq0ZPOsvo03A6vFiY/sxJQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203969; c=relaxed/simple;
	bh=uF8K59uhfTnsnHYF0QgQ3k7irpxn8tRe22ZZGYaVdYA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uKUivkryBsCyXV4HqVubbfcc+37CB0YSuU5Kw5HytRIWgVEbLMl9Ilh87eD2wy672sq3TujwpkRLgEQMUrGbdhOK3ZKb7oRRJ7XIxnCNaj0CfzGUB8TnxIMts+p0EQELuK8+UF7fyBujIg9S5/WsT8T3BMBU45fogLBOsUhdp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zTXxdqoV; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zTXxdqoV"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38dd0dc2226so2383254f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 10 Feb 2025 08:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739203964; x=1739808764; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bui6a+u8nCr5hYL5RmyZzGBCPswahyVTcFp15Z0jabc=;
        b=zTXxdqoVVOAp3MQhd5hS0lOThnAbaUsykLQlH4H1dszqE3qmMQrkPQrxvEk/428PsN
         By7nfhnOMnwHcuv/RgMPgyqQTwVFtUvvFj8nEBEBqOUGKkWWdAK7mwqAm9Et2t/JYizU
         tczZzp3NVhoDGW8NxztOHhHZq4C5JryFeJTrMe0aP/trXkAOXjcr9Tdj6vsPVPJh/YNA
         o+/NfwI1SO07on/DUfxwaQYNY+hiKQ5Qw6AOExv3Jq9bh+5PpX/9NhvypGQYHoiRr68M
         jt0saPN51/GygNobxld9S1M6Ek5EKYfiK5/AQo5WYBpO+DqnxZEhF1PjVcsZejl6KUJ1
         U2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203964; x=1739808764;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bui6a+u8nCr5hYL5RmyZzGBCPswahyVTcFp15Z0jabc=;
        b=A0TBRDFv2hNhxVTULwlCnaBgCLWQPcEgq4m9uYjXoJHl8VKhepuWEzjT/MR5UWvTCO
         APQSLsVFM9a7WdTQ8zO+TkQu8ctlcVFb8m2/CKIz1kuoB1uXczF1OImm4gJqMPnwVQPJ
         VScohim4GDNY/V2E7qx3/cLjeT8nHH9GLJ9NsNh5Sc+tvUFV4olWKqANLwfPWLbAuBtY
         hM7vVVijnZAM05shFp+tAG5rCI1cWn86QYLDQCtYqaX2vJ5kqlKl5fxNDM4YDGSwqFKG
         aDxNYX89wG74JX7QfTLn0ofGvUe2k4I8DqGXWC0jIDknclmystXeZw/+IQShqXQbFp/u
         DTtA==
X-Forwarded-Encrypted: i=1; AJvYcCU+LIWLQtCxw796hi+y2K/cDsfOSMtyXAn/rjDjBlH1w4jNc2T+5+zDUB2egkmaSWazmY3NCWZR3szb0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyInABSXk2I/FCaZ0tWSxYhgvFPSGxr1DkRK1DzZ3AiwaWiztM
	IjfzMTZb417bOI+ZyREhMmzeaX5ZoxvpaD6WcBYpb8NuJG7BrR99FRFPBsCVFag=
X-Gm-Gg: ASbGncudpa3qMisRbpiRHs9ueQbWjt+BVAIDdoTQ+suErGWx97Ek+ST3bGktPsz69W1
	9/SJeS+dFmsrpTYelTEToinqtwBoiJ6u41FbfZ9NS8d7imhPmZAKC0zEvfevpB7ifAUqJlEtZpX
	bekUaYvFnn9gNH/Ru/PYkWYsX+9TjAuKYssB7C7//3vB0dG3slv+0bF8eJDpZctMLLUOQN+NVWc
	4tkDyr5TEP5xnFiLHsyA8vPNN1+IxI0iiF+rS1W2YuB8sRh49HCKZ6oFtp8ZLDGVlfBg5NP9wUQ
	i0gYITvKbFSCittiHWM9DeZLRpzGJljCm52OCkT3bahg9qxwJeEvrNSzhEkIoIQ=
X-Google-Smtp-Source: AGHT+IHUCCXzWViw53v2z70NsQLCy9biU20BiEN5hSZXLoMpP9jMFah5HdHZWC2wYRaW+ixAC4KYsQ==
X-Received: by 2002:a05:6000:1a8f:b0:38d:e39e:ed14 with SMTP id ffacd0b85a97d-38de39ef19amr1133646f8f.25.1739203964485;
        Mon, 10 Feb 2025 08:12:44 -0800 (PST)
Received: from [127.0.1.1] (host-87-8-15-130.retail.telecomitalia.it. [87.8.15.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4391dc9ffcdsm146637945e9.15.2025.02.10.08.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:12:44 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Subject: [PATCH v4 0/9] add support for Software mode on AD7606's iio
 backend driver
Date: Mon, 10 Feb 2025 17:10:50 +0100
Message-Id: <20250210-wip-bl-ad7606_add_backend_sw_mode-v4-0-160df18b1da7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAolqmcC/5WNQQ7CIBAAv9JwFoNgIXryH6YhC2ztxrY0YFqbp
 n8X/YHHmcPMxjImwsyu1cYSzpQpjgXOh4r5DsYHcgqFmRSyFid54QtN3PUcgtFCWwjBOvBPHIP
 Nix1iQB6ClFALrVWrWOlMCVt6/x73pnBH+RXT+lvO6mv/qc+KC+4VoDfGC3Dm5mDtySU8+jiwZ
 t/3D7gZvSzVAAAA
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
Changes in v4:
- some spaces / tabs fixes,
- fix child nodes creation as done for dac,
- change usleep_range into flseep,
- use just a u32 as a value in bus access functions,
- protect bus access from concurrent access,
- Link to v3: https://lore.kernel.org/r/20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com

Changes in v3:
- add some fixes found while testing,
- general commit meessages fixes,
- codying style fixes,
- dt-bindings: add some properties as requirted,
- use iio_device_claim_direct_mode (and release),
- rename bus read/write functions with "bus" as done for ad3552r.

Changes in v2:
- Improved descriptions.
- dt-bindings: improved descriptions, added exemple and additional
  property for the custom IP.
- Reworked some macro commits to avoid changing order and associated
  diff artifacts.
- Various cleanups and formatting fixes.
- Link to v1: https://lore.kernel.org/r/20241121-ad7606_add_iio_backend_software_mode-v1-0-8a693a5e3fa9@baylibre.com

---
Angelo Dureghello (3):
      iio: adc: adi-axi-adc: add struct axi_adc_info
      iio: adc: adi-axi-adc: add platform children support
      iio: adc: ad7606: protect register access

Guillaume Stols (6):
      dt-bindings: iio: dac: adi-axi-adc: add ad7606 variant
      iio: adc: ad7606: move the software mode configuration
      iio: adc: ad7606: move software functions into common file
      iio: adc: adi-axi-adc: add support for AD7606 register writing
      iio: adc: ad7606: change channel macros parameters
      iio: adc: ad7606: add support for writing registers when using backend

 .../devicetree/bindings/iio/adc/adi,axi-adc.yaml   |  70 +++++++-
 drivers/iio/adc/ad7606.c                           | 159 +++++++++++++++++--
 drivers/iio/adc/ad7606.h                           | 103 ++++++++----
 drivers/iio/adc/ad7606_bus_iface.h                 |  16 ++
 drivers/iio/adc/ad7606_par.c                       |  52 +++++-
 drivers/iio/adc/ad7606_spi.c                       | 137 +---------------
 drivers/iio/adc/adi-axi-adc.c                      | 176 +++++++++++++++++++--
 7 files changed, 516 insertions(+), 197 deletions(-)
---
base-commit: 4692f10bec7459a0baa95bdfa66a4ea740ec9e0a
change-id: 20250129-wip-bl-ad7606_add_backend_sw_mode-dd22a50663f3

Best regards,
-- 
Angelo Dureghello <adureghello@baylibre.com>

