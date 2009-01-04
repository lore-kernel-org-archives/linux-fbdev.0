From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/v2] Atari frame buffer fixes
Date: Sun,  4 Jan 2009 12:46:57 +0100
Message-ID: <1231069624-13362-1-git-send-email-geert@linux-m68k.org>
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
  [3] fbdev: c2p - Correct indentation
  [4] fbdev: c2p - Cleanups
  [5] fbdev: c2p - Extract common c2p core to c2p_core.h
  [6] fbdev: c2p/atafb - Add support for Atari interleaved bitplanes
  [7] fbdev: c2p - Rename c2p to c2p_planar

Changes since previous submission:
  - Convert macros to static inline functions
  - Make sure we get a build-time error (undefined reference to
    'c2p_unsupported') in case of future misuse
  - Replace `unsigned long' by `u32' in comp(), as that's what all callers use
  - Use {get,put}_unaligned_be32() in store_{iplan2,planar}{,_masked}()

If nobody objects, I'd like to push this to Linus via the m68k tree, as the
c2p code is used by m68k drivers (atafb and amifb) only.

 drivers/video/Makefile     |    4 +-
 drivers/video/amifb.c      |    6 +-
 drivers/video/atafb.c      |  101 ++++++++-----------
 drivers/video/c2p.c        |  232 --------------------------------------------
 drivers/video/c2p.h        |   11 ++-
 drivers/video/c2p_core.h   |  153 +++++++++++++++++++++++++++++
 drivers/video/c2p_iplan2.c |  153 +++++++++++++++++++++++++++++
 drivers/video/c2p_planar.c |  156 +++++++++++++++++++++++++++++
 8 files changed, 515 insertions(+), 301 deletions(-)


