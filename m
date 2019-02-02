From: Yifeng Li <tomli@tomli.me>
Date: Sat, 02 Feb 2019 06:16:40 +0000
Subject: [PATCH 0/8] fbdev: sm712fb: implement 2D acceleration w/ cleanups.
Message-Id: <20190202061648.30374-1-tomli@tomli.me>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Yifeng Li <tomli@tomli.me>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Previously, in staging/sm7xxfb (now fbdev/sm712fb), 2D acceleration
was implemented, but after its submission, a critical bug that causes
total system hang was discovered, as a stopgap measure, 2D ops was
completele removed in commit 3af805735a25 ("staging: sm7xx: remove the
buggy 2D acceleration support") and never implemented again.

It created a massive usability problem - on YeeLoong 8089, a notable
MIPS platform which uses SM712 - even scrolling a single line of text
on the console required an unaccelerated screen redraw, running "dmesg"
typically takes 8-11 seconds, and absurdly, printf(), became a significant
performance bottleneck that slows down GCC and "make", make the computer
largely unusable.

So I decided to take a look. Most of the my actual development was done
in 2014 in a personal out-of-tree driver, I did not mainline it because
2D acceleration was not working properly in 24-bit color. I discovered
the solution in early 2019 and now it's ready to be mainlined.

This commit reimplements the 2D acceleration for sm712fb. Unlike the
original implementation, which was messy and unnecessarily complicated
by calling a 2D acceleration wrapper file with many unneeded functions,
this is a minimum and (relatively) clean implementation. My tests have
shown that running "dmesg" only takes 0.9 seconds, a performance boost
of 950%. System hangs did not occur in my tests.

Currently, 2D acceleration is only supported on SM712 with little-endian
CPUs, it's disabled on Big Endian systems and SM720 chips as a safety
measure, since I code for myself without any monetary or hardware support
from any company or OEMs, I don't have the hardware and it's completely
untested. I should be also to purchase a Big Endian test platform and add
proper support soon.  If you have a Big-Endian platform with SM7xx
available for testing, please send an E-mail to me immediately! Thanks!

Also, thanks to Miodrag Vallat and other OpenBSD developers, this work
would be impossible without their code, that served as a reference
implementation for me.

Finally, during the development and testing of 2D acceleration, the
modesetting code of this driver received a minor cleanup, and many
issues about issues about the modesetting code and this driver in
general have been documented.

Yifeng Li (8):
  fbdev: sm712fb: update copyright headers.
  fbdev: sm712fb: use type "u8" for 8-bit I/O.
  fbdev: sm712fb: add 2D-related I/O headers and functions.
  fbdev: sm712fb: support 2D acceleration on SM712 w/ Little-Endian CPU.
  fbdev: sm712fb: add 32-bit color modes, drops some other modes.
  Documentation: fb: sm712fb: add information mainly about 2D.
  fbdev: sm712fb: Kconfig: add information about docs.
  MAINTAINERS: sm712fb: list myself as one maintainer.

 Documentation/fb/sm712fb.txt  | 123 +++++++-
 MAINTAINERS                   |   1 +
 drivers/video/fbdev/Kconfig   |   4 +
 drivers/video/fbdev/sm712.h   | 129 +++++++-
 drivers/video/fbdev/sm712fb.c | 574 ++++++++++++++++++++++++++--------
 5 files changed, 679 insertions(+), 152 deletions(-)

-- 
2.20.1
