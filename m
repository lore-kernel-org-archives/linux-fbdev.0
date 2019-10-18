From: Lee Jones <lee.jones@linaro.org>
Date: Fri, 18 Oct 2019 07:38:35 +0000
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-Id: <20191018073835.GU4365@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
 <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
 <20191017132324.GP4365@dell>
 <20191017132846.ojsh27celyl76dlx@linutronix.de>
In-Reply-To: <20191017132846.ojsh27celyl76dlx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, tglx@linutronix.de

On Thu, 17 Oct 2019, Sebastian Andrzej Siewior wrote:

> On 2019-10-17 14:23:24 [+0100], Lee Jones wrote:
> > So what are the OP's expectations in that regard?  I see this is a
> > large set and I am only privy to this patch, thus lack wider
> > visibility.  Does this patch depend on others, or is it independent?
> > I'm happy to take it, but wish to avoid bisectability issues in the
> > next release kernel.
> 
> It is independent, you can apply it to your -next branch. All
> dependencies are merged.
> 
> Sebastian

Wonderful.  Thanks for the info.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
