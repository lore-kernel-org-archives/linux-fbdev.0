From: Rob Herring <robh@kernel.org>
Date: Fri, 28 Jun 2019 19:22:38 +0000
Subject: Re: [PATCH] dt-bindings: backlight: lm3630a: correct schema validation
Message-Id: <20190628192238.GA8617@bogus>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520085846.22320-1-masneyb@onstation.org>
In-Reply-To: <20190520085846.22320-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, daniel.thompson@linaro.org, jonathan@marek.ca, b.zolnierkie@samsung.com, jingoohan1@gmail.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, lee.jones@linaro.org, linux-leds@vger.kernel.org, dmurphy@ti.com

On Mon, 20 May 2019 04:58:46 -0400, Brian Masney wrote:
> The '#address-cells' and '#size-cells' properties were not defined in
> the lm3630a bindings and would cause the following error when
> attempting to validate the examples against the schema:
> 
> Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> '#address-cells', '#size-cells' do not match any of the regexes:
> '^led@[01]$', 'pinctrl-[0-9]+'
> 
> Correct this by adding those two properties.
> 
> While we're here, move the ti,linear-mapping-mode property to the
> led@[01] child nodes to correct the following validation error:
> 
> Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> led@0: 'ti,linear-mapping-mode' does not match any of the regexes:
> 'pinctrl-[0-9]+'
> 
> Fixes: 32fcb75c66a0 ("dt-bindings: backlight: Add lm3630a bindings")
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> Reported-by: Rob Herring <robh+dt@kernel.org>
> ---
>  .../leds/backlight/lm3630a-backlight.yaml     | 20 +++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 

Applied, thanks.

Rob
