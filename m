From: Brian Masney <masneyb@onstation.org>
Date: Mon, 01 Apr 2019 23:04:05 +0000
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <20190401230405.GA7877@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
 <20190401213926.GD14681@amd>
In-Reply-To: <20190401213926.GD14681@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, dmurphy@ti.com, jonathan@marek.ca

On Mon, Apr 01, 2019 at 11:39:26PM +0200, Pavel Machek wrote:
> On Mon 2019-04-01 06:30:33, Brian Masney wrote:
> > Add new backlight bindings for the TI LM3630A dual-string white LED.
> > 
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > ---
> >  .../leds/backlight/lm3630a-backlight.yaml     | 112
> ++++++++++++++++++
> 
> What is that? Is it future of all the bindings?
> 
> Up to device tree people, I guess, but...

Yes, this is the future format of the bindings so that automated
validation can be performed. See
Documentation/devicetree/writing-schema.md.

Brian
