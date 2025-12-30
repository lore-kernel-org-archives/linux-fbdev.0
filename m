Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133DA280A51
	for <linux-fbdev@vger.kernel.org>; Tue, 30 Dec 2025 05:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767072544; cv=none; b=qJ7PMwNHgfU1Uvth+PTOrF/BngRM6cdM9bVfY5t3Yq3R4jAH7i5NUHVR+4zBwxFWFoEWDmsI99OAnNOJa2eIAFMMFN87Uc4cRSLQads6BsFIrL++dCefKbduz1DQ2F5/qDQpGew2LJGZ6hWjlpMGnfY6Gg4G97Or0vP/KAG8BCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767072544; c=relaxed/simple;
	bh=9ea4jF6P3TyrXMCdcTje93kbQRCfpteLO1tsmpVJYR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHk0tHVn0S8vrJNGWETaRJe3ZQOshZz0Iqv21IxateFKW2czQ0rR7tDEHDqa4FUkWm0zkBZfNZfUCYa+vEXK511DiWSJSDpgk/89jtUwmv+iaORYUzo41QEIRg2FVxM73iSymA1u7GMriQYtl60q2QE45hWe9gF1RDoMDz20970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4HrvkuK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4HrvkuK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a0a95200e8so83799285ad.0
        for <linux-fbdev@vger.kernel.org>; Mon, 29 Dec 2025 21:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767072542; x=1767677342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dj6McVGjym7Yb0fc3OqJWPUYkxg//XdJSHr/RV+rzYI=;
        b=h4HrvkuKxfZRPTt/l9xyyhLsw6ivBR+T/1Ua45ETohAKYsBH1o5QJ9qWEGUQnVYXBh
         MBoeRyRnG3vtssaKP0Omm6CaJk4TSjPUEjMEj8rPxk3NzjoQrDov6RZOziRAmsKjNKSW
         w7DZTtOaOd7LljTzHh5CSyXxpgVw2xOJykFngSW0nqValknqoqxkUFGEakyYN2pvnzF2
         o5+u00gBXS4EZTHpn3hnds8BG6DvGL/5Ky6x37Aadko8Df+GMEmTDIm7KbeJ+rRjfaLq
         p5URxILtpgJzbxGamCBwIqD2gMopOwwD7fYGCekcS3RGjixGw9z4veRRY9DpQWpx4zKT
         +6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767072542; x=1767677342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj6McVGjym7Yb0fc3OqJWPUYkxg//XdJSHr/RV+rzYI=;
        b=ge7w7znKk1DLL9le1SyRgXM5EwPnz3RRNyKs8FMiiXLtX9/Itu41VZzy2+ATNzgPf6
         buH+7IQrkr22pnMXKw/yuxurLhEvMz0Ka9KrAUDD4DPxDWsJl1MRUKO4xpY6xZls/PyP
         ksnWfESLmebMKIhyVS45ppswtiK40qDhT5pUfs1AHk03jcdVPF653b8wvAddsJnxFp5a
         LRcn1sYD6AV/67aJ5ScIVKw6Ywjll4P/X72pPZRm/4J8e62K/clX6NP+sHaf3mrUtFG0
         b2dvNLHoF3B5OkHuCF536X1mBEuAH7hvH4utawmbl4M7fAFP09uKbLe9+CsitRU12geS
         Cxbg==
X-Gm-Message-State: AOJu0YwRQFx/dLRaDcveVWEalRYjVM65rILZPRMXqrRKTkMRHEcvleAT
	mikna1pPPV8SIEjUk/7mrzmIykCs78TKp/ZPyBhNu9267rHnDTM300hDYjPDgZNl
X-Gm-Gg: AY/fxX7mnxFdnHEUGejS69o/kef1pOxd/kBaUyBKSvl8q2snnd6m8HSJqZdWpXwZtGt
	eN2UNwrOg122TITJHwa9+AQ/4J+2hU2ZQbHLPw/oZDBupLemQry+AsjrLGh/TUgQmPl7nYbEpOw
	ouQjuEJKgPFge73PBCE1RpKu92c+fWzFp/oas5YWpf21YAeB3Rkvzjfi+9qq2a1Mo6Vh5cmxaPg
	95ZJY3Ni//bVgP66YLqdXQrHzw35tJgokUaCT3SbhYSW2uARtAY4O7bwEQz1Cahu+zk9yOAdVgL
	ifv8ZotpkOkFiJvWf0t5vMLdZzuoCqHwZVRQK7S3/Flhrj4/JfKGQc60ctB3gg3vTTxCf1OO4SV
	2uvmJF4eE53FmTbCnbxBU7W6DwqVUGSV5HPyV3nmjX6JM44WrVcMPp2WjBUXaU+a0HD6wnKgRR4
	tX/rEg2MzVXPVjCe5u24s3W7zLV/Ohu/+/yWRd7ax3SA==
X-Google-Smtp-Source: AGHT+IHwTfpQdWaiGQID80ROPYBWipLKNMwbumSR5a0iV81jvx/Y/dNBzJjvj9L9pMYVwYJAGCLB/w==
X-Received: by 2002:a17:902:e785:b0:2a0:acf1:ad0f with SMTP id d9443c01a7336-2a2f22024e0mr275687215ad.12.1767072541794;
        Mon, 29 Dec 2025 21:29:01 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:f7a0:c2f:d915:faf0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c8286esm289290375ad.33.2025.12.29.21.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 21:29:01 -0800 (PST)
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
Subject: [PATCH v3 0/4] fbdev: Make CONFIG_FB_DEVICE optional for drivers
Date: Mon, 29 Dec 2025 21:28:18 -0800
Message-ID: <20251230052827.4676-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series makes CONFIG_FB_DEVICE optional for fbdev drivers that use
it only for sysfs interfaces, addressing Thomas Zimmermann’s TODO to
remove hard FB_DEVICE dependencies.

The series introduces a small helper, dev_of_fbinfo(), which returns
NULL when CONFIG_FB_DEVICE=n. This allows sysfs code paths to be skipped
via runtime checks, avoids #ifdef CONFIG_FB_DEVICE clutter, and keeps
full compile-time syntax checking.

Signed-off-by: Chintan Patel <chintanlike@gmail.com>
---
Changes in v3:
- Use PTR_IF() to conditionally include overlay_sysfs_group in 
  overlay_sysfs_groups
- Decouple variable definition and assignment in fbtft_sysfs_init/exit

Changes in v2:
- Add dev_of_fbinfo() helper (suggested by Geert Uytterhoeven)
- Replace #ifdef CONFIG_FB_DEVICE blocks with runtime NULL checks
- Switch to fb_dbg() / fb_info() logging (suggested by Thomas Zimmermann)

---

Chintan Patel (4):
  fb: Add dev_of_fbinfo() helper for optional sysfs support
  staging: fbtft: Make FB_DEVICE dependency optional
  fbdev: omapfb: Make FB_DEVICE dependency optional
  fbdev: sh_mobile_lcdc: Make FB_DEVICE dependency optional

 drivers/staging/fbtft/Kconfig                 |  5 ++++-
 drivers/staging/fbtft/fbtft-sysfs.c           | 20 +++++++++++++++----
 drivers/video/fbdev/omap2/omapfb/Kconfig      |  3 ++-
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   | 16 +++++++++++----
 drivers/video/fbdev/sh_mobile_lcdcfb.c        | 12 ++++++++++-
 include/linux/fb.h                            |  9 +++++++++
 6 files changed, 54 insertions(+), 11 deletions(-)

-- 
2.43.0

