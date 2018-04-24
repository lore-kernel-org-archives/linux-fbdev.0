From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 24 Apr 2018 10:07:23 +0000
Subject: Re: [PATCH RESEND] backlight: pwm_bl: don't use GPIOF_* with gpiod_get_direction
Message-Id: <20180424100723.hyt3vxa2wp7sruqz@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180410123241.25745-1-wsa+renesas@sang-engineering.com>
 <20180411073215.fzvh4ejj2kd7wam3@verge.net.au>
 <20180416091257.swbt7i6zjfbwysg2@dell>
 <20180424084124.6tpxf3ekadzefwd4@verge.net.au>
 <CAMuHMdWLya+=QeCwzszMxGPm7b3KbdsNFgc0vsk8NWC5tDO2QQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWLya+=QeCwzszMxGPm7b3KbdsNFgc0vsk8NWC5tDO2QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux PWM List <linux-pwm@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms@verge.net.au>, Thierry Reding <thierry.reding@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Tue, 24 Apr 2018, Geert Uytterhoeven wrote:

> On Tue, Apr 24, 2018 at 10:41 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Apr 16, 2018 at 10:12:57AM +0100, Lee Jones wrote:
> >> On Wed, 11 Apr 2018, Simon Horman wrote:
> >> > On Tue, Apr 10, 2018 at 02:32:40PM +0200, Wolfram Sang wrote:
> >> > > The documentation was wrong, gpiod_get_direction() returns 0/1 instead
> >> > > of the GPIOF_* flags. The docs were fixed with commit 94fc73094abe47
> >> > > ("gpio: correct docs about return value of gpiod_get_direction"). Now,
> >> > > fix this user (until a better, system-wide solution is in place).
> >> > >
> >> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> > > Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> >> >
> >> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> >>
> >> Thanks for the Reviewed-by Simon.  I have applied it to the original mail.
> >>
> >> Do you know why you mail wasn't sent attached to the original thread?
> >> For some reason I received this mail on it's own i.e. not in reply
> >> to the original.
> >
> > No, not off hand. Perhaps I responded to the email in some unusual way
> > but by now I don't recall. In any case I'll try to be more careful
> > in future.
> 
> I see Lee is using gmail for sending, so I assume also for receiving.

Well I'm using their servers, but my set-up is IMAP/Mutt.

> While I did receive Simon's reply in-thread, lately I had issues with gmail
> not always doing so, and sometimes failing to do deduplication when receiving
> email through multiple paths (mailing lists and/or directly).

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
