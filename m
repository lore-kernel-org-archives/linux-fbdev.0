From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 03 Nov 2015 11:08:44 +0000
Subject: Re: [PATCH v2] pwm-backlight: fix the panel power sequence
Message-Id: <1446548924.3373.3.camel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444987060-48202-1-git-send-email-yh.huang@mediatek.com>
 <1444988219.3541.3.camel@pengutronix.de>
 <1445526750.27586.8.camel@mtksdaap41>
 <1446133259.3274.52.camel@pengutronix.de>
 <1446190900.17558.16.camel@mtksdaap41>
 <1446201271.3334.22.camel@pengutronix.de>
 <1446538299.2449.8.camel@mtksdaap41>
In-Reply-To: <1446538299.2449.8.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi YH,

Am Dienstag, den 03.11.2015, 16:11 +0800 schrieb YH Huang:
> > The reasoning is that devices where there is no phandle link pointing to
> > the backlight (for example from a simple-panel node), we should keep the
> > current default behaviour (enable during probe).
> 
> I have a little problem for the current default behaviour.
> Should we enable during probe?

Here I mean enabling the backlight (at the end of the probe function),
not enabling the GPIO already when requesting it.

> Before this patch ( http://patchwork.ozlabs.org/patch/324690/ ),
> we disable "enable-gpio" in the probe function.

While before this patch the GPIO would be initialized in the disabled
state, the call to backlight_update_status at the end of the probe
function would still enable the backlight afterwards.

regards
Philipp

