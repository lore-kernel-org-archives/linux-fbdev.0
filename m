Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B813283FE5
	for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 13:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976311; cv=none; b=Ihz+cHSJwMGG7SrwODkiry/TNOWIawGsXwPlP66Ru8GXsyValManpAR99DfLDuVUhpYDBLZ9ZQRQmPEWKwMczgWW1tMUO7b9nV1tcLsmvoQn1TqkxezOqJOVeFH+IO3zy+m7Uq9YrKYR4TvD6SSNY8EuohAEV/mZbdtvHJ6OhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976311; c=relaxed/simple;
	bh=nPvrywprKqXAHSVzS2cZuwfCIpnN+xuVhyNHb3N1fMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrgL7SEHJSvgioIKk2a1KUNh4QqvRdGkzKgiP4iUIfHxzv+Vjf/yqCDfDjtKvYQj0tHCVNFPaNw2/oAgKA3PuaVHLpi3hEyOBx8YXKsmJU6BSud/JXZb4A9JPO8IRV/DdLqqOveLICwOnaOzdZ4rPsdXqD7c3m9sbLzKuiC80BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOGhyKpH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOGhyKpH"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso21758600a12.3
        for <linux-fbdev@vger.kernel.org>; Thu, 28 May 2026 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779976308; x=1780581108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DSg6ryVfD5S41bWs4eS7vIgEWozL5e55NM5iPpo1Yvg=;
        b=iOGhyKpHC28LAcS2hK0z0cg+fqFV7cQWqqCDG9ZjfCZbksbp5zEtWwVuEFsNw/jXZP
         m+xbPLF33xKbSL2qQQhJ7XLHIaChXSOAZUjMXP4Iq0cu/samZ0hqy+SwreZal87pMIXl
         gvCd3h6vFiNeh47NByA0Qp2bhq00rnb78EWj7N7ITvWgtwLmvCTN9d6VLY/uLh5vLCPT
         bVLSKOdK4TnoU9c4HgR30+n0AyRV8BwM18fLA7ITovJ7YQDe8kw9Os2KdMYuJZI44NXb
         ddb7wRCvVX/O8FvCsQnUpvhbPwe8XwyM+7hSiNAhJYQGhl3369WUC9i+HLsf/i0lJNcq
         zYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976308; x=1780581108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSg6ryVfD5S41bWs4eS7vIgEWozL5e55NM5iPpo1Yvg=;
        b=F6A0MjkteJFstDjzADgM5+Cm26zZaZOlG4W0pGMDK0qwixbcLFVZmF6959AI/HT6yl
         zTo3K4KoReVzWbAfhleIGK/aMox2PTItOCaEBkw7qkNbHuslTBEBbNEZRZU55zsYVmji
         NHgNkzKzKsn19KvfnqThzZh7uhBA0oIYY16eTrRoIk9gw1NSujqifqM14M5nzFyBALXR
         5zEHqwZkJ9mehK+drwIIknLXnaRhvp5psPzheHeaHDwTvNJ68SrDOWEkIG35EcJsDS7F
         JPDD/J+02wWKzwrTMuYx/yxrIBS5aINp9ol86Wk+RMoZHRQJ2wyqnc4GPD7ibTsYrnmj
         W9hg==
X-Forwarded-Encrypted: i=1; AFNElJ9BMFJjOPFatffaJ1zM3ObcPGaQSxaCPi0OpzfV6ZPgrH+4SZmnuyrOqW2uewovBlT0ID2Sblv3xilvig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJFk62ng9opQLnEB72xjGia9PC+q5Me7VPhFHy/VHSZqHTod+/
	XtmTKOwVzuO7CX+RHtvlNJobgj4TWcszwQAfugX8hbiQQWgWMzkCVu++
X-Gm-Gg: Acq92OHNldlba+LJI/gVIbTig9TQTwOKqoYbzzZdloDEiMZjR77HbNNPOVRT9JAjLHT
	3sCJP3Tz+pnaboIhJM3w6/ma/UvddW8FwhEKa3iHMVMEMNXN6qXKLEoab+etNKoR7DulbLZ0NO6
	/TOj7SHJc+5jvB7QMhO3vS9vs4qv9p47gDiaP69IUiuSEl66U150b9r7FJzeObtVhmnV3cP2/eS
	60bbJa2/tHts+ZXAp5q/YwGI+E1EGiBVoSYU+/xyceMaxWWCHJx0XlfwgwXFG/EbBH4S2guA315
	aIvkvVKV2KuoauylVAm76yppmDkOoW/25+hb8bybCi7eWcl490bV0U0ztPklR906HJdLtO+Av6R
	D8vFkmb7QMONFe28hoeBBGlOqmMeLDuT6kIa+IE1yHHdxJCXWFKq7Y2JJiZiijvjcElxmqa7kf2
	nm7BVRYu+WRXta85UojlMkw+MNvcXTaNFS2w==
X-Received: by 2002:a17:906:30c5:b0:bdd:90b8:e397 with SMTP id a640c23a62f3a-bdd90b8ec51mr1173734966b.4.1779976307812;
        Thu, 28 May 2026 06:51:47 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:51:47 -0700 (PDT)
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
Subject: [PATCH v2 0/6] mfd: lm3533: convert to OF bindings, improve support
Date: Thu, 28 May 2026 16:51:17 +0300
Message-ID: <20260528135123.103745-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert LM3533 to OF bindings, add missing VIN supply, add support for
setting mapping mode and LED sources based on device tree. 

---
Changes in v2:

schema
- maximum led sources for leds set to 4
- anyOf > oneOf in ALS
- improved ALS descriptions
- adjusted example
drivers
- dropped devm convertion of irq and mfd helpers
- all als configuration moved into lm3533_als_setup
- added regulator/consumer.h
- lm3533_bl_setup set before sysfs_create_group in backlight
- added check if LVLED is valid
- LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLED5
---

Svyatoslav Ryhel (6):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: Set DMA mask
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  68 ++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  66 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++
 drivers/iio/light/lm3533-als.c                |  95 +++---
 drivers/leds/leds-lm3533.c                    | 108 +++++--
 drivers/mfd/lm3533-core.c                     | 291 +++++++-----------
 drivers/video/backlight/lm3533_bl.c           | 127 ++++++--
 include/linux/mfd/lm3533.h                    |  53 +---
 8 files changed, 653 insertions(+), 325 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.51.0

