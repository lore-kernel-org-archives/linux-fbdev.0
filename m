From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Date: Mon, 20 Aug 2012 18:04:39 +0000
Subject: [PATCH 0/7] framebuffer fixes
Message-Id: <alpine.DEB.2.00.1208202000250.4009@artax.karlin.mff.cuni.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi

Here I'm sending 7 patches for Linux framebuffer.

The first patch fixes a bug in cfb_copyarea if the position is not aligned 
on 4-byte or 8-byte boundary.

The next three patches fix bugs on mach64 and remove videomode 
restriction.

The next three patches fix bugs on tga and remove videomode restriction.

Mikulas
