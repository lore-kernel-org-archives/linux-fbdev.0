Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A251A9B29
	for <linux-fbdev@vger.kernel.org>; Thu,  6 Feb 2025 19:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738871108; cv=none; b=GNeMci2XboNMn5mvUxpJQtmsIY6O4qNGouJZQoBCajG+DIsQW/uf05/MGeaj060K+7/U9XNR2SHZZGyv+rFv5N2FP9WTKNoqYzRfS1/3i5muWLt12aKryDoFkhO086TQM7UZEPRkycwCiVPKjNqxuaDQBYQsi3JvGNVqL+D32LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738871108; c=relaxed/simple;
	bh=PiXGlOYyOQzswKDpDjNBc2ui4OdFr6Loif1NFbEzD1Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=rBuY05JRwcKxPmv2DxkvQuaHH1MlWKcIY1VulefglauaQbNIlRa+CYUxJBcMQjF5bjk3rVen47K0KBktEDZWriUsHSa8sZlMdh0Y9/Qr/1TsScRYaBVwcBbMHaus2D9XDj8pP+UYgcBhrUySWxTwuoplDmKTqKeuGitlfo6LJmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 4C64C100FA; Thu,  6 Feb 2025 20:44:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by c64.rulez.org (Postfix) with ESMTP id 4900B100F6;
	Thu,  6 Feb 2025 20:44:50 +0100 (CET)
Date: Thu, 6 Feb 2025 20:44:50 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 00/13] Deduplicate cfb/sys drawing fbops
Message-ID: <dfcaa8c6-a8bd-257b-832a-1a36ff87e4f@c64.rulez.org>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII


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

