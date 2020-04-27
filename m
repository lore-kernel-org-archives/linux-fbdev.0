From: Oliver Graute <oliver.graute@gmail.com>
Date: Mon, 27 Apr 2020 08:36:42 +0000
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: Initialize the Display
Message-Id: <20200427083642.GD18436@portage>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1586424337-26602-1-git-send-email-oliver.graute@gmail.com>
 <20200409102013.GP2001@kadam>
In-Reply-To: <20200409102013.GP2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, Oliver Graute <oliver.graute@kococonnector.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On 09/04/20, Dan Carpenter wrote:
> On Thu, Apr 09, 2020 at 11:25:32AM +0200, Oliver Graute wrote:
> > From: Oliver Graute <oliver.graute@kococonnector.com>
> > 
> > Set Gamma Values and Register Values for the HSD20_IPS
> > 
> > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > ---
> >  drivers/staging/fbtft/fb_st7789v.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> > index 84c5af2dc9a0..b0aa96b703a8 100644
> > --- a/drivers/staging/fbtft/fb_st7789v.c
> > +++ b/drivers/staging/fbtft/fb_st7789v.c
> > @@ -17,8 +17,8 @@
> >  #define DRVNAME "fb_st7789v"
> >  
> >  #define DEFAULT_GAMMA \
> > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25\n" \
> > -	"70 2C 2E 15 10 09 48 33 53 0B 19 18 20 25"
> > +	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
> > +	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"
> 
> How do you know this won't break someone else's setup?

Should I declare an extra define for my values?

+#define HSD20_IPS_GAMMA \
+	"D0 05 0A 09 08 05 2E 44 45 0F 17 16 2B 33\n" \
+	"D0 05 0A 09 08 05 2E 43 45 0F 16 16 2B 33"

> 
> Without knowing anything at all about this driver, it feels like this
> should be:
> 
> 	if (new_hardware)
> 		write_reg(par, PORCTRL, 0x05, 0x05, 0x00, 0x33, 0x33);
> 	else
> 		write_reg(par, PORCTRL, 0x08, 0x08, 0x00, 0x22, 0x22);

ok, I'll update this.

Best regards,

Oliver
