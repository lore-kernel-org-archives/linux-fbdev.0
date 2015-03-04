From: Peter Chen <peter.chen@freescale.com>
Date: Wed, 04 Mar 2015 06:57:58 +0000
Subject: Re: [PATCH] video: mxsfb: Make sure axi clock is enabled when accessing registers
Message-Id: <20150304065757.GB2689@shlinux2>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1425448735-21490-1-git-send-email-Ying.Liu@freescale.com>
 <20150304060817.GA12241@kroah.com>
In-Reply-To: <20150304060817.GA12241@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Liu Ying <Ying.Liu@freescale.com>, linux-fbdev@vger.kernel.org, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Fabio Estevam <fabio.estevam@freescale.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Tue, Mar 03, 2015 at 10:08:17PM -0800, Greg KH wrote:
> On Wed, Mar 04, 2015 at 01:58:55PM +0800, Liu Ying wrote:
> > The LCDIF engines embedded in i.MX6sl and i.MX6sx SoCs need the axi clock
> > as the engine's system clock.  The clock should be enabled when accessing
> > LCDIF registers, otherwise the kernel would hang up.  We should also keep
> > the clock being enabled when the engine is being active to scan out frames
> > from memory.  This patch makes sure the axi clock is enabled when accessing
> > registers so that the kernel hang up issue can be fixed.
> > 
> > Reported-by: Peter Chen <peter.chen@freescale.com>
> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> > ---
> >  drivers/video/fbdev/mxsfb.c | 70 ++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 56 insertions(+), 14 deletions(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
> for how to do this properly.
> 
> </formletter>

Hi Greg,

I find this system hang issue at v4.0, and it should exist at v3.19 too.
Do you mean Ying forget to add tag "Cc: stable@vger.kernel.org # 3.19"
at commit log or you think this fix is too large?

-- 

Best Regards,
Peter Chen
