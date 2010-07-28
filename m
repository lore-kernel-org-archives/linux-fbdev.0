From: Ondrej Zary <linux@rainbow-software.org>
Date: Wed, 28 Jul 2010 19:59:16 +0000
Subject: cyber2000fb - 24bpp and 32bpp modes not working
Message-Id: <201007282159.19583.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Hello,
some more CyberPro 2000 testing shows that 24bpp and 32bpp modes don't work. 
8bpp and 16bpp modes work fine.

The mode appears to be set correctly (monitor OSD shows correct resolution and 
frequency) but console remains blank (even no cursor).

Xorg with fbdev in 24bpp mode displays mouse cursor, then gdm background and 
gdm login window and immediately segfaults. Xorg with fbdev in 32bpp mode 
works.

So the framebuffer works (24bpp crash might be Xorg bug) but maybe the console 
output is not written to the correct place?

-- 
Ondrej Zary
