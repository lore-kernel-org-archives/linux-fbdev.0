From: Brian Masney <masneyb@onstation.org>
Date: Sun, 07 Apr 2019 11:28:21 +0000
Subject: Re: [PATCH v2 2/3] dt-bindings: backlight: add lm3630a bindings
Message-Id: <20190407112821.GA6922@basecamp>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190401103034.21062-1-masneyb@onstation.org>
 <20190401103034.21062-3-masneyb@onstation.org>
 <68229e7f-4749-cde5-f541-793ab614084d@ti.com>
 <20190402132440.GA10359@basecamp>
 <c88d954a-ce37-35dc-414b-df28d6095d89@ti.com>
In-Reply-To: <c88d954a-ce37-35dc-414b-df28d6095d89@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Murphy <dmurphy@ti.com>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, jonathan@marek.ca

Hi Dan,

On Tue, Apr 02, 2019 at 08:44:22AM -0500, Dan Murphy wrote:
> Also one other comment I noticed when reviewing the code that there is no definition to
> which child led properties are optional and which are required?

With the new YAML bindings, there is a separate toplevel 'required' tag in
the schema. Here is a snippet from my last submission that illustrates
this:

    properties:
      compatible:
        const: ti,lm3630a
    
      reg:
        maxItems: 1
    
      ti,linear-mapping-mode:
        description: |
          Enable linear mapping mode. If disabled, then it will use exponential
          mapping mode in which the ramp up/down appears to have a more uniform
          transition to the human eye.
        type: boolean
    
    required:
      - compatible
      - reg

So 'ti,linear-mapping-mode' is optional in this example.

> > +      led-sources:
> > +        description: |
> > +          List of device current outputs the LED is connected to.
> > +        allOf:
> > +          - $ref: /schemas/types.yaml#/definitions/uint32-array
> > +          - minItems: 1
> > +            maxItems: 2
> > +            items:
> > +              minimum: 0
> > +              maximum: 1
> > +
> 
> label and led-sources are already defined in the common.txt no need to redefine them here.

We'll still need to define the led-sources and label in this binding
with the new format even though it will also be in the LED common
bindings. We won't have to put the common things like the description
since that information will come from the common binding. We only need
to specify the additional constraints like the min/max number of items
and the min/max value for each item for this particular example.

Brian
