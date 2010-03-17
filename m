From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@nokia.com>
Date: Wed, 17 Mar 2010 20:14:25 +0000
Subject: Re: [PATCH v3 1/4] DSS2: OMAPFB: Add support for switching memory
Message-Id: <20100317201425.GI18243@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1267795582-21004-1-git-send-email-ville.syrjala@nokia.com>
 <20100317173407.GD30422@localhost>
In-Reply-To: <20100317173407.GD30422@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Deak Imre (Nokia-D/Helsinki)" <imre.deak@nokia.com>
Cc: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Mar 17, 2010 at 06:34:07PM +0100, Deak Imre (Nokia-D/Helsinki) wrot=
e:
> Hi,
>=20
> couple of minor comments inlined.
>=20
> On Fri, Mar 05, 2010 at 02:26:19PM +0100, Syrjala Ville (Nokia-D/Helsinki=
) wrote:
> > From: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
> >=20
> > Separate the memory region from the framebuffer device a little bit.
> > It's now possible to select the memory region used by the framebuffer
> > device using the new mem_idx parameter of omapfb_plane_info. If the
> > mem_idx is specified it will be interpreted as an index into the
> > memory regions array, if it's not specified the framebuffer's index is
> > used instead. So by default each framebuffer keeps using it's own
> > memory region which preserves backwards compatibility.
> >=20
> > This allows cloning the same memory region to several overlays and yet
> > each overlay can be controlled independently since they can be
> > associated with separate framebuffer devices.
> >=20
> > Signed-off-by: Ville Syrj=E4l=E4 <ville.syrjala@nokia.com>
> > ---
> > Changes since v2:
> > * Removed the use_count and rely on just counting all active overlays. =
A bit racy
> >   but no chance of getting stuck in a state where memory allocation can=
't be changed.
> > * s/source_idx/mem_idx as that seems to be a little more self explanato=
ry
> > [...]
> >=20
> >  drivers/video/omap2/omapfb/omapfb-ioctl.c |  163 ++++++++++++++++++++-=
----
> >  drivers/video/omap2/omapfb/omapfb-main.c  |  184 +++++++++++++++++++--=
--------
> >  drivers/video/omap2/omapfb/omapfb-sysfs.c |   60 ++++++++--
> >  drivers/video/omap2/omapfb/omapfb.h       |   38 ++++++-
> >  include/linux/omapfb.h                    |    5 +-
> >  5 files changed, 339 insertions(+), 111 deletions(-)
> >=20
> > diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/=
omap2/omapfb/omapfb-ioctl.c
> > index 1ffa760..cd00bdc 100644
> > --- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
> > +++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
> > [...]
> >  static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_plane=
_info *pi)
> >  {
> >         struct omapfb_info *ofbi =3D FB2OFB(fbi);
> > +       struct omap_overlay *ovl =3D ofbi->overlays[0];
> > +       struct omap_overlay_info *ovli =3D &ovl->info;
> >=20
> >         if (ofbi->num_overlays !=3D 1) {
> >                 memset(pi, 0, sizeof(*pi));
> >         } else {
> > -               struct omap_overlay_info *ovli;
> > -               struct omap_overlay *ovl;
> > -
> > -               ovl =3D ofbi->overlays[0];
> > -               ovli =3D &ovl->info;
> > -
>=20
> Is this really necessary?

Nope. Leftovers from some earlier stuff I think.

>=20
> >                 pi->pos_x =3D ovli->pos_x;
> >                 pi->pos_y =3D ovli->pos_y;
> >                 pi->enabled =3D ovli->enabled;
> >                 pi->channel_out =3D 0; /* xxx */
> >                 pi->mirror =3D 0;
> > +               pi->mem_idx =3D get_mem_idx(ofbi);
> >                 pi->out_width =3D ovli->out_width;
> >                 pi->out_height =3D ovli->out_height;
> >         }
> > @@ -115,30 +184,57 @@ static int omapfb_setup_mem(struct fb_info *fbi, =
struct omapfb_mem_info *mi)
> >         struct omapfb_info *ofbi =3D FB2OFB(fbi);
> >         struct omapfb2_device *fbdev =3D ofbi->fbdev;
> >         struct omapfb2_mem_region *rg;
> > -       int r, i;
> > +       int r =3D 0;
> >         size_t size;
> > +       int i;
> >=20
> >         if (mi->type > OMAPFB_MEMTYPE_MAX)
> >                 return -EINVAL;
> >=20
> >         size =3D PAGE_ALIGN(mi->size);
> >=20
> > -       rg =3D &ofbi->region;
> > +       rg =3D ofbi->region;
> >=20
> > -       for (i =3D 0; i < ofbi->num_overlays; i++) {
> > -               if (ofbi->overlays[i]->info.enabled)
> > -                       return -EBUSY;
> > +       /* FIXME probably should be a rwsem ... */
> > +       mutex_lock(&rg->mtx);
> > +       while (rg->ref) {
> > +               mutex_unlock(&rg->mtx);
> > +               schedule();
> > +               mutex_lock(&rg->mtx);
> > +       }
>=20
> Yes, rwsem would mean no unnecessary scheduling and also make things
> clearer.

Just tried it and seems to be mostly OK. We get lockdep checking as a
bonus. It didn't like setup_plane taking the same rwsem twice so I
added a check to see if the old and new regions are the same and just
lock once in that case. I thought rwsem was supposed to be OK with
read recursion but perhaps I was mitaken, or perhaps it's just lockdep
that's misbehaving.

>=20
> > [...]
> >  static int omapfb_query_mem(struct fb_info *fbi, struct omapfb_mem_inf=
o *mi)
> > @@ -146,12 +242,15 @@ static int omapfb_query_mem(struct fb_info *fbi, =
struct omapfb_mem_info *mi)
> >         struct omapfb_info *ofbi =3D FB2OFB(fbi);
> >         struct omapfb2_mem_region *rg;
> >=20
> > -       rg =3D &ofbi->region;
> >         memset(mi, 0, sizeof(*mi));
> >=20
> > +       rg =3D omapfb_get_mem_region(ofbi->region);
>=20
> At some other users of region I haven't seen omapfb_get_mem_region,
> like store_mirror, store_overlays_rotate.

Right. I apparently just missed them. I now have a patch that tracks the
lock count too and added a few WARN_ON()s to some of the omapfb-main
functions that assume that the region is locked. That triggered a few
warning during boot which I already knew would not hold the lock since
they were only exectedu during init. But I fixed them anyway to take the
lock and now I can boot without warnings.

> It wouldn't have been nice to have this patch in smaller chunks. For exam=
ple
> one for converting all region. to region-> and another one for adding the
> locking for it, then the rest.

I've now split it up into smalled chunks and eliminated all the
gratuitous changes. Assuming I can get my emmc working again and no issues
appear during some randr torture tests I will post the new patchset still t=
oday.

--=20
Ville Syrj=E4l=E4
