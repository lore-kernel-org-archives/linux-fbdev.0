From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 17:15:09 +0000
Subject: Re: [PATCH RFC 0/9] omapdrm/omapfb/omapdss split
Message-Id: <5669B31D.6000102@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JsmlUQFdlesPscD4uG3QXBIAUvBFdA7xQ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
 <CAF6AEGsCi_-YwQHYjfO_ao7Fg8QmQ=Gka1rG+OgkNqNaRsA5vw@mail.gmail.com>
 <CACvgo51Yezd4Rzcc8A1wrCUH4YX9gjhgpuYrt5dEPwhc=v03fA@mail.gmail.com>
In-Reply-To: <CACvgo51Yezd4Rzcc8A1wrCUH4YX9gjhgpuYrt5dEPwhc=v03fA@mail.gmail.com>
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

--JsmlUQFdlesPscD4uG3QXBIAUvBFdA7xQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 10/12/15 19:00, Emil Velikov wrote:
> On 10 December 2015 at 14:53, Rob Clark <robdclark@gmail.com> wrote:
>=20
>> It would be nice to see omapdrm eventually using the panel framework,
>> etc.  But I think copy/paste to decouple omapdrm from omapfb/vout as
>> the first step makes sense.
>>
> Moar panels/bridges :-P

I have a bunch more in my TI branch, which I have never upstreamed
because I haven't wanted to push too much into the omap specific
panel/encoder directory...

> But seriously, I think that this is the better idea, despite the
> duplication that'll exist in the first place. Otherwise you'll end up
> pulling your hairs out trying to balance everything drm and fbdev/vout
> working.
>=20
> A suggestion... do throw a big scary warning in the fbdev copy - "Here
> be dragons... old, mostly maintained code, bugfixes only please".
> Otherwise some poor soul might decide to port the drm patches back
> into the fbdev copy, or try to de-duplicate things :-)

The fbdev maintainer (me) will block any attempts to do so, but good
point, it doesn't harm to add a small README to the omapfb side.

 Tomi


--JsmlUQFdlesPscD4uG3QXBIAUvBFdA7xQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWabMdAAoJEPo9qoy8lh71Q/gQAKX+gv9e6SImUxqMq8tYg0dN
qNAE/hx3z6vAt7YGORBEEVZYpmwJERkpXefcOhSd04WBrqOqejLf9XfypH4iw7OT
iZj6mXnaJ8aUTrVDnRoYuu5LJFSCFZejgF3Gh3YKz69fK1t2t2N1OJwvpbZUVohN
406+Qzhto0fxHGCNxMd1u8S//VfsX7Rlecr5QW7BsuMrsS+g/7PJ6S9rwPktnBwW
D6LH3iqtAPbpFaHPvJF5PSzHMuZAGE4NQQ+zWwI++hlg/Ozk9dDdmClj9+ZN8WHD
CF8JMCd9W0yF47VvBxUqPIXCwgxvoMtZmP/sv8TXuYTnQYq1kq8GjSkwuWBCgfS9
1PQKNwFSUwxC40JMLDnNa21o2TZ98KnpD1gJkhlzact3xPeAjdd50syI10z3HeIn
eeIYt/7SF9XvGIXEw1T3oQzLA/hQ/llNuG5PdKuD9Vf/36DDKdynNBArbcByl1Ct
0ZrL80M3H5VRFREdGPmvsGAbss5Ln9rZASAqqS6dBbYwEzIlUwKwcBVuPSp6/oVv
oez9H4RV0WCFDgXijsbPIYMebeENiFjUq78ciGZqu7oUljFmOaX6b1Cnwf51Z1uN
hSAMSLOQDgDeryzc2DWpQmeyOXCOMkR7SzV39nMwvxXxDevokbl7FXIiIfQALvn1
TOTpFfrtfgpbppky/9Sa
=vpGW
-----END PGP SIGNATURE-----

--JsmlUQFdlesPscD4uG3QXBIAUvBFdA7xQ--
