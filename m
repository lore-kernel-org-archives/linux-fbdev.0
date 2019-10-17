From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 17 Oct 2019 13:28:47 +0000
Subject: Re: [PATCH 29/34] backlight/jornada720: Use CONFIG_PREEMPTION
Message-Id: <20191017132846.ojsh27celyl76dlx@linutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
 <20191015191821.11479-30-bigeasy@linutronix.de>
 <20191017113707.lsjwlhi6b4ittcpe@holly.lan>
 <20191017132324.GP4365@dell>
In-Reply-To: <20191017132324.GP4365@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linux-kernel@vger.kernel.org, tglx@linutronix.de, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On 2019-10-17 14:23:24 [+0100], Lee Jones wrote:
> So what are the OP's expectations in that regard?  I see this is a
> large set and I am only privy to this patch, thus lack wider
> visibility.  Does this patch depend on others, or is it independent?
> I'm happy to take it, but wish to avoid bisectability issues in the
> next release kernel.

It is independent, you can apply it to your -next branch. All
dependencies are merged.

Sebastian
