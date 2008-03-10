From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: RE: [Linux-fbdev-devel] [PATCH 1/1 try#2] [VIDEO/FRAMEBUFFER]: add BF52x EZkit Display driver
Date: Mon, 10 Mar 2008 14:35:45 -0000
Message-ID: <600D5CB4DFD93545BF61FF01473D11AC12E9A755@limkexm2.ad.analog.com>
References: <Pine.LNX.4.64.0803061906210.20407@anakin>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753267AbYCJOge@vger.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <Pine.LNX.4.64.0803061906210.20407@anakin>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, Bryan Wu <bryan.wu@analog.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <randy.dunlap@oracle.com>, adaplas@gmail.com, Michael Hennerich <michael.hennerich@analog.com>, linux-kernel@vger.kernel.org



>From: geert@linux-m68k.org [mailto:geert@linux-m68k.org]
>Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 try#2] [VIDEO/FRAMEBUFFER]:
add
>BF52x EZkit Display driver
>
>On Thu, 6 Mar 2008, Bryan Wu wrote:
>> On Wed, Mar 5, 2008 at 11:02 PM, Andrew Morton
>> <akpm@linux-foundation.org> wrote:
>> > On Thu, 31 Jan 2008 00:49:43 +0800 Bryan Wu <bryan.wu@analog.com>
>wrote:
>> >  > +     fbinfo =
>> >  > +         framebuffer_alloc(sizeof(struct bfin_t350mcqbfb_info),
>&pdev->dev);
>> >  > +     if (!fbinfo) {
>> >  > +             ret = -ENOMEM;
>> >  > +             goto out2;
>> >  > +     }
>
>    [...]
>
>> >  > +     fbinfo->pseudo_palette = kmalloc(sizeof(u32) * 16,
>GFP_KERNEL);
>> >  > +     if (!fbinfo->pseudo_palette) {
>> >  > +             printk(KERN_ERR DRIVER_NAME
>> >  > +                    "Fail to allocate pseudo_palette\n");
>> >  > +
>> >  > +             ret = -ENOMEM;
>> >  > +             goto out4;
>> >  > +     }
>> >  > +
>> >  > +     memset(fbinfo->pseudo_palette, 0, sizeof(u32) * 16);
>> >
>> >  You just invented kzalloc!
>> >
>>
>> Right
>
>Alternatively, you could embed the pseudo palette inside struct
>bfin_t350mcqbfb_info, so it's allocated by the framebuffer_alloc() call
>above.

This makes the most sense.
Bryan is going to send an updated patch, including your and Andrew's
recommendations.

Thanks and best regards,
Michael
 

>
>Gr{oetje,eeting}s,
>
>						Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-
>m68k.org
>
>In personal conversations with technical people, I call myself a
hacker.
>But
>when I'm talking to journalists I just say "programmer" or something
like
>that.
>							    -- Linus
Torvalds
