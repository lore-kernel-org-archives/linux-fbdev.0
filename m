Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486130EF7B
	for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003813; cv=none; b=MlDt5JJXzDqWfaKmgTesBrkDiN6KIgYhXdE2+q72bhWKtbMCkWJOcU9roHaf9xYC9GnHh+y9ovqKRIc15VKYhm7zYwBH/tfxapLW/zAPsasM6VFulF6qq0oYCQt0xDuxJ+CooGsrrFbgThsQYU3YS5TFOmaR4cxgherus6syMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003813; c=relaxed/simple;
	bh=Y+Ex24d/as2CHkwX1uEjCtuYJgz4R8M4AkquqzZdRGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RR4qNvHeKMGe25q5JxovTZmgSOdrVxu2rS5pfpbSSlCOqDjjEpzYEMYripgZPBMImIWN0GrxWp/r+60kO3EzJBaw76EDFWx4s0cNnfNwiJbyr8JcPnDULl9vRxyHfv1636fV6A3U4OgK7Q9dveJWOaGW2Afe4uE7Y9nQ48/WHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejglwb88; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejglwb88"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-459bf19e87bso598500f8f.1
        for <linux-fbdev@vger.kernel.org>; Sun, 17 May 2026 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779003811; x=1779608611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIN4QPzSpV0aaXXOpKphRYVC2gTnp619k6g01a8YFLQ=;
        b=ejglwb88a7xr+VNBcXRowPG20Fb4Ffj/yk9XWlHVovJLEvHQb2KNJh8mqIuBs5ZkA3
         MXbCNva6vdDuvZKqNbQ6CeWdbTWCQUbtRF93XyKlCKaTVvuhsZig468MInSZxUKnsuJk
         4hmEiCTmAOIREGGzoLyJye8ZH7Nv0/kDGEWQ3xijEJ5+IM7bC6uAi1ReXE2jen4R1AVg
         W9R+ukHqmBVixMrZkq5fmohIsW/gRWZFVdjm3jhLLEtUz/ASn0aHUiNpo8mlUzMNnBZx
         7XBgDCLQoR62JnYpvUG5nDFbtJf46W9AVqQfOQEXT+ZhBiL6akdYCjgCYlFSOV52Loh6
         rkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779003811; x=1779608611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIN4QPzSpV0aaXXOpKphRYVC2gTnp619k6g01a8YFLQ=;
        b=ZyjU7b1sTB26yk/zdU1f4eoz/0gfP2t02Og+js2veiBFQCc11Wtlt/u6eZJH1jWvYK
         3/wqJzRweS2z6Ccyg5KfjQOYscWzR9alPa5jAVcwSU4mcyfHerbw+VEU/+fAPqC0Ot1r
         GQjFXWVONdomhXgQTxB05vUHUNPvx6j5uZS2uPLx31PFeXDR6YCorQa4MjEZPL1H8NxN
         BVkkJedDb4KbCbjJ5sO/pNwRV1xDIaARMy9NRtcn4+BTPL8SdPO4VPPNUpgWtZ8DRmx0
         n9lVFcppxUkbaVMaS1dXnQdpBURxzcHVlL0y6nTD+DIMpg4pgS1tvxiLON9FTU1NGnQF
         jbUw==
X-Forwarded-Encrypted: i=1; AFNElJ+cA4/2iB1E1ePFu9HIzK3oZeT5HYrcqPp8rE3NfgnW9mdN5guBp6wn58mob/WNtsMXhnATUxZwKe93OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymN+hr3vTAybRFdRjoKILxZAT+WPksOd5RZgIw4F7zRTJTNCVZ
	ts5W99f2gPe5v55cEeaXOu/KC/smX7XaYms1QlLYj0HziPLM7LOt1rZ1
X-Gm-Gg: Acq92OFBgH1U60Q9fz3Pv5FSXdO6AY4HfJU3g7Yhbpcf9um2CHtvpQCLGRWIGslFowv
	M1qHbdy+KZEciS1omk4EIjiGCs8SjX+1A+ufIepS56WjFk0Yu+m7K13V+oHYrJpsTgn+wCa6or9
	vR4YK+6kna8BHiTr5cSyiv7FGYMixfrkrK3WuZw5nZYXRZMYnLOGjwerQtjTfkUWBCVW1iDf/g2
	mFSPuNEqvLhTnTP9YZGgl57S/78oJAVPLQcfhl7QKPwXkuk7QcUSTuOeVnEc3yHVwXBB0PZVnn/
	5B3z+Pxnd99iBOo6oWqU/EMihmzaTDWEkbBDgAMOE7TdCUTlJTyajtsTMnqPeybLfFbt+z5/uxX
	Tqkr4D0ltS18423hFQP3tTlwV2NSMptkeX2xMxvzEMWSZnCrMvbEUd4xBi5znvzDCEH3TtcrjDR
	kO/wLIZIw6FcIM
X-Received: by 2002:a05:6000:2302:b0:44f:c886:89b4 with SMTP id ffacd0b85a97d-45e5c589d83mr15861004f8f.15.1779003810524;
        Sun, 17 May 2026 00:43:30 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 00:43:28 -0700 (PDT)
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
Cc: dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v1 0/6] mfd: lm3533: convert to OF bindings, improve support
Date: Sun, 17 May 2026 10:43:00 +0300
Message-ID: <20260517074306.30937-1-clamor95@gmail.com>
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

Svyatoslav Ryhel (6):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: set DMA mask
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  68 +++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  66 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 190 ++++++++++++
 drivers/iio/light/lm3533-als.c                | 123 +++-----
 drivers/leds/leds-lm3533.c                    | 117 ++++++--
 drivers/mfd/lm3533-core.c                     | 281 +++++++-----------
 drivers/video/backlight/lm3533_bl.c           | 123 ++++++--
 include/linux/mfd/lm3533.h                    |  52 +---
 8 files changed, 660 insertions(+), 360 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.51.0

