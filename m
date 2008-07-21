From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Mon, 21 Jul 2008 08:32:45 -0400
Message-ID: <45a44e480807210532w20495622ub36bd8a9722c2023@mail.gmail.com>
References: <1216534233-26674-1-git-send-email-jayakumar.lkml@gmail.com>
	<1216534233-26674-2-git-send-email-jayakumar.lkml@gmail.com>
	<20080721111159.GA18909@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKuZM-0004FZ-Pu for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 05:32:48 -0700
Received: from nf-out-0910.google.com ([64.233.182.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KKuZL-0007tJ-51
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 05:32:48 -0700
Received: by nf-out-0910.google.com with SMTP id g16so376224nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 21 Jul 2008 05:32:45 -0700 (PDT)
In-Reply-To: <20080721111159.GA18909@flint.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Mon, Jul 21, 2008 at 7:11 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jul 20, 2008 at 02:10:29AM -0400, Jaya Kumar wrote:
>>       if (fbi->map_cpu) {
>>               /* prevent initial garbage on screen */
>>               memset(fbi->map_cpu, 0, fbi->map_size);
>> -             fbi->fb.screen_base = fbi->map_cpu + fbi->video_offset;
>> +             fbi->fb.screen_base = (char __force __iomem *) fbi->map_cpu
>> +                                     + fbi->video_offset;
>
> I'm not sure this has any benefits - the use of __force in drivers is
> definitely frowned upon.
>
> It's well known that FB doesn't sit well with all the MMIO sparse checking
> so it's probably a good idea not to try and make it work.

Ok, I'll take it out. My intentions were to avoid causing any new
sparse warnings.

>
>> @@ -1357,6 +1379,8 @@ static void pxafb_decode_mode_info(struct pxafb_info *fbi,
>>               smemlen = modes[i].xres * modes[i].yres * modes[i].bpp / 8;
>>               if (smemlen > fbi->fb.fix.smem_len)
>>                       fbi->fb.fix.smem_len = smemlen;
>> +             if (inf->custom_xfer_div)
>> +                     fbi->fb.fix.smem_len /= inf->custom_xfer_div;
>
> I don't understand this.  If you have a 640x480 display with 8 bits of
> memory per pixel, then it's 307200 bytes no matter whether you're only
> using the lower 4 bits and the upper 4 are unused.
>
> If, on the other hand, the lower 4 bits contain one pixel and the upper
> 4 bits contain the other pixel, then you have a 4 bit per pixel
> framebuffer, so 'bpp' should be 4.  In which case the original calculation
> gives the correct answer.
>

The complexity I faced is that the transfers used by Metronome on the
AMLCD bus have to be 16-bits wide although it is actually treating the
pixels as 8-bits per pixel and then only using the lower 4-bits within
that for actual content. So what I did in the code is set bits per
pixel, bpp to 16 so that pxafb sets the LCCR3_16BPP flag (so that it
meets Metronome's AMLCD transfer requirements) and then use the
custom_xfer_div to divide the transfer sizes and buffer allocations to
the correct size.

If I set bpp to 8, the allocations and transfer sizes are correct but
then that causes pxafb to set LCCR3_8BPP and that causes Metronome to
fail to display anything.

Instead of doing custom_xfer_div, I had thought about setting
pxafb_mach_info.lccr3 = LCCR3_16BPP to try to force the setting of
LCCR3_16BPP but then I saw:

include/asm/arch-pxa/pxafb.h
         * The following should not be defined in LCCR3
         *      LCCR3_HSP, LCCR3_VSP, LCCR0_Pcd(x), LCCR3_Bpp
         */
        u_int           lccr3;

so I decided to create custom_xfer_div instead. How about if I try a
different way like creating a separate flag that can be used to
predicate the lccr3 setting. Maybe something like:

static int pxafb_bpp_to_lccr3(struct fb_var_screeninfo *var)
...
        case 8:
               switch (inf->custom_amlcd_bpp) {
                case 16: ret = LCCR3_16BPP; break;
                default: ret = LCCR3_8BPP; break;
        case 16: ret = LCCR3_16BPP; break;

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
