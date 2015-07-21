From: Ilia Mirkin <imirkin@alum.mit.edu>
Date: Tue, 21 Jul 2015 02:44:51 +0000
Subject: Re: likely signedness bug in drm and nvidia drivers
Message-Id: <CAKb7UvhLp=G6yH7MgivOPp9kDDdH2Y2q4v0YDjt8vHewLzzy=w@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87fv4io8ug.fsf@rasmusvillemoes.dk>
In-Reply-To: <87fv4io8ug.fsf@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-fbdev@vger.kernel.org, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Ben Skeggs <bskeggs@redhat.com>

I think you're right. The intent is to mask off the bits above
bits_per_pixel. So if bits_per_pixel is 24, the mask would be
0xff000000. If it's 16, then the mask would be 0xffff0000. If it's 32,
then the mask is 0.

In reality, bits_per_pixel is almost exclusively 32, which will end up
with a mask of 0 (note that the shift result is inverted at the end).
So for the majority case, there's not bug... just a useless operation.

I took a look at linux/bitops.h, and there's nothing particularly
great there. GENMASK, I guess, but it's not quite right. Just
switching to 0U should be fine there.

Now that I think about it, I believe these patches have already been
sent in the past. I also just did the grep that I did before:

$ git grep -- '~0 >>'
arch/m32r/include/asm/thread_info.h:    ti->flags = (ti->flags & (~0
>> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
arch/sh/include/asm/thread_info.h:      ti->flags = (ti->flags & (~0
>> (32 - TI_FLAG_FAULT_CODE_SHIFT)))
drivers/gpu/drm/nouveau/nv50_fbcon.c:   uint32_t mask = ~(~0 >> (32 -
info->var.bits_per_pixel));
drivers/gpu/drm/nouveau/nvc0_fbcon.c:   uint32_t mask = ~(~0 >> (32 -
info->var.bits_per_pixel));
drivers/video/fbdev/nvidia/nv_accel.c:  u32 fg, bg, mask = ~(~0 >> (32
- info->var.bits_per_pixel));

which shows that these are the only ones. See email with subject
"[PATCH] nvidia/noveau: Fix color mask" from June 17, 2015.

  -ilia

On Mon, Jul 20, 2015 at 4:46 PM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> Hi,
>
> The files
>
>   drivers/gpu/drm/nouveau/nv50_fbcon.c
>   drivers/gpu/drm/nouveau/nvc0_fbcon.c
>   drivers/video/fbdev/nvidia/nv_accel.c
>
> all contain a right-shift of ~0 (aka -1) - just grep for '~0 >>'. gcc
> always does arithmetic right shift of signed types, which means that the
> result is always -1 again [type promotion/conversion doesn't kick in
> until after the shift subexpression has been evaluated], independent of
> the second operand. I can hardly believe that is intended (the result is
> used as a mask, which thus consists of all 1s). If these are indeed
> bugs, the patch is obvious (just make the literal an unsigned 0).
>
> Rasmus
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
