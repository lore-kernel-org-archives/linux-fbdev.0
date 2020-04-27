From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 27 Apr 2020 09:33:06 +0000
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: Initialize the Display
Message-Id: <20200427093306.GU2682@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1586424337-26602-1-git-send-email-oliver.graute@gmail.com>
 <20200409102013.GP2001@kadam> <20200427083642.GD18436@portage>
In-Reply-To: <20200427083642.GD18436@portage>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oliver Graute <oliver.graute@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, Oliver Graute <oliver.graute@kococonnector.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On Mon, Apr 27, 2020 at 10:36:42AM +0200, Oliver Graute wrote:
> On 09/04/20, Dan Carpenter wrote:
> > On Thu, Apr 09, 2020 at 11:25:32AM +0200, Oliver Graute wrote:
> > > From: Oliver Graute <oliver.graute@kococonnector.com>
> > > 
> > > Set Gamma Values and Register Values for the HSD20_IPS
> > > 
> > > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > > ---
> > >  drivers/staging/fbtft/fb_st7789v.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> > > index 84c5af2dc9a0..b0aa96b703a8 100644
> > > --- a/drivers/staging/fbtft/fb_st7789v.c
> > > +++ b/drivers/staging/fbtft/fb_st7789v.c
> > > @@ -17,8 +17,8 @@
> > >  #define DRVNAME "fb_st7789v"
> > >  
> > >  #define DEFAULT_GAMMA \
> > > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25\n" \
> > > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25"
> > > +	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
> > > +	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
> > 
> > How do you know this won't break someone else's setup?
> 
> Should I declare an extra define for my values?
> 
> +#define HSD20_IPS_GAMMA \
> +	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
> +	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
> 

That's fine, but it can't be a compile time thing.  Both types of
hardware have to be working/available at run time.

regards,
dan carpenter
