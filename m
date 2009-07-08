From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Framebuffer support for HTC Dream
Date: Wed, 8 Jul 2009 11:19:31 +0200
Message-ID: <20090708091930.GA24385@elf.ucw.cz>
References: <20090629111029.GA15514@elf.ucw.cz> <20090629123840.1e20f17d.akpm@linux-foundation.org> <a55d774e0906291300u3bb9b491r124f27fdf832b495@mail.gmail.com> <20090629211931.GD6611@elf.ucw.cz> <404ea8000906291606u600673f3r63a9ac0dfe02eea@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759363AbZGHJTv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <404ea8000906291606u600673f3r63a9ac0dfe02eea@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Dima Zavin <dima@android.com>
Cc: Brian Swetland <swetland@google.com>, Andrew Morton <akpm@linux-foundation.org>, Rebecca Schultz Zavin <rebecca@android.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hi!

> >> > Will it have a maintainer?
> >>
> >> I did the original quick and dirty version for bringup. =A0Rebecca=
 took
> >> over and (re)wrote the bulk of the driver, getting things stable f=
or
> >> production ship of Dream and Sapphire, and Dima is currently addin=
g
> >> support for later Qualcomm chipsets (QSD8x50, etc). =A0Looping the=
m into
> >> this discussion.
> >
> > I can maintain it if noone else steps up. Of course, someone who
> > actually knows the hw/has the docs would be preferable.
>=20
> As Brian mentioned, I'm the last one to touch it here, so I now own
> it. I've done a bunch refactoring to add support for the qsd8x50

Can you submit a patch adding yourself into MAINTAINERS file?

> devices. I'll post those up onto our experimental git tree (hopefully
> sometime today), and once this patch goes in, I'll make sure that we
> apply cleanly against it. Alternatively, if you like, I can
> incorporate your comments into the refactoring work I'm doing, and ca=
n
> push out the combined patch. In the future though, I'll try to be a
> lot more aggressive at sending these out for review earlier so you
> don't have to clean up our mess.

I believe it makes sense to submit patches relative to -mm tree now.


> Please feel free to CC Rebecca and myself on all the msm_fb related
> changes/discussions.
>=20
> >> It would probably be worth referring to drivers like this as "for
> >> Qualcomm MSM/QSD SoCs" or the like, since they do work with a lot =
of
> >> hardware beyond just Dream.
> >
> > Well, the Dream is why I'm doing it, hence patch title. Of course,
> > Kconfig should say 'Qualcomm MSM/QSD SoCs', too.
>=20
> I second the request that the patches for qualcomm msm7k/qsd8k generi=
c
> support would have descriptions that refer to them as such, since the
> htc dream specific code is only in the board files in
> arch/arm/mach-msm. Note that the HTC Magic (aka the Ion, myTouch 3G,

Ok, I guess someone should do a picture of all the connections and
dictionary of all the acronyms :-).
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
