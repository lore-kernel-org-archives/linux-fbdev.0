From: Colin Watson <cjwatson@canonical.com>
Date: Wed, 25 Aug 2010 17:28:52 +0000
Subject: Re: [PATCH] Add new linearfb driver
Message-Id: <20100825172851.GL21862@riva.ucam.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100825141111.GI21862@riva.ucam.org> <20100825190438.55ecb34d@neptune.home>
In-Reply-To: <20100825190438.55ecb34d@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Wed, Aug 25, 2010 at 07:04:38PM +0200, Bruno Pr=E9mont wrote:
> On Wed, 25 August 2010 Colin Watson <cjwatson@canonical.com> wrote:
> > -config FB_EFI
> > -	bool "EFI-based Framebuffer Support"
> > -	depends on (FB =3D y) && X86 && EFI
> > +config FB_LINEAR
> > +	bool "Simple linear framebuffer support"
> > +	depends on FB
> >  	select FB_CFB_FILLRECT
> >  	select FB_CFB_COPYAREA
> >  	select FB_CFB_IMAGEBLIT
>         ^^^^^^^^^^^^^^^^^^^^^^^
>=20
> > +config FB_EFI
> > +	bool "EFI-based Framebuffer Support"
> > +	depends on (FB =3D y) && X86 && EFI
> > +	select FB_LINEAR
>         ^^^^^^^^^^^^^^^^
>   Has kconfig been adjusted to process select recursively?
>   If not the selects from FB_LINEAR will have to be copied here.

When I start with a consistent .config with FB_CFB_FILLRECT unset, then
'make menuconfig' and enable FB_EFI, the resulting .config has
CONFIG_FB_CFB_FILLRECT=3Dy.  That should be a sufficient test, shouldn't
it?

Thanks,

--=20
Colin Watson                                    [cjwatson@canonical.com]
