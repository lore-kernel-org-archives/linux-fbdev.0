From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 15 Nov 2017 14:32:11 +0000
Subject: Re: [PATCH 1/3] backlight: as3711_bl: fix device-tree node lookup
Message-Id: <20171115143211.azfduwkxmzrhlcsd@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171113102049.9342-1-johan@kernel.org>
 <94c3debe-17f6-9151-eefe-129f2bd1cfd4@linaro.org>
 <20171114180514.GA11226@localhost>
 <ada29d80-4589-b419-cf9e-881bab227528@linaro.org>
 <20171115134903.GD11226@localhost>
In-Reply-To: <20171115134903.GD11226@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Johan Hovold <johan@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, stable <stable@vger.kernel.org>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Wed, 15 Nov 2017, Johan Hovold wrote:

> On Tue, Nov 14, 2017 at 07:48:09PM +0000, Daniel Thompson wrote:
> > On 14/11/17 18:05, Johan Hovold wrote:
> > > On Mon, Nov 13, 2017 at 02:16:09PM +0000, Daniel Thompson wrote:
> > >> On 13/11/17 10:20, Johan Hovold wrote:
> > >>> Fix child-node lookup during probe, which ended up searching the wh=
ole
> > >>> device tree depth-first starting at the parent rather than just mat=
ching
> > >>> on its children.
> > >>>
> > >>> To make things worse, the parent mfd node was also prematurely free=
d.
> > >>>
> > >>> Note that the nodes returned from the two calls to of_parse_phandle=
()
> > >>> are also leaking, but fixing that is a bit more involved as pointer=
s to
> > >>> node fields are being stored for later use.
> > >>
> > >> Is using a devm_kstrdup() to remember the full_name sufficient so get
> > >> each of the FIXMEs cleaned up as well?
> > >=20
> > > Yeah, that may be sufficient, but looking closer at this now, it seems
> > > the name pointers (su1_fb and su2_fb) are only used as booleans, and =
the
> > > fb_name pointer in struct as3711_bl_data is never used at all.
> > >=20
> > > So cleaning that up somehow (e.g. and maybe even dropping non-dt
> > > probing) would also work.
> > >=20
> > > But since this is a separate, and less critical issue, I think it nee=
ds
> > > to be done as a follow up to this one.
> >=20
> > To be honest it was adding the separate and less critical FIXMEs into=20
> > the patches that attracted my attention in the first place. ;-)
>=20
> Heh. Since I was touching those error paths, I at least wanted to record
> somehow there were further issues to be addressed. But feel free to drop
> the FIXMEs if you prefer.

In my experience FIXME's tend not to get addressed:

$ git grep -i fixme | wc -l
4431

Submit patches instead. :)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
