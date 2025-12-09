Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3D62EBDE3
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Dec 2025 04:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765254492; cv=none; b=NGLQ28w0rWKbUPyTkj/k/q3xkD9gh4HuBW8Z5w5SnMn/GXqlvv0E0hffLwMWTe35htx+ivldASS84M595zEWXn24bAwF2U62yZyVS8hCLTZjO70H4Azw9FzKVc4HN1icp/WPweVr+lgVb0zBl4CGtk0EbIzuaCrYlG+Va+UTBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765254492; c=relaxed/simple;
	bh=LsB2Rw1u+BAgI+Dke597qwki4yRQSIPkKWxz+iJXnKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/HGk75ID9DG/7RFfxVb1ufaTgEkmBuAw0V1OtCPr569MKTnE5wgF3mbUDcPp9WPXPA5JlEblGoa1UVuZGiy4sqSwPFRwfZarY4NEDu16JYSVHQyoeyTvujmClEODFjcxW/slAD7WVebD8rhsEzkg2BGwW1BpJ/O1/NVpwgdrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iP0wR6bJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iP0wR6bJ"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-340c39ee02dso4161526a91.1
        for <linux-fbdev@vger.kernel.org>; Mon, 08 Dec 2025 20:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765254488; x=1765859288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OlS8NGZoUAbx3WVREmoqnUjbjOgDJ/P+b1vdg2wt/Bk=;
        b=iP0wR6bJhNO2gY/tLDMnaPxTUfxT3IY2A6qwLfRmR4lDwH2mxSx80g+NuX2fU5Avh2
         RtMIaM1Ct5EbYwd8lBXHySUhbXEO76C6vzWSotMBnW5mEoTSpy8YYlG46DrJd+5AGEaW
         dc1Vo1t5beMYsJqIl8J6kZicAdBBpwTsLeBWtTgayKeluikViLXlY89Gjco/kcFpm3nC
         ymGpJwMNHTmz+S5SIH7DCrOmdBNA8pt1lTZ9EH4oVgtxHSgPSK2YeyPRBES2ejxXVKtA
         7AwXDl70ZAEPcjciiIOO0Xo/U05w6s/n/s25iwawuacLqF76nzDt+GUK+wv+/5ARakW9
         8Chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765254488; x=1765859288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlS8NGZoUAbx3WVREmoqnUjbjOgDJ/P+b1vdg2wt/Bk=;
        b=jbUfGBuoBKC/hGrDhzWAA7GIIFrtV1mZc/fRNxWrKuIw37pWd2Y6FHUHRG67m7TNCO
         yHEFeYQM2OTrpmz2SsK26V9m0yJXBrj+lelZgxcliysni6j9eoY8nDd02G+ynqUddZXR
         NhrXZzC/iX4Xoq09Oyo7tlxH6xTujZX6MvmfsyTVepOrdCSsVkCLF5HoyW8vGTHwYcJo
         VSCDbHrTfTnNAQb5LFRAxEkHSsutPEmbB7/0fkeAAhEq5okJTcGC2X01fAXa5V5xeWEU
         tjZKwIh4/nWGHDtXe5joR31LYDq3BGF/WzA0h5uDaAEiCWNutfk1oDWLiu3D8QNgA8Bh
         WiLA==
X-Gm-Message-State: AOJu0YzS2GgX2GpzQKd9dRKk1pnL276HvTtL3QXCo6ByN+yUAhzp3kWA
	mypiCA6g4Wx9vWi2RKHtLDTP1c7J+L1dsVrFOoIXRXmqixwjPkOv7VaN7FZ/pvBJvos=
