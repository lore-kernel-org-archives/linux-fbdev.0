From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Mar 2015 15:45:28 +0000
Subject: Re: fbdev: sh_mobile_lcdc: Implement overlays support
Message-Id: <CAMuHMdVw+rg7KmxW4ahZ-frxO_31W8VQmK3AN3X5yM7fLuRCJg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150313100737.GA1984@mwanda>
In-Reply-To: <20150313100737.GA1984@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Fri, Mar 13, 2015 at 11:07 AM, Dan Carpenter
<dan.carpenter@oracle.com> wrote:
> The patch c5deac3c9b22: "fbdev: sh_mobile_lcdc: Implement overlays
> support" from Dec 12, 2011, leads to the following static checker
> warning:
>
>         drivers/video/fbdev/sh_mobile_lcdcfb.c:1471 overlay_rop3_store()
>         warn: bool comparison is always 'false'
>
> drivers/video/fbdev/sh_mobile_lcdcfb.c
>   1455  static ssize_t
>   1456  overlay_rop3_store(struct device *dev, struct device_attribute *attr,
>   1457                      const char *buf, size_t count)
>   1458  {
>   1459          struct fb_info *info = dev_get_drvdata(dev);
>   1460          struct sh_mobile_lcdc_overlay *ovl = info->par;
>   1461          unsigned int rop3;
>   1462          char *endp;
>   1463
>   1464          rop3 = !!simple_strtoul(buf, &endp, 10);
>                        ^^
> rop3 is true/false.
>
>   1465          if (isspace(*endp))
>   1466                  endp++;
>   1467
>   1468          if (endp - buf != count)
>   1469                  return -EINVAL;
>   1470
>   1471          if (rop3 > 255)
>                     ^^^^^^^^^^
> This condition is never true.  Should we just delete it?

Documentation/ABI/testing/sysfs-devices-platform-sh_mobile_lcdc_fb:
"Values range from 0 to 255".

So it looks like the "!!" should be dropped instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
