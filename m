From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 08 Jan 2013 01:25:35 +0000
Subject: Re: [PATCH] backlight: check null deference of name when device is registered
Message-Id: <003c01cded3f$0f25a3e0$2d70eba0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <000b01cdea55$92725aa0$b7570fe0$%han@samsung.com>
 <20130107160137.dec5098a.akpm@linux-foundation.org>
In-Reply-To: <20130107160137.dec5098a.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, linux-fbdev@vger.kernel.org, 'Richard Purdie' <rpurdie@rpsys.net>, 'Devendra Naga' <devendra.aaru@gmail.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Tuesday, January 08, 2013 9:02 AM, Andrew Morton wrote
> On Fri, 04 Jan 2013 17:29:11 +0900
> Jingoo Han <jg1.han@samsung.com> wrote:
> 
> > NULL deference of name is checked when device is registered.
> > If the name is null, it will cause a kernel oops in dev_set_name().
> >
> > ...
> >
> > --- a/drivers/video/backlight/backlight.c
> > +++ b/drivers/video/backlight/backlight.c
> > @@ -292,6 +292,11 @@ struct backlight_device *backlight_device_register(const char *name,
> >  	struct backlight_device *new_bd;
> >  	int rc;
> >
> > +	if (name = NULL) {
> > +		pr_err("backlight name is null\n");
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> >  	pr_debug("backlight_device_register: name=%s\n", name);
> 
> I don't understand this.
> 
> Is there some driver which is calling these functions with name=NULL?
> If so, which one(s)?

No, there is no one.

> 
> If "no" then why don't we declare that "passing name=NULL is a bug" and
> leave the code as-is?

Do you mean following?

+	if (name = NULL)
+		pr_err("passing name=NULL is a bug");
+
  	pr_debug("backlight_device_register: name=%s\n", name);


Best regards,
Jingoo Han



