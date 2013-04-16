From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 16 Apr 2013 00:53:12 +0000
Subject: Re: [PATCH v2] backlight: platform_lcd: introduce probe callback
Message-Id: <001601ce3a3c$c5680360$50380a20$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1365705391-23181-1-git-send-email-abrestic@chromium.org>
 <1365711890-15168-1-git-send-email-abrestic@chromium.org>
 <20130415160632.99e867b25418189c95fbc826@linux-foundation.org>
In-Reply-To: <20130415160632.99e867b25418189c95fbc826@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>, 'Andrew Bresticker' <abrestic@chromium.org>
Cc: linux-fbdev@vger.kernel.org, 'Richard Purdie' <rpurdie@rpsys.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, linux-kernel@vger.kernel.org, 'Doug Anderson' <dianders@chromium.org>, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, April 16, 2013 8:07 AM, Andrew Morton wrote:
> 
> On Thu, 11 Apr 2013 13:24:50 -0700 Andrew Bresticker <abrestic@chromium.org> wrote:
> 
> > Platform LCD devices may need to do some device-specific
> > initialization before they can be used (regulator or GPIO setup,
> > for example), but currently the driver does not support any way of
> > doing this.  This patch adds a probe() callback to plat_lcd_data
> > which platform LCD devices can set to indicate that device-specific
> > initialization is needed.
> >
> > index 17a6b83..f46180e 100644
> > --- a/drivers/video/backlight/platform_lcd.c
> > +++ b/drivers/video/backlight/platform_lcd.c
> > @@ -86,6 +86,12 @@ static int platform_lcd_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >
> > +	if (pdata->probe) {
> > +		err = pdata->probe(pdata);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> >  	plcd = devm_kzalloc(&pdev->dev, sizeof(struct platform_lcd),
> >  			    GFP_KERNEL);
> >  	if (!plcd) {
> > diff --git a/include/video/platform_lcd.h b/include/video/platform_lcd.h
> > index ad3bdfe..23864b2 100644
> > --- a/include/video/platform_lcd.h
> > +++ b/include/video/platform_lcd.h
> > @@ -15,6 +15,7 @@ struct plat_lcd_data;
> >  struct fb_info;
> >
> >  struct plat_lcd_data {
> > +	int	(*probe)(struct plat_lcd_data *);
> >  	void	(*set_power)(struct plat_lcd_data *, unsigned int power);
> >  	int	(*match_fb)(struct plat_lcd_data *, struct fb_info *);
> >  };
> 
> Sigh.  I see that this entire interface has been lovingly undocumented.
> It's an invitation for us to grow bugs, incompatibilities, leaks, etc.
> 
> Possible example: what happens if pdata->probe does some resource
> allocation or device initialisation which should be backed out if, say,
> platform_lcd_probe() later fails?

Hi Andrew,

I agree with you.
Indeed, the documentation is necessary.

Andrew Bresticker,
Would you make the document?
It would be very helpful.

Best regards,
Jingoo Han


