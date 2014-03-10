From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Mar 2014 16:40:58 +0000
Subject: Re: [PATCH 0/9] Doc/DT: DT bindings for various display components
Message-Id: <531DEB1A.5090509@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eET4CNQ3bBDUnx3QgaDsfXJpAXst4naJq"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1393590016-9361-1-git-send-email-tomi.valkeinen@ti.com>	<20140228162752.GU21483@n2100.arm.linux.org.uk>	<5310BDE3.60603@ti.com>	<20140228165628.GX21483@n2100.arm.linux.org.uk>	<53143796.2050309@ti.com>
 <CAL_JsqLppZHjND_LFMxscR0WCD4Ox7vF0fDbQFoYg=TENXxY8Q@mail.gmail.com>
In-Reply-To: <CAL_JsqLppZHjND_LFMxscR0WCD4Ox7vF0fDbQFoYg=TENXxY8Q@mail.gmail.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Tomasz Figa <tomasz.figa@gmail.com>, dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Rob Clark <robdclark@gmail.com>, Rob Herring <robh+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

--eET4CNQ3bBDUnx3QgaDsfXJpAXst4naJq
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On 10/03/14 18:05, Rob Herring wrote:

>> Russell's point was that these connector bindings are very generic, i.=
e.
>> they are not for any particular chip from a particular vendor, but for=

>> any connector for DVI, HDMI or analog-tv. And he's worried that maybe =
we
>> shouldn't define such generic bindings without consulting the whole
>> device-tree community (i.e including non-linux users).
>=20
> So re-work it to be generic and send it out. DT maintainers would
> rarely disagree that something shouldn't be made generic.

They (in this series) are already designed to be generic.

I should perhaps re-word the question: we are concerned whether these
bindings are good for all the users, not just us, and whether there
already exists something that overlaps.

Afaik, there's nothing overlapping. And I don't see why they wouldn't be
good for all users (with the few minor modifications that have been
discussed in this thread). But, if I gathered right, Russell would like
some kind of ack from someone who might know better than us.

So is it enough to have posted these, and gotten acks from the people
involved, or should we get acks from DT maintainers also?

Is there a way to get the attention of, say, BSD people, or should we
just presume they'll follow the list?

>> So the question is, is there such a community and a forum to bring up
>> this kind of things? If yes, should we bring this up there? If yes, wh=
at
>> kind of things in general should be brought into the attention of
>> non-linux users?
>=20
> devicetree list is just that. It is not just for Linux. There is the
> newly created devicetree-spec@vger.kernel.org which is for more
> core/common binding discussion.

Ok.

>> What I wonder here is that while a thing like DVI connector is, of
>> course, more generic than, say, "ti,tfp410" encoder chip, but isn't th=
e
>> case still the same: we're defining global bindings for hardware that
>> should work for everyone, not only Linux users?
>=20
> Defining the connectors in DT is a useful thing although mainly when
> you have multiple connectors of the same type. Labels for composite,
> SVideo, VGA, DVI, HDMI seem less useful to me. Describing position or
> printed label (like front vs. rear connections) seem more useful to
> me.

My point above was that it feels mentally easier to define bindings for
one particular IP block or chip, than defining bindings for a more
generic thing like "HDMI connector". But, in the end, I believe they
both should go through similar review, and there's no such difference.

As for the labels, they can be anything that makes sense for that
particular board. It can be "HDMI Front", if such makes sense, or
"HDMI-2" if the connector has such physical printed label. Or, say,
"Main LCD", "Secondary LCD". It's a free form text that is given to the
user.

 Tomi



--eET4CNQ3bBDUnx3QgaDsfXJpAXst4naJq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTHesaAAoJEPo9qoy8lh71R9MQAKdG8OcH5aml90jL66StavCl
qQ/yoBzyCF6Xcyt9ks0hCMCs5rb9/G9rgTd3oT+j48q1Cxa1t5AkHeDB05B999RO
QnrC2CNJxeS/R2tRBvjxH5ebkh1GabFVesgN5I3GMNOKJvtY8wgqDiK8tEPOMG6j
jrf31ML7HPnIuHcyRZbtlgMWrQlUSQaxzm9aJ6DG/AugGVquHhGyKk+6efMfbEAn
GUyGheyU7QjvlUZG40o0I8ETH8kBLQKD6Eq9Rtw9IhNfY/aFNhefvwWjxxKNlJhE
d6ESaKGYf2vFs4lxFR+lZY+iB5utrsD4hrFsAM2uqwbX+OBNALhazhAS374IKQsY
E1FXp1YI2+P8tP99omKW7KYyW4QK304KwNC4Av8twdoXwqhZhXaNQffT0fjoPVSI
hRSsEc/kQG2IUeoIRflCBRA8P01gDWGjJVO3+DvPD6NJRe5A+5CeFrq/SzND55wy
qmeixItVbGNrzPkiZW2izvcNgs4Jytypu+DJdsezWQz6oA+RzHKSLJUOy5fK/gaC
mn8RkAd9eFcsJe1HszvuQCmuypOvNC1hy+RYwoIbth3FzvAxbyOBPKx4nx53afz1
yf9T7LaPSQ0bqi+1JEO3+4eihxmEBiYKOWt6EYIPLpMyDug6cIk7gz++ZsXGLj5c
yR6IGKHq3Li+T5ypbUnA
=6AnV
-----END PGP SIGNATURE-----

--eET4CNQ3bBDUnx3QgaDsfXJpAXst4naJq--
