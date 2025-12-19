Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F35029A9FE
	for <linux-fbdev@vger.kernel.org>; Fri, 19 Dec 2025 05:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123021; cv=none; b=jvgRAeV/ep2iOGru8aKnUewCSh58q7rw7E9zNw8fkusYnHEexFNL/AeIf4RTUjHnWABl21KYz773/0Mk6EuhR4ktAStwwFzygtmaPrJ/aqyaSLrUe5EbvPW0KsDfqCjhF5zz3ioil+p5j9DDJVkNX63BUjzg0wKhx2jAxhfd93M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123021; c=relaxed/simple;
	bh=olchUGNmj+A+qnIzj2ct7pmV079cgkWTHEnd61K24Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=htqx6n5bg0huHCPFWpMweCfauzwXrEzD55skIDluvmQIUhQrIMD0pZgUlrUpQP0UK5SsfIUS2n3DZLrHYpL2UYqLWBG3d55TY+rjYQ3eZqoM/4hGjEUROvraoaDnSC8WgrwajKJHMGbe7xlV6FMJfWCRBJgzrQFSFi7m5KXeiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op5ML9dW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op5ML9dW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0d5c365ceso16821945ad.3
        for <linux-fbdev@vger.kernel.org>; Thu, 18 Dec 2025 21:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766123019; x=1766727819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEjpRHuoUQuSNfpUTp6o9J/plYbBOC8VgnoTelGo6Ag=;
        b=Op5ML9dWJhyTMibNWfF3eiFnzIpILBuwxYZ75fJTT4DahmXkt4RmOhuGaz7coymmWn
         1htSQY/VXmn+InWd+n6WVu67BAN+6spc4DA+9g4GEWNCI/2OWLlUvneg5IBWSzhnTlUn
         aOcnN0hefYPQxZ6F9vBH7+5OKhJgu/jfr/KYcagE/U3jIh5t0BLdwvatpT8BYWRk5gsy
         QzPQ8qaQe14dx+3BSBkXd6dx/JC5SSIJGkCcdjHhTMtAWLtjxrsq8oU2+VNiE6tAXxgE
         xxRFFtYGZ2rlPyGJxEMjQuuNsNUEdI69glbgRgOeQr/e+AKtg0iLzL0xaduaDBrvwlVN
         vuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766123019; x=1766727819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEjpRHuoUQuSNfpUTp6o9J/plYbBOC8VgnoTelGo6Ag=;
        b=BA3NsqKnOSnk6YXP1q+A4vOMgaFtkN34IBpSE/kh9rDwHjSV5opzs7onMoexb1zKzz
         +o37euidluvxtg0x46IxrjJsY6UOIVPKwkpR5EKJYMEA7mcjbq1UO/l9AEJppvWyepzF
         sUzcr47NrqbdVee/k06U4/QMOMScqwAN+CxSG+bZ8FSfKUZZeV4deMiSKCVsoJqGxbDx
         9PlrztkSwAQ5dPnWzIKfWJqmhgd1s6IHf2Dvd5cwE/ex1y4reWWNJpMg4s9xriJq6da1
         UyeiprvbfMrhHb2pd5tmi3QUOTZ7mWbsSN9R00hdfgAxkuMmectWboK1Vr+LHpqjUWMj
         7IvA==
X-Gm-Message-State: AOJu0YwplNn0YuNWRzQZBCumaVL5MJZ7JD6/FO+8jj3Jo5+CdKYQB9Nr
	HRGt3eoDu2rvBglNwE62YseDHDZ0FW6E/06C8MPcmNjTw/9wGmJJI60fEdxFOmm9
X-Gm-Gg: AY/fxX6BRWoSDRBOfFVqt4f3Is/bA2O99b3YZkaXQuidHw7cQnqhKhutXG9ALypDXEs
	cQ9ctNd3hxRvmIGzK2TWCi05tqmz2LStxkjJujpBCL1nNF0KNSmqOcz8EGt4wehSOD0Jaay3Ekp
	ExXLXH2ruOGz69K4/SN7mFsndU6+7p2QlMlxAFCZP3x+I9TkeqivWu3olZQmEZ2ITG6/YCIZfBo
	YxbtZj6Tho/AVKp9HzquYAVyUnc9v3kDAxIGQIlw7/XXFKTJdARJMfUSovDipiQC7D2CBqECgXE
	1t8A7bWY5xlqcMgkKlEI5xf6puYegW4eGPP6IVbfzy3vUr79nI9RVTze9gD/HDDVqvxrWC+Xtaj
	gSbx+6RtXqUCA4oLgx4lbU5N7OLPXSucu0uUHt2fXmVDKdmjkkpytS7jX1lt2CN29oV+LABDwuv
	En5hE48+W70lS1Vy9CpM1egmdQMJSGEjBOha8aGRrytQQ=
X-Google-Smtp-Source: AGHT+IHctISdxJ6hWwW5bBx0NwJSgL9qDkTNsgriPOBWh2QM/6lUZdbbSRVd/mE4FUYhXiJRoQ1jPw==
X-Received: by 2002:a17:903:2301:b0:294:f6b4:9a42 with SMTP id d9443c01a7336-2a2f21fad06mr14413895ad.9.1766123018955;
        Thu, 18 Dec 2025 21:43:38 -0800 (PST)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:5160:2cad:cf88:afa5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3da7dabsm9878955ad.25.2025.12.18.21.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 21:43:38 -0800 (PST)
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
Subject: [PATCH v2 0/4] fbdev: Make CONFIG_FB_DEVICE optional for drivers
Date: Thu, 18 Dec 2025 21:43:15 -0800
Message-ID: <20251219054320.447281-1-chintanlike@gmail.com>
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

Changes in v2:
Add dev_of_fbinfo() helper (suggested by Geert Uytterhoeven)
Replace #ifdef CONFIG_FB_DEVICE blocks with runtime NULL checks
Switch to fb_dbg() / fb_info() logging (suggested by Thomas Zimmermann)

Chintan Patel (4):
  fb: Add dev_of_fbinfo() helper for optional sysfs support
  staging: fbtft: Make FB_DEVICE dependency optional
  fbdev: omapfb: Make FB_DEVICE dependency optional
  fbdev: sh_mobile_lcdc: Make FB_DEVICE dependency optional

 drivers/staging/fbtft/Kconfig                  |  5 ++++-
 drivers/staging/fbtft/fbtft-sysfs.c            | 18 ++++++++++++++----
 drivers/video/fbdev/omap2/omapfb/Kconfig       |  3 ++-
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c    | 16 ++++++++++++----
 drivers/video/fbdev/sh_mobile_lcdcfb.c         |  9 +++++++++
 include/linux/fb.h                             |  9 +++++++++
 6 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.43.0

