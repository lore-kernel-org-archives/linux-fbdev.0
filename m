From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 02 Jul 2010 13:29:24 +0000
Subject: RE: [PATCH v3 05/12] s3c-fb: Add support for display panning
Message-Id: <003e01cb19ea$969e0090$c3da01b0$%osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277712538-23188-1-git-send-email-p.osciak@samsung.com>
	<1277712538-23188-6-git-send-email-p.osciak@samsung.com>
	<4C2DCC5B.2000100@simtec.co.uk>
In-Reply-To: <4C2DCC5B.2000100@simtec.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

>Ben Dooks <ben@simtec.co.uk> wrote:
>On 28/06/10 09:08, Pawel Osciak wrote:

>> diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-
>samsung/include/plat/regs-fb.h
>> index ac10013..f454e32 100644
>> --- a/arch/arm/plat-samsung/include/plat/regs-fb.h
>> +++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
>> @@ -112,6 +112,11 @@
>>  #define VIDCON2_ORGYCbCr			(1 << 8)
>>  #define VIDCON2_YUVORDCrCb			(1 << 7)
>>
>> +/* PRTCON (S3C6410, S5PC100) */
>
>Not listed in my S3C6410 manual?
>

Not in my either. It is there in the S5PC100 docs though. This is not an
"official statement", but I've been testing panning on my 6410 *very*
intensively and experienced a lot of crashes without it. Not a single one
with it though. So it's either almost impossible luck or it is there,
undocumented. There is a hole at this address anyway, so this shouldn't
hurt anything.

>> @@ -735,6 +741,66 @@ static int s3c_fb_blank(int blank_mode, struct fb_info
>*info)
>>  	return 0;
>>  }
>>
>> +/**
>> + * s3c_fb_pan_display() - Pan the display.
>> + *
>> + * Note that the offsets can be written to the device at any time, as
>their
>> + * values are latched at each vsync automatically. This also means that
>only
>> + * the last call to this function will have any effect on next vsync, but
>> + * there is no need to sleep waiting for it to prevent tearing.
>> + *
>> + * @var: The screen information to verify.
>> + * @info: The framebuffer device.
>> + */
>> +static int s3c_fb_pan_display(struct fb_var_screeninfo *var,
>> +			      struct fb_info *info)
>> +{
>> +	struct s3c_fb_win *win	= info->par;
>> +	struct s3c_fb *sfb	= win->parent;
>> +	void __iomem *buf	= sfb->regs + win->index * 8;
>> +	unsigned int start_byte_offset, end_byte_offset;
>
>could have shortened to start and end, might have made some of the
>calculation easier.
>

Ok, will fix.

>> +	/* Offset in bytes to the start of the displayed area */
>> +	start_byte_offset = var->yoffset * info->fix.line_length;
>> +	/* X offset depends on the current bpp */
>> +	if (info->var.bits_per_pixel >= 8) {
>> +		start_byte_offset +>> +			var->xoffset * (info->var.bits_per_pixel >> 3);
>> +	} else {
>> +		switch (info->var.bits_per_pixel) {
>> +		case 4:
>> +			start_byte_offset += var->xoffset >> 1;
>> +			break;
>> +		case 2:
>> +			start_byte_offset += var->xoffset >> 2;
>> +			break;
>> +		case 1:
>> +			start_byte_offset += var->xoffset >> 3;
>> +			break;
>> +		default:
>> +			dev_err(sfb->dev, "invalid bpp\n");
>> +			return -EINVAL;
>> +		}
>> +	}
>
>this could have been done by changing it to
>start_byte_offset += var->xoffset / (8 / info->var.bits_per_pixel);
>

Good point, although I wanted to have no division here... Whichever you
prefer then...

>note, you always set pan step to 1, evne if the case of bpp less than 8.
>

Hmm... so I guess I should be changing xpanstep on bpp switch in fb_set_par
if needed?


Best regards
--
Pawel Osciak
Linux Platform Group
Samsung Poland R&D Center





