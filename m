From: Thierry Reding <treding@nvidia.com>
Date: Thu, 19 Nov 2015 11:51:46 +0000
Subject: Re: [PATCH] [media] hdmi: added functions for MPEG InfoFrames
Message-Id: <20151119115144.GA21862@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447526299-4222-1-git-send-email-enric.balletbo@collabora.com>
 <20151116115037.GF31033@ulmo.nvidia.com>
 <CAFqH_514hjjgPHbP=u1nQ2FPoQe2zLuK5L2R6JcLXjOQdpqZ9g@mail.gmail.com>
 <20151117125507.GD25715@ulmo.nvidia.com>
 <CAFqH_50RB27sPZDZD_Et+uzNqZvh+iS2OuGap-x9aqR5CnEc6w@mail.gmail.com>
In-Reply-To: <CAFqH_50RB27sPZDZD_Et+uzNqZvh+iS2OuGap-x9aqR5CnEc6w@mail.gmail.com>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hans Verkuil <hans.verkuil@cisco.com>, Martin Bugge <marbugge@cisco.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2015 at 11:55:53PM +0100, Enric Balletbo Serra wrote:
> Hello Thierry,
>=20
> 2015-11-17 13:55 GMT+01:00 Thierry Reding <treding@nvidia.com>:
> > On Mon, Nov 16, 2015 at 05:28:24PM +0100, Enric Balletbo Serra wrote:
> >> Hello Thierry,
> >>
> >> Many thanks for your comments.
> >>
> >> 2015-11-16 12:50 GMT+01:00 Thierry Reding <treding@nvidia.com>:
> >> > On Sat, Nov 14, 2015 at 07:38:19PM +0100, Enric Balletbo i Serra wro=
te:
> >> >> The MPEG Source (MS) InfoFrame is in EIA/CEA-861B. It describes asp=
ects of
> >> >> the compressed video stream that were used to produce the uncompres=
sed
> >> >> video.
> >> >>
> >> >> The patch adds functions to work with MPEG InfoFrames.
> >> >>
> >> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> >> ---
> >> >>  drivers/video/hdmi.c | 156 +++++++++++++++++++++++++++++++++++++++=
++++++++++++
> >> >>  include/linux/hdmi.h |  24 ++++++++
> >> >>  2 files changed, 180 insertions(+)
> >> >
> >> > According to the CEA specification a source is expected to send this
> >> > type of infoframe once per video frame. I'm curious how you envision
> >> > this to be ensured. Would hardware provide a mechanism to store this
> >> > data and send the infoframe automatically? How would you ensure that
> >> > updates sent to the hardware match the upcoming frame?
> >> >
> >>
> >> To be honest I'm not sure if I have the full picture. In the use case
> >> I'm trying there is a hardware mechanism to store the data and send
> >> the infoframe through a "Packet Send Control Register".
> >
> > Okay, sounds like the hardware will automatically send out packets at
> > the right time. That still leaves open the issue of how to ensure this
> > is synchronized with userspace. Perhaps this could be done by attaching
> > a property to a framebuffer, so that we'd know what exact frame the meta
> > data is attached to and when to update the FIFOs for the infoframe.
> >
> > Usually it's a good idea to send this type of patch as part of a larger
> > series precisely so that people can see how it is used. That should make
> > it easier to see if this is good enough or needs some more thought on
> > how to synchronize. Do you have any code that you could post that makes
> > use of this new infoframe?
> >
>=20
> I was thinking use this and other helpers in the anx7814 bridge
> driver[1], I thought that this patch should go through another tree,
> this is the reason why I send it separately, but If you want or you
> prefer I can send as part of these patch series.
>=20
> [1] https://lkml.org/lkml/2015/11/13/284

I haven't seen those patches yet. I should've been Cc'ed on those
patches since I'm technically the maintainer of drm/bridge. Did the
get_maintainer.pl script not list me?

In my opinion, it's usually a good idea to keep all dependencies in a
single series, just so people get a better picture of what you're
submitting. Of course that's just my opinion, somebody else may yell at
you because they get Cc'ed on patches that they're not interested in...

As for merging patches, it's usually best to let maintainers figure that
out once the series is in good shape.

Thierry

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWTbfMAAoJEN0jrNd/PrOhKywP/jUGBNbFkKXQQ59RqjEew2rS
eNX5LZbN9i721uiJt4MWVllZQuiiK2dUNt6pUkxz7IH+yGHYLnHctkZctaVzAqwG
ew30P+SBgJsP6Q52U/eRi69m7dZFB0qw0uc2pma7knFV0ro3k1XNXLAQ8XBJ+0U4
mA6RxbtrkmP1oT7MxJkU072ipJRlhr6Oi+r6RkqBTsx8m1SfG1uG5MyEwtllYkDq
E2ufacYKAQ8Nfo6dAy0Q2v3D/gxch1HM8CdIT3n6QOjXTJzJPwI0uEAavFE18czz
q2gdlRoupni326Ag5IX/djmMtPi7hMCrUNonjz3BnvBEJgfQaaZIdk8DPp95/ulo
nKSST2Zde9rXrhC+gH4mKqTC+vmOhNbOl5lxaG5YbbLUGXAxcFbNoGKZVR5I5pSI
20rQZIiqzHi3JLVa0bFw0sKpkF+MZYkpTFTWZEdref8TAJJJ2S9wyeSD3lqaTBfj
e3nGkWPWA0flqWiForEYzgDLJqIQ/q/k6cjFND6x+uk42mlPsMRSy7JHR+0VP1MX
P5eZoFRP4do1mKROFS4yAjCth6/D6o8y8MUHanB0IAeapEchP56l5cDyjCRaPrzB
ksPqpChVOQe9VMruHFy8Iog9pP/kv0NG0cNlZhWsfTq18Bpm3C3AQoMXy1yPcoQ6
+ZpA4l7LHN7VE4tlbq5S
=pMp/
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
