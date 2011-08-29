From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 29 Aug 2011 14:32:06 +0000
Subject: Re: [PATCH/RFC v2 1/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <201108291632.06717.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313746626-23845-1-git-send-email-laurent.pinchart@ideasonboard.com> <201108291617.13236.laurent.pinchart@ideasonboard.com> <CAMuHMdV1mPFUWk_=6sB73hFiRXeXwgLGKzSQy=gZA0YuG0Fb3A@mail.gmail.com>
In-Reply-To: <CAMuHMdV1mPFUWk_=6sB73hFiRXeXwgLGKzSQy=gZA0YuG0Fb3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi Geert,

On Monday 29 August 2011 16:26:02 Geert Uytterhoeven wrote:
> On Mon, Aug 29, 2011 at 16:17, Laurent Pinchart wrote:
> > On Monday 29 August 2011 16:14:38 Geert Uytterhoeven wrote:
> >> On Mon, Aug 29, 2011 at 15:34, Laurent Pinchart wrote:
> >> > On Monday 29 August 2011 15:09:04 Geert Uytterhoeven wrote:
> >> >> On Mon, Aug 29, 2011 at 14:55, Laurent Pinchart wrote:
> >> >> >> When will the driver report FB_{TYPE,VISUAL}_FOURCC?
> >> >> >>   - When using a mode that cannot be represented in the legacy
> >> >> >> way,
> >> >> >=20
> >> >> > Definitely.
> >> >> >=20
> >> >> >>   - But what with modes that can be represented? Legacy software
> >> >> >> cannot handle FB_{TYPE,VISUAL}_FOURCC.
> >> >> >=20
> >> >> > My idea was to use FB_{TYPE,VISUAL}_FOURCC only when the mode is
> >> >> > configured using the FOURCC API. If FBIOPUT_VSCREENINFO is called
> >> >> > with a non-FOURCC format, the driver will report non-FOURCC types
> >> >> > and visuals.
> >> >>=20
> >> >> Hmm, two use cases:
> >> >>   - The video mode is configured using a FOURCC-aware tool ("fbset =
on
> >> >> steroids").
> >> >=20
> >> > Such as http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dsummary :-)
> >>=20
> >> Yep.
> >>=20
> >> >>     Later the user runs a legacy application.
> >> >>       =3D> Do not retain FOURCC across opening of /dev/fb*.
> >> >=20
> >> > I know about that problem, but it's not that easy to work around. We
> >> > have no per-open fixed and variable screen info, and FB devices can
> >> > be opened by multiple applications at the same time.
> >> >=20
> >> >>   - Is there an easy way to force FOURCC reporting, so new apps don=
't
> >> >> have to support parsing the legacy formats? This is useful for new
> >> >> apps that want to support (a subset of) FOURCC modes only.
> >> >=20
> >> > Not at the moment.
> >>=20
> >> So perhaps we do need new ioctls instead...
> >> That would also ease an in-kernel translation layer.
> >=20
> > Do you mean new ioctls to replace the FOURCC API proposal, or new ioctls
> > for the above two operations ?
>=20
> New ioctls to replace the FOURCC proposal.

*sigh*...

I'd like other people's opinion on this before throwing everything away.=20
Florian, Magnus, Guennadi, others, what do you think ?

--=20
Regards,

Laurent Pinchart
