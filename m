From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 09 Apr 2015 11:06:34 +0000
Subject: Re: simple framebuffer slower by factor of 20, on socfpga (arm) platform
Message-Id: <20150409110634.GA27407@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150407121247.GA29497@amd>
 <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXWRx7bKWhQuWH05CbPTXPy5imCUcW1xUf2E8f7BtF9NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Dinh Nguyen <dinh.linux@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Rob Clark <robdclark@gmail.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, archit@ti.com, shc_work@mail.ru, linux@arm.linux.org.uk, hsweeten@visionengravers.com

On Tue 2015-04-07 14:19:33, Geert Uytterhoeven wrote:
> Hi Pavel,
> 
> On Tue, Apr 7, 2015 at 2:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > I have an socfpga board, which uses has simple framebuffer implemented
> > in the FPGA. On 3.15, framebuffer is fast:
> >
> > root@wagabuibui:~# time cat /dev/fb0 > /dev/null
> > real               0m 0.00s
> > user               0m 0.00s
> > sys                0m 0.00s
> >
> > on 3.18, this takes 220msec. Similar slowdown exists for
> > writes. Simple framebuffer did not change at all between 3.15 and
> > 3.18; resource flags of the framebuffer are still same (0x200).
> >
> > If I enable caching on 3.18, it speeds up a bit, to 70msec or
> > so... Which means problem is not only in caching.
> >
> > Any ideas?
> 
> My first guess was  commit 67dc0d4758e5 ("vt_buffer: drop console buffer
> copying optimisations"), but this was introduced only in v4.0-rc1.
> 
> Just in case you encounter another performance regression after upgrading
> to a more modern kernel ;-)

:-). I did a git bisect, and it pointed to this. And reverting it
indeed fixes the problem in 3.18. Problem is still there in 4.0.

Archit do you know what is going on there? Should the revert be filled
for 4.0?

								Pavel

commit 981409b25e2a99409b26daa67293ca1cfd5ea0a0
Author: Archit Taneja <archit@ti.com>
Date:   Fri Nov 16 14:46:04 2012 +0530

    fbdev: arm has __raw I/O accessors, use them in fb.h

    This removes the sparse warnings on arm platforms:

    warning: cast removes address space of expression

 Signed-off-by: Archit Taneja <archit@ti.com>
 Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
 Cc: H Hartley Sweeten <hsweeten at visionengravers.com>
 Cc: Alexander Shiyan <shc_work@mail.ru>
 Cc: Russell King <linux@arm.linux.org.uk>



> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
