From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Mar 2013 22:13:30 +0000
Subject: Re: [GIT PULL] at91: framebuffer enhancements for 3.10
Message-Id: <201303152213.31100.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5142F3DE.1060209@atmel.com>
In-Reply-To: <5142F3DE.1060209@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 15 March 2013, Nicolas Ferre wrote:
> Arnd, Olof,
> 
> Following our conversation about these framebuffer patches for
> Atmel LCD driver, here are the remaining three patches that can be
> pushed for 3.10. As suggested by Arnd, I have kept them on top of last
> commit concerning this topic that have already been merged in arm-soc 3.9
> fixes branch.
> Thanks a lot for taking care of these modifications.

I think it's reasonable to take the patches through the arm-soc tree here,
because you did not manage to get any feedback on them from Florian
and he also didn't pull them into his framebuffer tree.

However, if you are bypassing a maintainer, you should not do that silently,
and you should note that I don't have any intention of taking all framebuffer
patches in the future.

I've taken Florian and the linux-fbdev list on Cc. If there are any objections
to me taking these through the arm-soc tree, please let us know and we can
revert them to find a better way.

I have applied them to the next/drivers branch in the arm-soc tree now.

	Arnd


> The following changes since commit 67cf9c0a00bd88443adb7d6c3efa8b18d03f97c5:
> 
>   ARM: at91: fix LCD-wiring mode (2013-03-13 11:05:04 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/at91linux/linux-at91.git tags/at91-driversLCD
> 
> for you to fetch changes up to bbd44f6bd9d1aa735b180b29b5719d63a8e87b55:
> 
>   ARM: at91/avr32/atmel_lcdfb: add platform device-id table (2013-03-13 11:05:12 +0100)
> 
> ----------------------------------------------------------------
> Some Atmel framebuffer driver enhancements with modification
> of configuration data in ARM/AT91 and AVR32/AP7 trees.
> A merge of these modifications seems easier through arm-soc
> git tree nowadays.
> 
> ----------------------------------------------------------------
> Johan Hovold (3):
>       ARM: at91/avr32/atmel_lcdfb: add bus-clock entry
>       atmel_lcdfb: move lcdcon2 register access to compute_hozval
>       ARM: at91/avr32/atmel_lcdfb: add platform device-id table
> 
>  arch/arm/mach-at91/at91sam9261.c         |   2 +
>  arch/arm/mach-at91/at91sam9261_devices.c |   6 +-
>  arch/arm/mach-at91/at91sam9263.c         |   1 +
>  arch/arm/mach-at91/at91sam9263_devices.c |   2 +-
>  arch/arm/mach-at91/at91sam9g45.c         |   2 +
>  arch/arm/mach-at91/at91sam9g45_devices.c |   6 +-
>  arch/arm/mach-at91/at91sam9rl.c          |   1 +
>  arch/arm/mach-at91/at91sam9rl_devices.c  |   2 +-
>  arch/avr32/mach-at32ap/at32ap700x.c      |   6 +-
>  drivers/video/atmel_lcdfb.c              | 120 +++++++++++++++++++++++++++--------
>  include/video/atmel_lcdc.h               |   4 +-
>  11 files changed, 117 insertions(+), 35 deletions(-)
> 

