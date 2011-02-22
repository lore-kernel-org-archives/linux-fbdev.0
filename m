From: Damian <dhobsong@igel.co.jp>
Date: Tue, 22 Feb 2011 02:34:52 +0000
Subject: Re: [PATCH 1/1] sh_mobile_lcdc: Add NV12 input framebuffer support
Message-Id: <4D6320CC.30309@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297734708-20803-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1297734708-20803-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 2011/02/17 14:45, Damian wrote:
Hi again Magnus,
> On 2011/02/17 9:19, Magnus Damm wrote:
> Hi Magnus,
>> Hi Damian,
>>
>> On Tue, Feb 15, 2011 at 10:51 AM, Damian Hobson-Garcia
>> <dhobsong@igel.co.jp> wrote:
>>> Specify .bpp = 12 and .yuv = 1 when configuring the LCDC channel that
>>> you want
>>> to you with NV12 input support.
>>>
>>> Due to the encoding of YUV data, writing 0s to the framebuffer will
>>> clear to
>>> green instead of black.
>>>
>>> There is also no native framebuffer support for YUV formats,
>>> so this mode will not work with most software rendering.
>>>
>>> Signed-off-by: Damian Hobson-Garcia<dhobsong@igel.co.jp>
>>> ---
>>
>> Nice to see patches for YUV mode support!
> And thank you for your comments.
>>
>>> --- a/include/video/sh_mobile_lcdc.h
>>> +++ b/include/video/sh_mobile_lcdc.h
>>> @@ -25,6 +25,8 @@ enum {
>>> SYS24, /* 24bpp */
>>> };
>>>
>>> +#define REN_COLOR_NV12 0x1 /* Non-standard framebuffer color format
>>> - NV12 */
>>> +
>>> enum { LCDC_CHAN_DISABLED = 0,
>>> LCDC_CHAN_MAINLCD,
>>> LCDC_CHAN_SUBLCD };
>>> @@ -77,6 +79,7 @@ struct sh_mobile_lcdc_chan_cfg {
>>> struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
>>> struct sh_mobile_lcdc_board_cfg board_cfg;
>>> struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
>>> + int yuv;
>>
>> Instead of having "yuv" here I think you should use "nonstd" and make
>> sure the "nonstd" field in struct fb_var_screeninfo is set the same
>> way.
>>
>> Also, the REN_COLOR_NV12 constant can go away IMO.
> Yes, I guess that using the nonstd together with the bits_per_pixel,
> REN_COLOR_NV12 is unnecessary.
>>
>> I believe the best way to deal with this is to map the "nonstd" value
>> directly to bit 16-18 in LDDFR. If "nonstd" is non-zero then you
>> should program bits 8-9 depending on the bpp value. This way both 12,
>> 16 and 20 (?) bit YUV can be supported with compression enabled or
>> not. I believe both sh7724 and sh7372 can be supported too - given
>> that the correct "nonstd" value is provided. But since it's provided
>> by the platform data it is part of the system configuration and we can
>> assume it is correct.

One question/comment about setting the value of nonstd.
Ideally, when an application reads the nonstd field from 
fb_var_screeninfo, it would need to be sure that the value corresponds 
to a YUV setting instead of some other valid non-zero nonstd value, 
right? So maybe defining a bitmask for the YUV bit somewhere accessible 
from user space would be beneficial (perhaps a new file, 
linux/sh_mobile_fb.h, which might also be a good place to define any 
ioctls that might be used in future, for blending for example).
It seems that for both sh7372 and sh7724 that bit would be bit 16 in 
LDDFR, which is nice. As for the remaining bits, which are chip 
dependent, I was thinking that it would be good to define similar 
mask/flags and "or" them all together to build up nonstd.  The question 
is where to define these.  There are separate files for mach/sh7724.h 
and mach/sh7372.h, which I though might fit nicely or would it be better 
to define flags for both chips in video/sh_mobile_lcdc.h?

> Sounds good. By 20 bit are you referring to the YCbCr 4:4:4 mode? I
> haven't really looked at that but it sounds like it should work. I think
> that its a 24 bit mode though, if I understand correctly 8 bits each for
> Y, Cb, Cr.
>>
>> Please consider reworking the patch to make it more generic. Just
>> adding NV12 support is aiming too low. =)
>>
> I'm also looking at re-arranging the arrangement of the Y and CbCr
> planes so that in a double buffer (or more) situation all of the Y
> planes come first, followed by the CbCr planes, as it makes the panning
> calculations much simpler.
>
> I'll submit these all as a version 2 of this patch.
>> Thanks,
>>
>> / magnus
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html

Thanks,
-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
