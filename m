From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 25 Jun 2018 13:29:27 +0000
Subject: simple-framebuffer enquire
Message-Id: <CAOf5uwmSeugMHBBFc8ZQKY=wEsVD-YwD=YSWi=XbysU58Gp=Ww@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hans de Goede <hdegoede@redhat.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Hans

In order to let it even registered the simplefb I have added this
change. According on what I understand
from the code seems that this is the way to acquire memory with the
correct attribute

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index a3c44ec..7e61ce3 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -466,8 +466,8 @@ static int simplefb_probe(struct platform_device *pdev)

        info->fbops = &simplefb_ops;
        info->flags = FBINFO_DEFAULT | FBINFO_MISC_FIRMWARE;
-       info->screen_base = ioremap_wc(info->fix.smem_start,
-                                      info->fix.smem_len);
+       info->screen_base = arch_memremap_wb(info->fix.smem_start,
+                                            info->fix.smem_len);
        if (!info->screen_base) {
                ret = -ENOMEM;
                goto error_fb_release;

Another question is

        aliases {
                display0 = &lcdif;
        };

        chosen {
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;

                stdout-path = &uart1;
                framebuffer0: framebuffer@86fd6080 {
                        compatible = "simple-framebuffer";
                        reg = <0x86fd6080 (480 * 272 * 4)>;
                        width = <480>;
                        height = <272>;
                        stride = <(480 * 4)>;
                        format = "a8r8g8b8";
                        clocks = <&clks IMX6UL_CLK_LCDIF_PIX>,
                                 <&clks IMX6UL_CLK_LCDIF_APB>,
                                 <&clks IMX6UL_CLK_DUMMY>,
                                 <&clks IMX6UL_CLK_GPIO3>,
                                 <&clks IMX6UL_CLK_GPIO4>;
                        nshut-supply = <&reg_lcd_nshut>;
                        nreset-supply = <&reg_lcd_nreset>;
                        display = <&lcdif>;
                };
        };
};

How do you ensure that regulators that are bind to gpios can be
maintain during boot?
A small minor comment is how to automatic switch then to normal
framebuffer. Anyway seems
that
                #address-cells = <1>;
                #size-cells = <1>;
                ranges;

are mandatory and they are in the dts documentation.

Best regards
Michael
