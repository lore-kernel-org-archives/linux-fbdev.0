Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80FA2FF64C
	for <linux-fbdev@vger.kernel.org>; Mon,  3 Nov 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168021; cv=none; b=Ty3Ybxq/Dz3tCloU7lYqZT/vPsqD/TE8yBI3ySZLjiy/bVARmz2I4PPBo5kqQRhMf3GMmaSmyHFqRg9qBFWyKyUEPzT+l8UEjk9BQyiRTu5wwivvpoyuXh+L+egSSp6CkmtyiUgTDTRY9QX77VFYyqqq7WLWhLazlFqIfl0eDLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168021; c=relaxed/simple;
	bh=4K8ff7naWva5QP5+rWneFBDK+QFz923xCqhRcHl62d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lYHPiQwedf0fTblWhzUnf4n8mDII0b2otzABp6Spy+9T4ggjXzXsPSTmhnRUMW2zTOhF/ToH1VdB6NLGQPf1EkaFbv7iiyvCsrlUcA4c4zU19JnnqE3pc1VxEYCtB2yQZ4yLX608OoJ+PhiuYEid1iXAoWXlPNuh2oLqYFQ55qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acI4HVvX; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acI4HVvX"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-29555415c5fso24231915ad.1
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Nov 2025 03:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762168018; x=1762772818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=msKPrbmLk4Pe+fn3QzDxAI35yUJEjQv+lopXWiS4lts=;
        b=acI4HVvXpDlipCGu3tF4pNA8mEaYI1wS8/ybxO6sMKNln0/f7Gj3M5kUfhyGVu8102
         ABa0zey2hWthYSAA3OcCg7wcrTtW29eQqb/9dZae2Dp5KPdsn3G27R4MTbud2uCbhzgR
         L0OqhTVA9v2QyG7/eVIekBPQDPMzgvApbmjEJGMW/MI2VGxZzSJBaAwpZq90S5eCjxLH
         vJymWCOpwDc2FP8R7KKRDQ9fV5oYimwMkNNDJTgNvswhTJNz2lDrozvvzDlnEVn2K6Dg
         JE1bN1jgtdF/mMnj5Omq440UNL4tT+1BFzmxb155G1QgizwJ7V3BuecGAE84hKKTrCrd
         8ahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762168018; x=1762772818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msKPrbmLk4Pe+fn3QzDxAI35yUJEjQv+lopXWiS4lts=;
        b=Z19nW7G8NT8yx2eZhkBd74oX5BONlB6yg7a+IR+NEhRRXQ+EmMWZJhQ8kJEXdP0j9Q
         CNHrPvbW/Ufrt1EyhgEI9yUyEURARhcmQdkbsZl0E7zjUmFOFxemQBsBLUyNbtRyhlSS
         CXa0uqesmq64Eo830xUCl51Z6x3yAW21JRCf6Ba6xCCt/YpKr0o4IVnv18RgGbuRrRzq
         JIjdNPgC9VHmUsuq5PUkXtVipeMBEkEBcrqjHYJYj8Kwwn93pw0AoFP0JT+MHYDOW1Mn
         a52vYgmvhAC0wqNip3ntCpThYvIt47dPdXx7aZGrTzDKcrB04u8HFuk7aY8mI9nL752Q
         3UTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhtcH7+WUyM1ru2/xj6sZen2HUiWW+kEnkJ6P3lLGbalwvL828iCp00gzKqrVEFYphjxYeJOqkSv1v2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MuX3aGToNszd1UflNjY+/nuIxV4kg16mHX6bXavW3cJNZYcx
	kMNukepB0JYV/6eJ/341SFUmAL4HlqiOoaLE4zXNUazPQaiIdQoaIp1A
X-Gm-Gg: ASbGncs9cCGFuJ6Unz4N7LPMSeSzzo/48ptZCEOZrnUGoXe2ZfOggdtFpOfHApbg/3h
	T+xQmVAA0cD99ntgQt6ibL9cGCRsDvjK6NCfvPywzG0LiXB+gPjL8ycRVbfNOXTcRB0w6Dsn39l
	Wmjd2DREUhnpVHFxlbL4Y/7/kLbWett+8/ZmaN0xG2UEOMQ5Zc1A/yPsut9A3uevjNjmWeeSs3N
	RlPODsObZS3tWwnynGDpun2gWSLNu8AOiPJWvqj0c+tUmei4uI4FtXsmLyAPQ9MjOmrRufCOear
	H1Xxeh59J1bFLswZDZxx4GsfTqRxOnMRlOCfIgVNMf1eAW5/i8AkLmmOqp5vnSgJdeNZ2aU8gBT
	ku272AW7OsQKY72OvdL0TcRTuZghJMEBjAT/h/IIcBY4fw9ADwJVgFI9y+3pos0hJF0L0qPti9k
	7SiMg83pSNfNTqJrMk/Q==
X-Google-Smtp-Source: AGHT+IG3q2ScRjcYVlSQKEOGzfSShOd+VCm6j/zTtP/syrwGIinOh8u7Pw68B0XoVDTjaFHiUhDd5Q==
X-Received: by 2002:a17:902:e74b:b0:269:b30c:c9b8 with SMTP id d9443c01a7336-2951a55923fmr150821025ad.56.1762168018110;
        Mon, 03 Nov 2025 03:06:58 -0800 (PST)
Received: from VM-0-14-ubuntu.. ([43.134.26.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2955615d720sm84025575ad.65.2025.11.03.03.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 03:06:57 -0800 (PST)
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
	Pengyu Luo <mitltlatltl@gmail.com>,
	Junjie Cao <caojunjie650@gmail.com>
Subject: [PATCH v2 0/2] backlight: aw99706: Add support for Awinic AW99706 backlight
Date: Mon,  3 Nov 2025 19:06:46 +0800
Message-ID: <20251103110648.878325-1-caojunjie650@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengyu Luo <mitltlatltl@gmail.com>

Add support for Awinic AW99706 backlight, which can be found in
tablet and notebook backlight, one case is the Lenovo Legion Y700
Gen4. This driver refers to the official datasheets and android
driver, they can be found in [1].

[1] https://www.awinic.com/en/productDetail/AW99706QNR

Signed-off-by: Junjie Cao <caojunjie650@gmail.com>
---
base-commit: 72fb0170ef1f45addf726319c52a0562b6913707
---
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

 .../leds/backlight/awinic,aw99706.yaml        | 100 ++++
 MAINTAINERS                                   |   6 +
 drivers/video/backlight/Kconfig               |   8 +
 drivers/video/backlight/Makefile              |   1 +
 drivers/video/backlight/aw99706.c             | 492 ++++++++++++++++++
 5 files changed, 607 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/awinic,aw99706.yaml
 create mode 100644 drivers/video/backlight/aw99706.c

-- 
2.51.1.dirty

