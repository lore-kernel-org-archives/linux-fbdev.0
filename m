Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA023750BC
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Jun 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141921; cv=none; b=c1J7LC5ehLktu17svlrGucVW4a8RvQMKnRloF1OtdXsHeZZoKuTsCa9PRz3YRFBOwGh6BpprLlQJsBcs/Gg0d8c2w3gvD5o0aLIdKOseLNq/k0urbdhKWYri+/arcKtv+9EGaEB9zEGjaRPNcMLihW3Gtq+YvyRT2SXNa00k5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141921; c=relaxed/simple;
	bh=FjFXJ5dUGr72R4YaGkKyaIYzexfp4gxj3M1jHMlRFI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvukQQcS1leLAmDgRv4anK8SsFzVaK6Rw95peeX69bnJggj8+7NplpZgpKLBIKClUwgeifdlOTD08IAHrb3GlhFTP+sbsSDXNQ5CBAgyDp1i/pJSSBhD7r75UVC/vLZvjrMl+N9wcAh6eyg/t42drIEKbG1NBv+Bx+NTXX8iI9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCVMOuqO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCVMOuqO"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-46255b269c2so3506929f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Jun 2026 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782141918; x=1782746718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kL1tj/BLw05+tMmUXWpE7p03gE32TyonQg4lQC1zuNQ=;
        b=oCVMOuqODYuueS51P7A97np0ij6118fitVxcxc9RKMB7fqwOK1XNwXlyIjRV4u9vJj
         8XXtyC4bNPsdnXupYpd5r20X4jNJ0mS+kT1+N9asGB3BF4bUrEKkiWLOW7ziiPEMKYAc
         MF7OTq59nCF9PONs/PDQh3U2mg1cjnQ/ato2xm/iXxjfT25Sg/XQszzNLF9tB/5k4E99
         48azXwDiXJILdluP1cLNEhGpwgUTJvs6kypMfSgHAnKpnE8jebAl97Dz42KQm4muLvwl
         R9HOPUYmUztnpNOp87HjaTdmTL8L+6K++wyfMez6Rsc4AWaPgYac33HLAkvg2NSJUk2J
         CPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782141918; x=1782746718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kL1tj/BLw05+tMmUXWpE7p03gE32TyonQg4lQC1zuNQ=;
        b=az1NOeIBYB8/3SA3WpEqxEXScKmOxPeJV8vSgoig0Tsk+0C1diMIMefUzTv5rv/nrr
         a0Ls44hiR18bHVoOVk7OFhL7pUCt+oRepc0A37jfD47dy9DxcC5J52nUmzERY6mZSMBs
         a2nvmmV87xMKnscLx/CN0hrAsHH9yDC9XIpqbjLXNu1cGfUMZR8eCj6HgojTfkgqq1Fb
         JfxFnaOZsmzlFGzoHonteUCreXtQqTXDSyl/21rRBIerQn9Wml7qCRI3pPul107jCCP/
         B5PpbYDEtagq1OQyFYsBIVisTJlhItjxEmiOxHv9AVxatPyrih8bIrFsw/uL/ZSJCTeH
         NrSg==
X-Forwarded-Encrypted: i=1; AFNElJ8kVZqnysEoxPcOFD0/fLjDl36cNNoNAUCYn+FFj7tIQzKO+inIx+G0lZZnn1rruSUct2tgJjK9D59Xnw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0MLZmNlaBNHOk7v//1QAG0ieI416eIETdxuUNd/rWgLeGl76y
	YedSlU8TODQ4zEvwixBAg2zTFqYz4owZUTH+deTqb075E4mD542JAVXA
X-Gm-Gg: AfdE7clAqxs9vxEldnhoPmpuRWdUea8BfFa9CiD93qeHrpZKrNcPsg4uojx+drizAw2
	g4hYE/mAE+ChIwN0sb1TfJANLi5Fc+Vwd6mO/yh6bz2KGK6gksFf+UO0akdmu4u07+XbreIfYmZ
	gnkLaexTXmD2OKR9oNEJrnDqHOaMMdCEA3esRZOTiOsAKxOyWPU92CoWSxMEZB1X3uXDEm5xhO3
	wGLh0hp/WCd7ZhYpISxDeIybY5z7celJtRGfUJ47z/eSJMfeLZ/fU2U0wUbDdax2P44sABaYRVb
	KIeRaTrlXzLQcW6PhHj0/d7h7/yy5ffx1MuNVM98mz1pm7Rr7r6uMaPLihQ85kK2C8LlK8mDLF5
	HhnCOXSiDptLxcotUsKEONprY4P1KdQg+oKFKzITw3hjBFz5iliSntoaam9V/Q8A+rP6kdTz0DH
	v8lbFmJHvQrp5pNw2c8FU54XK1lpA=
