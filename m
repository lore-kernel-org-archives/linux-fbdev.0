From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 21 Feb 2016 22:39:24 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdaXFUCR5=5mS28_4Dx_LfzqV13zwT=vVeJwuOzm_rGRBQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <56C438DA.5040109@ti.com>
 <CACRpkdZ+G17hmVP8AejL7NTqg7k0SBC5kgF55ASjD+kfuGFJhQ@mail.gmail.com>
 <20160217213250.GK19428@n2100.arm.linux.org.uk>
 <56C5B080.9090007@ti.com>
In-Reply-To: <56C5B080.9090007@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 18, 2016 at 12:52 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> For panels we need DT fragments. The question is where these fragments
> are and, possibly, who who loads them.

I hacked something up that augments the device tree from the kernel,
given you have a node with all the props you want to augment, tell me
what you think of this and whether I should continue in this direction...
also the DT people need to be involved:

#include "../../drivers/of/of_private.h"
/* Obviously make the property duplication function public instead,
it's a test */

struct versatile_panel {
    u32 id;
    char *compatible;
    u32 clock_frequency;
    u32 pixelclk_active;
    u32 hsync_active;
    u32 vsync_active;
    u32 de_active;
    u32 hactive;
    u32 hback_porch;
    u32 hfront_porch;
    u32 hsync_len;
    u32 vactive;
    u32 vback_porch;
    u32 vfront_porch;
    u32 vsync_len;
    bool ib2;
};

static const struct versatile_panel versatile_panels[] = {
    {
        .id = SYS_CLCD_ID_VGA,
        .compatible = "VGA",
        .clock_frequency = 25175000,
        .pixelclk_active = 0,
        .hsync_active = 1,
        .vsync_active = 1,
        .de_active = 1,
        .hactive = 640,
        .hback_porch = 48,
        .hfront_porch = 16,
        .hsync_len = 96,
        .vactive = 480,
        .vback_porch = 33,
        .vfront_porch = 10,
        .vsync_len = 2,
    },
    {
        .id = SYS_CLCD_ID_SANYO_3_8,
        .compatible = "sanyo,tm38qv67a02a",
        .clock_frequency = 10000000,
        .pixelclk_active = 1,
        .hsync_active = 1,
        .vsync_active = 1,
        .de_active = 1,
        .hactive = 320,
        .hback_porch = 6,
        .hfront_porch = 6,
        .hsync_len = 6,
        .vactive = 240,
        .vback_porch = 6,
        .vfront_porch = 6,
        .vsync_len = 0,
    },
    {
        .id = SYS_CLCD_ID_SHARP_8_4,
        .compatible = "sharp,lq084v1dg21",
        .clock_frequency = 25175000,
        .pixelclk_active = 0,
        .hsync_active = 1,
        .vsync_active = 1,
        .de_active = 1,
        .hactive = 640,
        .hback_porch = 48,
        .hfront_porch = 16,
        .hsync_len = 96,
        .vactive = 480,
        .vback_porch = 33,
        .vfront_porch = 10,
        .vsync_len = 2,
    },
    {
        .id = SYS_CLCD_ID_EPSON_2_2,
        .compatible = "epson,l2f50113t00",
        .clock_frequency = 16000000,
        .pixelclk_active = 0,
        .hsync_active = 1,
        .vsync_active = 1,
        .de_active = 1,
        .hactive = 176,
        .hback_porch = 3,
        .hfront_porch = 2,
        .hsync_len = 3,
        .vactive = 220,
        .vback_porch = 1,
        .vfront_porch = 0,
        .vsync_len = 2,
    },
    {
        .id = SYS_CLCD_ID_SANYO_2_5,
        .compatible = "sanyo,alr252rgt",
        .ib2 = true,
        .clock_frequency = 5440000,
        .pixelclk_active = 0,
        .hsync_active = 0,
        .vsync_active = 0,
        .de_active = 1,
        .hactive = 240,
        .hback_porch = 20,
        .hfront_porch = 10,
        .hsync_len = 10,
        .vactive = 320,
        .vback_porch = 2,
        .vfront_porch = 2,
        .vsync_len = 2,
    },
};

static void update_timings_prop(struct device *dev,
                struct of_changeset *cset,
                struct device_node *timings,
                const char *propname,
                u32 val)
{
    struct property *prop, *new;
    __be32 *dt_val;

    prop = of_find_property(timings, propname, NULL);
    if (!prop) {
        dev_err(dev, "could not find property \"%s\" - skipping\n",
            propname);
        return;
    }
    new = __of_prop_dup(prop, GFP_KERNEL);
    if (!new) {
        dev_err(dev, "could not copy property \"%s\" - skipping\n",
            propname);
        return;
    }

    dt_val = new->value;
    *dt_val = cpu_to_be32(val);

    of_changeset_update_property(cset, timings, new);
}

