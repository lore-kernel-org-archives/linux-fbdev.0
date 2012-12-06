From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Thu, 06 Dec 2012 08:08:19 +0000
Subject: RE: [PATCH] da8xx: Allow use by am33xx based devices
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3EA1452B@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1351698968-3965-1-git-send-email-panto@antoniou-consulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>, "Porter, Matt" <mporter@ti.com>, "Dill, Russ" <russ.dill@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "FlorianSchandinat@gmx.de" <FlorianSchandinat@gmx.de>, Pantelis Antoniou <panto@antoniou-consulting.com>

Hi Tomi,

On Wed, Oct 31, 2012 at 10:52:59, Manjunathappa, Prakash wrote:
> Hi,
> 
> On Wed, Oct 31, 2012 at 21:26:08, Pantelis Antoniou wrote:
> > This driver can be used for AM33xx devices, like the popular beaglebone.
> > 
> > Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> > ---
> >  drivers/video/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> > index 9791d10..e7868d8 100644
> > --- a/drivers/video/Kconfig
> > +++ b/drivers/video/Kconfig
> > @@ -2202,7 +2202,7 @@ config FB_SH7760
> >  
> >  config FB_DA8XX
> >  	tristate "DA8xx/OMAP-L1xx Framebuffer support"
> > -	depends on FB && ARCH_DAVINCI_DA8XX
> > +	depends on FB && (ARCH_DAVINCI_DA8XX || SOC_AM33XX)
> 
> Agreed this is present on da8xx and am33xx, but moving forward for
> supporting DT, we should be avoiding these dependencies. So instead
> change this to remove machine dependencies.
> 

I could be wrong here, having dependency on platform seems to be right.
Otherwise may lead to build errors for other platforms. Please ignore my
comments and accept this patch.

Thanks,
Prakash
