From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Mon, 29 Aug 2011 16:41:03 +0000
Subject: Re: [PATCH/RFC v2 1/3] fbdev: Add FOURCC-based format configuration
Message-Id: <4E5BC11F.7000704@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1313746626-23845-1-git-send-email-laurent.pinchart@ideasonboard.com> <201108291617.13236.laurent.pinchart@ideasonboard.com> <CAMuHMdV1mPFUWk_=6sB73hFiRXeXwgLGKzSQy=gZA0YuG0Fb3A@mail.gmail.com> <201108291632.06717.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201108291632.06717.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi,

On 08/29/2011 02:32 PM, Laurent Pinchart wrote:
> Hi Geert,
>=20
> On Monday 29 August 2011 16:26:02 Geert Uytterhoeven wrote:
>> On Mon, Aug 29, 2011 at 16:17, Laurent Pinchart wrote:
>>> On Monday 29 August 2011 16:14:38 Geert Uytterhoeven wrote:
>>>> On Mon, Aug 29, 2011 at 15:34, Laurent Pinchart wrote:
>>>>> On Monday 29 August 2011 15:09:04 Geert Uytterhoeven wrote:
>>>>>> On Mon, Aug 29, 2011 at 14:55, Laurent Pinchart wrote:
>>>>>>>> When will the driver report FB_{TYPE,VISUAL}_FOURCC?
>>>>>>>>   - When using a mode that cannot be represented in the legacy
>>>>>>>> way,
>>>>>>>
>>>>>>> Definitely.
>>>>>>>
>>>>>>>>   - But what with modes that can be represented? Legacy software
>>>>>>>> cannot handle FB_{TYPE,VISUAL}_FOURCC.
>>>>>>>
>>>>>>> My idea was to use FB_{TYPE,VISUAL}_FOURCC only when the mode is
>>>>>>> configured using the FOURCC API. If FBIOPUT_VSCREENINFO is called
>>>>>>> with a non-FOURCC format, the driver will report non-FOURCC types
>>>>>>> and visuals.
>>>>>>
>>>>>> Hmm, two use cases:
>>>>>>   - The video mode is configured using a FOURCC-aware tool ("fbset on
>>>>>> steroids").
>>>>>
>>>>> Such as http://git.ideasonboard.org/?p=FBdev-test.git;a=3Dsummary :-)
>>>>
>>>> Yep.
>>>>
>>>>>>     Later the user runs a legacy application.
>>>>>>       =3D> Do not retain FOURCC across opening of /dev/fb*.
>>>>>
>>>>> I know about that problem, but it's not that easy to work around. We
>>>>> have no per-open fixed and variable screen info, and FB devices can
>>>>> be opened by multiple applications at the same time.
>>>>>
>>>>>>   - Is there an easy way to force FOURCC reporting, so new apps don't
>>>>>> have to support parsing the legacy formats? This is useful for new
>>>>>> apps that want to support (a subset of) FOURCC modes only.
>>>>>
>>>>> Not at the moment.
>>>>
>>>> So perhaps we do need new ioctls instead...
>>>> That would also ease an in-kernel translation layer.
>>>
>>> Do you mean new ioctls to replace the FOURCC API proposal, or new ioctls
>>> for the above two operations ?
>>
>> New ioctls to replace the FOURCC proposal.
>=20
> *sigh*...
>=20
> I'd like other people's opinion on this before throwing everything away. =

> Florian, Magnus, Guennadi, others, what do you think ?
>=20

So, your issue is that some formats can be represented in the new and the o=
ld way?
There are 2 simpler solutions I can think of:

(1) ignore it, just do it the way Laurent proposed. I understand that someo=
ne
might feel uneasy about applications that are trapped because they don't kn=
ow
the new format but could work with the old one. But I think this is not a b=
ig
issue as many applications will just try to set their own mode. For those t=
hat
doesn't and rely on the previous mode that is set by fbset or similar, we c=
ould
change fbset to prefer the old format if available. But even if we don't do
this, I don't have a problem with a program failing because it sees an
unsuitable mode even if it supports the legacy mode. It's not a regression =
and
can be easily fixed in userspace.

(2) forbid it, just allow drivers to implement FOURCC for formats that cann=
ot be
represented in the old scheme. This is my preferred solution if anyone has
problems with (1).

I don't see how IOCTLs would help here. The pixel format just belongs into =
var
and fix so it has to be represented there anyway and thus set through it. We
could do an IOCTL that always returns the FOURCC active at the moment, if s=
uch a
FOURCC exists, and always use the legacy API for representing it in var/fix=
, if
it exists. But as I see this is not what you thought about so please explain
what your IOCTLS would look like and how they would solve the problem.

And I don't think a in-kernel translation layer is a good idea. Yes, it sou=
nds
interesting, but it's tricky and the result will be that the driver and
userspace will permanently see different var and fix structures. Seriously I
think changing every framebuffer driver out there would be easier and much =
saner
than trying to implement such a thing.


Best regards,

Florian Tobias Schandinat
