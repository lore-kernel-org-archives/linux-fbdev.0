From: Andreas Kemnade <andreas@kemnade.info>
Date: Sat, 05 Oct 2019 18:19:19 +0000
Subject: Re: [PATCH] backlight: lm3630a: fix module aliases
Message-Id: <20191005201919.013524da@aktux>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190910152359.7448-1-andreas@kemnade.info>
        <20190911105148.4prmcr2f2r36sgrf@holly.lan>
In-Reply-To: <20190911105148.4prmcr2f2r36sgrf@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com

Hi,

hmm, this bugfix has not arrived in -next or any -fixes branch I am
aware of yet. I hope it is not forgotten...
so a friendly ping.

Regards,
Andreas

On Wed, 11 Sep 2019 11:51:48 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> On Tue, Sep 10, 2019 at 05:23:59PM +0200, Andreas Kemnade wrote:
> > Devicetree aliases are missing, so that module autoloading
> > does not work properly.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> 
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> 
> > ---
> >  drivers/video/backlight/lm3630a_bl.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
> > index 3b45a1733198..9d67c07db2f2 100644
> > --- a/drivers/video/backlight/lm3630a_bl.c
> > +++ b/drivers/video/backlight/lm3630a_bl.c
> > @@ -617,12 +617,14 @@ static const struct i2c_device_id lm3630a_id[] = {
> >  	{}
> >  };
> >  
> > +MODULE_DEVICE_TABLE(i2c, lm3630a_id);
> > +
> >  static const struct of_device_id lm3630a_match_table[] = {
> >  	{ .compatible = "ti,lm3630a", },
> >  	{ },
> >  };
> >  
> > -MODULE_DEVICE_TABLE(i2c, lm3630a_id);
> > +MODULE_DEVICE_TABLE(of, lm3630a_match_table);
> >  
> >  static struct i2c_driver lm3630a_i2c_driver = {
> >  	.driver = {
> > -- 
> > 2.11.0
> >   
> 