static int versatile_overwrite_of_panel(struct device *dev,
                    struct device_node *panel,
                    const struct versatile_panel *vpanel)
{
    struct of_changeset cset;
    struct device_node *timings;
    int ret;

    dev_info(dev, "CLCD: overwriting device tree\n");

    of_changeset_init(&cset);
    /* Find the timings node */
    timings = of_get_child_by_name(panel, "panel-timing");
    if (!timings) {
        dev_err(dev, "could not find panel timing node\n");
        goto err_destroy_cs;
    }
    update_timings_prop(dev, &cset, timings, "clock-frequency",
                vpanel->clock_frequency);
    update_timings_prop(dev, &cset, timings, "pixelclk-active",
                vpanel->pixelclk_active);
    update_timings_prop(dev, &cset, timings, "hsync-active",
                vpanel->hsync_active);
    update_timings_prop(dev, &cset, timings, "vsync-active",
                vpanel->vsync_active);
    update_timings_prop(dev, &cset, timings, "de-active",
                vpanel->de_active);
    update_timings_prop(dev, &cset, timings, "hactive",
                vpanel->hactive);
    update_timings_prop(dev, &cset, timings, "hback-porch",
                vpanel->hback_porch);
    update_timings_prop(dev, &cset, timings, "hsync-len",
                vpanel->hsync_len);
    update_timings_prop(dev, &cset, timings, "vactive",
                vpanel->vactive);
    update_timings_prop(dev, &cset, timings, "vback-porch",
                vpanel->vback_porch);
    update_timings_prop(dev, &cset, timings, "vfront-porch",
                vpanel->vfront_porch);
    update_timings_prop(dev, &cset, timings, "vsync-len",
                vpanel->hsync_len);

    ret = of_changeset_apply(&cset);
    if (ret) {
        dev_err(dev, "could not apply device tree changeset\n");
        goto err_destroy_cs;
    }
    return ret;

err_destroy_cs:
    of_changeset_destroy(&cset);
    return ret;
}

static void versatile_panel_probe(struct device *dev,
                  struct device_node *endpoint)
{
    struct versatile_panel const *vpanel = NULL;
    struct device_node *panel = NULL;
    u32 val;
    int ret;
    int i;

    /*
     * The Versatile CLCD has a panel auto-detection mechanism.
     * We use this and look for the compatible panel in the
     * device tree.
     */
    ret = regmap_read(versatile_syscon_map, SYS_CLCD, &val);
    if (ret) {
        dev_err(dev, "cannot read CLCD syscon register\n");
        return;
    }
    val &= SYS_CLCD_CLCDID_MASK;
    dev_info(dev, "SYS_CLCD=%08x\n", val);

    /* First find corresponding panel information */
    for (i = 0; i < ARRAY_SIZE(versatile_panels); i++) {
        vpanel = &versatile_panels[i];

        if (val = vpanel->id) {
            dev_err(dev, "autodetected panel \"%s\"\n",
                vpanel->compatible);
            break;
        }
    }
    if (i = ARRAY_SIZE(versatile_panels)) {
        dev_err(dev, "could not auto-detect panel\n");
        return;
    }

    /* This is the default panel node in the device tree */
    panel = of_graph_get_remote_port_parent(endpoint);
    if (!panel) {
        dev_err(dev, "could not locate remote port for panel\n");
        return;
    }

    /*
     * So now we dynamically update the display properties of the
     * panel in accordance to what was detected..
     */
    ret = versatile_overwrite_of_panel(dev, panel, vpanel);
    if (ret) {
        dev_err(dev, "cannot overwrite devicetree panel\n");
        return;
    }

    /*
     * If we have a Sanyo 2.5" port
     * that we're running on an IB2 and proceed to look for the
     * IB2 syscon regmap.
     */
    if (!vpanel->ib2)
        return;

    versatile_ib2_map = syscon_regmap_lookup_by_compatible(
        "arm,versatile-ib2-syscon");
    if (IS_ERR(versatile_ib2_map)) {
        dev_err(dev, "could not locate IB2 control register\n");
        versatile_ib2_map = NULL;
        return;
    }
}


This actually works. But would need some public device tree
property augmentation API instead of the hacks. Should I pursue
it?

Yours,
Linus Walleij
