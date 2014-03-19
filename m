From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Date: Wed, 19 Mar 2014 14:22:32 +0000
Subject: Re: [PATCH 14/16] backlight: atmel-pwm-bl: remove obsolete driver
Message-Id: <20140319142231.GF20872@samfundet.no>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-15-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1395234209-15546-15-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Around Wed 19 Mar 2014 14:03:27 +0100 or thereabout, Alexandre Belloni wrote:
> The atmel-pwm-bl driver is now obsolete. It is not used by any mainlined boards
> and is replaced by the generic pwm_bl with the pawm-atmel driver using the
> generic PWM framework.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  drivers/video/backlight/Kconfig        |  11 --
>  drivers/video/backlight/Makefile       |   1 -
>  drivers/video/backlight/atmel-pwm-bl.c | 223 ---------------------------------
>  include/linux/atmel-pwm-bl.h           |  43 -------
>  4 files changed, 278 deletions(-)
>  delete mode 100644 drivers/video/backlight/atmel-pwm-bl.c
>  delete mode 100644 include/linux/atmel-pwm-bl.h

<snipp diff>

> -MODULE_AUTHOR("Hans-Christian egtvedt <hans-christian.egtvedt@atmel.com>");
>

sob )':

Great cleanup though.

<snipp diff>

-- 
mvh
Hans-Christian Egtvedt
