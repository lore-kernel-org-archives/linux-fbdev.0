From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 24 Nov 2011 10:50:36 +0000
Subject: Re: [PATCH v3 1/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <201111241150.38653.laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314789501-824-1-git-send-email-laurent.pinchart@ideasonboard.com> <4EC85F41.50100@gmx.de> <201111201155.22948.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201111201155.22948.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com

Hi Florian,

Gentle ping ?

On Sunday 20 November 2011 11:55:22 Laurent Pinchart wrote:
> On Sunday 20 November 2011 03:00:33 Florian Tobias Schandinat wrote:
> > Hi Laurent,
> >=20
> > On 08/31/2011 11:18 AM, Laurent Pinchart wrote:
> > > This API will be used to support YUV frame buffer formats in a standa=
rd
> > > way.
> >=20
> > looks like the union is causing problems. With this patch applied I get
> >=20
> > errors like this:
> >   CC [M]  drivers/auxdisplay/cfag12864bfb.o
> >=20
> > drivers/auxdisplay/cfag12864bfb.c:57: error: unknown field =91red=92
> > specified in initializer
>=20
> *ouch*
>=20
> gcc < 4.6 chokes on anonymous unions initializers :-/
>=20
> [snip]
>=20
> > > @@ -246,12 +251,23 @@ struct fb_var_screeninfo {
> > >=20
> > >  	__u32 yoffset;			/* resolution			*/
> > >  =09
> > >  	__u32 bits_per_pixel;		/* guess what			*/
> > >=20
> > > -	__u32 grayscale;		/* !=3D 0 Graylevels instead of colors */
> > >=20
> > > -	struct fb_bitfield red;		/* bitfield in fb mem if true color, */
> > > -	struct fb_bitfield green;	/* else only length is significant */
> > > -	struct fb_bitfield blue;
> > > -	struct fb_bitfield transp;	/* transparency			*/
> > > +	union {
> > > +		struct {		/* Legacy format API		*/
> > > +			__u32 grayscale; /* 0 =3D color, 1 =3D grayscale	*/
> > > +			/* bitfields in fb mem if true color, else only */
> > > +			/* length is significant			*/
> > > +			struct fb_bitfield red;
> > > +			struct fb_bitfield green;
> > > +			struct fb_bitfield blue;
> > > +			struct fb_bitfield transp;	/* transparency	*/
> > > +		};
> > > +		struct {		/* FOURCC-based format API	*/
> > > +			__u32 fourcc;		/* FOURCC format	*/
> > > +			__u32 colorspace;
> > > +			__u32 reserved[11];
> > > +		} fourcc;
> > > +	};
>=20
> We can't name the union, otherwise this will change the userspace API.
>=20
> We could "fix" the problem on the kernel side with
>=20
> #ifdef __KERNEL__
> 	} color;
> #else
> 	};
> #endif

(and the structure that contains the grayscale, red, green, blue and transp=
=20
fields would need to be similarly named, the "rgb" name comes to mind)

> That's quite hackish though... What's your opinion ?
>=20
> It would also not handle userspace code that initializes an
> fb_var_screeninfo structure with named initializers, but that shouldn't
> happen, as application should read fb_var_screeninfo , modify it and write
> it back.
>=20
> > >  	__u32 nonstd;			/* !=3D 0 Non standard pixel format */

--=20
Regards,

Laurent Pinchart
