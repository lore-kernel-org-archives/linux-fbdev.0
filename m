From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Wed, 30 Jul 2008 10:41:57 +0800
Message-ID: <f17812d70807291941u3617b2e8q3ba0422c1db15b2d@mail.gmail.com>
References: <1216534233-26674-1-git-send-email-jayakumar.lkml@gmail.com>
	<1216534233-26674-2-git-send-email-jayakumar.lkml@gmail.com>
	<20080721111159.GA18909@flint.arm.linux.org.uk>
	<45a44e480807210532w20495622ub36bd8a9722c2023@mail.gmail.com>
	<45a44e480807252030w9f542j4926005249dbf01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KO1dY-0002ax-UH for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 19:42:00 -0700
Received: from qw-out-1920.google.com ([74.125.92.150])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KO1dW-0007iz-Ek
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 19:42:00 -0700
Received: by qw-out-1920.google.com with SMTP id 5so204731qwc.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 29 Jul 2008 19:41:57 -0700 (PDT)
In-Reply-To: <45a44e480807252030w9f542j4926005249dbf01@mail.gmail.com>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, ymiao3@marvell.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk

On Sat, Jul 26, 2008 at 11:30 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
> On Mon, Jul 21, 2008 at 8:32 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> On Mon, Jul 21, 2008 at 7:11 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Sun, Jul 20, 2008 at 02:10:29AM -0400, Jaya Kumar wrote:
>>>
>>>> @@ -1357,6 +1379,8 @@ static void pxafb_decode_mode_info(struct pxafb_info *fbi,
>>>>               smemlen = modes[i].xres * modes[i].yres * modes[i].bpp / 8;
>>>>               if (smemlen > fbi->fb.fix.smem_len)
>>>>                       fbi->fb.fix.smem_len = smemlen;
>>>> +             if (inf->custom_xfer_div)
>>>> +                     fbi->fb.fix.smem_len /= inf->custom_xfer_div;
>>>
>>> I don't understand this.  If you have a 640x480 display with 8 bits of
>>> memory per pixel, then it's 307200 bytes no matter whether you're only
>>> using the lower 4 bits and the upper 4 are unused.
>>>
>>> If, on the other hand, the lower 4 bits contain one pixel and the upper
>>> 4 bits contain the other pixel, then you have a 4 bit per pixel
>>> framebuffer, so 'bpp' should be 4.  In which case the original calculation
>>> gives the correct answer.
>>>
>>
>> The complexity I faced is that the transfers used by Metronome on the
>> AMLCD bus have to be 16-bits wide although it is actually treating the
>> pixels as 8-bits per pixel and then only using the lower 4-bits within
>> that for actual content. So what I did in the code is set bits per
>> pixel, bpp to 16 so that pxafb sets the LCCR3_16BPP flag (so that it
>> meets Metronome's AMLCD transfer requirements) and then use the
>> custom_xfer_div to divide the transfer sizes and buffer allocations to
>> the correct size.
>>
>> If I set bpp to 8, the allocations and transfer sizes are correct but
>> then that causes pxafb to set LCCR3_8BPP and that causes Metronome to
>> fail to display anything.
>>
>> Instead of doing custom_xfer_div, I had thought about setting
>> pxafb_mach_info.lccr3 = LCCR3_16BPP to try to force the setting of
>> LCCR3_16BPP but then I saw:
>>
>> include/asm/arch-pxa/pxafb.h
>>         * The following should not be defined in LCCR3
>>         *      LCCR3_HSP, LCCR3_VSP, LCCR0_Pcd(x), LCCR3_Bpp
>>         */
>>        u_int           lccr3;
>>
>> so I decided to create custom_xfer_div instead. How about if I try a
>> different way like creating a separate flag that can be used to
>> predicate the lccr3 setting. Maybe something like:
>>
>> static int pxafb_bpp_to_lccr3(struct fb_var_screeninfo *var)
>> ...
>>        case 8:
>>               switch (inf->custom_amlcd_bpp) {
>>                case 16: ret = LCCR3_16BPP; break;
>>                default: ret = LCCR3_8BPP; break;
>>        case 16: ret = LCCR3_16BPP; break;
>>
>> Thanks,
>> jaya
>>
>
> I took a look at doing the above, ie: adjusting bpp instead of
> custom_xfer_size. I've realized that I would still need to adjust lccr
> in at least one other place:
>
>        fbi->reg_lccr1 =
>                LCCR1_DisWdth(var->xres) +
>
> I'll try to improve my explanation. :-)
>
> The reason for this is that metronome requires a different bus width
> (16 bit) for AMLCD transfers than it requires for its expected bits
> per pixel ( 8 bits). To get LCDC to use 16 bits on the AMLCD bus, we
> need to set 16bpp in LCCR3. So we then need to divide down the x
> resolution in LCCR1. Eg: 800 pixels at 8bpp is the framebuffer. We
> need 16-bit transfers so we set the desired pixels per line in LCCR to
> = 800 pixels / ( 16 custom bus bits / 8 bits per pixel ) = 400 pixels
> per line. So the code would be like:
>
> pix_per_line = var->xres / ( inf->custom_lccr_bpp / var->bits_per_pixel )
>
> I hope I was able to explain my reasoning for this above.
>

Sorry for the delay, I begin to understand the way this metronome is
working, so each transfer is 16-bit wide and contains two 8-bit pixels?

Then the most simple way is to treat this display as 16-bit, and
adjust the resolution parameters in the platform data with a nice
comment.

The problem of doing so is that:
1) framebuffer console cann't work anymore, and will show garbage
instead of showing the nice penguine logo

2) the framebuffer application has to be aware of this, and handles
the pixel format correctly.

Provided the fact of this weird organized pixel format, I don't see many
chances that X window or console can be run on top of this, but a
specialized application, no?

> Thanks,
> jaya
>
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
>



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
