From: Finn Thain <fthain@telegraphics.com.au>
Date: Fri, 07 Feb 2020 00:10:21 +0000
Subject: Re: [PATCH 1/3] fbdev/g364fb: Fix build failure
Message-Id: <alpine.LNX.2.22.394.2002071054180.13@nippy.intranet>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="-1463811774-1984420675-1581033946=:13"
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1580610812.git.fthain@telegraphics.com.au>
 <d8f19ebc00a7688da739d41d584d081d1559f0d2.1580610812.git.fthain@telegraphics.com.au>
 <CAAdtpL7SpzfqSmEcuVszNyXfrRegC20txoS5j7Ss3WkCmyRH+g@mail.gmail.com>
 <alpine.LNX.2.22.394.2002060829410.8@nippy.intranet>
 <CAAdtpL5Cz5YGKZVfbA=X8qMtP7jDc0G7igSj3EB=PfazM5JoDg@mail.gmail.com>
In-Reply-To: <CAAdtpL5Cz5YGKZVfbA=X8qMtP7jDc0G7igSj3EB=PfazM5JoDg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: linux-fbdev@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, James Hogan <jhogan@kernel.org>, open list <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Thomas Bogendoerfer <tbogendoerfer@suse.de>, dri-devel@lists.freedesktop.org, Laurent Vivier <laurent@vivier.eu>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811774-1984420675-1581033946=:13
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.LNX.2.22.394.2002071105541.13@nippy.intranet>

On Fri, 7 Feb 2020, Philippe Mathieu-Daud=C3=A9 wrote:

> On Wed, Feb 5, 2020 at 11:18 PM Finn Thain <fthain@telegraphics.com.au>  =
wrote:
> > On Wed, 5 Feb 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> > > On Sun, Feb 2, 2020 at 3:41 AM Finn Thain  <fthain@telegraphics.com.a=
u> wrote:
> > > >
> > > > This patch resolves these compiler errors and warnings --
> > > >
> > > >   CC      drivers/video/fbdev/g364fb.o
> > > > drivers/video/fbdev/g364fb.c: In function 'g364fb_cursor':
> > > > drivers/video/fbdev/g364fb.c:137:9: error: 'x' undeclared (first us=
e in this function)
> > > > drivers/video/fbdev/g364fb.c:137:9: note: each undeclared identifie=
r is reported only once for each function it appears in
> > > > drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of =
function 'fontwidth' [-Werror=3Dimplicit-function-declaration]
> > > > drivers/video/fbdev/g364fb.c:137:23: error: 'p' undeclared (first u=
se in this function)
> > > > drivers/video/fbdev/g364fb.c:137:38: error: 'y' undeclared (first u=
se in this function)
> > > > drivers/video/fbdev/g364fb.c:137:7: error: implicit declaration of =
function 'fontheight' [-Werror=3Dimplicit-function-declaration]
> > > > drivers/video/fbdev/g364fb.c: In function 'g364fb_init':
> > > > drivers/video/fbdev/g364fb.c:233:24: error: 'fbvar' undeclared (fir=
st use in this function)
> > > > drivers/video/fbdev/g364fb.c:234:24: error: 'xres' undeclared (firs=
t use in this function)
> > >
> > > 18 years unnoticed...
> > >
> >
> > More likely, it was noticed by those without the skills or time to get=
=20
> > it fixed upstream.
> >
> > Those with the hardware skills and platform knowledge to be affected=20
> > by an obscure bug aren't necessarily also capable of fixing a kernel=20
> > bug, sending a patch upstream and getting it past code review.
> >
> > Getting a patch into the Linux kernel is itself a lot of work, unless=
=20
> > you've had years of experience with that constantly changing process=20
> > (which varies significantly between subsystems).
>=20
> I see, I'm not custom to kernel workflow.
>=20
> > Kernel developers are only human and do accidentally introduce=20
> > breakage in their work (as contributors) while ironically (as=20
> > reviewers) they raise the bar for random fixes from users not versed=20
> > in the 10000+ lines of Documentation/process/*.rst
> >
> > Broken code does not mean zero potential users or zero frustrated=20
> > users yet I often hear kernel developers disingenuously claim that it=
=20
> > does. They have an incentive to make that claim and often there's=20
> > no-one reading the mailing lists to push back.
>=20
> But broken code is also bad example of code. The removed code is still=20
> buried in the git tree.
>=20

Some bugs may never be noticed and yet everyone assumes that they are=20
present (hence "defence in depth" and all of the complexity that entails).

My complaint was really about broken code being used as a rationale to=20
remove additional code (whatever its quality).

For example, some maintainers would say, "18 years unnoticed... don't stop=
=20
at g364fb_cursor(), remove the entire driver".
---1463811774-1984420675-1581033946=:13--
