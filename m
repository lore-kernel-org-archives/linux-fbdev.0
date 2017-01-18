From: Rob Herring <robh@kernel.org>
Date: Wed, 18 Jan 2017 22:33:10 +0000
Subject: Re: [PATCH v2 4/5] fbdev/ssd1307fb: add support to enable VBAT
Message-Id: <20170118223310.kxbgq47v7cl33ls3@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1484303628.git.jsarha@ti.com>
 <214ae9ca86009148f233be71a3606917f3150dcd.1484303628.git.jsarha@ti.com>
In-Reply-To: <214ae9ca86009148f233be71a3606917f3150dcd.1484303628.git.jsarha-l0cyMroinI0@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomi.valkeinen-l0cyMroinI0@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org

On Fri, Jan 13, 2017 at 12:35:48PM +0200, Jyri Sarha wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> SSD1306 needs VBAT when it is wired in charge pump configuration. This
> patch adds support to the driver to enable VBAT regulator at init time.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Reviewed-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  .../devicetree/bindings/display/ssd1307fb.txt        |  1 +
>  drivers/video/fbdev/ssd1307fb.c                      | 20 +++++++++++++++++++-
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> index 6617df6..209d931 100644
> --- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
> +++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
> @@ -16,6 +16,7 @@ Required properties:
>  Optional properties:
>    - reset-gpios: The GPIO used to reset the OLED display, if available. See
>                   Documentation/devicetree/bindings/gpio/gpio.txt for details.
> +  - vbat-supply: The supply for VBAT

According to the datasheet, SSD1307 has 2 supplies: Vdd and Vcc

I don't see any mention of a charge pump, so that must be an external 
component.

>    - solomon,segment-no-remap: Display needs normal (non-inverted) data column
>                                to segment mapping
>    - solomon,com-seq: Display uses sequential COM pin configuration
