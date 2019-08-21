From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 21 Aug 2019 03:55:12 +0000
Subject: [PATCH 0/4] video/logo: various fix and cleanups of drivers/video/logo/Makefile
Message-Id: <20190821035517.21671-1-yamada.masahiro@socionext.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org




Masahiro Yamada (4):
  video/logo: remove unneeded *.o pattern from clean-files
  video/logo: fix unneeded generation of font C files
  video/logo: simplify cmd_logo
  video/logo: move pnmtologo tool to drivers/video/logo/ from scripts/

 drivers/video/logo/.gitignore               |  1 +
 drivers/video/logo/Makefile                 | 36 ++++-----------------
 {scripts => drivers/video/logo}/pnmtologo.c |  0
 scripts/.gitignore                          |  1 -
 scripts/Makefile                            |  2 --
 5 files changed, 8 insertions(+), 32 deletions(-)
 rename {scripts => drivers/video/logo}/pnmtologo.c (100%)

-- 
2.17.1
