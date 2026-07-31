Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AAC3B71DC
	for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497808; cv=none; b=Fa8fOUV5kGn/SA3mUUG7TgOPgxOjZ7MeQMLH889I6/nNyyTZWkBG2BNEyOlgJK3TH68LafoqOrC8XsEl7LaN0CdkOO2bYUh3PkJ0hRb3iYpdzcA2LcBs9Em9b6T1AxHhaUinPf3daJBC7Vy2j975zACeBl+DqlIBS2VclFMcggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497808; c=relaxed/simple;
	bh=AUKrB+1UwvRA+EobKyrqOVgmoMGLyj3fg3zoQatKMk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAm+2meqvwz/6l1dCrkBqZj4WotpZQHYdzQVJSxhy7qa4kaLmei38LNJIqg6J/gs448Yvcr3mFb6G64EyQ6Yl2sSCxiIRGrGYBd7WjRm8Ds364MdEsmKnz/kreF9xzPQTRuwWQ3kZcNiKjd734278f9B53dB08mcFOnU4G6BIDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bp11gIzP; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bp11gIzP"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso897659f8f.3
        for <linux-fbdev@vger.kernel.org>; Fri, 31 Jul 2026 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785497806; x=1786102606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0oYKY0Gc5U72MShEoavxG+AazK3v/FMxLUqW5uFuuYY=;
        b=Bp11gIzPk6NYgpg1sKmqDzQj0k+pJwwA7Tgr93OPALc8zQZOc/iNVXpdyyk/n4mfrL
         wy16LTzLImgsBmwwPFkgIrAqFCZOdg3LEzZK3XaF8HFwhndS6okO6DuyZfgwkVHnk1k/
         ObLtsFusHDLCy5SW1CZjelqFAtFWCmrNXK3zLLWXPnXRoDtEnOCua2sueJrwvauZfPec
         q1BmTleFvzO4cbAgh/xZPuEFP6DDwiqA3eFcg5WyiG3zUx3K3K/Q92QxHwK8yHqDCqo9
         S+NqHR8TpKLwscFv/GU5LMgWHaOWe7GyojfjRjxlcdDsj5eH+KKNVvGJ43xnMJL8hYj7
         7uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785497806; x=1786102606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0oYKY0Gc5U72MShEoavxG+AazK3v/FMxLUqW5uFuuYY=;
        b=XOow6BSxNLeA18f8TnQauimQk46HL58cbdVSjHGYFhJgHzAAYAfspuwnOMQaHmXcBT
         0GYgnLasklvcl/1kMtGtUGYS8rahPHTK6fLJ+UsSBnlIMNI7OlQJ0L3mz0xTc0mfGEMl
         AJcbiYdJAUNWN7tQX/05t0neU0aVDwU9KTp2xdjd3TgUXks9BN/zg1lLoGVYHs1zNHoD
         Cviict5rs2BdsPJfrdBOTBLpmK+bMjR4IAT8O1xdaaskJjrQGt3TgWssuVBlZp/KEa55
         J06Ztx1ukjy2UPg8s8rI7oD5WYKv/9q0AywGyQV+zeNHwBe4NSoGoBAsJK+UBr+bu3tC
         LkBA==
X-Forwarded-Encrypted: i=1; AHgh+Ro17IVx5/2p0jP7bHghfNXrseRi6PDD8VtUjQHxZ+fQHC5gm7OsqOlIs4ITPy3lbVDfTL5/fbUL/+j6Cg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb9gOdL6BLB3efg9eH5BFwMGrz0OwXlZ8NzQT0rvPa5vcH8+nC
	d/+OP7apBhrmKHmQMUdYpKd7Sio58jpK5mTG2YukgllySecvKiooklly
