Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C81FA15E
	for <linux-fbdev@vger.kernel.org>; Sun,  9 Nov 2025 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762658571; cv=none; b=ui081q6tl5TM2v6n+PkXj8VhFJKsihuUlCFkHxSDEdiEQwCVN3U3wK2R/gf5v96j4jLWlQnMtKDELrEGyQsUKKKaldve58DmYKaorrjqwskFcawkUV8cMgDJvgvEiuVRD9MkSffzXaYZT/vE8B7Oxl6vDWXdrlYuD8tSBsGQ0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762658571; c=relaxed/simple;
	bh=KRL39vgwT3XMUn3s5DtSCHjsPeAz1H7nQ2W0QFd1uB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M7lodt8Ye6XT7q1EF0gorDaG8ef+jZ4U3mMqDcaxOHaNxTmZe/MDWbeQlJVYMdD+lvo7Tw+xK0iNsEf3aKJxCL5xyb+pKzWtnfP2tFB4Fu7RWUaBJr2mbRYwddGyC8dzeHLNPfZIWB+iwrpwfKF3JIdCTwaHDe2jZng0Ks7GVEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqoSpm3K; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqoSpm3K"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b62e7221351so1643973a12.1
        for <linux-fbdev@vger.kernel.org>; Sat, 08 Nov 2025 19:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762658568; x=1763263368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=309e2xiNVgkaFiSxGZQDDrS3Pr+1mEXfBB2ZrdJ+pPY=;
        b=GqoSpm3KYYymnGbt3zlZ/+B9aHRDGop1QgWfvKx+2hvSGda/M9l9yEoreDG3HNLex+
         1ROe3GCTUvbtJ/8YZJ6WgclsMQGhvvNp0Ii+N0MzKbPhbBroLLRdtRWETvoZbIg1YIZJ
         wD2sFn3tN3yskjLj7vWZ1ry6yCnGNcssp3A4cw0n1YhEHqlbpqw16frBIFsdt2Dwl9EN
         oSWo+ODkQa/y3vyxc3kLdp6N6Mc1tM37ZcmfFx65VDrpsMvI1u5OMi0BxpSoYpQcSwr1
         oTpn+R7fxJDYsO70VTibsfGG5QukeKgNDf/l4tX9ligXveshQ0Pp9BvCc1Ef4ZYcg3g4
         JLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762658568; x=1763263368;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=309e2xiNVgkaFiSxGZQDDrS3Pr+1mEXfBB2ZrdJ+pPY=;
        b=FC/eHiwmUUf7EBj7KjuWgF4gykBQF72nbSEfWebL6GOb+lf52jn3pCUjFkalZjMJ5c
         3+3wNc/X+s7OlT1YHSN265teMMQAKCzJUbPEYxokNyCOR3SPHQH7RHbyKFyl+OY6OL5z
         YYzkXNggHvEvp1zIrUTEdXdRjJ9Yl/Abosga7nQ90DQ6+bCd023PsaQ1bgAP2GnjAn3P
         qigWeLglhzOPmYgs4c9BfhFZKL7vU0ELg+n9UoUfJ/xJ5N1MWcpCktWfomNbywfDpzeG
         ipwuyZ0KPOPJhMVflBZy+8SOjqYaTJxMpGm6VenVnzjDA/2vMf1vGC4pW5ksmFAqrqX/
         jIBw==
X-Forwarded-Encrypted: i=1; AJvYcCVsLoPtz1i0KdZSWiR9F/06KxqWYokg7Hx49Nsvd/5W447pogN4kQTdlzg7+TDgZ0xo5DV5czwt+9ylJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0UrnCB/Aw+yUc0kG7GTrD7qzw4l5FlxlOMgkql42PsXuLHSlf
	ghEef6qS330raEtZc0jk86OFvSBIrcAZItVM7092hwJjXHlacGOIIq1x
