From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 Nov 2013 08:46:24 +0000
Subject: Re: [PATCH v2 19/19] fbdev: sh-mobile-lcdcfb: Enable the driver on all ARM platforms
Message-Id: <CAMuHMdWaprjsfyO548HCzou4W0yP1nqfw2rP66BudXWgY7uKww@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383086274-11049-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383086274-11049-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <alpine.DEB.2.02.1310312039330.13521@ayla.of.borg>
 <1671829.6znfm3IPYO@avalon>
In-Reply-To: <1671829.6znfm3IPYO@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 6, 2013 at 1:27 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +#ifdef CONFIG_PM_SLEEP
>>  static int sh_mobile_meram_suspend(struct device *dev)
>>  {
>>       struct platform_device *pdev = to_platform_device(dev);
>> @@ -592,7 +593,9 @@ static int sh_mobile_meram_suspend(struct device *dev)
>>       }
>>       return 0;
>>  }
>> +#endif
>>
>> +#ifdef CONFIG_PM_RUNTIME
>>  static int sh_mobile_meram_resume(struct device *dev)
>>  {
>>       struct platform_device *pdev = to_platform_device(dev);
>> @@ -611,6 +614,7 @@ static int sh_mobile_meram_resume(struct device *dev)
>>               meram_write_reg(priv->base, common_regs[i], priv->regs[i]);
>>       return 0;
>>  }
>> +#endif
>>
>>  static UNIVERSAL_DEV_PM_OPS(sh_mobile_meram_dev_pm_ops,
>>                           sh_mobile_meram_suspend,
>
> I'm a bit surprised, looking at the definition of UNIVERSAL_DEV_PM_OPS, I
> would have thought that both functions would be used when either
> CONFIG_PM_SLEEP or CONFIG_PM_RUNTIME is defined. I would thus have guarded
> both functions with #if defined(CONFIG_PM_SLEEP) ||
> defined(CONFIG_PM_RUNTIME).

You're right. I missed that both function pointers are passed to both macros.

Will send v2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
