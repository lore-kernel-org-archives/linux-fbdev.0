From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Date: Fri, 12 Apr 2013 09:52:26 +0000
Subject: Re: [PATCH 1/8] video: atmel_lcdfb: fix platform data struct
Message-Id: <20130412095226.GA10028@samfundet.no>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Around Thu 11 Apr 2013 17:00:15 +0200 or thereabout, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Today we mix pdata and drivers data in the struct atmel_lcdfb_info
> Fix it and introduce a new struct atmel_lcdfb_pdata for platform data only
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>

For the AVR32 bits

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  arch/arm/mach-at91/at91sam9261_devices.c    |    6 +-
>  arch/arm/mach-at91/at91sam9263_devices.c    |    6 +-
>  arch/arm/mach-at91/at91sam9g45_devices.c    |    6 +-
>  arch/arm/mach-at91/at91sam9rl_devices.c     |    6 +-
>  arch/arm/mach-at91/board-sam9261ek.c        |    6 +-
>  arch/arm/mach-at91/board-sam9263ek.c        |    4 +-
>  arch/arm/mach-at91/board-sam9m10g45ek.c     |    4 +-
>  arch/arm/mach-at91/board-sam9rlek.c         |    4 +-
>  arch/arm/mach-at91/board.h                  |    4 +-
>  arch/avr32/boards/atngw100/evklcd10x.c      |    6 +-
>  arch/avr32/boards/atngw100/mrmt.c           |    4 +-
>  arch/avr32/boards/atstk1000/atstk1000.h     |    2 +-
>  arch/avr32/boards/atstk1000/setup.c         |    2 +-
>  arch/avr32/boards/favr-32/setup.c           |    2 +-
>  arch/avr32/boards/hammerhead/setup.c        |    2 +-
>  arch/avr32/boards/merisc/display.c          |    2 +-
>  arch/avr32/boards/mimc200/setup.c           |    4 +-
>  arch/avr32/mach-at32ap/at32ap700x.c         |    8 +--
>  arch/avr32/mach-at32ap/include/mach/board.h |    4 +-
>  drivers/video/atmel_lcdfb.c                 |  104 +++++++++++++++++----------
>  include/video/atmel_lcdc.h                  |   24 +------
>  21 files changed, 109 insertions(+), 101 deletions(-)

<snipp diff>

-- 
HcE