X-Gm-Gg: ASbGnct5QduDFHtKmEBTCRTUfrb2YFSHS1nSpyanO4HHPCSOdoaROyl5+1GPdof3bqy
	20EaREdQfh85p6FJYAmmM03NzmNQ9OvXewMYMuoSFjMbjd0BBbU7i8Fdqs7BugGNz2qHb+CxJbO
	lpxBBkOGcFY23Oylr2TXi7xIrsRtv/Z7DKus6vfFI2SYYQAYI0r7uZaIWftmcnUEDi19gchBX+k
	1gYwlTWPHgWAG/igi0eEBZmtphDi6559LsFuEkSYt0OBEq4ESiGe+xAZ4k6UgGrAyaMiPkqmqVW
	UgwR/v9v4nWQcyTyRUW7HiVp6dOWdMujz+BInGxDIq8DTQhXYtpBJioR6DB6ga5eLFBHJ/FwDHN
	YlMsGDGPdhQqPnQzX1AH3iXRVHiqYjoZzVO9TBs9tQT3yXStCe29Wn/rJcXcAlMa8rKZn2OCl05
	0hsIv6O3rdBc1rtCK7CQ==
X-Google-Smtp-Source: AGHT+IG+NU2yi/NgsNSjZY0ObuL/1G3s3dBw0Ad9cUlsXl76c/IPuu1PQw3w7qQoYNY21AsMnNqtwQ==
X-Received: by 2002:a17:903:94e:b0:264:70da:7a3b with SMTP id d9443c01a7336-297e570dd4bmr52150255ad.49.1762658568492;
        Sat, 08 Nov 2025 19:22:48 -0800 (PST)
Received: from VM-0-14-ubuntu.. ([43.134.26.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682casm101941215ad.22.2025.11.08.19.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 19:22:48 -0800 (PST)
From: Junjie Cao <caojunjie650@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Junjie Cao <caojunjie650@gmail.com>
Subject: [PATCH v3 0/2] backlight: aw99706: Add support for Awinic AW99706 backlight
Date: Sun,  9 Nov 2025 11:22:38 +0800
Message-ID: <20251109032240.3422503-1-caojunjie650@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Awinic AW99706 backlight, which can be found in
tablet and notebook backlight, one case is the Lenovo Legion Y700
Gen4. This driver refers to the official datasheets and android
driver, they can be found in [1].

[1] https://www.awinic.com/en/productDetail/AW99706QNR

Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
---
base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
---
Changes in v3:
- remove the shift field (Daniel)
- use FIELD_PREP() to replace FIELD_MODIFY() (Daniel)
- include init table into aw99706_device (Daniel)
- breaking a long line (Krzysztof)
- rename backlight node (Krzysztof)
- make aw99706_regs static (Krzysztof)
- return -ENODEV if it is a unknown chip id (Krzysztof)
- use __ffs() to handle shift, since mask is not compiletime in for loop
- reorder functions and structs
- Link to v2: https://lore.kernel.org/linux-leds/20251103110648.878325-1-caojunjie650@gmail.com

Changes in v2:
- add handler for max-brightness and default-brightness
- add properties(max-brightness, default-brightness) (Krzysztof)
- use proper units for properties (Krzysztof)
- drop non-fixed properties (Krzysztof)
- include default values in the aw99706_dt_props table (Daniel)
- warn when a property value from DT is invalid (Daniel)
- drop warning when optional properties are missing (Daniel)
- add a function pointer into the aw99706_dt_props table to handle lookup (Daniel)
- use a lookup function instead of hardcoding the formula for the iLED max (Daniel)
- move BL enalbe handler into aw99706_update_brightness (Daniel)
- Link to v1: https://lore.kernel.org/linux-leds/20251026123923.1531727-3-caojunjie650@gmail.com

Junjie Cao (2):
  dt-bindings: leds: backlight: Add Awinic AW99706 backlight
  backlight: aw99706: Add support for Awinic AW99706 backlight

 .../leds/backlight/awinic,aw99706.yaml        | 101 ++++
 MAINTAINERS                                   |   6 +
 drivers/video/backlight/Kconfig               |   8 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/aw99706.c             | 471 ++++++++++++++++++
 5 files changed, 587 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
 create mode 100644 drivers/video/backlight/aw99706.c

-- 
2.51.1.dirty

