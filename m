From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Aug 2011 14:26:02 +0000
Subject: Re: [PATCH/RFC v2 1/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <CAMuHMdV1mPFUWk_=6sB73hFiRXeXwgLGKzSQy=gZA0YuG0Fb3A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313746626-23845-1-git-send-email-laurent.pinchart@ideasonboard.com>
	<201108291534.35951.laurent.pinchart@ideasonboard.com>
	<CAMuHMdV=ZWMSJ_-r9fRMs0RCHyDZL=1a0_ZPZCgLBYJf=Ws4=Q@mail.gmail.com>
	<201108291617.13236.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201108291617.13236.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com

Hi Laurent,

On Mon, Aug 29, 2011 at 16:17, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 29 August 2011 16:14:38 Geert Uytterhoeven wrote:
>> On Mon, Aug 29, 2011 at 15:34, Laurent Pinchart wrote:
>> > On Monday 29 August 2011 15:09:04 Geert Uytterhoeven wrote:
>> >> On Mon, Aug 29, 2011 at 14:55, Laurent Pinchart wrote:
>> >> >> When will the driver report FB_{TYPE,VISUAL}_FOURCC?
>> >> >> =C2=A0 - When using a mode that cannot be represented in the legac=
y way,
>> >> >
>> >> > Definitely.
>> >> >
>> >> >> =C2=A0 - But what with modes that can be represented? Legacy softw=
are
>> >> >> cannot handle FB_{TYPE,VISUAL}_FOURCC.
>> >> >
>> >> > My idea was to use FB_{TYPE,VISUAL}_FOURCC only when the mode is
>> >> > configured using the FOURCC API. If FBIOPUT_VSCREENINFO is called w=
ith
>> >> > a non-FOURCC format, the driver will report non-FOURCC types and
>> >> > visuals.
>> >>
>> >> Hmm, two use cases:
>> >> =C2=A0 - The video mode is configured using a FOURCC-aware tool ("fbs=
et on
>> >> steroids").
>> >
>> > Such as http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dsummary :-)
>>
>> Yep.
>>
>> >> =C2=A0 =C2=A0 Later the user runs a legacy application.
>> >> =C2=A0 =C2=A0 =C2=A0 =3D> Do not retain FOURCC across opening of /dev=
/fb*.
>> >
>> > I know about that problem, but it's not that easy to work around. We h=
ave
>> > no per-open fixed and variable screen info, and FB devices can be open=
ed
>> > by multiple applications at the same time.
>> >
>> >> =C2=A0 - Is there an easy way to force FOURCC reporting, so new apps =
don't
>> >> have to support parsing the legacy formats? This is useful for new ap=
ps
>> >> that want to support (a subset of) FOURCC modes only.
>> >
>> > Not at the moment.
>>
>> So perhaps we do need new ioctls instead...
>> That would also ease an in-kernel translation layer.
>
> Do you mean new ioctls to replace the FOURCC API proposal, or new ioctls =
for
> the above two operations ?

New ioctls to replace the FOURCC proposal.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
