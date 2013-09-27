From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Fri, 27 Sep 2013 03:59:20 +0000
Subject: Re: [PATCH] video: mxsfb: Add missing break
Message-Id: <20130927035920.GG18477@ns203013.ovh.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380194038-5148-1-git-send-email-marex@denx.de>
 <524429C0.2020907@ti.com> <201309261504.45088.marex@denx.de>
In-Reply-To: <201309261504.45088.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 15:04 Thu 26 Sep     , Marek Vasut wrote:
> Hi Tomi,
> 
> > On 26/09/13 14:13, Marek Vasut wrote:
> > > Add missing break into the restore function.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > > Cc: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > ---
> > > 
> > >  drivers/video/mxsfb.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> > > index d250ed0..27197a8 100644
> > > --- a/drivers/video/mxsfb.c
> > > +++ b/drivers/video/mxsfb.c
> > > @@ -620,6 +620,7 @@ static int mxsfb_restore_mode(struct mxsfb_info
> > > *host)
> > > 
> > >  		break;
> > >  	
> > >  	case 3:
> > >  		bits_per_pixel = 32;
> > > 
> > > +		break;
> > > 
> > >  	case 1:
> > >  	
> > >  	default:
> > >  		return -EINVAL;
> > 
> > Thanks, queued for 3.12 fixes.
> 
> Can you please also queue this for stable 3.10? It's broken there too.

this you have to do it by yourself by cc stable

Greg will take it not us

Best Regards,
J.
> 
> Thanks!
> 
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fbdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
