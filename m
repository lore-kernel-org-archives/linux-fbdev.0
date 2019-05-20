From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 20 May 2019 13:14:03 +0000
Subject: Re: [PATCH] dt-bindings: backlight: lm3630a: correct schema validation
Message-Id: <CAL_JsqLcycH5e=YT-4AQFo-8O0bosjU7oagCRS5CMTfQNBLrcg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520085846.22320-1-masneyb@onstation.org>
In-Reply-To: <20190520085846.22320-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Jonathan Marek <jonathan@marek.ca>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>

On Mon, May 20, 2019 at 3:59 AM Brian Masney <masneyb@onstation.org> wrote:
>
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

Reviewed-by: Rob Herring <robh@kernel.org>
