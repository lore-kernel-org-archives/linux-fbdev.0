From: Damian <dhobsong@igel.co.jp>
Date: Thu, 17 Feb 2011 05:45:48 +0000
Subject: Re: [PATCH 1/1] sh_mobile_lcdc: Add NV12 input framebuffer support
Message-Id: <4D5CB60C.30507@igel.co.jp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1297734708-20803-2-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1297734708-20803-2-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 2011/02/17 9:19, Magnus Damm wrote:
Hi Magnus,
> Hi Damian,
>
> On Tue, Feb 15, 2011 at 10:51 AM, Damian Hobson-Garcia
> <dhobsong@igel.co.jp>  wrote:
>> Specify .bpp = 12 and .yuv = 1 when configuring the LCDC channel that you want
>> to you with NV12 input support.
>>
>> Due to the encoding of YUV data, writing 0s to the framebuffer will clear to
>> green instead of black.
>>
>> There is also no native framebuffer support for YUV formats,
>> so this mode will not work with most software rendering.
>>
>> Signed-off-by: Damian Hobson-Garcia<dhobsong@igel.co.jp>
>> ---
>
> Nice to see patches for YUV mode support!
And thank you for your comments.
>
>> --- a/include/video/sh_mobile_lcdc.h
>> +++ b/include/video/sh_mobile_lcdc.h
>> @@ -25,6 +25,8 @@ enum {
>>         SYS24,  /* 24bpp */
>>   };
>>
>> +#define REN_COLOR_NV12  0x1 /* Non-standard framebuffer color format - NV12 */
>> +
>>   enum { LCDC_CHAN_DISABLED = 0,
>>         LCDC_CHAN_MAINLCD,
>>         LCDC_CHAN_SUBLCD };
>> @@ -77,6 +79,7 @@ struct sh_mobile_lcdc_chan_cfg {
>>         struct sh_mobile_lcdc_lcd_size_cfg lcd_size_cfg;
>>         struct sh_mobile_lcdc_board_cfg board_cfg;
>>         struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
>> +       int yuv;
>
> Instead of having "yuv" here I think you should use "nonstd" and make
> sure the "nonstd" field in struct fb_var_screeninfo is set the same
> way.
>
> Also, the REN_COLOR_NV12 constant can go away IMO.
Yes, I guess that using the nonstd together with the bits_per_pixel,
REN_COLOR_NV12 is unnecessary.
>
> I believe the best way to deal with this is to map the "nonstd" value
> directly to bit 16-18 in LDDFR. If "nonstd" is non-zero then you
> should program bits 8-9 depending on the bpp value. This way both 12,
> 16 and 20 (?) bit YUV can be supported with compression enabled or
> not. I believe both sh7724 and sh7372 can be supported too - given
> that the correct "nonstd" value is provided. But since it's provided
> by the platform data it is part of the system configuration and we can
> assume it is correct.
Sounds good.  By 20 bit are you referring to the YCbCr 4:4:4 mode?  I 
haven't really looked at that but it sounds like it should work.  I 
think that its a 24 bit mode though, if I understand correctly 8 bits 
each for Y, Cb, Cr.
>
> Please consider reworking the patch to make it more generic. Just
> adding NV12 support is aiming too low. =)
>
I'm also looking at re-arranging the arrangement of the Y and CbCr 
planes so that in a double buffer (or more) situation all of the Y 
planes come first, followed by the CbCr planes, as it makes the panning 
calculations much simpler.

I'll submit these all as a version 2 of this patch.
> Thanks,
>
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
