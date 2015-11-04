From: YH Huang <yh.huang@mediatek.com>
Date: Wed, 04 Nov 2015 01:47:36 +0000
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Message-Id: <1446601656.15340.11.camel@mtksdaap41>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
 <1444988219.3541.3.camel@pengutronix.de>
 <1445526750.27586.8.camel@mtksdaap41>
 <1446133259.3274.52.camel@pengutronix.de>
 <1446190900.17558.16.camel@mtksdaap41>
 <1446201271.3334.22.camel@pengutronix.de>
 <1446538299.2449.8.camel@mtksdaap41>
 <1446548924.3373.3.camel@pengutronix.de>
In-Reply-To: <1446548924.3373.3.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2015-11-03 at 12:08 +0100, Philipp Zabel wrote:
> Hi YH,
> 
> Am Dienstag, den 03.11.2015, 16:11 +0800 schrieb YH Huang:
> > > The reasoning is that devices where there is no phandle link pointing to
> > > the backlight (for example from a simple-panel node), we should keep the
> > > current default behaviour (enable during probe).
> > 
> > I have a little problem for the current default behaviour.
> > Should we enable during probe?
> 
> Here I mean enabling the backlight (at the end of the probe function),
> not enabling the GPIO already when requesting it.
> 
> > Before this patch ( http://patchwork.ozlabs.org/patch/324690/ ),
> > we disable "enable-gpio" in the probe function.
> 
> While before this patch the GPIO would be initialized in the disabled
> state, the call to backlight_update_status at the end of the probe
> function would still enable the backlight afterwards.

Based on this, could we disable it initially and update in the
backlight_update_status function?

Like this,

if (pb->enable_gpio) {
	if (phandle &&
	    gpiod_get_direction(pb->enable_gpio) = GPIOF_DIR_OUT &&
	    gpiod_get_value(pb->enable_gpio) = 1)
		gpiod_direction_output(pb->enable_gpio, 1);
	else
		gpiod_direction_output(pb->enable_gpio, 0);
}

And then update with props.brightness in backlight_update_status.
I am not sure, maybe I miss something.

Regards,
YH Huang

