From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 14 Nov 2014 10:28:29 +0000
Subject: Re: [PATCH v6] simplefb: add clock handling code
Message-Id: <5465D94D.50805@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415906546-2408-1-git-send-email-hdegoede@redhat.com>
 <CACxGe6uB-J8_uzNJqCOEjM5G8=Bq=KFf-O1tfXVwP0=cMY+7iw@mail.gmail.com>
In-Reply-To: <CACxGe6uB-J8_uzNJqCOEjM5G8=Bq=KFf-O1tfXVwP0=cMY+7iw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On 11/14/2014 10:42 AM, Grant Likely wrote:
> On Thu, Nov 13, 2014 at 7:22 PM, Hans de Goede <hdegoede@redhat.com> wrote:
>> From: Luc Verhaegen <libv@skynet.be>
>>
>> This claims and enables clocks listed in the simple framebuffer dt node.
>> This is needed so that the display engine, in case the required clocks
>> are known by the kernel code and are described in the dt, will remain
>> properly enabled.
>>
>> Signed-off-by: Luc Verhaegen <libv@skynet.be>
>> [hdegoede@redhat.com: Change clks from list to dynamic array]
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
>> Acked-by: Grant Likely <grant.likely@linaro.org>
>> --
>> Changes in v4:
>> -change clks from linkedlist to dynamic allocated array
>> -propagate EPROBE_DEFER up from simplefb_clocks_init to simplefb_probe
>> changes in v6:
>> -Wrap the clock code in #ifdef CONFIG_OF, as simplefb is used on non
>>  devicetree platforms too
>> ---
>>  drivers/video/fbdev/simplefb.c | 106 ++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 105 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
>> index cdcf1fe..868099a 100644
>> --- a/drivers/video/fbdev/simplefb.c
>> +++ b/drivers/video/fbdev/simplefb.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/module.h>
>>  #include <linux/platform_data/simplefb.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/clk-provider.h>
>>
>>  static struct fb_fix_screeninfo simplefb_fix = {
>>         .id             = "simple",
>> @@ -167,8 +168,103 @@ static int simplefb_parse_pd(struct platform_device *pdev,
>>
>>  struct simplefb_par {
>>         u32 palette[PSEUDO_PALETTE_SIZE];
>> +#ifdef CONFIG_OF
>> +       int clk_count;
>> +       struct clk **clks;
>> +#endif
>>  };
>>
>> +/*
>> + * Clock handling code.
>> + *
>> + * Here we handle the clocks property of our "simple-framebuffer" dt node.
>> + * This is necessary so that we can make sure that any clocks needed by
>> + * the display engine that the bootloader set up for us (and for which it
>> + * provided a simplefb dt node), stay up, for the life of the simplefb
>> + * driver.
>> + *
>> + * When the driver unloads, we cleanly disable, and then release the clocks.
>> + *
>> + * We only complain about errors here, no action is taken as the most likely
>> + * error can only happen due to a mismatch between the bootloader which set
>> + * up simplefb, and the clock definitions in the device tree. Chances are
>> + * that there are no adverse effects, and if there are, a clean teardown of
>> + * the fb probe will not help us much either. So just complain and carry on,
>> + * and hope that the user actually gets a working fb at the end of things.
>> + */
>> +static int
>> +simplefb_clocks_init(struct simplefb_par *par, struct platform_device *pdev)
> 
> Going against convention here. Functions in the rest of the file have
> the return parameters on the same line as the function name. Don't do
> something different here.
> 
> Besides, it's just bad practice. Putting the return values on a
> separate line means they don't show up in the results when grepping
> for a function name.

This was present in the original version of this patch (which I did not write),
will fix for v7.

> 
>> +{
>> +#ifdef CONFIG_OF
> 
> Rather ugly. When #ifdefs are unavoidable, please wrap the entire
> function including the prototype and have an #else block with a static
> inline empty function so that the #ifdef/#endif directives don't
> interfere with the indentation flow.

Will fix for v7.

>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct clk *clock;
>> +       int i, ret;
>> +
>> +       if (dev_get_platdata(&pdev->dev) || !np)
>> +               return 0;
>> +
>> +       par->clk_count = of_clk_get_parent_count(np);
>> +       if (par->clk_count <= 0)
>> +               return 0;
>> +
>> +       par->clks = kcalloc(par->clk_count, sizeof(struct clk *), GFP_KERNEL);
>> +       if (!par->clks)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < par->clk_count; i++) {
>> +               clock = of_clk_get(np, i);
> 
> Should check if there is an 'of' version of devm_clk_get(). Then the
> clock destroy function wouldn't be needed at all.

There is no version of devm_clk_get which takes an index rather then a name.

>> +               if (IS_ERR(clock)) {
>> +                       if (PTR_ERR(clock) = -EPROBE_DEFER) {
>> +                               while (--i >= 0) {
>> +                                       if (par->clks[i])
>> +                                               clk_put(par->clks[i]);
>> +                               }
>> +                               kfree(par->clks);
>> +                               return -EPROBE_DEFER;
>> +                       }
>> +                       dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
>> +                               __func__, i, PTR_ERR(clock));
>> +                       continue;
>> +               }
>> +               par->clks[i] = clock;
>> +       }
> 
> (comment for a followup patch) As discussed on IRC, I don't think we
> want the driver to return -EPROBE_DEFER if it can't get a clock. It
> should continue anyway. The kernel knows the framebuffer is already
> set up, so there is no reason to defer using it. The driver should
> keep track of the clocks that it failed to obtain and try again just
> before unused clocks get disabled. Have a special initcall hook that
> walks though the bound framebuffers and tries the unobtained clocks
> again.
> 
>> +
>> +       for (i = 0; i < par->clk_count; i++) {
>> +               if (par->clks[i]) {
>> +                       ret = clk_prepare_enable(par->clks[i]);
>> +                       if (ret) {
>> +                               dev_err(&pdev->dev,
>> +                                       "%s: failed to enable clock %d: %d\n",
>> +                                       __func__, i, ret);
>> +                               clk_put(par->clks[i]);
>> +                               par->clks[i] = NULL;
>> +                       }
>> +               }
>> +       }
>> +#endif
>> +       return 0;
>> +}
>> +
>> +static void
>> +simplefb_clocks_destroy(struct simplefb_par *par)
>> +{
>> +#ifdef CONFIG_OF
>> +       int i;
>> +
>> +       if (!par->clks)
>> +               return;
>> +
>> +       for (i = 0; i < par->clk_count; i++) {
>> +               if (par->clks[i]) {
>> +                       clk_disable_unprepare(par->clks[i]);
>> +                       clk_put(par->clks[i]);
>> +               }
>> +       }
>> +
>> +       kfree(par->clks);
>> +#endif
>> +}
>> +
>>  static int simplefb_probe(struct platform_device *pdev)
>>  {
>>         int ret;
>> @@ -236,6 +332,10 @@ static int simplefb_probe(struct platform_device *pdev)
>>         }
>>         info->pseudo_palette = par->palette;
>>
>> +       ret = simplefb_clocks_init(par, pdev);
>> +       if (ret < 0)
>> +               goto error_unmap;
>> +
>>         dev_info(&pdev->dev, "framebuffer at 0x%lx, 0x%x bytes, mapped to 0x%p\n",
>>                              info->fix.smem_start, info->fix.smem_len,
>>                              info->screen_base);
>> @@ -247,13 +347,15 @@ static int simplefb_probe(struct platform_device *pdev)
>>         ret = register_framebuffer(info);
>>         if (ret < 0) {
>>                 dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
>> -               goto error_unmap;
>> +               goto error_clocks;
>>         }
>>
>>         dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
>>
>>         return 0;
>>
>> +error_clocks:
>> +       simplefb_clocks_destroy(par);
>>  error_unmap:
>>         iounmap(info->screen_base);
>>  error_fb_release:
>> @@ -264,8 +366,10 @@ error_fb_release:
>>  static int simplefb_remove(struct platform_device *pdev)
>>  {
>>         struct fb_info *info = platform_get_drvdata(pdev);
>> +       struct simplefb_par *par = info->par;
>>
>>         unregister_framebuffer(info);
>> +       simplefb_clocks_destroy(par);
>>         framebuffer_release(info);
>>
>>         return 0;
>> --
>> 2.1.0
>>

Regards,

Hans
