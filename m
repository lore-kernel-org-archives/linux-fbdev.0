From: Ryan Harkin <ryan.harkin@linaro.org>
Date: Fri, 21 Sep 2012 10:35:30 +0000
Subject: Re: [RFC PATCH 1/3] amba-clcd: Add Device Tree support to amba-clcd driver
Message-Id: <CAD0U-h+Z1zQYTiEm+aKwNJa48SdHfs6-qUu4vNRwFr=mqxyXCg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348070666-9153-1-git-send-email-ryan.harkin@linaro.org>
 <1348070666-9153-2-git-send-email-ryan.harkin@linaro.org>
 <20120920102453.GG32603@e102652-lin.cambridge.arm.com>
In-Reply-To: <20120920102453.GG32603@e102652-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi Liviu,

Thanks for your feedback.  All good stuff...

On 20 September 2012 11:24, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Wed, Sep 19, 2012 at 05:04:24PM +0100, Ryan Harkin wrote:
>> Add support to parse the display configuration from device tree.
>>
>> If the board does not provide platform specific functions in the struct
>> clcd_board contained with the amba device info, then defaults are provided
>> by the driver.
>>
>> The device tree configuration can either ask for a DMA setup or provide a
>> framebuffer address to be remapped into the driver.
>>
>> Signed-off-by: Ryan Harkin <ryan.harkin@linaro.org>
>> ---
>>  drivers/video/amba-clcd.c |  253 +++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 253 insertions(+)
>>
>> diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
>> index 0a2cce7..01dbad1 100644
>> --- a/drivers/video/amba-clcd.c
>> +++ b/drivers/video/amba-clcd.c
>> @@ -16,7 +16,10 @@
>>  #include <linux/string.h>
>>  #include <linux/slab.h>
>>  #include <linux/delay.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/memblock.h>
>>  #include <linux/mm.h>
>> +#include <linux/of.h>
>>  #include <linux/fb.h>
>>  #include <linux/init.h>
>>  #include <linux/ioport.h>
>> @@ -391,6 +394,19 @@ static int clcdfb_blank(int blank_mode, struct fb_info *info)
>>       }
>>       return 0;
>>  }
>> +int clcdfb_mmap_dma(struct clcd_fb *fb, struct vm_area_struct *vma)
>> +{
>> +     return dma_mmap_writecombine(&fb->dev->dev, vma,
>> +                                  fb->fb.screen_base,
>> +                                  fb->fb.fix.smem_start,
>> +                                  fb->fb.fix.smem_len);
>> +}
>> +
>> +void clcdfb_remove_dma(struct clcd_fb *fb)
>> +{
>> +     dma_free_writecombine(&fb->dev->dev, fb->fb.fix.smem_len,
>> +                           fb->fb.screen_base, fb->fb.fix.smem_start);
>> +}
>>
>>  static int clcdfb_mmap(struct fb_info *info,
>>                      struct vm_area_struct *vma)
>> @@ -542,12 +558,249 @@ static int clcdfb_register(struct clcd_fb *fb)
>>       return ret;
>>  }
>>
>> +struct string_lookup {
>> +     const char *string;
>> +     const u32       val;
>> +};
>> +
>> +static struct string_lookup vmode_lookups[] = {
>> +     { "FB_VMODE_NONINTERLACED", FB_VMODE_NONINTERLACED},
>> +     { "FB_VMODE_INTERLACED",    FB_VMODE_INTERLACED},
>> +     { "FB_VMODE_DOUBLE",        FB_VMODE_DOUBLE},
>> +     { "FB_VMODE_ODD_FLD_FIRST", FB_VMODE_ODD_FLD_FIRST},
>> +     { NULL, 0 },
>> +};
>> +
>> +static struct string_lookup tim2_lookups[] = {
>> +     { "TIM2_CLKSEL", TIM2_CLKSEL},
>> +     { "TIM2_IVS",    TIM2_IVS},
>> +     { "TIM2_IHS",    TIM2_IHS},
>> +     { "TIM2_IPC",    TIM2_IPC},
>> +     { "TIM2_IOE",    TIM2_IOE},
>> +     { "TIM2_BCD",    TIM2_BCD},
>> +     { NULL, 0},
>> +};
>> +static struct string_lookup cntl_lookups[] = {
>> +     {"CNTL_LCDEN",        CNTL_LCDEN},
>> +     {"CNTL_LCDBPP1",      CNTL_LCDBPP1},
>> +     {"CNTL_LCDBPP2",      CNTL_LCDBPP2},
>> +     {"CNTL_LCDBPP4",      CNTL_LCDBPP4},
>> +     {"CNTL_LCDBPP8",      CNTL_LCDBPP8},
>> +     {"CNTL_LCDBPP16",     CNTL_LCDBPP16},
>> +     {"CNTL_LCDBPP16_565", CNTL_LCDBPP16_565},
>> +     {"CNTL_LCDBPP16_444", CNTL_LCDBPP16_444},
>> +     {"CNTL_LCDBPP24",     CNTL_LCDBPP24},
>> +     {"CNTL_LCDBW",        CNTL_LCDBW},
>> +     {"CNTL_LCDTFT",       CNTL_LCDTFT},
>> +     {"CNTL_LCDMONO8",     CNTL_LCDMONO8},
>> +     {"CNTL_LCDDUAL",      CNTL_LCDDUAL},
>> +     {"CNTL_BGR",          CNTL_BGR},
>> +     {"CNTL_BEBO",         CNTL_BEBO},
>> +     {"CNTL_BEPO",         CNTL_BEPO},
>> +     {"CNTL_LCDPWR",       CNTL_LCDPWR},
>> +     {"CNTL_LCDVCOMP(1)",  CNTL_LCDVCOMP(1)},
>> +     {"CNTL_LCDVCOMP(2)",  CNTL_LCDVCOMP(2)},
>> +     {"CNTL_LCDVCOMP(3)",  CNTL_LCDVCOMP(3)},
>> +     {"CNTL_LCDVCOMP(4)",  CNTL_LCDVCOMP(4)},
>> +     {"CNTL_LCDVCOMP(5)",  CNTL_LCDVCOMP(5)},
>> +     {"CNTL_LCDVCOMP(6)",  CNTL_LCDVCOMP(6)},
>> +     {"CNTL_LCDVCOMP(7)",  CNTL_LCDVCOMP(7)},
>> +     {"CNTL_LDMAFIFOTIME", CNTL_LDMAFIFOTIME},
>> +     {"CNTL_WATERMARK",    CNTL_WATERMARK},
>> +     { NULL, 0},
>> +};
>> +static struct string_lookup caps_lookups[] = {
>> +     {"CLCD_CAP_RGB444",  CLCD_CAP_RGB444},
>> +     {"CLCD_CAP_RGB5551", CLCD_CAP_RGB5551},
>> +     {"CLCD_CAP_RGB565",  CLCD_CAP_RGB565},
>> +     {"CLCD_CAP_RGB888",  CLCD_CAP_RGB888},
>> +     {"CLCD_CAP_BGR444",  CLCD_CAP_BGR444},
>> +     {"CLCD_CAP_BGR5551", CLCD_CAP_BGR5551},
>> +     {"CLCD_CAP_BGR565",  CLCD_CAP_BGR565},
>> +     {"CLCD_CAP_BGR888",  CLCD_CAP_BGR888},
>> +     {"CLCD_CAP_444",     CLCD_CAP_444},
>> +     {"CLCD_CAP_5551",    CLCD_CAP_5551},
>> +     {"CLCD_CAP_565",     CLCD_CAP_565},
>> +     {"CLCD_CAP_888",     CLCD_CAP_888},
>> +     {"CLCD_CAP_RGB",     CLCD_CAP_RGB},
>> +     {"CLCD_CAP_BGR",     CLCD_CAP_BGR},
>> +     {"CLCD_CAP_ALL",     CLCD_CAP_ALL},
>> +     { NULL, 0},
>> +};
>> +
>> +u32 parse_setting(struct string_lookup *lookup, const char *name)
>> +{
>> +     int i = 0;
>> +     while (lookup[i].string != NULL) {
>> +             if (strcmp(lookup[i].string, name) = 0)
>> +                     return lookup[i].val;
>> +             ++i;
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>> +u32 get_string_lookup(struct device_node *node, const char *name,
>> +                   struct string_lookup *lookup)
>> +{
>
> I have this feeling that swapping the names of the two functions above
> would reflect better their actual functionality.

I see what you mean.  I'm happy to swap them if there are no objections.


>
>> +     const char *string;
>> +     int count, i, ret = 0;
>> +
>> +     count = of_property_count_strings(node, name);
>> +     if (count >= 0)
>> +             for (i = 0; i < count; i++)
>> +                     if (of_property_read_string_index(node, name, i,
>> +                                     &string) = 0)
>> +                             ret |= parse_setting(lookup, string);
>> +     return ret;
>> +}
>> +
>> +int get_val(struct device_node *node, const char *string)
>> +{
>> +     u32 ret = 0;
>> +
>> +     if (of_property_read_u32(node, string, &ret))
>> +             ret = -1;
>> +     return ret;
>> +}
>> +
>> +struct clcd_panel *getPanel(struct device_node *node)
>> +{
>> +     static struct clcd_panel panel;
>> +
>> +     panel.mode.refresh      = get_val(node, "refresh");
>> +     panel.mode.xres         = get_val(node, "xres");
>> +     panel.mode.yres         = get_val(node, "yres");
>> +     panel.mode.pixclock     = get_val(node, "pixclock");
>> +     panel.mode.left_margin  = get_val(node, "left_margin");
>> +     panel.mode.right_margin = get_val(node, "right_margin");
>> +     panel.mode.upper_margin = get_val(node, "upper_margin");
>> +     panel.mode.lower_margin = get_val(node, "lower_margin");
>> +     panel.mode.hsync_len    = get_val(node, "hsync_len");
>> +     panel.mode.vsync_len    = get_val(node, "vsync_len");
>> +     panel.mode.sync         = get_val(node, "sync");
>> +     panel.bpp               = get_val(node, "bpp");
>> +     panel.width             = (signed short) get_val(node, "width");
>> +     panel.height            = (signed short) get_val(node, "height");
>> +
>> +     panel.mode.vmode = get_string_lookup(node, "vmode", vmode_lookups);
>> +     panel.tim2       = get_string_lookup(node, "tim2",  tim2_lookups);
>> +     panel.cntl       = get_string_lookup(node, "cntl",  cntl_lookups);
>> +     panel.caps       = get_string_lookup(node, "caps",  caps_lookups);
>> +
>> +     return &panel;
>> +}
>> +
>> +struct clcd_panel *clcdfb_get_panel(const char *name)
>> +{
>> +     struct device_node *node = NULL;
>> +     const char *mode;
>> +     struct clcd_panel *panel = NULL;
>> +
>> +     do {
>> +             node = of_find_compatible_node(node, NULL, "panel");
>> +             if (node)
>> +                     if (of_property_read_string(node, "mode", &mode) = 0)
>> +                             if (strcmp(mode, name) = 0) {
>> +                                     panel = getPanel(node);
>> +                                     panel->mode.name = name;
>> +                             }
>> +     } while (node != NULL);
>> +
>> +     return panel;
>> +}
>> +
>> +#ifdef CONFIG_OF
>
> shouldn't this #ifdef be earlier? you are calling of_property_read_string()
> and while there are empty definitions if CONFIG_OF is not defined, the code
> will do nothing in that case. Is that intended? The clcdfb_get_panel()
> function only gets called if CONFIG_OF *is* defined.

Agree.


>
>
>> +static int clcdfb_dt_init(struct clcd_fb *fb)
>> +{
>> +     int err = 0;
>> +     struct device_node *node;
>> +     const char *mode;
>> +     dma_addr_t dma;
>> +     u32 use_dma;
>> +     const __be32 *prop;
>> +     int len, na, ns;
>> +     phys_addr_t fb_base, fb_size;
>> +
>> +     node = fb->dev->dev.of_node;
>> +     if (!node)
>> +             return -ENODEV;
>> +
>> +     na = of_n_addr_cells(node);
>> +     ns = of_n_size_cells(node);
>> +
>> +     if (WARN_ON(of_property_read_string(node, "mode", &mode)))
>> +             return -ENODEV;
>> +
>> +     fb->panel = clcdfb_get_panel(mode);
>> +     if (!fb->panel)
>> +             return -EINVAL;
>> +     fb->fb.fix.smem_len = fb->panel->mode.xres * fb->panel->mode.yres * 2;
>> +
>> +     if (of_property_read_u32(node, "use_dma", &use_dma))
>
> I haven't seen any documentation for this property. What's the intended use?

Good point.  Sorry for my ignorance, but is there a place I should put
such documentation?

When the A9 CoreTile uses the on-tile CLCD controller, it can use DMA
to handle the framebuffer.  DMA is not available to the motherboard
CLCD controller.

I was trying to keep the properties simple, but they are more complex
than just the two settings: use_dma and framebuffer.  If use_dma is
specified, the framebuffer property is not used; in this case, the
framebuffer is allocated by the DMA framework and the framebuffer
property is ignored.  If use_dma is not present or is set to <0>, the
code uses the framebuffer property to specify the address.


>
>> +             use_dma = 0;
>> +     if (use_dma) {
>> +             fb->fb.screen_base = dma_alloc_writecombine(&fb->dev->dev,
>> +                     fb->fb.fix.smem_len, &dma, GFP_KERNEL);
>> +             if (!fb->fb.screen_base) {
>> +                     pr_err("CLCD: unable to map framebuffer\n");
>> +                     err = -ENOMEM;
>> +             } else
>> +                     fb->fb.fix.smem_start   = dma;
>> +     } else {
>> +             prop = of_get_property(node, "framebuffer", &len);
>> +             if (WARN_ON(!prop || len < (na + ns) * sizeof(*prop)))
>> +                     return -EINVAL;
>> +             fb_base = of_read_number(prop, na);
>> +             fb_size = of_read_number(prop + na, ns);
>> +
>> +             if (memblock_remove(fb_base, fb_size) != 0)
>> +                     return -EINVAL;
>> +
>> +             fb->fb.fix.smem_start = fb_base;
>> +             fb->fb.screen_base = ioremap_wc(fb->fb.fix.smem_start, fb_size);
>> +     }
>> +     return err;
>> +}
>> +#endif /* CONFIG_OF */
>> +
>>  static int clcdfb_probe(struct amba_device *dev, const struct amba_id *id)
>>  {
>>       struct clcd_board *board = dev->dev.platform_data;
>>       struct clcd_fb *fb;
>>       int ret;
>>
>> +#ifdef CONFIG_OF
>> +     if (dev->dev.of_node) {
>> +             const __be32 *prop;
>> +             int len, na, ns;
>> +             phys_addr_t reg_base;
>> +
>> +             na = of_n_addr_cells(dev->dev.of_node);
>> +             ns = of_n_size_cells(dev->dev.of_node);
>> +
>> +             prop = of_get_property(dev->dev.of_node, "reg", &len);
>> +             if (WARN_ON(!prop || len < (na + ns) * sizeof(*prop)))
>> +                     return -EINVAL;
>> +             reg_base = of_read_number(prop, na);
>> +
>> +             if (dev->res.start != reg_base)
>> +                     return -EINVAL;
>> +
>> +             if (!board) {
>> +                     board = kzalloc(sizeof(struct clcd_board), GFP_KERNEL);
>> +                     if (!board)
>> +                             return -EINVAL;
>> +                     board->name    = "Device Tree CLCD PL111";
>> +                     board->caps    = CLCD_CAP_5551 | CLCD_CAP_565;
>> +                     board->check   = clcdfb_check;
>> +                     board->decode  = clcdfb_decode;
>> +                     board->setup   = clcdfb_dt_init;
>> +                     board->mmap    = clcdfb_mmap_dma;
>> +                     board->remove  = clcdfb_remove_dma;
>> +             }
>> +     }
>> +#endif /* CONFIG_OF */
>> +
>>       if (!board)
>>               return -EINVAL;
>>
>> --
>> 1.7.9.5
>>
>>
>
> --
> ==========
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
>
> -- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
>
