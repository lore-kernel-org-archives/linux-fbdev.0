From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 28 Nov 2011 11:12:37 +0000
Subject: Re: [PATCH v3 1/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <201111281212.37923.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314789501-824-1-git-send-email-laurent.pinchart@ideasonboard.com> <201111241150.38653.laurent.pinchart@ideasonboard.com> <4ED01224.9020703@gmx.de>
In-Reply-To: <4ED01224.9020703@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com

Hi Florian,

On Friday 25 November 2011 23:09:40 Florian Tobias Schandinat wrote:
> On 11/24/2011 10:50 AM, Laurent Pinchart wrote:
> > Hi Florian,
> >=20
> > Gentle ping ?
>=20
> Sorry, but I'm very busy at the moment and therefore time-consuming thing=
s,
> like solving challenging problems, are delayed for some time.

No worries.

> > On Sunday 20 November 2011 11:55:22 Laurent Pinchart wrote:
> >> On Sunday 20 November 2011 03:00:33 Florian Tobias Schandinat wrote:
> >>> Hi Laurent,
> >>>=20
> >>> On 08/31/2011 11:18 AM, Laurent Pinchart wrote:
> >>>> This API will be used to support YUV frame buffer formats in a
> >>>> standard way.
> >>>=20
> >>> looks like the union is causing problems. With this patch applied I g=
et
> >>>=20
> >>> errors like this:
> >>>   CC [M]  drivers/auxdisplay/cfag12864bfb.o
> >>>=20
> >>> drivers/auxdisplay/cfag12864bfb.c:57: error: unknown field =91red=92
> >>> specified in initializer
> >>=20
> >> *ouch*
> >>=20
> >> gcc < 4.6 chokes on anonymous unions initializers :-/
> >>=20
> >> [snip]
> >>=20
> >>>> @@ -246,12 +251,23 @@ struct fb_var_screeninfo {
> >>>>=20
> >>>>  	__u32 yoffset;			/* resolution			*/
> >>>>  =09
> >>>>  	__u32 bits_per_pixel;		/* guess what			*/
> >>>>=20
> >>>> -	__u32 grayscale;		/* !=3D 0 Graylevels instead of colors */
> >>>>=20
> >>>> -	struct fb_bitfield red;		/* bitfield in fb mem if true color, */
> >>>> -	struct fb_bitfield green;	/* else only length is significant */
> >>>> -	struct fb_bitfield blue;
> >>>> -	struct fb_bitfield transp;	/* transparency			*/
> >>>> +	union {
> >>>> +		struct {		/* Legacy format API		*/
> >>>> +			__u32 grayscale; /* 0 =3D color, 1 =3D grayscale	*/
> >>>> +			/* bitfields in fb mem if true color, else only */
> >>>> +			/* length is significant			*/
> >>>> +			struct fb_bitfield red;
> >>>> +			struct fb_bitfield green;
> >>>> +			struct fb_bitfield blue;
> >>>> +			struct fb_bitfield transp;	/* transparency	*/
> >>>> +		};
> >>>> +		struct {		/* FOURCC-based format API	*/
> >>>> +			__u32 fourcc;		/* FOURCC format	*/
> >>>> +			__u32 colorspace;
> >>>> +			__u32 reserved[11];
> >>>> +		} fourcc;
> >>>> +	};
> >>=20
> >> We can't name the union, otherwise this will change the userspace API.
> >>=20
> >> We could "fix" the problem on the kernel side with
> >>=20
> >> #ifdef __KERNEL__
> >>=20
> >> 	} color;
> >>=20
> >> #else
> >>=20
> >> 	};
> >>=20
> >> #endif
> >=20
> > (and the structure that contains the grayscale, red, green, blue and
> > transp fields would need to be similarly named, the "rgb" name comes to
> > mind)
>=20
> Which, I guess, would require modifying all drivers?

Unfortunately. That can be automated using coccinelle (I wrote a semantic=20
patch for that), but it will still be around 10k lines of diff.

> I don't consider that a good idea. Maybe the simplest solution would be to
> drop the union idea and just accept an utterly misleading name "grayscale"
> for setting the FOURCC value.

I'll see if we can add an accessor macro to make it more explicit.

> The colorspace could use one of the reserved fields at the end or do you
> worry that we need to add a lot of other things?

For FOURCC-based format configuration I don't think we will need much more.=
 If=20
we do need lots of additional fields in the future we might have to conside=
r=20
an fbdev2 API ;-)

I'll resubmit patches based on this.

--=20
Regards,

Laurent Pinchart
