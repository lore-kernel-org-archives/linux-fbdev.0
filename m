From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 20 Jun 2017 20:08:58 +0000
Subject: Re: [PATCH 1/2] staging: sm750fb: avoid conflicting vesafb
Message-Id: <20170620200858.GA5287@sudip-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1497904378-4808-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VdQ0BoKtbr5m--sZH1yHs=Oo-B577VnxoO8E-0jn0QzCA@mail.gmail.com>
In-Reply-To: <CAHp75VdQ0BoKtbr5m--sZH1yHs=Oo-B577VnxoO8E-0jn0QzCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org

On Mon, Jun 19, 2017 at 11:47:20PM +0300, Andy Shevchenko wrote:
> On Mon, Jun 19, 2017 at 11:32 PM, Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> 
> 
> > +#ifdef CONFIG_X86
> > +       primary = pdev->resource[PCI_ROM_RESOURCE].flags &
> > +                                       IORESOURCE_ROM_SHADOW;
> > +#endif
> 
> Why do we need #ifdef?

It has been done in exactly the same way it is done in drm drivers.
All the drm drivers I have checked uses #ifdef.

See for example:
http://elixir.free-electrons.com/linux/v4.12-rc6/source/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c#L470

If you think #ifdef is not required, please send patch for the drm
drivers, and we follow that change here also.

> 
> In any case you may introduce a temporary variable to have pointer to resource
> 
> struct resource *res = &pdev->resource[PCI_ROM_RESOURCE];

No, we will not want to do it in a different way than the way it is done
by drm drivers.

--
Regards
Sudip
