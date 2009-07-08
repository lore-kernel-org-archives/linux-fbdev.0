From: krzysztof.h1@poczta.fm
Subject: =?UTF-8?q?Re:_Re:_matroxfb:_fix_regression_with_uninitalized_fb=5Finfo->mm=5Flock_mutex_(second_head)?=
Date: 08 Jul 2009 08:27:28 +0200
Message-ID: <20090708062729.E32231B00E2@f41.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758110AbZGHG1t@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/plain; charset="iso-8859-1"
To: Linus Torvalds <torvalds@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, akp

Linus Torvalds napisa=B3(a):
>=20
>=20
> On Tue, 7 Jul 2009, Krzysztof Helt wrote:
> >=20
> > Remove redundant locking by the mm_lock mutex before a second head =
of
> matrox=20
> > framebuffer is registered.
>=20
> Why do you write misleading commentary like this.
>=20

I have not intention to mislead someone. English is not my primary lang=
uage and this can be a source of this unfortunate wording.

> > +/*
> > + * This function is called before the register_framebuffer so
> > + * no locking is needed.
> > + */
>=20
> Or this?
>=20
> It&#039;s not about "needed". The locking is not only not needed, it =
would be=20
> BUGGY.
>=20
> And it&#039;s not "redundant". That implies that it&#039;s done somew=
here else. It&#039;s
>=20
> more than "not needed" - it would be actively buggy to lock things th=
ere.
>=20
> I really don&#039;t like how you&#039;re approaching this. You&#039;r=
e ignoring the real
>=20
> issues I ask you, you&#039;re writing misleading comments and commit =
messages,
>=20
> and the end result is fragile code. I still don&#039;t understand why=
 you=20
> insist on initializing those things late, which is the primary proble=
m=20
> here.
>=20

The mm_lock mutex is used only inside the fb_mmap() function and driver=
's specific code. The fb_mmap()=20
cannot be called before a framebuffer is registered. That's why it is e=
nough to initialize the mutex
just before registering the framebuffer (or inside the register_framebu=
ffer()). A current approach=20
allows for statically declared fb_info structures (you consider it wron=
g).

It is easy to find affected drivers: "grep -rl mm_lock drivers/video/*"=
=2E I went too far with some
drivers and added mm_lock mutex to functions which are called only from=
 a probing function. They do
not need any locking yet. This is similar as marking them as __init or =
__devinit which makes incorrect
calling them after driver initialization. Some of these functions are s=
o short they can be unrolled
into the probing functions. Does it make removal of the unneeded mutexi=
ng correct then?

All other drivers just have, let's say, inefficient code - calling a fu=
nction which is called just
a moment later or set values which are not used before set again later =
(i810fb, matroxfb, sisfb).
The mm_lock patch converted this inefficient code into broken code.=20

I understand you choose different approach. In order to keep this ineff=
icient code in place you=20
decided to change some correctly working legacy drivers and disallow st=
atically declared fb_info=20
structures. I see I cannot convince you it is worse solution so I am no=
t trying any more.

However, you can still count my patches as small code improvements.

My fault is that I haven't tested the patch on a hardware and driver wi=
th added mm_lock mutex and
broken by this (like sisfb or matroxfb). I have not known I broke them.

Regards,
Krzysztof

----------------------------------------------------------------------
Teraz AC/OC + ubezpieczenie kosztow leczenia za granica
http://link.interia.pl/f2230
