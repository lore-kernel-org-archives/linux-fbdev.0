From: Alex Courbot <acourbot@nvidia.com>
Date: Fri, 24 May 2013 07:30:49 +0000
Subject: Re: [PATCH] video: simplefb: add mode parsing function
Message-Id: <519F1729.2050003@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369296231-26597-1-git-send-email-acourbot@nvidia.com>
 <519E438A.9030408@wwwdotorg.org>
In-Reply-To: <519E438A.9030408-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/24/2013 01:27 AM, Stephen Warren wrote:
>> Stephen, please note that the "r5g6b5" mode initially supported
>> by the driver becomes "b5g6r5" with the new function. This is because
>> the least significant bits are defined first in the string - this
>> makes parsing much easier, notably for modes which do not fill whole
>> bytes (e.g. 15 bit modes). I hope this is not a problem - it's probably
>> better to do the change now while the driver is still new.
>
> Hmm. searchin Google (and even looking at the VDPAU spec I myself wrote)
> does imply that format names like this do typically list the LSBs first.
>
> I guess the problem is that when I decided to change from rgb565 to a
> machine-parsable r5g6b5, I didn't think enough to realize that the field
> order in the name "rgb565" didn't follow the same convention as when you
> write out the fields in the style "r5g6b5"/"b5g6r5":-(
>
> I guess this driver and DT binding are only in linux-next and targeted
> at 3.11, and didn't make 3.10, so I'd assert it's probably still OK to
> change the DT binding, if this patch also gets into 3.11.

Great, keeping it like that then.

>> -- format: The format of the framebuffer surface. Valid values are:
>> -  - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
>> +- format: The format of the framebuffer surface. Described as a sequence of
>> +	channel/nbbits pairs, where each pair describes how many bits are used
>
> Change nbbits to bitcount, num-bits, nr-bits?

Ok.

>> +	by a given color channel. Value channels are "r" (red), "g" (green),
>> +	"b" (blue) and "a" (alpha).
>
> I think you'll need "x" too, to represent any gaps/unused bits.

Are there such formats? 15-bit formats do exist but AFAIK they just drop 
the MSB. Anyway, this can be done easily, so I won't argue. :)

>> Channels are listed starting in bit-significance order.
>
> I would explicitly add ", starting from the LSB." to the end there.
> Perhaps drop "-significance" too?

Agreed, sounds better.

>> +static struct simplefb_format *simplefb_parse_format(struct device *dev,
>> +						     const char *str)
>> +{
>> +	struct simplefb_format *format;
>> +	unsigned int cpt = 0;
>
> What does cpt mean? Something like bit or bitnum or bitindex might be
> more descriptive.

Fixed.

>> +	unsigned int i = 0;
>> +
>> +	format = devm_kzalloc(dev, sizeof(*format), GFP_KERNEL);
>> +	if (!format)
>> +		return ERR_PTR(-ENOMEM);
>
> Can we just add some storage into the FB object itself for this, so we
> don't need to make a special allocation? The first parameter to
> framebuffer_alloc() allows allocating that, although you would have to
> rejig the order of probe() a bit to do that:-( Perhaps it's fine as you
> wrote it.

The less allocations the better - if using framebuffer_alloc does not 
make things more confusing, I'll gladly use that solution.

>> +		field->offset = cpt;
>> +		field->length = c - '0';
>
> What about R10G10B10A2? Something like strtol() is needed here.

True. That's probably more color depth than humans can perceive, but 
will make the mantis shrimp happy.

>> +
>> +		cpt += field->length;
>> +	}
>> +
>> +	format->bits_per_pixel = ((cpt + 7) / 8) * 8;
>
> Should this error-check that isn't > 32?

That would make the mantis shrimp sad.

>> +	if (!params->format || IS_ERR(params->format)) {
>
> That's just saying IS_ERR_OR_NULL(params->format). It'd be better to
> pick one thing to represent errors; either NULL or an error-pointer. I
> think having simplefb_parse_format() just return NULL on error would be
> best; the caller can't really do anything useful with the information
> anyway.

Weird - I actually removed that NULL check since the parse function can 
only return a valid pointed an error code. Probably forgot to 
format-patch again after that.

It seems more customary to let the function that fails decide the error 
code and have it propagated by its caller (even though in the current 
case there is no much variety in the returned error codes). If you see 
no problem with it, I will stick to that way of doing.

Thanks for the review - will send an update soon.
Alex.


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
