Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34EE1DE8AD
	for <linux-fbdev@vger.kernel.org>; Fri,  7 Feb 2025 04:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738901998; cv=none; b=L5M28QgduGka41poG9IEp9YzvjUrifHu/DHfvykZwk/p6PhAqgxUqYIO4Ihi0S28dliUxgcikJWOQ/vfATVk9tXTXMdoXLZe3VaI+Tr5J9Un/+8N1x7thhn0jYfcP4gV7oqajFQ00ShNLia4lfDiWOJD7Y+s8dpWqxuOnF/WZkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738901998; c=relaxed/simple;
	bh=jZB8zGXz36/+lvUPD5y3bq+QwxXeco1+RGlfWkVq0WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nSCWPIGOwJmv+5rBWTdWjIyClyjQ2ygK7UT+eFPOsxoGSlWyc0NHDDnBYml3wEc26MhBqW8dmdmJMOh+jDnnmp6rK4lFdiYWR77Vav54Fo8QWmIrJoklP2noeHlpnvHm01OmFeLfFavfAWMXlDm7ILIFRSeEUZSH65x/6/Qvv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 0FEB0100FA; Fri,  7 Feb 2025 05:19:52 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH RESEND 00/13] fbdev: core: Deduplicate cfb/sys drawing fbops
Date: Fri,  7 Feb 2025 05:18:05 +0100
Message-Id: <20250207041818.4031-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 68648ed1f58d98b8e8d994022e5e25331fbfe42a the drawing routines were
duplicated to have separate I/O and system memory versions.

Later the pixel reversing in 779121e9f17525769c04a00475fd85600c8c04eb
was only added to the I/O version and not to system.

That's unfortunate as reversing is not something only applicable for
I/O memory and I happen to need both I/O and system version now.

One option is to bring the system version up to date, but from the
maintenance perspective it's better to not have two versions in the
first place.

The drawing routines (based on the cfb version) were moved to header
files. These are now included in both cfb and sys modules. The memory
access and other minor differences were handled with a few macros.

The last patch adds a separate config option for the system version.

Zsolt Kajtar (13):
  fbdev: core: Copy cfbcopyarea to fb_copyarea
  fbdev: core: Make fb_copyarea generic
  fbdev: core: Use generic copyarea for as cfb_copyarea
  fbdev: core: Use generic copyarea for as sys_copyarea
  fbdev: core: Copy cfbfillrect to fb_fillrect
  fbdev: core: Make fb_fillrect generic
  fbdev: core: Use generic fillrect for as cfb_fillrect
  fbdev: core: Use generic fillrect for as sys_fillrect
  fbdev: core: Copy cfbimgblt to fb_imageblit
  fbdev: core: Make fb_imageblit generic
  fbdev: core: Use generic imageblit for as cfb_imageblit
  fbdev: core: Use generic imageblit for as sys_imageblit
  fbdev: core: Split CFB and SYS pixel reversing configuration

 drivers/video/fbdev/core/Kconfig        |  10 +-
 drivers/video/fbdev/core/cfbcopyarea.c  | 427 +-----------------------
 drivers/video/fbdev/core/cfbfillrect.c  | 363 +-------------------
 drivers/video/fbdev/core/cfbimgblt.c    | 358 +-------------------
 drivers/video/fbdev/core/fb_copyarea.h  | 421 +++++++++++++++++++++++
 drivers/video/fbdev/core/fb_draw.h      |   6 +-
 drivers/video/fbdev/core/fb_fillrect.h  | 359 ++++++++++++++++++++
 drivers/video/fbdev/core/fb_imageblit.h | 356 ++++++++++++++++++++
 drivers/video/fbdev/core/syscopyarea.c  | 358 +-------------------
 drivers/video/fbdev/core/sysfillrect.c  | 315 +----------------
 drivers/video/fbdev/core/sysimgblt.c    | 326 +-----------------
 11 files changed, 1208 insertions(+), 2091 deletions(-)
 create mode 100644 drivers/video/fbdev/core/fb_copyarea.h
 create mode 100644 drivers/video/fbdev/core/fb_fillrect.h
 create mode 100644 drivers/video/fbdev/core/fb_imageblit.h

-- 
2.30.2

