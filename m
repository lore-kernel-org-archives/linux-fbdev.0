Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35CF3A1A32
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Feb 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196527; cv=none; b=U+pwYHLXU7boaQXx9ud0xzrvGuKc9SqqtOf1FzH6VyU+wQwHZTvA0p8SusfAKV66KThYBLJscZSCc6ibD5bGkXgpMCUQg1Z/toSjFaB9D+f9gscmDh4Cp1P7MdoYIobnqjPpCszXTRSQqYCC+UjeSo2WcM2ZGVDvYZP2ISYiITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196527; c=relaxed/simple;
	bh=5m9kSIVNTKtItphnRlrL11Gl8bzNdjb0IlTPZPxLNyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FW4DmEjeH5mWsznw2Z3625RjWIig4ssGgQNYYH4qWyIvffaJgf0/TA4BDZGLsuKWe7WMpIVVl5FAWvFJT+kFfHtGVUEyO0B9qanwyACn8BLRF2BWWpVEvRMgF2PYmhy/7GRmKL+JyvtnVaKN9kq5DV/n1/TzKtAX5fwhz3HDBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jOFQL2tv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jOFQL2tv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4805ef35864so57480605e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 04 Feb 2026 01:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770196525; x=1770801325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bO9G9tYPhY8+70A/i4Fl7rDlPCoV3MPLBkNv0Mgen4Y=;
        b=jOFQL2tvtgVi9r0lEzH0r5cn/hSmsuO0Ebe09tGlfm+5GO24jSAYYFRAzpwlREay2k
         Z5nvktMmHXWNeos/7g3lV51X5HNy4ENhc0TvGaPM6prCVQlZkSRZvBHFpQHnTKjqIy6o
         YU6+GhKuJ5cLbBTI2TPoU0D0lDDYT61WhNp7nRtgoD9LAkBE2aAOff0l2BtL8sHWmzCY
         FrhGn8mdPkplqk86BpQZSBAl+jw3EAMMwJyWs9fHKxF37foQUhGh78Skpr63SFdBq5PI
         KoPBsq8i8u/yt7hRNaT35pzDYUCm0lWn5KdfqzO+oj+IIVMB7dGfkZeWZPrx1JvIMc4d
         jFrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770196525; x=1770801325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO9G9tYPhY8+70A/i4Fl7rDlPCoV3MPLBkNv0Mgen4Y=;
        b=alcHrM4tDnFT9+CS3aUJNCMJ2WyNy9UFWpXl4WbHFOU3mnLZmC0RCKegBIFJvEMkpD
         Z/C7VIsSDPpN1Ih+hpEcKhaHfjqj35dEll9EjAVDEdR9e5rN2cF/DRVAYU2armXH1o23
         a7+5tjyv+FiQJzYiaWhTtxUSAT3RkVLM9SdF9GOzyFQbdnYxDuMIyr/T5l40B4xJvYPk
         qyU+x3CgQsL+f1Bf/891mJl1q39WsNlb5Rl/d/NOw4/ivBsrtuYHVaYLHWbpoHMVzRtp
         vHH6caPl9IUOmUeF5xVw/FsjCEiD2mD4cOvfTMW+QZqW1yx4Y2pjbHTczUx8ZLQm5Q8x
         ix8g==
X-Forwarded-Encrypted: i=1; AJvYcCVbcrUE5FzHvaf6kCr1mxoDhQSUQujni1g53AQW/+c3eNTKZjBu2S/BKUksSf9ZY4v3XhaieDKvQR1r9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvDlXTTPhw66tOQTlguzSa3iXRKSKnSB8cl/qbrGV08I2ikjXt
	deuPAwNFEvf2XdVzSwmd5ElxR3+xLq0SLy0hHDGPbia98M10Vn3z3Rn4Ga4iGG8vrKM=
