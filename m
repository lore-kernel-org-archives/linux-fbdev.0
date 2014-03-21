From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 21 Mar 2014 00:51:16 +0000
Subject: Re: [PATCH 14/16] backlight: atmel-pwm-bl: remove obsolete driver
Message-Id: <000101cf449f$aa609960$ff21cc20$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1395234209-15546-15-git-send-email-alexandre.belloni@free-electrons.com>
 <20140319142231.GF20872@samfundet.no>
In-Reply-To: <20140319142231.GF20872@samfundet.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday, March 19, 2014 11:23 PM, Hans-Christian Egtvedt wrote:
> Around Wed 19 Mar 2014 14:03:27 +0100 or thereabout, Alexandre Belloni wrote:
> > The atmel-pwm-bl driver is now obsolete. It is not used by any mainlined boards
> > and is replaced by the generic pwm_bl with the pawm-atmel driver using the
> > generic PWM framework.
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Acked-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> 
> > ---
> >  drivers/video/backlight/Kconfig        |  11 --
> >  drivers/video/backlight/Makefile       |   1 -
> >  drivers/video/backlight/atmel-pwm-bl.c | 223 ---------------------------------
> >  include/linux/atmel-pwm-bl.h           |  43 -------
> >  4 files changed, 278 deletions(-)
> >  delete mode 100644 drivers/video/backlight/atmel-pwm-bl.c
> >  delete mode 100644 include/linux/atmel-pwm-bl.h

