From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Fri, 27 Mar 2015 19:38:58 +0000
Subject: Re: [PATCH v1 09/47] vidoe: fbdev: atyfb: remove and fix MTRR MMIO "hole" work around
Message-Id: <20150327193858.GI5622@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-10-git-send-email-mcgrof@do-not-panic.com>
 <20150321091514.GA22926@sci.fi>
 <20150327083703.GB22926@sci.fi>
In-Reply-To: <20150327083703.GB22926@sci.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 27, 2015 at 10:37:04AM +0200, Ville Syrj=E4l=E4 wrote:
> On Sat, Mar 21, 2015 at 11:15:14AM +0200, Ville Syrj=E4l=E4 wrote:
> > On Fri, Mar 20, 2015 at 04:17:59PM -0700, Luis R. Rodriguez wrote:
> > > diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbd=
ev/aty/atyfb_base.c
> > > index 8025624..8875e56 100644
> > > --- a/drivers/video/fbdev/aty/atyfb_base.c
> > > +++ b/drivers/video/fbdev/aty/atyfb_base.c
> > > @@ -2630,21 +2630,10 @@ static int aty_init(struct fb_info *info)
> > > =20
> > >  #ifdef CONFIG_MTRR
> > >  	par->mtrr_aper =3D -1;
> > > -	par->mtrr_reg =3D -1;
> > >  	if (!nomtrr) {
> > > -		/* Cover the whole resource. */
> > > -		par->mtrr_aper =3D mtrr_add(par->res_start, par->res_size,
> > > +		par->mtrr_aper =3D mtrr_add(info->fix.smem_start,
> > > +					  info->fix.smem_len,
> > >  					  MTRR_TYPE_WRCOMB, 1);
> >=20
> > MTRRs need power of two size, so how is this supposed to work?
>=20
> Still waiting for an answer...

Sorry was in the desert for a bit, I'm back now.

  Luis