X-Gm-Gg: AZuq6aL9MezPYA4wOFuIy79kIx7zqYfEJr9QfOLx5nPwnT451IS493mEbdtkJYOIEdj
	PX8we+JnCVkyXuS1UcYQTkssuzPTWiHsPBT8azaDulAOeERkd0ZvnkKZPPWttNN2wUzbXP5PCIf
	oTtWhq7e5sT/E1Jx3dlk1Lf06rSvWlED6s5I19LAxwGinXNXxlVlr1Ezzy1xUvAFEXeA+fSjzvS
	EzgyApRWY8hCt0PHXwsxG52DBUZiqalcrZ3e1r3pmdz9DEgN4YBMiqVbzQuyrRGD5P4tJzrbHVN
	Fh8QQFB7guR36YH4DfBNf6cJpYXST4BDbwMw2cVYWBO9YXfaNB7Dr475BYgwck3JKVhbSnG9shT
	b6PrxbLubUt+T0CFhISLozQGqZLoidJnejzGFHdGMwbNYyVrgOwsWcLthRvyH/wAuodzCcx6Bgy
	43TAR4S88jMfzNoHggUd2fU+W8xl1ZlO/roo8yFoqFd0mHTsJ2uaH7m7Zndio968qFBDbryVdeV
	Vx4/HwkA8vH6g==
X-Received: by 2002:a05:600c:1e2a:b0:477:9dc1:b706 with SMTP id 5b1f17b1804b1-4830e988efdmr30794505e9.19.1770196524897;
        Wed, 04 Feb 2026 01:15:24 -0800 (PST)
Received: from localhost (p200300f65f20eb0470629fa1229c2efb.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:7062:9fa1:229c:2efb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43618058473sm5267642f8f.22.2026.02.04.01.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:15:24 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Helge Deller <deller@gmx.de>
Cc: Chen Ni <nichen@iscas.ac.cn>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v1 0/3] fbdev: au1100fb: support COMPILE_TEST and fix multi-device support
Date: Wed,  4 Feb 2026 10:15:10 +0100
Message-ID: <cover.1770196161.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=5m9kSIVNTKtItphnRlrL11Gl8bzNdjb0IlTPZPxLNyw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpgw4fm5EVfF5VorVtnsGTdUtnwTU9CvRL9ZmPa dYfsrRRt/2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaYMOHwAKCRCPgPtYfRL+ ToTkB/oCnl1j/dWfB/K/yBWDw+ka6uMn8A8pVPT1poAR5kUjRJrosD0FvxRS7Sk0hZc9W4Vg5Qy 9HKhOnXBhDJ37VrVCFIqy1tSRpzgKILkG8fWQg+rdEjSmaPoc9pn8ciZA8V5VA6M7/7SB8qb29Z gdvas+i5W+P+heNbEcM3P7OKKrJlMm+JhVjj1GaaEEYhMEMjsLU0+AuGsNxjj2UBzY4QluIPkN2 p/WLmfMLMvY3SA952mEmDq6dTlKZrePmgiEZRLgAAPk9EvV6dY+02eCU4W71QZetl+yJ6jjvzKT wXTf1gCOhf1Hpix2UhOXfIfNBC4L4NI6uOJOjKkIfu0+Dq8C
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

In reply to the patch that became commit 0636e6205bee ("fbdev: au1100fb:
Check return value of clk_enable() in .resume()") I pointed out that the
driver uses global data in .suspend() and .resume(). Helge asked Chen if
they want to address it, but up to now there was no reply. So to get
this thread out of my inbox I address the issue here. While working on
that I found another two variables affected and instead of installing a
mips compiler added COMPILE_TEST support (which revealed several
warnings fixed in patch #1 when compiled for ARCH=arm).

Uwe Kleine-König (3):
  fbdev: au1100fb: Mark several local functions as static
  fbdev: au1100fb: Make driver compilable on non-mips platforms
  fbdev: au1100fb: Don't store device specific data in global variables

 drivers/video/fbdev/Kconfig    |  3 +-
 drivers/video/fbdev/au1100fb.c | 86 +++++++++++++++++-----------------
 drivers/video/fbdev/au1100fb.h |  7 ++-
 3 files changed, 49 insertions(+), 47 deletions(-)


base-commit: 0636e6205beed850d985276dc56fd73d785bea5c
-- 
2.47.3

