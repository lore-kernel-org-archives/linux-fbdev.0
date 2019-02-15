From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Feb 2019 08:58:57 +0000
Subject: [PATCH 0/4] fbdev: atafb: Fix after kexec, misc. cleanups
Message-Id: <20190215085901.21479-1-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Schmitz <schmitzmic@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org

	Hi all,

This patch series fixes the frame buffer on Atari Falcon when using
kexec while blanked, and does some miscellaneous cleanups.

This has been tested on ARAnyM.

Thanks!

Geert Uytterhoeven (4):
  fbdev: atafb: Stop printing virtual screen_base
  fbdev: atafb: Remove obsolete module support
  fbdev: atafb: Fix broken frame buffer after kexec
  fbdev: atafb: Modernize printing of kernel messages

 drivers/video/fbdev/atafb.c          | 67 +++++++++++++++++-----------
 drivers/video/fbdev/atafb_iplan2p2.c | 23 ----------
 drivers/video/fbdev/atafb_iplan2p4.c | 23 ----------
 drivers/video/fbdev/atafb_iplan2p8.c | 23 ----------
 drivers/video/fbdev/atafb_mfb.c      | 23 ----------
 5 files changed, 40 insertions(+), 119 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
