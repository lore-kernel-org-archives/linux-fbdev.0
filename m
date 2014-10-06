From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 06 Oct 2014 10:15:04 +0000
Subject: Re: [PATCH v2 5/5] simplefb: add clock handling code
Message-Id: <CAMuHMdVDtjkow+Q_6H6Pp-+6mKYOdGP02_FTO4AG6_85K+ij-A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
 <1412337125-14388-6-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1412337125-14388-6-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 3, 2014 at 1:52 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> +static void
> +simplefb_clocks_init(struct platform_device *pdev, struct list_head *list)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       int clock_count, i;
> +
> +       INIT_LIST_HEAD(list);
> +
> +       if (dev_get_platdata(&pdev->dev) || !np)
> +               return;
> +
> +       clock_count = of_clk_get_parent_count(np);
> +       for (i = 0; i < clock_count; i++) {
> +               struct simplefb_clock *entry;
> +               struct clk *clock = of_clk_get(np, i);
> +               int ret;
> +
> +               if (IS_ERR(clock)) {
> +                       dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
> +                              __func__, i, PTR_ERR(clock));
> +                       continue;
> +               }
> +
> +               ret = clk_prepare_enable(clock);
> +               if (ret) {
> +                       dev_err(&pdev->dev,
> +                               "%s: failed to enable clock %d: %d\n",
> +                              __func__, i, ret);
> +                       clk_put(clock);
> +                       continue;
> +               }
> +
> +               entry = kzalloc(sizeof(struct simplefb_clock), GFP_KERNEL);
> +               if (!entry) {
> +                       clk_disable_unprepare(clock);
> +                       clk_put(clock);
> +                       continue;
> +               }

I'd allocate memory first, to avoid calling clk_disable_unprepare() (which
will kill your display) if memory allocation fails.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
