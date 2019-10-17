From: Lee Jones <lee.jones@linaro.org>
Date: Thu, 17 Oct 2019 13:23:24 +0000
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-Id: <20191017132324.GP4365@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
 <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
In-Reply-To: <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, tglx@linutronix.de

On Thu, 17 Oct 2019, Daniel Thompson wrote:

> On Tue, Oct 15, 2019 at 09:18:16PM +0200, Sebastian Andrzej Siewior wrote:
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> > Both PREEMPT and PREEMPT_RT require the same functionality which today
> > depends on CONFIG_PREEMPT.
> > 
> > Switch the Kconfig dependency to CONFIG_PREEMPTION.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > [bigeasy: +LCD_HP700]
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> (I know... the review for this particular patch is trivial but an
> Acked-by from a maintainer means something specific and it is Lee
> Jones who coordinates landing cross sub-system patch sets for
> backlight).

Right.  Thanks Dan.

So what are the OP's expectations in that regard?  I see this is a
large set and I am only privy to this patch, thus lack wider
visibility.  Does this patch depend on others, or is it independent?
I'm happy to take it, but wish to avoid bisectability issues in the
next release kernel.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
