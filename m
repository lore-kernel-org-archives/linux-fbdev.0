From: Ondrej Zary <linux@rainbow-software.org>
Date: Fri, 06 Aug 2010 15:35:08 +0000
Subject: matroxfb - wrong PLL calculation for Mystique and Mystique 220
Message-Id: <201008061735.09854.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello,
there is a long-standing problem in matroxfb (and also with xf86-video-mga) 
with PLL values calculation. It results in "wavy" vertical lines at least on 
Mystique and Mystique 220, especially where dotted horizontal lines are 
displayed.

On non-220 Mystique in 1024x768@85Hz, matroxfb calculates:
m=0x0f, n=0x69, p=0x00 (producing wavy vertical lines)

Windows driver calculates:
m=0x03, n=0x34, p=0x01 (producing straight vertical lines)

The resulting f_vco from windows values is 189713.5, which is above max_freq 
for this card. So it looks like the assumption that f_vco must be less
or equal to max_freq is wrong. Could someone with access to MGA1064/1164 
documentation look into this?

xf86-video-mga bug (with photos of the screen):
http://bugs.xfree86.org/show_bug.cgi?id14

-- 
Ondrej Zary
