From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 20 Jan 2014 01:34:41 +0000
Subject: Re: [PATCH v2] backlight: Convert from Legacy pm ops to dev_pm_ops
Message-Id: <001f01cf157f$ca2e8530$5e8b8f90$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <2236505237-3336-1-git-send-email-shuah.kh@samsung.com>
 <15798389.lgk83XnI1i@vostro.rjw.lan>
In-Reply-To: <15798389.lgk83XnI1i@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Shuah Khan' <shuah.kh@samsung.com>
Cc: 'Richard Purdie' <rpurdie@rpsys.net>, 'Florian Tobias Schandinat' <FlorianSchandinat@gmx.de>, 'Jean-Christophe PLAGNIOL-VILLARD' <plagnioj@jcrosoft.com>, 'Tomi Valkeinen' <tomi.valkeinen@ti.com>, "'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, 'Shuah Khan' <shuahkhan@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Monday, January 20, 2014 12:37 AM, Rafael J. Wysocki wrote:
> On Wednesday, November 14, 2040 04:27:17 AM Shuah Khan wrote:
> > Convert drivers/video/backlight/class to use dev_pm_ops for power
> > management and remove Legacy PM ops hooks. With this change, rtc class
> > registers suspend/resume callbacks via class->pm (dev_pm_ops) instead of
> > Legacy class->suspend/resume. When __device_suspend() runs call-backs,
> > it will find class->pm ops for the backlight class.
> >
> > Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
> > Cc: Shuah Khan <shuahkhan@gmail.com>
> 
> Can you please resend the patches that nobody took with CCs to
> linux-pm@vger.kernel.org?  If the original maintainers don't care, I'll be
> able to pick those patches up then (if they look good).

I already gave the comment, and am waiting v3 patch.
However, Shuah Khan did not send the v3 patch yet.

Currently, backlight subsystem patches go through mm-tree
With my acked-by.

Shuah Khan,
Will you send the v3 patch? As I said, there is the typo in
commit message. Please fix it. 
   s/rtc class/backlight class

Best regards,
Jingoo Han

> > ---
> >
> > v2: Updated changelog to correct device class.
> >
> >  drivers/video/backlight/backlight.c |    8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
> > index c74e7aa..0ffb251 100644
> > --- a/drivers/video/backlight/backlight.c
> > +++ b/drivers/video/backlight/backlight.c
> > @@ -208,7 +208,7 @@ static ssize_t backlight_show_actual_brightness(struct device *dev,
> >
> >  static struct class *backlight_class;
> >
> > -static int backlight_suspend(struct device *dev, pm_message_t state)
> > +static int backlight_suspend(struct device *dev)
> >  {
> >  	struct backlight_device *bd = to_backlight_device(dev);
> >
> > @@ -236,6 +236,9 @@ static int backlight_resume(struct device *dev)
> >  	return 0;
> >  }
> >
> > +static SIMPLE_DEV_PM_OPS(backlight_class_dev_pm_ops, backlight_suspend,
> > +			 backlight_resume);
> > +
> >  static void bl_device_release(struct device *dev)
> >  {
> >  	struct backlight_device *bd = to_backlight_device(dev);
> > @@ -414,8 +417,7 @@ static int __init backlight_class_init(void)
> >  	}
> >
> >  	backlight_class->dev_attrs = bl_device_attributes;
> > -	backlight_class->suspend = backlight_suspend;
> > -	backlight_class->resume = backlight_resume;
> > +	backlight_class->pm = &backlight_class_dev_pm_ops;
> >  	return 0;
> >  }
> >
> >

