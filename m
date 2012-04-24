From: Joe Perches <joe@perches.com>
Date: Tue, 24 Apr 2012 12:46:26 +0000
Subject: RE: [PATCH] drivers/video/ep93xx-fb.c: clean up error-handling code
Message-Id: <1335271586.25429.19.camel@joe2Laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1334777828-3557-1-git-send-email-Julia.Lawall@lip6.fr>
	 <4F8F5938.2000207@gmail.com>
	 <000401cd1dd2$5f8ee3b0$1eacab10$%han@samsung.com>
	 <alpine.DEB.2.02.1204190713200.1954@localhost6.localdomain6>
In-Reply-To: <alpine.DEB.2.02.1204190713200.1954@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Jingoo Han <jg1.han@samsung.com>, 'Ryan Mallon' <rmallon@gmail.com>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2012-04-19 at 07:14 +0200, Julia Lawall wrote:
> I don't know thw impact of the ./.  I use the options
>=20
> --nokeywords --nogit-fallback --subsystem --norolestats -f
>=20
> julia
>=20
> On Thu, 19 Apr 2012, Jingoo Han wrote:
>=20
> >> -----Original Message-----
> >> From: Ryan Mallon
[]
> >> Oddly, scripts/get_maintainer.pl on this file doesn't return me, even
> >> though, according to git blame, I am the author of 90% of the commits.
> >> Should I have an entry in the MAINTAINERS file, or is
> >> scripts/get_maintainer.pl not working properly?
> >
> > There are optional differences in using scripts/get_maintainer.pl.
> > If you use './' ahead of file path, you will see your name.
> >
> > Without './' ahead of 'drivers/video/ep93xx-fb.c':
> > ./scripts/get_maintainer.pl --file drivers/video/ep93xx-fb.c
> > Florian Tobias Schandinat <FlorianSchandinat@gmx.de> (maintainer:FRAMEB=
UFFER LAYER)
> > linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
> > linux-kernel@vger.kernel.org (open list)
> >
> > With './' ahead of 'drivers/video/ep93xx-fb.c':
> > ./scripts/get_maintainer.pl --file ./drivers/video/ep93xx-fb.c
> > Ryan Mallon <rmallon@gmail.com> (commit_signer:2/3g%)
> > Paul Gortmaker <paul.gortmaker@windriver.com> (commit_signer:1/33%)
> > H Hartley Sweeten <hsweeten@visionengravers.com> (commit_signer:1/33%)
> > Jesper Juhl <jj@chaosbits.net> (commit_signer:1/33%)
> > Jiri Kosina <jkosina@suse.cz> (commit_signer:1/33%)
> > linux-kernel@vger.kernel.org (open list)

Prefixing "./" to the file path bypasses the normal
get_maintainers pattern check for file maintainership.

Florian Schandinat and linux-fbdev are not returned
in the second lookup above.

One of the patterns for FRAMEBUFFER is
F:	drivers/video/
which is a direct match for is ep93xx-fb.c file,
so --git is not used by default.

Adding --git may be appropriate and it also returns
Ryan's name in this case.

$ ./scripts/get_maintainer.pl -f drivers/video/ep93xx-fb.c
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> (maintainer:FRAMEBUFFE=
R LAYER)
linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
linux-kernel@vger.kernel.org (open list)

$ ./scripts/get_maintainer.pl --git -f drivers/video/ep93xx-fb.c
Florian Tobias Schandinat <FlorianSchandinat@gmx.de> (maintainer:FRAMEBUFFE=
R LAYER)
Ryan Mallon <rmallon@gmail.com> (commit_signer:2/3g%)
Paul Gortmaker <paul.gortmaker@windriver.com> (commit_signer:1/33%)
H Hartley Sweeten <hsweeten@visionengravers.com> (commit_signer:1/33%)
Jesper Juhl <jj@chaosbits.net> (commit_signer:1/33%)
Jiri Kosina <jkosina@suse.cz> (commit_signer:1/33%)
linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
linux-kernel@vger.kernel.org (open list)

Nominally, as framebuffer maintainer, Florian
should also have "signed-off" on these commits,
but many subsystems don't actually have a
single path or person for patches and commits.

This file came into the tree via Andrew Morton.

Another way to investigate who actually does
work on an individual file is to use the
get_maintainer.pl option "--interactive".

That can give you an output like:

*  # email/list and role:stats                                        auth =
sign
*  1 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>            =20
     maintainer:FRAMEBUFFER LAYER
*  2 Ryan Mallon <rmallon@gmail.com>                                     4 =
   4
     commit_signer:2/3g%,authored lines:645/650=99%,commits:4/8P%
*  3 Paul Gortmaker <paul.gortmaker@windriver.com>                       1 =
   1
     commit_signer:1/33%,commits:1/8=12%
*  4 H Hartley Sweeten <hsweeten@visionengravers.com>                    0 =
   2
     commit_signer:1/33%,commits:2/8%%
*  5 Jesper Juhl <jj@chaosbits.net>                                      0 =
   1
     commit_signer:1/33%
*  6 Jiri Kosina <jkosina@suse.cz>                                       0 =
   1
     commit_signer:1/33%
*  7 Andrew Morton <akpm@linux-foundation.org>                           0 =
   2
     commits:2/8%%
*  8 Russell King <rmk+kernel@arm.linux.org.uk>                          0 =
   1
     commits:1/8=12%
*  9 linux-fbdev@vger.kernel.org                                     =20
     open list:FRAMEBUFFER LAYER
* 10 linux-kernel@vger.kernel.org                                    =20
     open list

About maintainership for individual files:

If anyone thinks they are the maintainer for
a particular file, generally they should submit
a patch to MAINTAINERS adding a section with
their name, maintainership level and an
appropriate file pattern.

