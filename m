From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Jul 2010 08:14:52 +0000
Subject: Re: [PATCH] fbdev: sh-mobile-lcdc: fix potential Oops in SH-Mobile
Message-Id: <AANLkTikcI1KTOsvhabvi1nPccEYFAgvR080jKXBfD3qs@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Jun 30, 2010 at 6:26 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> sh_mobile_lcdc_setup_clocks() can perform IO, therefore it has to be called
> after ioremap(). Also check return code of ioremap() and use resource_size()
> instead of open-coding it.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, looks fine.
Acked-by: Magnus Damm <damm@opensource.se>
