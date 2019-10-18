From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 18 Oct 2019 07:40:07 +0000
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-Id: <20191018074007.GV4365@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-30-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, tglx@linutronix.de

On Tue, 15 Oct 2019, Sebastian Andrzej Siewior wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the Kconfig dependency to CONFIG_PREEMPTION.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: +LCD_HP700]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/video/backlight/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
