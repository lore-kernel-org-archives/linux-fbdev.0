From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 23 Jul 2010 15:39:15 +0000
Subject: minor viafb updates
Message-Id: <1279899566-4359-1-git-send-email-FlorianSchandinat@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

All patches can also be found at
	git://github.com/schandinat/linux-2.6.git viafb-s1v1

Some tests were performed on CLE266, VX800 and VX855.

Further testing and/or comments appreciated.


Thanks,

Florian Tobias Schandinat


Florian Tobias Schandinat (11):
      MAINTAINERS: update viafb entry
      viafb: remove duplicated scaling code
      viafb: improve lcd code readability
      viafb: add lcd scaling support for some IGPs
      viafb: fix PCI table
      viafb: simplify lcd size "detection"
      viafb: PLL value cleanup
      viafb: update fix before calculating depth
      viafb: remove ioctls which break the framebuffer interface
      viafb: probe cleanups
      viafb: fix accel_flags check_var bug

