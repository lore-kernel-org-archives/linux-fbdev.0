From: Tabi Timur-B04825 <B04825@freescale.com>
Date: Sat, 09 Jul 2011 19:37:16 +0000
Subject: Re: [PATCH] drivers/video: use strings to specify the Freescale DIU
Message-Id: <4E18ADEB.3000904@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310057466-14599-1-git-send-email-timur@freescale.com>
	<20110709163809.53f18fea@wker>
In-Reply-To: <20110709163809.53f18fea@wker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatolij Gustschin <agust@denx.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, Gala Kumar-B11780 <B11780@freescale.com>, "lethal@linux-sh.org" <lethal@linux-sh.org>, Tabi Timur-B04825 <B04825@freescale.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>

Anatolij Gustschin wrote:
>> >    	ad->pix_fmt >> >  -		diu_ops.get_pixel_format(var->bits_per_pixel,
>> >  -					 machine_data->monitor_port);
>> >  +		cpu_to_be32(diu_ops.get_pixel_format(machine_data->monitor_port,
>> >  +						     var->bits_per_pixel));

> I think you can drop cpu_to_be32 here, it is somehow confusing. The
> descriptor fields are LE32,

Not according to the structure definition:

struct diu_ad {
	/* Word 0(32-bit) in DDR memory */
/* 	__u16 comp; */
/* 	__u16 pixel_s:2; */
/* 	__u16 pallete:1; */
/* 	__u16 red_c:2; */
/* 	__u16 green_c:2; */
/* 	__u16 blue_c:2; */
/* 	__u16 alpha_c:3; */
/* 	__u16 byte_f:1; */
/* 	__u16 res0:3; */

	__be32 pix_fmt; /* hard coding pixel format */

I see other places where the endianness of pix_fmt is assumed.  I'll have 
to fix those later.

When I look at the 5121 and 1022 reference manuals, it says that the area 
descriptor is little-endian.  I think York made this register big-endian 
so that it matches the endianness of get_pixel_format(), which doesn't 
make much sense.  I'll have to fix the whole endianness thing with pix_fmt 
in another patch.

 > get_pixel_format() returns LE32 value.

I don't think the endianness of get_pixel_format() is fixed.  It's 
whatever the CPU native endiannes is.  That's why I added a cpu_to_be32().

Anyway, I'm not quite sure what the right answer is, but it seems obvious 
that cpu_to_be32() is wrong.  I'll post another patch which removes it.

-- 
Timur Tabi
Linux kernel developer at Freescale
