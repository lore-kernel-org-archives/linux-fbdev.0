Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6524120E019
	for <linux-fbdev@vger.kernel.org>; Sun,  9 Mar 2025 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741546873; cv=none; b=ZrUK1Vr+MmCpn7IX9Iv8RzbToDkooc0709qAADQAzA1lHwkx0VIiy4sL+UCU9K1UnpzjNG27l9lp4EbQBR60Ltok2dAspXzmjQWPkJwB7XcRhwY9mjQ1frLJE7CGa2kl9GORhV0wrTIZDOx6thueExPzo8NZvCEmcy/EQw2+2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741546873; c=relaxed/simple;
	bh=E1ZbmvhhzzEYkwvOtw69JJabEp9EsGIZeq2Ti74uy8o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U7+S0998KtL/z3AnWa5TpLly/m3lQfDfA/h84sxVz2ht9sO/qYPshQ7JDKJ5yt26wyKpFIiUjm6td6Q29xW+fxijyTtrinrLndxPeDIkDLeaz1U4E4pAKm73OXfa8O+EhLdtOc9JEm4CaPRBOqonBXxFA7PPN/FjzZZmGGh6Fkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 4D988100CF; Sun,  9 Mar 2025 19:54:09 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH RESEND 0/2] Refactoring the fbcon packed pixel drawing routines
Date: Sun,  9 Mar 2025 19:47:14 +0100
Message-Id: <20250309184716.13732-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the same patch as before just updated to latest fbdev
master and with better description. And hopefully sent intact this
time.

Zsolt Kajtar (2):
  Refactoring the fbcon packed pixel drawing routines
  Adding contact info for packed pixel drawing

 MAINTAINERS                             |  16 +
 drivers/video/fbdev/core/Kconfig        |  10 +-
 drivers/video/fbdev/core/cfbcopyarea.c  | 428 +-------------------
 drivers/video/fbdev/core/cfbfillrect.c  | 362 +----------------
 drivers/video/fbdev/core/cfbimgblt.c    | 357 +----------------
 drivers/video/fbdev/core/cfbmem.h       |  43 ++
 drivers/video/fbdev/core/fb_copyarea.h  | 405 +++++++++++++++++++
 drivers/video/fbdev/core/fb_draw.h      | 274 ++++++-------
 drivers/video/fbdev/core/fb_fillrect.h  | 280 ++++++++++++++
 drivers/video/fbdev/core/fb_imageblit.h | 495 ++++++++++++++++++++++++
 drivers/video/fbdev/core/syscopyarea.c  | 369 +-----------------
 drivers/video/fbdev/core/sysfillrect.c  | 324 +---------------
 drivers/video/fbdev/core/sysimgblt.c    | 333 +---------------
 drivers/video/fbdev/core/sysmem.h       |  39 ++
 14 files changed, 1480 insertions(+), 2255 deletions(-)
 create mode 100644 drivers/video/fbdev/core/cfbmem.h
 create mode 100644 drivers/video/fbdev/core/fb_copyarea.h
 create mode 100644 drivers/video/fbdev/core/fb_fillrect.h
 create mode 100644 drivers/video/fbdev/core/fb_imageblit.h
 create mode 100644 drivers/video/fbdev/core/sysmem.h

-- 
2.30.2