X-Gm-Gg: AR+sD11E13ZWxk9bry7cVbvJbC05OzlOVMEhbbZKjgZA/pS0riJGxUvi4PXKxL/yqnw
	zopg9JocBfD97r0MkuIXGh26Z+YjGLcdTe7AcRSgFUKrqXySegVy2TxoOWlR6Xd6B9uPX7sJG6c
	oGPyJShereMP1JEUhqxQ5TqmmG3IhnFEHWvtJsntK/LdVG/a3VyHWc7Ew02OmHCzPLNTVdohfUT
	DYsAb/devPKz1UQ0sN3q5HJMubIWiCbviYStCmBjaej6vTdfIpz4nxpbIDmShM54Drf/K9a1v2W
	8eWRwu+0c0knm64/4xsAuw041ULg3GX8OgbbB/jEJYiE92nMsfF7kau7B/wSjb8KNTZrgIBDNeP
	+bWFFfHIefq3CoKwBNV6Zi5FSEMZYPbH810nwrTFF2fSq2p2FCECDp5iLmFVsQfn3gKbvCBLrD+
	U3Zyfq4KTmI396cg3gf+KsPSbH3itNw82y9nbDU/nkLqa1VJA7VMJTLvZLtAXmiu8NULojC5bUq
	2BulPgqew==
X-Received: by 2002:a05:6000:2904:b0:47f:2de3:b351 with SMTP id ffacd0b85a97d-47fd2adcad1mr4260062f8f.26.1785497805482;
        Fri, 31 Jul 2026 04:36:45 -0700 (PDT)
Received: from xeon ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 04:36:44 -0700 (PDT)
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
	mfd@lists.linux.dev,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v6 00/14] mfd: lm3533: convert to OF bindings, improve support
Date: Fri, 31 Jul 2026 14:36:18 +0300
Message-ID: <20260731113632.158440-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Changes in v4:

- fixed regmap_update_bits val and mask swap in lm3533_als_set_int_mode
- fixed als->irq check in store_thresh_either_en
- removed clamping of r_select in als driver
- added use_of_reg and of_reg for backlight and leds registration
- added intermediate step in asigning props.brightness
- fixed HVLED/LVLED configuration overwriting
- added bounds check for num_leds in leds and backlight driver
- switched to regmap_clean/set/assign/test_bits helpers where appropriate
- dropped extern from header function declartions
- switched lm3533 pointer in cell structures to regmap
- sysfs_create_group > device_add_group
- changes in backlight sysfs were expanded to all properties

Changes in v5:

- aligned driver helpers to use u32
- child nodes parsing linked with 'else if' to ensure there is one call per node
- removed redundant pwm var init for leds
- fixed regmap_test_bits return check
- fixed leds and backlight counting handling
- iterator variables made scoped
- lm3533_als_setup() set to exit after mode set if m0de is pwm

Changes in v6:

- expanded commit message in OF conversion commit
- restored original comment regarding PWM mode of ALS
- switched to FIELD_PREP macro in core for helper flattening
---

Svyatoslav Ryhel (14):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Remove driver specific regmap wrappers
  mfd: lm3533: Remove extern from shared functions in the header
  mfd: lm3533: Pass only regmap and light sensor presence to child
    devices
  iio: light: lm3533-als: Remove redundant pdata helpers
  mfd: lm3533-core: Remove redundant pdata helpers
  mfd: lm3533: Use dev_groups in struct device_driver
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: Set DMA mask
  video: backlight: lm3533_bl: Improve logic of sysfs functions
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: backlight: lm3533_bl: Implement backlight_scale property
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  69 ++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  67 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++
 drivers/iio/light/lm3533-als.c                | 179 ++++-----
 drivers/leds/leds-lm3533.c                    | 181 ++++++---
 drivers/mfd/lm3533-core.c                     | 378 +++++++-----------
 drivers/mfd/lm3533-ctrlbank.c                 |  33 +-
 drivers/video/backlight/lm3533_bl.c           | 231 ++++++-----
 include/linux/mfd/lm3533.h                    |  75 +---
 9 files changed, 818 insertions(+), 564 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.53.0

