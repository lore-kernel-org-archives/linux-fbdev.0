From: David Herrmann <dh.herrmann@gmail.com>
Date: Thu, 14 Aug 2014 10:33:55 +0000
Subject: Re: [PATCH 2/4] simplefb: add goto error path to probe
Message-Id: <CANq1E4TAf=Lyuz5psPJE+MWyUO8db8V+-BqXmVyvdLvmY5g=iQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1407914239-12054-1-git-send-email-libv@skynet.be>
 <1407914239-12054-3-git-send-email-libv@skynet.be>
 <CANq1E4Tsi6-a5wL8=SFZuX=+K68txAzp-WBjLSM+ZhW+k4tMfg@mail.gmail.com>
 <20140814102940.GA1000@skynet.be>
In-Reply-To: <20140814102940.GA1000@skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi

On Thu, Aug 14, 2014 at 12:29 PM, Luc Verhaegen <libv@skynet.be> wrote:
> On Wed, Aug 13, 2014 at 09:27:46AM +0200, David Herrmann wrote:
>> Hi
>>
>> On Wed, Aug 13, 2014 at 9:17 AM, Luc Verhaegen <libv@skynet.be> wrote:
>> > Signed-off-by: Luc Verhaegen <libv@skynet.be>
>> > ---
>> >  drivers/video/fbdev/simplefb.c |   20 +++++++++++++-------
>> >  1 files changed, 13 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
>> > index 32be590..72a4f20 100644
>> > --- a/drivers/video/fbdev/simplefb.c
>> > +++ b/drivers/video/fbdev/simplefb.c
>> > @@ -220,8 +220,8 @@ static int simplefb_probe(struct platform_device *pdev)
>> >
>> >         info->apertures = alloc_apertures(1);
>> >         if (!info->apertures) {
>> > -               framebuffer_release(info);
>> > -               return -ENOMEM;
>> > +               ret = -ENOMEM;
>> > +               goto error_fb_release;
>> >         }
>> >         info->apertures->ranges[0].base = info->fix.smem_start;
>> >         info->apertures->ranges[0].size = info->fix.smem_len;
>> > @@ -231,8 +231,8 @@ static int simplefb_probe(struct platform_device *pdev)
>> >         info->screen_base = ioremap_wc(info->fix.smem_start,
>> >                                        info->fix.smem_len);
>> >         if (!info->screen_base) {
>> > -               framebuffer_release(info);
>> > -               return -ENODEV;
>> > +               ret = -ENODEV;
>> > +               goto error_fb_release;
>> >         }
>> >         info->pseudo_palette = (void *) par->palette;
>> >
>> > @@ -247,14 +247,20 @@ static int simplefb_probe(struct platform_device *pdev)
>> >         ret = register_framebuffer(info);
>> >         if (ret < 0) {
>> >                 dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
>> > -               iounmap(info->screen_base);
>> > -               framebuffer_release(info);
>> > -               return ret;
>> > +               goto error_unmap;
>> >         }
>> >
>> >         dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
>> >
>> >         return 0;
>> > +
>> > + error_unmap:
>> > +       iounmap(info->screen_base);
>> > +
>> > + error_fb_release:
>> > +       framebuffer_release(info);
>> > +
>> > +       return ret;
>>
>> Again, I'd use different coding-style, but I will leave that to
>> Stephen and Tomi:
>>
>> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
>
> While the discussion about the last two patches rages on, can you state
> what coding style changes you would like to see here, as i am not clear
> as to what exactly is off with the above code.

I'd skip the leading whitespace and the newlines, like this:

+error_unmap:
+        iounmap(info->screen_base);
+error_fb_release:
+        framebuffer_release(info);
+        return ret;

at least that's my conception how we format error paths in drivers/video/.

Thanks
David