X-Gm-Gg: ASbGncuoGBydPgYrgM65vqaHh+J7uhG40Xw4/j4quaYnFF4Ugzxdras/StSZi5VzJeA
	Fbjt//XI0kdx8lDyE2hUmSioodB2gdntQPVOCj6qyBJi9B3AEdp874UF/6qXyyPoYpXuKGLdzdx
	tw0FG21YU0zFWRmnkzEQ5BYl+8epV/EcKDW+pOcZd9xV7xy90dLzEnXrIsUVOGCHo/mcVPYYUDu
	zPGD2wwtcuQdWftTFl/BnaVyGu5ZcArG86n4b7n5jKYRIklRwVklAFpe7353R72j68bFXiA3VRy
	lgqs1gPBeFNkuqfcZAJhAhAbbD8YzpcfIrW7lPXV0gj2XniEBXglEVwk2mL+x4tQwpGi/MQ1gdl
	/B8KRrd8WCfk7kKwwxQ9fyK+b6e5Nld8NqJr3YgeeZnmeW53FKPiCgS9/UmXNWJtMZ5323HRoPs
	NQu5bL5w4WnumnY0yO8nnZPrwPTb5LITHNbIJCD7ky5hxcdaG+st9CzA==
X-Google-Smtp-Source: AGHT+IFg1iIMyFLucr9uOHmmv9GE122UxHPeUmvBUIJroW50FItL/tqkSaQEcjZrl0Un6zQJ6OWfHQ==
X-Received: by 2002:a17:90b:1e07:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-349a2511cbdmr10578046a91.12.1765254488312;
        Mon, 08 Dec 2025 20:28:08 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:b455:298d:48bb:1784])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34a49b90fd5sm765185a91.10.2025.12.08.20.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 20:28:07 -0800 (PST)
From: Chintan Patel <chintanlike@gmail.com>
To: linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-omap@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	tzimmermann@suse.de,
	andy@kernel.org,
	deller@gmx.de,
	gregkh@linuxfoundation.org,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH 0/3] fbdev: Guard sysfs interfaces under CONFIG_FB_DEVICE
Date: Mon,  8 Dec 2025 20:27:41 -0800
Message-ID: <20251209042744.7875-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This small series makes several legacy fbdev drivers buildable with
CONFIG_FB_DEVICE=n. Currently, multiple fbdev drivers rely on fb_info->dev
and sysfs attribute registration unconditionally, which leads to build
failures whenever FB_DEVICE is disabled.

Thomas previously noted that FB_DEVICE should eventually become optional
and that drivers should not depend on sysfs or fb_info->dev being present
unless the Kconfig explicitly selects it. This series pushes in that
direction by tightening the FB_DEVICE dependency boundary without changing
any runtime behaviour when FB_DEVICE=y.

What this series does *not* change

- No functional behaviour changes when FB_DEVICE=y.
- No removal of sysfs interfaces.
- No changes to fbops, memory allocation, or display update paths.

Build & test coverage

Tested with the following combinations:

1. **FB=y, FB_DEVICE=y**  
   - Baseline configuration; no regressions expected.

2. **FB=y, FB_DEVICE=n**  
   - Drivers build successfully.
   - No sysfs attributes are created.
   - fbdev devices operate normally (where applicable).

3. **FB=n**  
   - Drivers depend on FB, so they properly do not build, unchanged.

Motivation

This moves fbdev closer to supporting FB_DEVICE as truly optional, helps
reduce Kconfig entanglement, and clears several long-standing TODO items
as suggested by Thomas Zimmermann around legacy sysfs usage inside fbdev 
drivers.

Feedback is welcome, especially on whether the guard boundaries around
sysfs are placed correctly or whether more logic should be pulled under
CONFIG_FB_DEVICE.

Thanks,
Chintan

Chintan Patel (3):
  fbtft: Make sysfs and dev_*() logging conditional on FB_DEVICE
  omapfb: Guard sysfs code under CONFIG_FB_DEVICE
  sh_mobile_lcdc: Guard overlay sysfs interfaces under CONFIG_FB_DEVICE

 drivers/staging/fbtft/fbtft-core.c            | 20 +++++++++++++++++--
 drivers/staging/fbtft/fbtft-sysfs.c           |  8 ++++++++
 drivers/video/fbdev/omap2/omapfb/Kconfig      |  2 +-
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   | 11 ++++++++++
 drivers/video/fbdev/sh_mobile_lcdcfb.c        |  4 ++++
 5 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.43.0

