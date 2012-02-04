From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:37:44 +0000
Subject: [PATCH 00/13] sa1100fb cleanups
Message-Id: <20120204093744.GQ889@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Here's another bunch of SA11x0 stuff - its framebuffer driver.  This
set of patches fixes some section mismatch warnings, moves the board
configuration out to the board files, converts the Shannon stuff to
use gpiolib rather than poking at GPDR/GPSR/GPCR directly.

The function hooks for LCD and backlight power control are moved into
the platform data passed from the board, eliminating the global function
pointers.

This series will conflict with the previous series (in the case of
Assabet, the conflict is quite large) so I'd prefer to keep this in my
tree for the next merge window.

 arch/arm/mach-sa1100/assabet.c              |  130 ++++++--
 arch/arm/mach-sa1100/collie.c               |   17 +
 arch/arm/mach-sa1100/generic.c              |   14 +-
 arch/arm/mach-sa1100/generic.h              |    6 +-
 arch/arm/mach-sa1100/h3100.c                |   23 ++-
 arch/arm/mach-sa1100/h3600.c                |   32 ++-
 arch/arm/mach-sa1100/include/mach/shannon.h |    2 +-
 arch/arm/mach-sa1100/lart.c                 |   79 +++++
 arch/arm/mach-sa1100/shannon.c              |   17 +
 drivers/video/sa1100fb.c                    |  433 +++++++--------------------
 drivers/video/sa1100fb.h                    |   67 +----
 include/video/sa1100fb.h                    |   63 ++++

