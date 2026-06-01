Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952783D967D
	for <linux-fbdev@vger.kernel.org>; Mon,  1 Jun 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327144; cv=none; b=HFBfHgzaVr63JSHguZ3lNTQfcXr7rVI3MST0ecFAlU5nfv4Gk9dtMbabJ9m+xNP8WEg9VU6060YMZ+rIDFjqO2DHM5wDvnAkvIZyaHailasJxltTzV017IJ3yYQ5v5PMx07pDiRXbWG69Dtq0Pl4hCIbTMegRbMNkSZ5bf+b5N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327144; c=relaxed/simple;
	bh=PXFHvGio0optY61LEkjNkEzijVZnDLT+o2ExZZLbhKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+fOHQDLsM6mhsILRC0BQATbGFT0618zgN0o+ltF1x8dctsucZKzujuZD8NWfdT2sgA8DoMIOn4y6D2v0KomgwO7LualAXdo31G/RY0+IkdghzW1cpbfRfmp2lMufvQ10wdXuYixov/4aefucTdQJ5DGylroW3p36vEpn7/bom4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOdIHSAB; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOdIHSAB"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef4223be7so1758752f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 01 Jun 2026 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327138; x=1780931938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qzN96GbcZUpB13Q9YtY/dmYRB6hgHD9CiDUD5v/xjEA=;
        b=HOdIHSABzfgWx6LFlNNUcprEOfEGGWvwEf4bQdcaQigLgiL4AE1dDrvfzsMI1ed0IB
         G29wE7pR7JSzZCLREquNbb3y1+aH8mZcNT8LO89DUCsAPONz644LJALPjjNZAipEtPwM
         p5q30ifdTIOrR7SBnleaEsxQeivIgezhMbvK7LDJTZONnwx8oHMICipOlpZb6KvX+GDb
         mHhWJ7aY1l5MfaetMcUxviJZSrxIE59a6numTNH18UaaOee5MDeDaYYq3B8H71xyc3gh
         nOITYDLRSi1hYlYQqHsikJ+Q2pk/CIeReTXpCOmehQO33F4XLcZ0ZrnhQ0La0lZfTnqp
         kL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327138; x=1780931938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzN96GbcZUpB13Q9YtY/dmYRB6hgHD9CiDUD5v/xjEA=;
        b=CvI22jEnzXbwyJJbBHkCCHjND7Kk8lhK2Es5QjROigEfVNP1Lljf7Q2t+l5jaTyWYx
         r3j+SPV9Bzvekq6wY2F/Wa5ErQBCLkdU4CucLg8H03BFyhTGSrm+QYii53srsjUfUktB
         nCQYW+mL0Z1KoA9pAu85J83u6l8cdQ2e9SVtkzusOHsKmqLXTJ2v3HbTwbJ4ouJ9cvyq
         mEls6nBYdegie6xUY2BXOKE8z8gb8r8tEHzhrrbTqKSGIRqj1wdphN1Wkz5plzn9q5Sy
         u5Tst8FiQyzcXCfwO9E50T7I6+G8hnAqqGSgOtsQSB3mJBAXjoXrXsyN7Hk6PIAyq13i
         3s7w==
X-Forwarded-Encrypted: i=1; AFNElJ8540n8bkX1flJhUEOAVEEu5yMmb/b8CUbFxQOh5HyshxmZGNT6Cp2pABIEDweQN8D5p0ztemPJo36Z/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAsHkPGLD9Kbg3bAP6mB66cTmKDlD9UiykReXKQbRW+BRzEv9
	Zwb42oJIk4jd6OPRz1yiMW2oxxc3CBJnzjtBJ+Tn3i/JZZUGYUxA1KSP
X-Gm-Gg: Acq92OFhhQ51kjTt1IoiwWc5aT2UQnQ5CIoJO35xitpi55ZVeq1hz/ZXyJTl6zQ2DLO
	mZBgs5CSOwoC+bu7yCvOUCFMegE++VesOxfwZcdqf3krQjoQrZ+vONirXEr+p/hKsDyZNd9KNVB
	NON6J4OERKiyg81R06vGhOMPXEhGFIup9qoTP6j+JMZND+HCm+KyRFQV9zZmqsSrKIDz/XJI5KQ
	TVG2jzligNFZt2GeAWrjVCkRvbgT6vFBMW+nO8LD2LNRO7EEhIohkEZhLgLrxPatPei9pKR/jfv
	/NHNp5rirU/tJKZ+NCpCoN7OU0TJO/FqUIgTqik11+UYCbY60s0bPR4EgTJ9K6MSzo/Th9V2TBa
	tjMU46x28MyEa0q/TFGrKxLLU6ejezs5QRop2PAINHlVBsXQ1l1CGedM0Xw6SwF6PaEyPZ5xPwZ
	/KRTKOtnbo9k4LWI16spLvHu0=
X-Received: by 2002:a5d:59ca:0:b0:45e:f46d:fa95 with SMTP id ffacd0b85a97d-45ef6a8c8f7mr19705747f8f.0.1780327137736;
        Mon, 01 Jun 2026 08:18:57 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:18:57 -0700 (PDT)
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
Subject: [PATCH v3 00/11] mfd: lm3533: convert to OF bindings, improve support
Date: Mon,  1 Jun 2026 18:18:20 +0300
Message-ID: <20260601151831.76350-1-clamor95@gmail.com>
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

Changes in v3:

- ohm -> ohms
- added default PWM mask to schema
- added commit removing driver regmap wrappers
- added commits which flatten pdata helpers
- adjusted check if als->irq > 0 since als->irq can be negative if error/missing
- added count for children defined in device tree and mfd_cell is allocated
  via devm_kcalloc to be able to contain all of them
- fixed backlight boundary check
- fixed count increased unconditionally
- dev_err returns node name instead of reg value
- LM3533_MAX_CURRENT_* defines moved to common header since they are used to clamp
  current values read from the tree
- mapping mode commit splitted into 2 (sysfs logic improvement > mode from DT)
- backlight mode configuration set before sysfs group is created
- fixed LVLED check on LEDs setup
- added check if HVLED is valid
- fixed wrong err_sysfs_remove goto in lm3533_bl
- added commit implementing backlight_scale property
---

Svyatoslav Ryhel (11):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Remove driver specific regmap wrappers
  iio: light: lm3533-als: Remove redundant pdata helpers
  mfd: lm3533-core: Remove redundant pdata helpers
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: Set DMA mask
  video: backlight: lm3533_bl: Improve linear sysfs logic
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: backlight: lm3533_bl: Implement backlight_scale property
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  69 ++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  67 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++
 drivers/iio/light/lm3533-als.c                | 159 ++++----
 drivers/leds/leds-lm3533.c                    | 142 +++++--
 drivers/mfd/lm3533-core.c                     | 361 +++++++-----------
 drivers/mfd/lm3533-ctrlbank.c                 |  27 +-
 drivers/video/backlight/lm3533_bl.c           | 153 ++++++--
 include/linux/mfd/lm3533.h                    |  62 +--
 9 files changed, 758 insertions(+), 451 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.51.0

