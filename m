From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 23 Jan 2014 17:14:36 +0000
Subject: Re: [PATCH 02/11] x86: sysfb: remove sysfb when probing real hw
Message-Id: <20140123171436.GA27345@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1390486503-1504-1-git-send-email-dh.herrmann@gmail.com>
 <1390486503-1504-3-git-send-email-dh.herrmann@gmail.com>
 <20140123165115.GB23869@gmail.com>
 <CANq1E4QQE2qeEz1AaN1NO3p2TE006jHfz8uaJ_LLHptKdHecxQ@mail.gmail.com>
In-Reply-To: <CANq1E4QQE2qeEz1AaN1NO3p2TE006jHfz8uaJ_LLHptKdHecxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Dave Airlie <airlied@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, Tom Gundersen <teg@jklm.no>


* David Herrmann <dh.herrmann@gmail.com> wrote:

> >> +#ifdef CONFIG_X86_SYSFB
> >> +#  include <asm/sysfb.h>
> >> +#endif
> >
> > I guess a single space is sufficient?
> >
> > Better yet, I'd include sysfb.h unconditionally:
> 
> Unconditionally won't work as only x86 has this header. [...]

Well, in non-x86 code an #ifdef x86 looks ugly as well - but I guess 
better than not building.

> [...] If there's a way to place a dummy into asm-generic which is 
> picked if arch/xy/include/asm/ doesn't have the header, let me know. 

Not that I know of.

> But if I include it unconditionally without any fallback, this will 
> fail on non-x86. And adding the header to all archs seems overkill.

So why not drop the x86-ism and rename it to CONFIG_PLATFORM_SYSFB? 
Some platforms configure it, some don't. Then the prototypes could 
move into include/linux/sysfb.h or so and would be platform agnostic.

Thanks,

	Ingo
