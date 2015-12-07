From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 07 Dec 2015 16:16:43 +0000
Subject: Re: [PATCH] fbdev: auo_k190x: avoid unused function warnings
Message-Id: <1678174.Yl1Wo71dkn@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <3917686.rD8ezhD468@wuerfel> <5665AF5C.4060801@ti.com>
In-Reply-To: <5665AF5C.4060801@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 07 December 2015 18:10:04 Tomi Valkeinen wrote:
> On 20/11/15 23:47, Arnd Bergmann wrote:
> > The auo_k190x framebuffer driver encloses the power-management
> > functions in #ifdef CONFIG_PM, but the auok190x_suspend/resume
> > functions are only really used when CONFIG_PM_SLEEP is also
> > set, as a frequent gcc warning shows:
> > 
> > drivers/video/fbdev/auo_k190x.c:859:12: warning: 'auok190x_suspend' defined but not used
> > drivers/video/fbdev/auo_k190x.c:899:12: warning: 'auok190x_resume' defined but not used
> > 
> > This changes the driver to remove the #ifdef and instead mark
> > the functions as __maybe_unused, which is a nicer anyway, as it
> > provides build testing for all the code in all configurations
> > and is harder to get wrong.
> 
> Applied for 4.5.
> 
> Btw, do you know if the linker will optimize the __maybe_unused funcs
> away if they are not used? I presume so.
> 

The compiler does it correctly when built with -O1 or higher (we don't
support -O0), and the linker is not involved here.

	Arnd
