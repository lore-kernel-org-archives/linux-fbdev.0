From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 25 Nov 2011 22:09:40 +0000
Subject: Re: [PATCH v3 1/3] fbdev: Add FOURCC-based format configuration API
Message-Id: <4ED01224.9020703@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314789501-824-1-git-send-email-laurent.pinchart@ideasonboard.com> <4EC85F41.50100@gmx.de> <201111201155.22948.laurent.pinchart@ideasonboard.com> <201111241150.38653.laurent.pinchart@ideasonboard.com>
In-Reply-To: <201111241150.38653.laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, linux-media@vger.kernel.org, magnus.damm@gmail.com

Hi Laurent,

On 11/24/2011 10:50 AM, Laurent Pinchart wrote:
> Hi Florian,
>=20
> Gentle ping ?

Sorry, but I'm very busy at the moment and therefore time-consuming things,=
 like
solving challenging problems, are delayed for some time.

>=20
> On Sunday 20 November 2011 11:55:22 Laurent Pinchart wrote:
>> On Sunday 20 November 2011 03:00:33 Florian Tobias Schandinat wrote:
>>> Hi Laurent,
>>>
>>> On 08/31/2011 11:18 AM, Laurent Pinchart wrote:
>>>> This API will be used to support YUV frame buffer formats in a standard
>>>> way.
>>>
>>> looks like the union is causing problems. With this patch applied I get
>>>
>>> errors like this:
>>>   CC [M]  drivers/auxdisplay/cfag12864bfb.o
>>>
>>> drivers/auxdisplay/cfag12864bfb.c:57: error: unknown field =91red=92
>>> specified in initializer
>>
>> *ouch*
>>
>> gcc < 4.6 chokes on anonymous unions initializers :-/
>>
>> [snip]
>>
>>>> @@ -246,12 +251,23 @@ struct fb_var_screeninfo {
>>>>
>>>>  	__u32 yoffset;			/* resolution			*/
>>>>  =09
>>>>  	__u32 bits_per_pixel;		/* guess what			*/
>>>>
>>>> -	__u32 grayscale;		/* !=3D 0 Graylevels instead of colors */
>>>>
>>>> -	struct fb_bitfield red;		/* bitfield in fb mem if true color, */
>>>> -	struct fb_bitfield green;	/* else only length is significant */
>>>> -	struct fb_bitfield blue;
>>>> -	struct fb_bitfield transp;	/* transparency			*/
>>>> +	union {
>>>> +		struct {		/* Legacy format API		*/
>>>> +			__u32 grayscale; /* 0 =3D color, 1 =3D grayscale	*/
>>>> +			/* bitfields in fb mem if true color, else only */
>>>> +			/* length is significant			*/
>>>> +			struct fb_bitfield red;
>>>> +			struct fb_bitfield green;
>>>> +			struct fb_bitfield blue;
>>>> +			struct fb_bitfield transp;	/* transparency	*/
>>>> +		};
>>>> +		struct {		/* FOURCC-based format API	*/
>>>> +			__u32 fourcc;		/* FOURCC format	*/
>>>> +			__u32 colorspace;
>>>> +			__u32 reserved[11];
>>>> +		} fourcc;
>>>> +	};
>>
>> We can't name the union, otherwise this will change the userspace API.
>>
>> We could "fix" the problem on the kernel side with
>>
>> #ifdef __KERNEL__
>> 	} color;
>> #else
>> 	};
>> #endif
>=20
> (and the structure that contains the grayscale, red, green, blue and tran=
sp=20
> fields would need to be similarly named, the "rgb" name comes to mind)

Which, I guess, would require modifying all drivers?
I don't consider that a good idea. Maybe the simplest solution would be to =
drop
the union idea and just accept an utterly misleading name "grayscale" for
setting the FOURCC value. The colorspace could use one of the reserved fiel=
ds at
the end or do you worry that we need to add a lot of other things?


Best regards,

Florian Tobias Schandinat

>=20
>> That's quite hackish though... What's your opinion ?
>>
>> It would also not handle userspace code that initializes an
>> fb_var_screeninfo structure with named initializers, but that shouldn't
>> happen, as application should read fb_var_screeninfo , modify it and wri=
te
>> it back.
>>
>>>>  	__u32 nonstd;			/* !=3D 0 Non standard pixel format */
>=20

