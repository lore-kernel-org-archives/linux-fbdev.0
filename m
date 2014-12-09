From: Ondrej Zary <linux@rainbow-software.org>
Date: Tue, 09 Dec 2014 21:33:16 +0000
Subject: Compiled tridentfb hangs but distribution kernel works fine
Message-Id: <201412092233.17030.linux@rainbow-software.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Kernel development list <linux-kernel@vger.kernel.org>

Hello,
I'm doing some work on tridentfb driver but encountered a weird problem.

When I compile custom kernel with tridentfb, it hangs with Blade3D card (ID 
0x9880) in blade_image_blit(). The screen is blank with some artifacts and 
machine does not respond to ping or keyboard. However, it can be rebooted by 
Alt+SysRq+B. It works fine with other cards (3DImage 9750 and CyberBlade XP) 
with no blit implementation. Commenting out contents of blade_image_blit() 
function makes the hang go away (nothing useful on the screen, of course).

The weird thing is that the Blade3D card works fine when I load Debian 
kernels! Debian 3.16-0.bpo.3-686-pae works fine but when I compile 3.16 
kernel, it hangs.

Any ideas?


-- 
Ondrej Zary
