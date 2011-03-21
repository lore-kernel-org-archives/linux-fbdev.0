From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 21 Mar 2011 18:17:53 +0000
Subject: Re: [GIT PULL] omap display subsystem changes for 2.6.39
Message-Id: <1300731473.2891.133.camel@deskari>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1300701083.2891.77.camel@deskari>
	 <AANLkTi=_zTJ0XeVC=MxqN6CzFqaXW0H6TbHEao3OihRb@mail.gmail.com>
In-Reply-To: <AANLkTi=_zTJ0XeVC=MxqN6CzFqaXW0H6TbHEao3OihRb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John S <john.schi15@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-03-21 at 12:43 -0500, John S wrote:
> On Mon, Mar 21, 2011 at 3:21 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> > Hi Paul,
> >
> > Here are OMAP display subsystem patches for 2.6.39 merge window. Quite a
> > bit of them, and many changes also in arch/arm/mach-omap2, which
> > unfortunately couldn't go through Tony's linux-omap tree due to
> > dependencies on DSS driver code.

<snip>

> some of these patches had problems related to HDMI:
> http://www.spinics.net/lists/linux-omap/msg48740.html
> Was this issue resolved?

No. We haven't been able to reproduce, and I haven't heard of anyone
else reporting problems. So I believe the patches are good enough for
rc1.

 Tomi


