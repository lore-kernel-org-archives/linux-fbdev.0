From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 26 Nov 2013 08:19:58 +0000
Subject: Re: [PATCH v3] video: add OpenCores VGA/LCD framebuffer driver
Message-Id: <CAMuHMdVx_jkUMB=gS0CtguBPB4f3fNRx0z4hB4zRz9OC09SvsQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1385094870-6962-1-git-send-email-stefan.kristiansson@saunalahti.fi>
	<52944976.4060003@monstr.eu>
In-Reply-To: <52944976.4060003@monstr.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <monstr@monstr.eu>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

On Tue, Nov 26, 2013 at 8:10 AM, Michal Simek <monstr@monstr.eu> wrote:
> On 11/22/2013 05:34 AM, Stefan Kristiansson wrote:
> This construction seems to me too complicated and can be simpler.
>
> What about this?
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

Don't forget to check for res being non-NULL here.

>         res->flags &= ~IORESOURCE_CACHEABLE;
>         fbdev->regs = devm_ioremap_resource(&pdev->dev, res);
>         if (IS_ERR(fbdev->regs))
>                 return PTR_ERR(fbdev->regs);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
