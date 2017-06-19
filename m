From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Jun 2017 20:47:20 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: avoid conflicting vesafb
Message-Id: <CAHp75VdQ0BoKtbr5m--sZH1yHs=Oo-B577VnxoO8E-0jn0QzCA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

On Mon, Jun 19, 2017 at 11:32 PM, Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:


> +#ifdef CONFIG_X86
> +       primary = pdev->resource[PCI_ROM_RESOURCE].flags &
> +                                       IORESOURCE_ROM_SHADOW;
> +#endif

Why do we need #ifdef?

In any case you may introduce a temporary variable to have pointer to resource

struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];

-- 
With Best Regards,
Andy Shevchenko
