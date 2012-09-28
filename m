From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 28 Sep 2012 19:18:41 +0000
Subject: Re: [PATCH 1/4] ARM: clps711x: Remove board support for CEIVA
Message-Id: <201209281918.41825.arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1345568375-28516-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 21 August 2012, Alexander Shiyan wrote:
> The current kernel does not fit in the CEIVA ROM. Also, some functional
> has already been removed due migrate from 2.6 to 3.0, and it seems that
> no one uses this platform. So, remove support for this board and modules
> specific only to this board.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Sorry, this fell through the cracks at first.

>  arch/arm/mach-clps711x/Kconfig                 |    6 -
>  arch/arm/mach-clps711x/Makefile                |    1 -
>  arch/arm/mach-clps711x/ceiva.c                 |   64 --
>  arch/arm/mach-clps711x/include/mach/hardware.h |   48 --
>  arch/arm/tools/mach-types                      |    1 -
>  drivers/video/Kconfig                          |   12 -
>  drivers/video/Makefile                         |    1 -
>  drivers/video/epson1355fb.c                    |  749 ------------------------
>  include/video/epson1355.h                      |   64 --
>  9 files changed, 0 insertions(+), 946 deletions(-)
>  delete mode 100644 arch/arm/mach-clps711x/ceiva.c
>  delete mode 100644 drivers/video/epson1355fb.c
>  delete mode 100644 include/video/epson1355.h

I've added Florian to Cc as the drivers/video maintainer, since you are
removing the epson1355fb driver along with its last user, and he
might have objections. Florian, I hope it's ok to merge this through
arm-soc, if not please let me know and I'll revert this.

I've applied the series to the next/cleanup2 branch in arm-soc now
for the next 3.7 merge window.

	Arnd
