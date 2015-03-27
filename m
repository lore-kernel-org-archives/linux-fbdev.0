From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Date: Fri, 27 Mar 2015 21:56:55 +0000
Subject: Re: [PATCH v1 09/47] vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
Message-Id: <20150327215655.GA29933@sci.fi>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
 <20150321091514.GA22926@sci.fi>
 <20150327193813.GH5622@wotan.suse.de>
 <CALCETrVfC8aGKuPvaqv3edBADnKKvgDRiKbDvaaOr-HLB7jijg@mail.gmail.com>
 <20150327195759.GK5622@wotan.suse.de>
In-Reply-To: <20150327195759.GK5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Bjorn Helgaas <bhelgaas@google.com>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 27, 2015 at 08:57:59PM +0100, Luis R. Rodriguez wrote:
> On Fri, Mar 27, 2015 at 12:43:55PM -0700, Andy Lutomirski wrote:
> > On Fri, Mar 27, 2015 at 12:38 PM, Luis R. Rodriguez <mcgrof@suse.com> w=
rote:
> > > On Sat, Mar 21, 2015 at 11:15:14AM +0200, Ville Syrj=E4l=E4 wrote:
> > >> On Fri, Mar 20, 2015 at 04:17:59PM -0700, Luis R. Rodriguez wrote:
> > >> > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/=
fbdev/aty/atyfb_base.c
> > >> > index 8025624..8875e56 100644
> > >> > --- a/drivers/video/fbdev/aty/atyfb_base.c
> > >> > +++ b/drivers/video/fbdev/aty/atyfb_base.c
> > >> > @@ -2630,21 +2630,10 @@ static int aty_init(struct fb_info *info)
> > >> >
> > >> >  #ifdef CONFIG_MTRR
> > >> >     par->mtrr_aper =3D -1;
> > >> > -   par->mtrr_reg =3D -1;
> > >> >     if (!nomtrr) {
> > >> > -           /* Cover the whole resource. */
> > >> > -           par->mtrr_aper =3D mtrr_add(par->res_start, par->res_s=
ize,
> > >> > +           par->mtrr_aper =3D mtrr_add(info->fix.smem_start,
> > >> > +                                     info->fix.smem_len,
> > >> >                                       MTRR_TYPE_WRCOMB, 1);
> > >>
> > >> MTRRs need power of two size, so how is this supposed to work?
> > >
> > > As per mtrr_add_page() [0] the base and size are just supposed to be =
in units
> > > of 4 KiB, although the practice is to use powers of 2 in *some* drive=
rs this
> > > is not standardized and by no means recorded as a requirement. Obviou=
sly
> > > powers of 2 will work too and you'd end up neatly aligned as well. mt=
rr_add()
> > > will use mtrr_check() to verify the the same requirement. Furthermore,
> > > as per my commit log message:
> >=20
> > Whatever the code may or may not do, the x86 architecture uses
> > power-of-two MTRR sizes.  So I'm confused.
>=20
> There should be no confusion, I simply did not know that *was* the
> requirement for x86, if that is the case we should add a check for that
> and perhaps generalize a helper that does the power of two helper changes,
> the cleanest I found was the vesafb driver solution.
>=20
> Thoughts?

The vesafb solution is bad since you'll only end up covering only
the first 4MB of the framebuffer instead of the almost 8MB you want.
Which in practice will mean throwing away half the VRAM since you really
don't want the massive performance hit from accessing it as UC. And that
would mean giving up decent display resolutions as well :(

And the other option of trying to cover the remainder with multiple ever
smaller MTRRs doesn't work either since you'll run out of MTRRs very
quickly.

This is precisely why I used the hole method in atyfb in the first
place.

I don't really like the idea of any new mtrr code not supporting that
use case, especially as these things tend to be present in older machines
where PAT isn't an option.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