X-Received: by 2002:a05:600c:45c5:b0:492:41a1:f217 with SMTP id 5b1f17b1804b1-49241a1f31fmr221649685e9.1.1782141917981;
        Mon, 22 Jun 2026 08:25:17 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492492338dasm217883655e9.1.2026.06.22.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:25:17 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	deller@gmx.de
Cc: azuddinadam@gmail.com,
	chintanlike@gmail.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v2 0/4] drm/ssd130x: Add support for the Solomon SSD1351 OLED controller
Date: Mon, 22 Jun 2026 18:25:02 +0300
Message-ID: <20260622152506.78627-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Solomon SSD1351, a 128x128 65k-color
RGB OLED controller, to the ssd130x DRM driver, and removes the legacy
fbtft fb_ssd1351 driver it supersedes.

v1 [1] was a self-contained ssd1351.c driver. Following Javier's review,
the SSD1351 is instead folded into ssd130x as a new color family, which
also brings 65k color to the existing SSD1331. The work is split as:

  - Patch 1 adds the device tree binding. It was previously posted
    standalone as a v2 [2]; it is folded into this series here, as Conor
    asked, so the binding lands together with the driver and the fbtft
    removal.

  - Patch 2 changes the SSD133X family to drive RGB565 instead of
    RGB332, via a per-variant flag in deviceinfo. The SSD1331 is the
    only current member and gains 65k color from this.

  - Patch 3 adds the SSD1351 as a new SSD135X_FAMILY, reusing the
    SSD133X plane/CRTC and blit/clear helpers. The only data-path
    difference is the explicit Write RAM command (0x5c) the SSD1351
    needs before pixel data; it also gets its own init sequence and a
    longer post-reset settle delay.

  - Patch 4 removes the now-redundant staging fbtft fb_ssd1351 driver.

Testing:

  - The SSD1351 (patches 1 and 3) is tested on hardware.
  - The SSD1331 RGB565 change (patch 2) is compile-tested only; I do not
    currently have a working SSD1331 panel. Javier has kindly offered to
    test it on his SSD1331.

Dependency:

  The SSD1351 reuses ssd133x_update_rect(), which programs the column
  and row *end* address as a relative offset rather than an absolute
  coordinate. This breaks partial updates that do not start at (0,0). A
  separate fix is posted at [3]; until it lands, the SSD1351 shows the
  same partial-redraw artifacts. This series applies independently of
  that fix, but the two are best merged together.

Based on drm-misc-next.

[1] standalone v1 driver:
    https://lore.kernel.org/dri-devel/20260615181253.97551-1-amit.barzilai22@gmail.com
[2] standalone v2 binding:
    https://lore.kernel.org/dri-devel/20260615175620.88828-1-amit.barzilai22@gmail.com
[3] ssd132x/ssd133x update_rect end-address fix:
    https://lore.kernel.org/dri-devel/20260622122604.32500-1-amit.barzilai22@gmail.com

---

Changes since v1:
- Fold the SSD1351 into ssd130x as a new SSD135X family instead of a
  standalone ssd1351.c driver (per Javier).
- Add RGB565 to the SSD133X family, so the SSD1331 also gains 65k color.
- Drop native 256k color (no matching DRM fourcc) and the 0/180
  rotation support, to keep the series focused; both can return later.
- Binding: drop solomon,width / solomon,height (deducible from the
  compatible) and the rotation property (no consumer), per Krzysztof;
  use dt-bindings/gpio/gpio.h flag defines in the example.
- Remove the staging fbtft fb_ssd1351 driver in the same series (per
  Conor).

Amit Barzilai (4):
  dt-bindings: display: Add Solomon SSD1351 OLED controller
  drm/ssd130x: Add RGB565 support to SSD133X family
  drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
  staging: fbtft: remove fb_ssd1351 driver

 .../bindings/display/solomon,ssd1351.yaml     |  42 +++
 drivers/gpu/drm/solomon/ssd130x-spi.c         |   7 +
 drivers/gpu/drm/solomon/ssd130x.c             | 269 +++++++++++++++---
 drivers/gpu/drm/solomon/ssd130x.h             |  12 +-
 drivers/staging/fbtft/Kconfig                 |   5 -
 drivers/staging/fbtft/Makefile                |   1 -
 drivers/staging/fbtft/fb_ssd1351.c            | 240 ----------------
 7 files changed, 283 insertions(+), 293 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
 delete mode 100644 drivers/staging/fbtft/fb_ssd1351.c

-- 
2.54.0

