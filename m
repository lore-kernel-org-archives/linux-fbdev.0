From: Oliver Graute <oliver.graute@gmail.com>
Date: Mon, 27 Apr 2020 08:31:24 +0000
Subject: Re: [PATCH v1] staging: fbtft: fb_st7789v: enabled inversion
Message-Id: <20200427083124.GC18436@portage>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1586424250-25897-1-git-send-email-oliver.graute@gmail.com>
 <20200409101416.GN2001@kadam>
In-Reply-To: <20200409101416.GN2001@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, gregkh@linuxfoundation.org, Oliver Graute <oliver.graute@kococonnector.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org

On 09/04/20, Dan Carpenter wrote:
> On Thu, Apr 09, 2020 at 11:24:05AM +0200, Oliver Graute wrote:
> > From: Oliver Graute <oliver.graute@kococonnector.com>
> > 
> > Enable inversion mode
> > 
> > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > ---
> >  drivers/staging/fbtft/fb_st7789v.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/fb_st7789v.c
> > index 3c3f387936e8..84c5af2dc9a0 100644
> > --- a/drivers/staging/fbtft/fb_st7789v.c
> > +++ b/drivers/staging/fbtft/fb_st7789v.c
> > @@ -120,6 +120,10 @@ static int init_display(struct fbtft_par *par)
> >  	write_reg(par, PWCTRL1, 0xA4, 0xA1);
> >  
> >  	write_reg(par, MIPI_DCS_SET_DISPLAY_ON);
> > +
> > +	/* enable inversion mode */
> > +	write_reg(par, 0x21);
> 
> Use the define and delete the comment.
> 
> 	write_reg(par, MIPI_DCS_ENTER_INVERT_MODE);

ok, I'll do on next version

Best regards,

Oliver
