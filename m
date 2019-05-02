From: Brian Masney <masneyb@onstation.org>
Date: Thu, 02 May 2019 10:46:12 +0000
Subject: Re: [PATCH v6 3/3] backlight: lm3630a: add firmware node support
Message-Id: <20190502104612.GB24563@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190424092505.6578-1-masneyb@onstation.org>
 <20190424092505.6578-4-masneyb@onstation.org>
 <3d8a2f9e-bd41-7713-5ad4-05a0d71e8fb1@linaro.org>
In-Reply-To: <3d8a2f9e-bd41-7713-5ad4-05a0d71e8fb1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca, Daniel Thompson <daniel@redfelineninja.org.uk>

On Thu, May 02, 2019 at 11:19:50AM +0100, Daniel Thompson wrote:
> On 24/04/2019 10:25, Brian Masney wrote:
> > Add fwnode support to the lm3630a driver and optionally allow
> > configuring the label, default brightness level, and maximum brightness
> > level. The two outputs can be controlled by bank A and B independently
> > or bank A can control both outputs.
> > 
> > If the platform data was not configured, then the driver defaults to
> > enabling both banks. This patch changes the default value to disable
> > both banks before parsing the firmware node so that just a single bank
> > can be enabled if desired. There are no in-tree users of this driver.
> 
> In that case given I'd certainly entertain patches that move the config
> structures out of include/linux/platform_data and say the driver requires a
> proper entry in the hardware description! Not a requirement though.

OK, I'll submit patches for that after this series is merged.

Brian
