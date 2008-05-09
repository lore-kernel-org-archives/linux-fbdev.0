From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: pxafb and am200epd question
Date: Fri, 9 May 2008 05:07:41 -0400
Message-ID: <45a44e480805090207me9a0da0w2bcb4f0a67f191f1@mail.gmail.com>
References: <45a44e480805060505r2b280717p60d0046e083adf98@mail.gmail.com>
	<E913911567467945BBEB9277E27868B0C1C3CB@msiexch01.marvell.com>
	<45a44e480805070807x7be5da5q632da9c25c66139a@mail.gmail.com>
	<45a44e480805080903m1acde0b2j73012646ef8da17e@mail.gmail.com>
	<E913911567467945BBEB9277E27868B0C1CDBE@msiexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuOZw-0004b0-N0 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 02:07:52 -0700
Received: from wf-out-1314.google.com ([209.85.200.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JuOZu-0005u0-6z
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 02:07:48 -0700
Received: by wf-out-1314.google.com with SMTP id 27so1077135wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 09 May 2008 02:07:41 -0700 (PDT)
In-Reply-To: <E913911567467945BBEB9277E27868B0C1CDBE@msiexch01.marvell.com>
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
To: Eric Miao <ymiao3@marvell.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, May 9, 2008 at 5:02 AM, Eric Miao <ymiao3@marvell.com> wrote:
> Hi Jaya,
>
> I'm ok with the extra_video_mem, yet I feel a bit upset about the callback
> to notify the peer about its allocated memory. I guess the am200epd.c can
> still examine the registered_fb[] to see the screen_base and screen_size.

Hi Eric,

Not sure I follow. How would am200epd get access to the screen_base
without a callback?

Thanks,
jaya

>
> - eric
>
>> -----Original Message-----
>> From: Jaya Kumar [mailto:jayakumar.lkml@gmail.com]
>> Sent: Friday, May 09, 2008 12:03 AM
>> To: Eric Miao
>> Cc: Linux Frame Buffer Device Development
>> Subject: Re: pxafb and am200epd question
>>
>> On Wed, May 7, 2008 at 11:07 AM, Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>> > On Tue, May 6, 2008 at 9:14 PM, Eric Miao <ymiao3@marvell.com> wrote:
>> >>
>> >>  In a long run, I guess the most critical dependency of metronomefb on
>> >>  pxafb is the video memory, while pxafb currently allocates its own
>> >>  video memory (correct me if my understanding is wrong).  For such case
>> >>  pxafb.c should really be modified where its platform data can specify
>> >>  customized video memory location. I'm not sure if this satisfy your
>> >>  requirement.
>> >
>> > Hi Eric,
>> >
>> > I think you are right. I can make modifications to accommodate this so
>> > that am200epd doesn't result in allocation of its own physical
>> > framebuffer. Here's what I am thinking:
>> >
>> > a) am200epd will use set_pxa_fb_info and pxafb_mach_info to pass pxafb
>> > information about modes that it wants. It can pass desired LCCR0..3
>> > settings through the lccr0,1,2,3 entries in pxafb_mach_info.
>> > b) am200epd will find out from metronomefb about the size of the
>> > waveform area that it needs in the framebuffer. It can do this before
>> > it calls set_pxa_fb_info. We can add an entry to pxafb_mach_info like
>> > extra_video_mem. Then pxafb can add that to the calculation of
>> > map_size so that the allocated framebuffer is suitable for am200epd.
>> > c) am200epd will need a way to get access to pxafb's map_cpu. This is
>> > the part that I'm unsure about. Maybe we can add a callback function
>> > entry in pxafb_mach_info that will be called by pxafb once it has
>> > allocated a framebuffer.
>> >
>> > Let me know if this sounds reasonable, especially on part c. If you
>> > like it, I will be happy to start writing a patch to do this.
>> >
>> >>
>> >>  And indeed what am200epd.c is doing looks quite platform specific, which
>> >>  means it's better to move them into some kind of <platform>.c, and note
>> >>  that manipulating GPARx/GPSRx/GPLRx directly is no longer recommended :)
>> >>
>> >
>> > Agreed. I intend to remove that code and switch to the new gpio stuff.
>> >
>> > Thanks,
>> > jaya
>> >
>>
>> Hi Eric,
>>
>> I'm thinking something along the lines of the following. Not a real
>> patch, just a draft.
>>
>> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
>> index 3ab6e3d..6d48fd2 100644
>> --- a/drivers/video/pxafb.c
>> +++ b/drivers/video/pxafb.c
>> @@ -1247,14 +1248,16 @@ static int pxafb_resume(struct platform_device *dev)
>>   *      cache.  Once this area is remapped, all virtual memory
>>   *      access to the video memory should occur at the new region.
>>   */
>> -static int __init pxafb_map_video_memory(struct pxafb_info *fbi)
>> +static int __init pxafb_map_video_memory(struct pxafb_info *fbi,
>> +                                        struct pxafb_mach_info *inf)
>>  {
>>         /*
>>          * We reserve one page for the palette, plus the size
>>          * of the framebuffer.
>>          */
>>         fbi->video_offset = PAGE_ALIGN(sizeof(struct pxafb_dma_buff));
>> -       fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset);
>> +       fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + fbi->video_offset +
>> +                                       inf->extra_video_mem);
>>         fbi->map_cpu = dma_alloc_writecombine(fbi->dev, fbi->map_size,
>>                                               &fbi->map_dma, GFP_KERNEL);
>>
>> @@ -1281,6 +1284,9 @@ static int __init pxafb_map_video_memory(struct
>> pxafb_info *fbi)
>>                 fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
>>                 fbi->n_smart_cmds = 0;
>>  #endif
>> +               if (inf->share_video_mem)
>> +                       inf->share_video_mem(fbi->fb.screen_base,
>> +                                       fbi->screen_dma, inf->extra_data);
>>         }
>>
>>         return fbi->map_cpu ? 0 : -ENOMEM;
>> @@ -1703,7 +1709,7 @@ static int __init pxafb_probe(struct platform_device
>> *dev)
>>         }
>>
>>         /* Initialize video memory */
>> -       ret = pxafb_map_video_memory(fbi);
>> +       ret = pxafb_map_video_memory(fbi, inf);
>>         if (ret) {
>>                 dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
>>                 ret = -ENOMEM;
>> diff --git a/include/asm-arm/arch-pxa/pxafb.h
>> b/include/asm-arm/arch-pxa/pxafb.h
>> index bbd2239..39560c2 100644
>> --- a/include/asm-arm/arch-pxa/pxafb.h
>> +++ b/include/asm-arm/arch-pxa/pxafb.h
>> @@ -138,9 +138,13 @@ struct pxafb_mach_info {
>>          * All other bits in LCCR4 should be left alone.
>>          */
>>         u_int           lccr4;
>> +       unsigned int    extra_video_mem; /* extra mem for special devices */
>> +       void            *extra_data; /* extra data for 2ndary drivers */
>>         void (*pxafb_backlight_power)(int);
>>         void (*pxafb_lcd_power)(int, struct fb_var_screeninfo *);
>>         void (*smart_update)(struct fb_info *);
>> +       /* share_video_mem allows a 2ndary driver to use the framebuffer */
>> +       void (*share_video_mem)(unsigned char *, dma_addr_t, void *);
>>  };
>>  void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
>>  void set_pxa_fb_parent(struct device *parent_dev);
>>
>> I haven't tried it out yet but I think that would be the bulk of the
>> changes. Let me know what you think. If you're happy with that and if
>> I can get it to work, then I can probably skip doing the temporary fix
>> to use __raw_write.
>>
>> Thanks,
>> jaya
>

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
