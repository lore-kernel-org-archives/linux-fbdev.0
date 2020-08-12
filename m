From: Joe Perches <joe@perches.com>
Date: Wed, 12 Aug 2020 22:32:32 +0000
Subject: Re: [PATCH] dt-bindings: Whitespace clean-ups in schema files
Message-Id: <f5dedf2d8d8057de3eaa2f9126f44cebb0653b09.camel@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200812203618.2656699-1-robh@kernel.org>
In-Reply-To: <20200812203618.2656699-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org, linux-usb@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

On Wed, 2020-08-12 at 14:36 -0600, Rob Herring wrote:
> Clean-up incorrect indentation, extra spaces, long lines, and missing
> EOF newline in schema files. Most of the clean-ups are for list
> indentation which should always be 2 spaces more than the preceding
                                     ^
> keyword.
[]
> diff --git a/Documentation/devicetree/bindings/arm/arm,integrator.yaml b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> index 192ded470e32..f0daf990e077 100644
> --- a/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,integrator.yaml
> @@ -67,9 +67,9 @@ patternProperties:
>        compatible:
>          items:
>            - enum:
> -            - arm,integrator-ap-syscon
> -            - arm,integrator-cp-syscon
> -            - arm,integrator-sp-syscon
> +              - arm,integrator-ap-syscon
> +              - arm,integrator-cp-syscon
> +              - arm,integrator-sp-syscon

Confused a bit here.
          - enum:
	10 spaces to dash
old line:
            - arm,integrator-ap-syscon
	12 spaces to dash
new line:
              - arm,integrator-ap-syscon
	14 spaces to dash

Is it supposed to be 2 spaces more than the preceding line
or 4 more?
