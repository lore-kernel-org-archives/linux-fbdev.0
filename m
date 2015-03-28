From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Sat, 28 Mar 2015 00:28:18 +0000
Subject: Re: [PATCH v1 09/47] vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
Message-Id: <20150328002818.GT5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
 <20150321091514.GA22926@sci.fi>
 <20150327193813.GH5622@wotan.suse.de>
 <CALCETrVfC8aGKuPvaqv3edBADnKKvgDRiKbDvaaOr-HLB7jijg@mail.gmail.com>
 <20150327195759.GK5622@wotan.suse.de>
 <20150327215655.GA29933@sci.fi>
 <CALCETrWW9WrE_4x6SctQQBe=zXp1yMQ1i=qtsACTnHV0_Ku2iQ@mail.gmail.com>
In-Reply-To: <CALCETrWW9WrE_4x6SctQQBe=zXp1yMQ1i=qtsACTnHV0_Ku2iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andy Lutomirski <luto@amacapital.net>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, Bjorn Helgaas <bhelgaas@google.com>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 27, 2015 at 03:02:10PM -0700, Andy Lutomirski wrote:
> On Fri, Mar 27, 2015 at 2:56 PM, Ville Syrj=E4l=E4 <syrjala@sci.fi> wrote:
> > On Fri, Mar 27, 2015 at 08:57:59PM +0100, Luis R. Rodriguez wrote:
> >> On Fri, Mar 27, 2015 at 12:43:55PM -0700, Andy Lutomirski wrote:
> >> > On Fri, Mar 27, 2015 at 12:38 PM, Luis R. Rodriguez <mcgrof@suse.com=
> wrote:
> >> > > On Sat, Mar 21, 2015 at 11:15:14AM +0200, Ville Syrj=E4l=E4 wrote:
> >> > >> On Fri, Mar 20, 2015 at 04:17:59PM -0700, Luis R. Rodriguez wrote:
> >> > >> > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/vid=
eo/fbdev/aty/atyfb_base.c
> >> > >> > index 8025624..8875e56 100644
> >> > >> > --- a/drivers/video/fbdev/aty/atyfb_base.c
> >> > >> > +++ b/drivers/video/fbdev/aty/atyfb_base.c
> >> > >> > @@ -2630,21 +2630,10 @@ static int aty_init(struct fb_info *inf=
o)
> >> > >> >
> >> > >> >  #ifdef CONFIG_MTRR
> >> > >> >     par->mtrr_aper =3D -1;
> >> > >> > -   par->mtrr_reg =3D -1;
> >> > >> >     if (!nomtrr) {
> >> > >> > -           /* Cover the whole resource. */
> >> > >> > -           par->mtrr_aper =3D mtrr_add(par->res_start, par->re=
s_size,
> >> > >> > +           par->mtrr_aper =3D mtrr_add(info->fix.smem_start,
> >> > >> > +                                     info->fix.smem_len,
> >> > >> >                                       MTRR_TYPE_WRCOMB, 1);
> >> > >>
> >> > >> MTRRs need power of two size, so how is this supposed to work?
> >> > >
> >> > > As per mtrr_add_page() [0] the base and size are just supposed to =
be in units
> >> > > of 4 KiB, although the practice is to use powers of 2 in *some* dr=
ivers this
> >> > > is not standardized and by no means recorded as a requirement. Obv=
iously
> >> > > powers of 2 will work too and you'd end up neatly aligned as well.=
 mtrr_add()
> >> > > will use mtrr_check() to verify the the same requirement. Furtherm=
ore,
> >> > > as per my commit log message:
> >> >
> >> > Whatever the code may or may not do, the x86 architecture uses
> >> > power-of-two MTRR sizes.  So I'm confused.
> >>
> >> There should be no confusion, I simply did not know that *was* the
> >> requirement for x86, if that is the case we should add a check for that
> >> and perhaps generalize a helper that does the power of two helper chan=
ges,
> >> the cleanest I found was the vesafb driver solution.
> >>
> >> Thoughts?
> >
> > The vesafb solution is bad since you'll only end up covering only
> > the first 4MB of the framebuffer instead of the almost 8MB you want.
> > Which in practice will mean throwing away half the VRAM since you really
> > don't want the massive performance hit from accessing it as UC. And that
> > would mean giving up decent display resolutions as well :(
> >
> > And the other option of trying to cover the remainder with multiple ever
> > smaller MTRRs doesn't work either since you'll run out of MTRRs very
> > quickly.
> >
> > This is precisely why I used the hole method in atyfb in the first
> > place.
> >
> > I don't really like the idea of any new mtrr code not supporting that
> > use case, especially as these things tend to be present in older machin=
es
> > where PAT isn't an option.
>=20
> According to the Intel SDM, volume 3, section 11.5.2.1, table 11-6,
> non-PAT CPUs that have a WC MTRR, PCD =3D 1, and PWT =3D 1 (aka UC) have
> an effective memory type of UC.  Hence my suggestion to add
> ioremap_x86_uc and/or set_memory_x86_uc to punch a UC hole in an
> otherwise WC MTRR-covered region.

OK I think I get it now.

And I take it this would hopefully only be used for non-PAT systems?
Would there be a use case for PAT systems? I wonder if we can wrap
this under some APIs to make it clean and hide this dirty thing
behind the scenes, it seems a fragile and error prone and my hope
would be that we won't need more specialization in this area for
PAT systems.

> ioremap_nocache is UC- (even on non-PAT unless I misunderstood how
> this stuff works), so ioremap_nocache by itself isn't good enough.

Thanks for the clarification.

 Luis
