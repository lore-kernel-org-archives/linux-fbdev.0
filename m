Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B803D12DD95
	for <linux-fbdev@vger.kernel.org>; Sun, 15 Dec 2024 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734259524; cv=none; b=WaUanU3yK08mz0Rb384YmKzeSqgWqzaDHMAtVH9IF2g5b8BXG63Gy69aZZEM4oTnG9OA6rGs70+nCUKK+kaOye5dNqz8Plp/X6Jv73Ec68+macfSGg3aF70qA4e8T/qG1Y/Aq9sa1VbiB2tZz5EsmdSScQBWpVTzAO1/znPu9/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734259524; c=relaxed/simple;
	bh=zDjYqcbP/94MtfPAXUruyqhoYuQP0HKJIph+YJSYx0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D+XOSsbM5n6f4M3SyDn0MSEj0hNLp9nAlpX0vJobi4HPTU6U+w0MaoQUJ0qpaXfzqrs22WBeHLBaPjtlBlSocydJTKMZeu7uxXNfMKTCUcbOd2t/MWlsxGWnS6cdusXip+IOjJSP52KA2FisPLQEeEChdRJG6+tBmlciG0DTuvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8e92:9273:64e7:a1e1])
	by laurent.telenet-ops.be with cmsmtp
	id oylD2D00Q4qjdAp01ylDAa; Sun, 15 Dec 2024 11:45:13 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7a-001Kj2-0C;
	Sun, 15 Dec 2024 11:45:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1tMm7d-000nlE-DQ;
	Sun, 15 Dec 2024 11:45:13 +0100
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH fbtest 00/17] Export feature and large ellipses support
Date: Sun, 15 Dec 2024 11:44:51 +0100
Message-Id: <20241215104508.191237-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

Recently, I ran into a segmentation fault when running test002 ("Draw a
grid and some ellipses") on a system with a display resolution of
2560x1440.  This turned out to be due to a 32-bit overflow in the
ellipse drawing routines.

This patch series:
  - Adds support for operating on a virtual buffer in RAM instead of on
    a real frame buffer device, and exporting the result as a PPM image,
    which is useful for e.g. testing drawing algorithms on screen sizes
    not supported by your hardware,
  - Fixes the drawing of ellipses on large displays,
  - Contains some small fixe and improvements.

I intend to apply these to
https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git/.

Thanks for your comments!

Geert Uytterhoeven (17):
  Add support for exporting virtual test images
  tests: Print test description in debug mode
  Test002: Fix test description
  drawops: Extract do_circle()
  drawops: Use "y == 0" in draw_ellipse_points()
  drawops: Remove always-false check in generic_fill_ellipse()
  drawops: Refactor generic_draw_ellipse()
  drawops: Return early in generic_{draw,fill}_ellipse()
  drawops: Extract do_ellipse()
  drawops: Make de in do_circle() unsigned
  drawops: Make dT1 and dS1 in do_ellipse() unsigned
  drawops: Fix crash when drawing large ellipses
  tests: Clear frame buffer before each test
  Make variables that are never negative unsigned
  test013: Fix off-by-one error in maximum circle calculation
  visops: Mark fall-through switch case
  util: Use __attribute__

 console.c            |   2 +-
 drawops/generic.c    | 427 ++++++++++++++++++++++---------------------
 export.c             | 176 ++++++++++++++++++
 fb.c                 |  11 +-
 include/export.h     |  14 ++
 include/fb.h         |   1 +
 include/types.h      |   3 +
 include/util.h       |   3 +-
 main.c               |  33 +++-
 pixmap.c             |   6 +-
 tests.c              |   7 +-
 tests/test002.c      |   2 +-
 tests/test004.c      |   2 +-
 tests/test006.c      |   2 +-
 tests/test007.c      |   2 +-
 tests/test009.c      |   2 +-
 tests/test010.c      |   2 +-
 tests/test013.c      |   4 +-
 util.c               |   6 +
 visops/pseudocolor.c |   1 +
 visual.c             |   2 +-
 21 files changed, 476 insertions(+), 232 deletions(-)
 create mode 100644 export.c
 create mode 100644 include/export.h

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
