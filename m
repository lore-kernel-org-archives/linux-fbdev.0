From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 21 Jul 2015 08:56:07 +0000
Subject: Re: likely signedness bug in drm and nvidia drivers
Message-Id: <55AE0927.1060604@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87fv4io8ug.fsf@rasmusvillemoes.dk>
 <CAKb7UvhLp=G6yH7MgivOPp9kDDdH2Y2q4v0YDjt8vHewLzzy=w@mail.gmail.com>
In-Reply-To: <CAKb7UvhLp=G6yH7MgivOPp9kDDdH2Y2q4v0YDjt8vHewLzzy=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ilia Mirkin <imirkin@alum.mit.edu>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>

On 21/07/15 03:44, Ilia Mirkin wrote:
 > I think you're right. The intent is to mask off the bits above> 
bits_per_pixel. So if bits_per_pixel is 24, the mask would be> 
0xff000000. If it's 16, then the mask would be 0xffff0000. If it's 32,> 
then the mask is 0.> > In reality, bits_per_pixel is almost exclusively 
32, which will end up> with a mask of 0 (note that the shift result is 
inverted at the end).> So for the majority case, there's not bug... just 
a useless operation.> > I took a look at linux/bitops.h, and there's 
nothing particularly> great there. GENMASK, I guess, but it's not quite 
right. Just> switching to 0U should be fine there.
I really don't see GENMASK() isn't quite right.

Try:

uint32_t mask = GENMASK(32, info->var.bits_per_pixel);

Versus:

uint32_t mask = ~(~0u >> (32 - info->var.bits_per_pixel));

For me, the GENMASK() is obvious whilst the later takes a good bit of 
mental decoding.


Daniel.
