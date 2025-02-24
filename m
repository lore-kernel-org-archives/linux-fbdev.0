Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8D41C6FF5
	for <linux-fbdev@vger.kernel.org>; Mon, 24 Feb 2025 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431576; cv=none; b=HNLRzNOax3tEmnZ1u9PvFux8xdMO8i6q4kaAwiepBRZWxPYoY7oEi94zrTLavW/sqcBBGeXmKHUIVCXQVV+aDX8mk2GJstHnuW6YSvaoohoBGhTXRowCmV4tLAaGfP0zpiXYvYdgqdbCyt5zjHZJGE03638G0C73UXVabohg6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431576; c=relaxed/simple;
	bh=Vd9lLxJrLFFr/I6BSqyiQZVH7AGo36KAAqFO7gCGCDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZSm/23/c6/NPhlXRijsQHH6mqgauAGrkZ3lIb38jPPs0ODFLgah4dwzGOuQWNmtwL0U29+JJwVD/ktGSNGR9R7Z9+tVD8yaV9Vfr4jzrYEVIxT5SM1krV/Qsol68JuJgGwgiE63hF7tW8rBuJqwFLjh4EhDAg8XJzqx6WKZfeSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id C8C62100CF; Mon, 24 Feb 2025 22:02:58 +0100 (CET)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH 0/1] Refactoring of framebuffer drawing routines
Date: Mon, 24 Feb 2025 21:59:07 +0100
Message-Id: <20250224205908.26336-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proper refactoring of the framebuffer drawing routines. This time it's
not only the merging of duplicated code. It isn't half finished either
so the various combinations of foreign endianness, pixel reversing, bits
per pixel, cpu word sizes and byte order should work.

Added myself to look after this code. Based on the time spent on proving
it I don't expect a busy inbox. Famous last words.

Zsolt Kajtar (1):
  Refactoring of framebuffer drawing routines

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

