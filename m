From: Rob Herring <robh@kernel.org>
Date: Wed, 08 Jun 2016 20:09:56 +0000
Subject: Re: [PATCH 2/3] fbdev: ssd1307fb: Remove reset-active-low from the DT binding document
Message-Id: <20160608200956.GA15788@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1465303439.git.jsarha@ti.com>
 <fc99babab77bbf9fcbe34fc82d7e2a18f9a1e464.1465303439.git.jsarha@ti.com>
In-Reply-To: <fc99babab77bbf9fcbe34fc82d7e2a18f9a1e464.1465303439.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org

On Tue, Jun 07, 2016 at 04:51:13PM +0300, Jyri Sarha wrote:
> Remove reset-active-low from the devicetree binding document. The actual
> implementation has never been there in the driver code and there is no
> reason to add it because the gpiod API supports gpio flags, including
> GPIO_ACTIVE_LOW, directly trough its own devicetree binding.
> 
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  Documentation/devicetree/bindings/display/ssd1307fb.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> index eb31ed4..4aee67f 100644
> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> @@ -8,14 +8,14 @@ Required properties:
>           0x3c or 0x3d
>    - pwm: Should contain the pwm to use according to the OF device tree PWM
>           specification [0]. Only required for the ssd1307.
> -  - reset-gpios: Should contain the GPIO used to reset the OLED display
> +  - reset-gpios: Should contain the GPIO used to reset the OLED display. See
> +                 Documentation/devicetree/bindings/gpio/gpio.txt for details.

You should state here it is active low.

>    - solomon,height: Height in pixel of the screen driven by the controller
>    - solomon,width: Width in pixel of the screen driven by the controller
>    - solomon,page-offset: Offset of pages (band of 8 pixels) that the screen is
>      mapped to.
>  
>  Optional properties:
> -  - reset-active-low: Is the reset gpio is active on physical low?
>    - solomon,segment-no-remap: Display needs normal (non-inverted) data column
>                                to segment mapping
>    - solomon,com-seq: Display uses sequential COM pin configuration
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
