From: phil.edworthy@renesas.com
Date: Fri, 05 Oct 2012 16:34:54 +0000
Subject: Re: [PATCH v2] fbdev: Add Renesas vdc4 framebuffer driver
Message-Id: <OFA74CF6F8.392AD698-ON80257A8E.005AF45A-80257A8E.005B163E@eu.necel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347267372-22949-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1347267372-22949-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

Any news on this patch?

Thanks
Phil

> From: Jingoo Han <jg1.han@samsung.com>
> To: "'Phil Edworthy'" <phil.edworthy@renesas.com>, 
> Cc: "'Florian Tobias Schandinat'" <FlorianSchandinat@gmx.de>, linux-
> fbdev@vger.kernel.org, linux-sh@vger.kernel.org, "'Jingoo Han'" 
> <jg1.han@samsung.com>
> Date: 11/09/2012 03:31
> Subject: Re: [PATCH v2] fbdev: Add Renesas vdc4 framebuffer driver
> 
> On Monday, September 10, 2012 5:56 PM Phil Edworthy wrote
> > 
> > The vdc4 display hardware is found on the sh7269 device.
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> 
> Reviewed-by: Jingoo Han <jg1.han@samsung.com>
> 
> Best regards,
> Jingoo Han
> 
> 
> > ---
> > v2:
> >  * Use devm_ variants of clk_get, ioremap_nocache, request_irq.
> >  * Replace spaces with tabs.
> >  * Check ren_vdc4_start return value.
> >  * Fix headers used.
> > 
> >  drivers/video/Kconfig      |   10 +
> >  drivers/video/Makefile     |    1 +
> >  drivers/video/ren_vdc4fb.c |  641 +++++++++++++++++++++++++++++++
> +++++++++++++
> >  include/video/ren_vdc4fb.h |   19 ++
> >  4 files changed, 671 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/video/ren_vdc4fb.c
> >  create mode 100644 include/video/ren_vdc4fb.h
> 
> 

