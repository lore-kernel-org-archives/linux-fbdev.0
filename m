From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Tue, 27 Nov 2018 10:56:42 +0000
Subject: Re: [PATCH 1/2] dt-bindings: trivial: add ti,lm3630a binding
Message-Id: <20181127105642.uu56phxjfl7bjl2p@holly.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20181124141703.29232-1-masneyb@onstation.org>
In-Reply-To: <20181124141703.29232-1-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Masney <masneyb@onstation.org>
Cc: lee.jones@linaro.org, jingoohan1@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jonathan@marek.ca, ctatlor97@gmail.com

On Sat, Nov 24, 2018 at 09:17:02AM -0500, Brian Masney wrote:
> Add a trivial binding for the Texas Instruments LM3630A Backlight Chip.

It's quite unusual for a backlight device to have a trivial binding.

The driver supports fairly extensive parametrization via struct
lm3530a_platform_data. It is really the case that none of these
properties should ever be set via DT?


Daniel.


> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
> index 6ab001fa1ed4..86486368dc35 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/trivial-devices.txt
> @@ -182,6 +182,7 @@ taos,tsl2550		Ambient Light Sensor with SMBUS/Two Wire Serial Interface
>  ti,ads7828		8-Channels, 12-bit ADC
>  ti,ads7830		8-Channels, 8-bit ADC
>  ti,amc6821		Temperature Monitoring and Fan Control
> +ti,lm3630a		Texas Instruments LM3630A Backlight Chip
>  ti,tsc2003		I2C Touch-Screen Controller
>  ti,tmp102		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
>  ti,tmp103		Low Power Digital Temperature Sensor with SMBUS/Two Wire Serial Interface
> -- 
> 2.17.2
> 
