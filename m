From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 17 Oct 2013 11:59:41 +0000
Subject: Re: [RFR 2/2] drm/panel: Add simple panel support
Message-Id: <525FD12D.3000200@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="41ulDBLI4m32DMoHP6LnuIXMg3rLvULOV"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381947912-11741-1-git-send-email-treding@nvidia.com> <12566222.aRYc4MDoOm@avalon> <525FCB95.6070401@ti.com> <4885946.7Zgjf9zNXx@avalon>
In-Reply-To: <4885946.7Zgjf9zNXx@avalon>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--41ulDBLI4m32DMoHP6LnuIXMg3rLvULOV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 17/10/13 14:51, Laurent Pinchart wrote:

>> I'm not sure if there's a specific need for the port or endpoint nodes=

>> in cases like the above. Even if we have common properties describing
>> the endpoint, I guess they could just be in the parent node.
>>
>> panel {
>> 	remote =3D <&dc>;
>> 	common-video-property =3D <asd>;
>> };
>>
>> The above would imply one port and one endpoint. Would that work? If w=
e
>> had a function like parse_endpoint(node), we could just point it to
>> either a real endpoint node, or to the device's node.
>=20
> You reference the display controller here, not a specific display contr=
oller=20
> output. Don't most display controllers have several outputs ?

Sure. Then the display controller could have more verbose description.
But the panel could still have what I wrote above, except the 'remote'
property would point to a real endpoint node inside the dispc node, not
to the dispc node.

This would, of course, need some extra code to handle the different
cases, but just from DT point of view, I think all the relevant
information is there.

 Tomi



--41ulDBLI4m32DMoHP6LnuIXMg3rLvULOV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSX9EtAAoJEPo9qoy8lh7140wP/12y8ZO6o7deEyGzFhKXVlBw
pB4JIxEJU/Iz4dC9GW3itYM1QzhXcuinuIAETix2EqUU1/t6xkpAOhuKi2BNGHFb
vZBff0zlaQdhfaDvud4P40ZYR9weGyuJqeXgCpvRnfypvLQfxVXhT98PW0PkF30U
Pnh4kMwdNVXwFXtt2YAjpffm3jZRSA3e2UqDvDIHoefbvCjCgD7k9tw/aujgPBJx
lFQxZx35vN1I2xhKweAFjIwE3PIrA4Dn6p1VuDPZHtfcF9MGAHiJnaRAgSe2V7kT
g2CLM6NRfyLyxESmp7vKeq/KO0Bs3kQT9U7G7n4MFVB6DVGCe29O3pK/2sWQOMP1
lTTQkfaNq5vlpziAkwWz41ELW3OX7cKZ7XNCNlHsnSYrvDi3cYTXYl9asewSvleW
Iu5XURK+hWT/+PQER+qgmYth3Q45t0nU6BnKtwbh6MImjEdcVSLbjVkYGvqmap1q
GXm4B/wPnWDh8xNTEB/UYnmWq/Ezg8Hl9wUq7KTBMlceNkve9vqreNyyFNrsvrAl
lVo4OVNIR4BGEWZ4gg8dejrP3tqHPjYn2SiGuxMsWoDUtIhR614B4gZPHnPGxi4A
AO4Bk2BrK9DCewc5oYFXiF9fuMB2pUDKUVXQq3RoxSeQrju9bjusfZJCwVR/1xNL
fQedZKuSd+m/YrAT2VEv
=wNuO
-----END PGP SIGNATURE-----

--41ulDBLI4m32DMoHP6LnuIXMg3rLvULOV--
