From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 21 Oct 2010 14:08:20 +0000
Subject: Re: [PATCH] fbdev: add a function to parse further EDID Detailed
Message-Id: <Pine.LNX.4.64.1010211548410.7853@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
References: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

On Thu, 21 Oct 2010, Dave Airlie wrote:

> On Fri, Aug 20, 2010 at 5:23 PM, Erik Gilling <konkers@google.com> wrote:
> > Guennadi,
> > =A0 =A0Not sure how you're using the edid but you can get all 4 DTDs by
> > calling fb_edid_to_monspecs() then calling fb_videomode_to_var() on
> > each of the entries in monspecs.modedb. =A0This is still lacking as
> > modern monitors/tvs can have multiple EDID blocks. =A0My recent patch
> > [1] is a proposal for addressing that.
>=20
> If someone is really interested in fixing up the fbdev EDID parser
> they probably should look at sharing the drm EDID parser, its a lot
> more complete and came mostly from the EDID parser in the X server.

I might be overseeing something, but in next/master I don't see any code=20
to parse SVDs in DRM. Could someone, please, point me out to it, if it is=20
indeed implemented?

If it is not implemented - how would one do it? Do I understand it right,=20
that the precise timing for those modes should be copied from the=20
CEA/EIA-861E document?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
