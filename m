From: Thierry Reding <treding@nvidia.com>
Date: Tue, 17 Nov 2015 12:55:08 +0000
Subject: Re: [PATCH] [media] hdmi: added functions for MPEG InfoFrames
Message-Id: <20151117125507.GD25715@ulmo.nvidia.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Clx92ZfkiYIKRjnr"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1447526299-4222-1-git-send-email-enric.balletbo@collabora.com>
 <20151116115037.GF31033@ulmo.nvidia.com>
 <CAFqH_514hjjgPHbP=u1nQ2FPoQe2zLuK5L2R6JcLXjOQdpqZ9g@mail.gmail.com>
In-Reply-To: <CAFqH_514hjjgPHbP=u1nQ2FPoQe2zLuK5L2R6JcLXjOQdpqZ9g@mail.gmail.com>
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: linux-fbdev@vger.kernel.org, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Hans Verkuil <hans.verkuil@cisco.com>, Martin Bugge <marbugge@cisco.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>

--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2015 at 05:28:24PM +0100, Enric Balletbo Serra wrote:
> Hello Thierry,
>=20
> Many thanks for your comments.
>=20
> 2015-11-16 12:50 GMT+01:00 Thierry Reding <treding@nvidia.com>:
> > On Sat, Nov 14, 2015 at 07:38:19PM +0100, Enric Balletbo i Serra wrote:
> >> The MPEG Source (MS) InfoFrame is in EIA/CEA-861B. It describes aspect=
s of
> >> the compressed video stream that were used to produce the uncompressed
> >> video.
> >>
> >> The patch adds functions to work with MPEG InfoFrames.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>  drivers/video/hdmi.c | 156 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  include/linux/hdmi.h |  24 ++++++++
> >>  2 files changed, 180 insertions(+)
> >
> > According to the CEA specification a source is expected to send this
> > type of infoframe once per video frame. I'm curious how you envision
> > this to be ensured. Would hardware provide a mechanism to store this
> > data and send the infoframe automatically? How would you ensure that
> > updates sent to the hardware match the upcoming frame?
> >
>=20
> To be honest I'm not sure if I have the full picture. In the use case
> I'm trying there is a hardware mechanism to store the data and send
> the infoframe through a "Packet Send Control Register".

Okay, sounds like the hardware will automatically send out packets at
the right time. That still leaves open the issue of how to ensure this
is synchronized with userspace. Perhaps this could be done by attaching
a property to a framebuffer, so that we'd know what exact frame the meta
data is attached to and when to update the FIFOs for the infoframe.

Usually it's a good idea to send this type of patch as part of a larger
series precisely so that people can see how it is used. That should make
it easier to see if this is good enough or needs some more thought on
how to synchronize. Do you have any code that you could post that makes
use of this new infoframe?

> >> @@ -899,6 +978,41 @@ static void hdmi_audio_infoframe_log(const char *=
level,
> >>                       frame->downmix_inhibit ? "Yes" : "No");
> >>  }
> >>
> >> +static const char *hdmi_mpeg_picture_get_name(enum hdmi_mpeg_picture_=
type type)
> >> +{
> >> +     switch (type) {
> >> +     case HDMI_MPEG_PICTURE_TYPE_UNKNOWN:
> >> +             return "Unknown";
> >> +     case HDMI_MPEG_PICTURE_TYPE_I:
> >> +             return "Intra-coded picture";
> >> +     case HDMI_MPEG_PICTURE_TYPE_B:
> >> +             return "Bi-predictive picture";
> >> +     case HDMI_MPEG_PICTURE_TYPE_P:
> >> +             return "Predicted picture";
> >> +     }
> >
> > I'd have chosen the slightly more canonical "I-Frame", "P-Frame",
> > "B-Frame" here, but that's not a strong objection.
> >
>=20
> I don't have any inconvenient to change, are the following names more
> canonical ?
>=20
>        HDMI_MPEG_UNKNOWN_FRAME =3D 0x00,
>        HDMI_MPEG_I_FRAME =3D 0x01,
>        HDMI_MPEG_B_FRAME =3D 0x02,
>        HDMI_MPEG_P_FRAME =3D 0x03,

I wasn't very clear. What I meant was the names for the constants. At
least personally I know immediately what is meant when I see "I-Frame",
"P-Frame" or "B-Frame", whereas "Bi-predictive picture" needs more
thinking.

Thierry

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWSyOoAAoJEN0jrNd/PrOhqHAQALCtgoYY1zVDhAW30H2ec9rE
VGhv44qjfW36gohIApjdR374RlD8XkOymLDHZG7TUqpKkaB+bz2tPwtF8XkWcycx
nVazwfZ1KOHgXA0XOBq+0ezHQsMSek850eEuFwaGZexFT4sMluBpPJO2DqisZfAm
tOfXoM5XcHTghrudic+k9CA083lPvH7cv35Pvk36pV9pJgzl4z/NWeOv1H2ulagf
pIjDGSfArgl4V5qtUMR5JasBZDuS+601ehMPpAWGNvkC/6Y5I6ItQf9N3N8fYY3E
b0rfpaZDUuKMaPueipGzrv6vePuDLpaZfx7FsRIHzKn+e1LiMxZldS+PQYsA+TiP
8Kh5v8xLO7ZBFGjDz7JmV5qHc52aDdpFebQM5oTJhVbE5YXpS86B+bQempFyZkBL
thmwVxv085eiIpy/sbVxcx9fea1dV073Hk5M23DxhYA4U2eJmgCGa7qcd12fMqzE
fkPIFW9Fw6RH5xJncWcgvChde9LEs1VDDCvQjuGm4TaYnVHx3zyq6z5eVctrpsb7
iLR2bce/LlNNOGzUt9Qv2ymCOi12jyccnjXmL1+iN5Tx9n6BlYH4HCK4xfcUHeh1
2Eq4Ud/7FGK5HCIxdBK62OlfhEgbyE+01Byx9VMKEKQtrvUvYoS0VgOhTl7aMwn5
F3woi6jDbGicroyTD0H1
=Tpb+
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
