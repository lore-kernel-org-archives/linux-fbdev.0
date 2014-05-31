From: Manuel Schoelling <manuel.schoelling@gmx.de>
Date: Sat, 31 May 2014 09:49:24 +0000
Subject: Re: [PATCH] console: Add persistent scrollback buffers for all VGA consoles
Message-Id: <1401529764.4646.12.camel@schoellingm.dzne.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401456425-15931-1-git-send-email-manuel.schoelling@gmx.de>
	 <20140530222622.GA1385@jwilk.net>
In-Reply-To: <20140530222622.GA1385@jwilk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jakub Wilk <jwilk@debian.org>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, geert@linux-m68k.org, broonie@linaro.org, rdunlap@infradead.org, dh.herrmann@gmail.com, airlied@redhat.com, mtosatti@redhat.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Sa, 2014-05-31 at 00:26 +0200, Jakub Wilk wrote:
> * Manuel Sch=C3=B6lling <manuel.schoelling@gmx.de>, 2014-05-30, 15:27:
> >Add a scrollback buffers for each VGA console. The benefit is that the=20
> >scrollback history is not flushed when switching between consoles but=20
> >is persistent.
>=20
> Some people rely on this scrollback flushing as a security feature. Is=20
> there even another way to clear the scrollback, than to switch to=20
> another vt and then back again?
Thanks for raising this security issue! Maybe we should add something
like VT_FLUSH_SCROLLBACK to vt_ioctl()? [1]
I'm open for better ways to flush the scrollback history.

[1] http://lxr.free-electrons.com/source/drivers/tty/vt/vt_ioctl.c#L334

> Debian ships this:
> http://manpages.debian.org/cgi-bin/man.cgi?query=3Dclear_console
> https://sources.debian.net/src/bash/4.2%2Bdfsg-0.1/debian/clear_console.c
>=20


