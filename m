From: Brian Masney <masneyb@onstation.org>
Date: Fri, 17 May 2019 23:12:11 +0000
Subject: Re: [PATCH v6 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <20190517231211.GA7907@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190424092505.6578-1-masneyb@onstation.org>
 <20190424092505.6578-3-masneyb@onstation.org>
 <CAL_JsqLdS2SDd-dczZmqDTN3XMY7fwDjdkX5OibXbrksd7qQYA@mail.gmail.com>
In-Reply-To: <CAL_JsqLdS2SDd-dczZmqDTN3XMY7fwDjdkX5OibXbrksd7qQYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel <dri-devel@lists.freedesktop.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>, Jonathan Marek <jonathan@marek.ca>

Hi Rob,

On Fri, May 17, 2019 at 04:11:48PM -0500, Rob Herring wrote:
> On Wed, Apr 24, 2019 at 4:25 AM Brian Masney <masneyb@onstation.org> wrote:
> >
> > Add new backlight bindings for the TI LM3630A dual-string white LED.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > Changes since v5:
> > - Change 'lm3630a_bl@38' in examples to 'led-controller@38'
> >
> > Changes since v4:
> > - Drop $ref from led-sources
> > - Drop description from reg of i2c address
> > - Expand description of reg for the control bank
> > - Drop status from examples
> >
> > Changes since v3:
> > - Add label. I didn't add a description for it since that'll come from
> >   the common properties once its converted.
> >
> > Changes since v2:
> > - Update description of max-brightness
> > - Add description for reg
> > - Correct typo: s/tranisiton/transition
> > - add reg to control banks
> > - add additionalProperties
> >
> >  .../leds/backlight/lm3630a-backlight.yaml     | 129 ++++++++++++++++++
> >  1 file changed, 129 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml
> 
> I'm working on getting the examples to be validated by the schema (in
> addition to just building with dtc) and there's a couple of errors:
> 
> Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> '#address-cells', '#size-cells' do not match any of the regexes:
> '^led@[01]$', 'pinctrl-[0-9]+'
> Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> '#address-cells', '#size-cells' do not match any of the regexes:
> '^led@[01]$', 'pinctrl-[0-9]+'
> 
> You didn't list '#address-cells' and '#size-cells'.
> 
> Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> led@0: 'ti,linear-mapping-mode' does not match any of the regexes:
> 'pinctrl-[0-9]+'
> Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.example.dt.yaml:
> led@1: 'ti,linear-mapping-mode' does not match any of the regexes:
> 'pinctrl-[0-9]+'
> 
> 'ti,linear-mapping-mode' is not defined in the child nodes.

I'm sorry about that. I'll send out a patch this weekend to correct
this. I have 'make dt_binding_check' in my local build script. Is there
something else that I should be running as well? Or do you have a
branch somewhere with your validation work that I can test my changes
against?

Brian
