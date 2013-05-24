From: Stephen Warren <swarren@wwwdotorg.org>
Date: Fri, 24 May 2013 15:37:42 +0000
Subject: Re: [PATCH] video: simplefb: add mode parsing function
Message-Id: <519F8946.4050705@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1369296231-26597-1-git-send-email-acourbot@nvidia.com>
 <519E438A.9030408@wwwdotorg.org> <519F1729.2050003@nvidia.com>
In-Reply-To: <519F1729.2050003-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 05/24/2013 01:30 AM, Alex Courbot wrote:
> On 05/24/2013 01:27 AM, Stephen Warren wrote:
>>> Stephen, please note that the "r5g6b5" mode initially supported
>>> by the driver becomes "b5g6r5" with the new function. This is because
>>> the least significant bits are defined first in the string - this
>>> makes parsing much easier, notably for modes which do not fill whole
>>> bytes (e.g. 15 bit modes). I hope this is not a problem - it's probably
>>> better to do the change now while the driver is still new.
...
>>> +    by a given color channel. Value channels are "r" (red), "g"
>>> (green),
>>> +    "b" (blue) and "a" (alpha).
>>
>> I think you'll need "x" too, to represent any gaps/unused bits.
> 
> Are there such formats? 15-bit formats do exist but AFAIK they just drop
> the MSB. Anyway, this can be done easily, so I won't argue. :)

Yes, I believe there are e.g. both a2r10g10b10 and b10g10r10a2 for
example, and it's quite common to replace a with x, especially for
scanout buffers. Google certainly has hits for that.

>>> +    if (!params->format || IS_ERR(params->format)) {
>>
>> That's just saying IS_ERR_OR_NULL(params->format). It'd be better to
>> pick one thing to represent errors; either NULL or an error-pointer. I
>> think having simplefb_parse_format() just return NULL on error would be
>> best; the caller can't really do anything useful with the information
>> anyway.
> 
> Weird - I actually removed that NULL check since the parse function can
> only return a valid pointed an error code. Probably forgot to
> format-patch again after that.
> 
> It seems more customary to let the function that fails decide the error
> code and have it propagated by its caller (even though in the current
> case there is no much variety in the returned error codes). If you see
> no problem with it, I will stick to that way of doing.

Using just an error-return is probably fine. I was going to say that the
table lookup might propagate a NULL all the way through to that check,
and hence require both checks above, but I guess that case can't happen,
since if there is no table entry, then simplefb_parse_format() will
always be called, so that's fine.
