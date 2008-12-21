From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [patch 0/6] [patch 0/6] Atari frame buffer fixes
Date: Sun, 21 Dec 2008 16:00:59 +0100
Message-ID: <20081221150059.844577615@mail.of.borg>
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org

This patchsets contains several fixes for the Atari frame buffer device, and
includes a refactoring of the c2p (Chunky-to-Planar) code:
  [1] fbdev: atafb - Fix line length handling
  [2] fbdev: atafb - Fix 16 bpp console
  [3] fbdev: c2p - Cleanups
  [4] fbdev: c2p - Extract common c2p core to c2p_core.h
  [5] fbdev: c2p/atafb - Add support for Atari interleaved bitplanes
  [6] fbdev: c2p - Rename c2p to c2p_planar and correct indentation

If nobody objects, I'd like to push this to Linus via the m68k tree, as the
c2p code is used by m68k drivers (atafb and amifb) only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

