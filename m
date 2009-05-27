From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?=5BPATCH=5D_fbdev=3A_does_not_allow?=
	=?utf-8?q?_VESA_modes_without_compiled-in_drivers_=28bug_=2313249?=
	=?utf-8?q?=29?=
Date: 27 May 2009 09:41:19 +0200
Message-ID: <20090527074119.D9ED34B3241@f33.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M9DlZ-0008Go-3M
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 07:41:37 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M9DlM-0001GL-1q for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 27 May 2009 07:41:29 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@linux-foundation.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Werner Lemberg <wl@gnu.org>

Andrew Morton napisa=B3(a):
> On Wed, 20 May 2009 14:27:04 +0200 Krzysztof Helt >krzysztof.h1@poczta.fm>
> wrote:
> =

> > From: Krzysztof Helt >krzysztof.h1@wp.pl>
> > =

> > Does not allow to accept VESA modes by the "vga=3D" kernel parameter
> > if there is no frame buffer driver compiled-in to handle it.
> > =

> > Bug was reported by Werner Lemberg as kernel bug #13249
> > "Intel 945GM: Boot option`vga=3D0x31a&#039; breaks display of TTYs".
> > =

> > Signed-off-by: Krzysztof Helt >krzysztof.h1@wp.pl>
> > ---
> > =

> > Werner, please test it. It should produce a correct display
> > with intelfb compiled in (=3Dy) and as a module (=3Dm).
> > =

> > =

> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 0048f11..c787357 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -1122,7 +1122,7 @@ config FB_INTEL
> >  	select FB_CFB_FILLRECT
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
> > -	select FB_BOOT_VESA_SUPPORT
> > +	select FB_BOOT_VESA_SUPPORT if FB_INTEL =3D y
> >  	help
> >  	  This driver supports the on-board graphics built in to the Intel
> >            830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM/965G/965GM
> chipsets.
> > @@ -1460,7 +1460,7 @@ config FB_SIS
> >  	select FB_CFB_FILLRECT
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
> > -	select FB_BOOT_VESA_SUPPORT
> > +	select FB_BOOT_VESA_SUPPORT if FB_SIS =3D y
> >  	help
> >  	  This is the frame buffer device driver for the SiS 300, 315, 330
> >  	  and 340 series as well as XGI V3XT, V5, V8, Z7 graphics chipsets.
> =

> I read through http://bugzilla.kernel.org/show_bug.cgi?id=3D13249 and am
> now unsure what to do with this patch?
> =

> =


Drop it. =


I think I know why my laptop uses PIPE_B but both pipes are active. The pip=
es are connected
to so called planes and driver must check which plane is enabled also.
Otherwise, when both pipes are enabled the driver doesn't know which one is=
 used.

Finally, I found the documentation for i845.

Kind regards,
Krzysztof

----------------------------------------------------------------------
Kup wlasne mieszkanie za 33 tys. zl.
Sprawdz >>> http://link.interia.pl/f21a3


---------------------------------------------------------------------------=
---
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT =

is a gathering of tech-side developers & brand creativity professionals. Me=
et
the minds behind Google Creative Lab, Visual Complexity, Processing, & =

iPhoneDevCamp as they present alongside digital heavyweights like Barbarian =

Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com =
