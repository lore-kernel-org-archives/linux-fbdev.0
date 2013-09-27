From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 27 Sep 2013 00:08:17 +0000
Subject: Re: [PATCH 1/2] backlight: l4f00242t03: Remove redundant spi_set_drvdata
Message-Id: <00f201cebb15$aaecdc40$00c694c0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379659133-18799-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1379659133-18799-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday, September 26, 2013 5:48 PM, Tomi Valkeinen wrote:
> On 20/09/13 09:38, Sachin Kamat wrote:
> > Driver core sets driver data to NULL upon failure or remove.
> >
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > ---
> >  drivers/video/backlight/l4f00242t03.c |    1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/video/backlight/l4f00242t03.c b/drivers/video/backlight/l4f00242t03.c
> > index a35a38c..59eebe0 100644
> > --- a/drivers/video/backlight/l4f00242t03.c
> > +++ b/drivers/video/backlight/l4f00242t03.c
> > @@ -244,7 +244,6 @@ static int l4f00242t03_remove(struct spi_device *spi)
> >
> >  	l4f00242t03_lcd_power_set(priv->ld, FB_BLANK_POWERDOWN);
> >  	lcd_device_unregister(priv->ld);
> > -	spi_set_drvdata(spi, NULL);
> >
> >  	return 0;
> >  }
> >
> 
> Thanks, queuing this and the second patch for 3.13.
> 

Hi Tomi Valkeinen,

Andrew Morton already merged these patches to mm-tree with my Acked-by.
So, you don't need to queue these patches.
Thank you for caring. :-)

Best regards,
Jingoo Han

