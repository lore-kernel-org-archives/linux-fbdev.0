From: Alex Courbot <acourbot@nvidia.com>
Date: Fri, 19 Oct 2012 09:31:53 +0000
Subject: Re: [PATCH v7 2/3] pwm_backlight: use power sequences
Message-Id: <2048338.SjS64CMeN7@percival>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350637589-7405-1-git-send-email-acourbot@nvidia.com> <1350637589-7405-3-git-send-email-acourbot@nvidia.com> <1350638436.3339.2.camel@gitbox>
In-Reply-To: <1350638436.3339.2.camel@gitbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tony Prisk <linux@prisktech.co.nz>
Cc: Stephen Warren <swarren@nvidia.com>, Thierry Reding <thierry.reding@avionic-design.de>, Simon Glass <sjg@chromium.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Anton Vorontsov <cbou@mail.ru>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Leela Krishna Amudala <l.krishna@samsung.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On Friday 19 October 2012 17:20:36 Tony Prisk wrote:
> On Fri, 2012-10-19 at 18:06 +0900, Alexandre Courbot wrote:
> > +static void pwm_backlight_on(struct backlight_device *bl)
> > +{
> > +     struct pwm_bl_data *pb = dev_get_drvdata(&bl->dev);
> > +     int ret;
> > +
> > +     if (pb->enabled)
> > +             return;
> > +
> > +     if (pb->power_on_seq) {
> > +             ret = power_seq_run(pb->power_on_seq);
> > +             if (ret < 0) {
> > +                     dev_err(&bl->dev, "cannot run power on
> > sequence\n");
> > +                     return;
> > +             }
> > +     } else {
> > +             /* legacy framework */
> > +             pwm_config(pb->pwm, 0, pb->period);
> > +             pwm_disable(pb->pwm);
> 
> Is this right? pwm_disable() in the backlight_on function?

Now everybody will notice that I never really tested the legacy interface. >_<

Thanks, this was totally wrong indeed.

Alex.

