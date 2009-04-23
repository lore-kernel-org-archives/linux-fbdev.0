From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Linux-fbdev-devel] fbcmap: non working tests on unsigned
	cmap->start
Date: Fri, 24 Apr 2009 00:47:38 +0300
Message-ID: <20090423214738.GF7134@sci.fi>
References: <49EDD799.8060607@gmail.com> <20090423134110.51ea8df2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758030AbZDWVrv@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090423134110.51ea8df2.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Thu, Apr 23, 2009 at 01:41:10PM -0700, Andrew Morton wrote:
> On Tue, 21 Apr 2009 16:26:33 +0200
> Roel Kluin <roel.kluin@gmail.com> wrote:
>=20
> > vi include/linux/fb.h +478
> >=20
> > Note that struct fb_cmap_user cmap->start in fb_set_user_cmap() is =
unsigned.
> > Should there maybe be a test:
> >=20
> > if (cmap->start > MAX || ...)
> >=20
> > (and what should MAX be then?)
> >=20
> > Otherwise you may want to apply the cleanup patch below
> >=20
> > Roel
> > ------------------------------>8-------------8<--------------------=
-------------
> > Remove redundant tests on unsigned
> >=20
> > Signed-off-by: Roel Kluin <roel.kluin@gmail.com>=20
> > ---
> > diff --git a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
> > index f53b9f1..958bf4e 100644
> > --- a/drivers/video/fbcmap.c
> > +++ b/drivers/video/fbcmap.c
> > @@ -266,8 +266,7 @@ int fb_set_user_cmap(struct fb_cmap_user *cmap,=
 struct fb_info *info)
> >  		rc =3D -ENODEV;
> >  		goto out;
> >  	}
> > -	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
> > -				!info->fbops->fb_setcmap)) {
> > +	if (!info->fbops->fb_setcolreg && !info->fbops->fb_setcmap) {
> >  		rc =3D -EINVAL;
> >  		goto out1;
> >  	}
>=20
> argh.
>=20
> - Perhaps userspace can kill the kernel by sending a "negative"
>   `start'.  Removing the test will make it even less likely that we'l=
l
>   fix this bug.

Shouldn't happen. 'start' is used as the starting index for the hardwar=
e
palette, 'start+len-1' is the last index. All drivers should already ch=
eck
the passed values since the maximum index depends on the display mode.
And I suppose the worst thing that could happen if the driver fails to
check the values would be incorrect colors.

> - If this bug doesn't exist, and there _is_ userspace which is
>   legitimately sending in "negative" values of `start' (unlikely?) th=
en
>   we will break userspace if we fix this comparison.

The comparison will always be false since 'start' is unsigned so how
would anything break?

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/
