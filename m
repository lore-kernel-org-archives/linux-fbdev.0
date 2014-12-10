From: Mike Galbraith <umgwanakikbuti@gmail.com>
Date: Wed, 10 Dec 2014 07:15:04 +0000
Subject: Re: Compiled tridentfb hangs but distribution kernel works fine
Message-Id: <1418195704.5312.31.camel@marge.simpson.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201412092233.17030.linux@rainbow-software.org>
In-Reply-To: <201412092233.17030.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On Tue, 2014-12-09 at 22:33 +0100, Ondrej Zary wrote: 
> Hello,
> I'm doing some work on tridentfb driver but encountered a weird problem.
> 
> When I compile custom kernel with tridentfb, it hangs with Blade3D card (ID 
> 0x9880) in blade_image_blit(). The screen is blank with some artifacts and 
> machine does not respond to ping or keyboard. However, it can be rebooted by 
> Alt+SysRq+B. It works fine with other cards (3DImage 9750 and CyberBlade XP) 
> with no blit implementation. Commenting out contents of blade_image_blit() 
> function makes the hang go away (nothing useful on the screen, of course).
> 
> The weird thing is that the Blade3D card works fine when I load Debian 
> kernels! Debian 3.16-0.bpo.3-686-pae works fine but when I compile 3.16 
> kernel, it hangs.
> 
> Any ideas?

I'd start by looking for what Debian changed in source and/or config.

-Mike

