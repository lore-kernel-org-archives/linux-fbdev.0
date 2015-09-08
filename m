From: Andrew Lunn <andrew@lunn.ch>
Date: Tue, 08 Sep 2015 13:41:40 +0000
Subject: Re: [PATCHv2 3/3] devicetree: Add led-backlight binding
Message-Id: <20150908134140.GH30736@lunn.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441711176-4258-1-git-send-email-tomi.valkeinen@ti.com>
 <1441711176-4258-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1441711176-4258-4-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org

On Tue, Sep 08, 2015 at 02:19:36PM +0300, Tomi Valkeinen wrote:
> Add DT binding for led-backlight.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  .../bindings/video/backlight/led-backlight.txt     | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/led-backlight.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/backlight/led-backlight.txt b/Documentation/devicetree/bindings/video/backlight/led-backlight.txt
> new file mode 100644
> index 000000000000..fb77051ac230
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/led-backlight.txt
> @@ -0,0 +1,30 @@
> +led-backlight bindings
> +
> +Required properties:
> +  - compatible: "led-backlight"
> +  - leds: phandle to a led OF node [0]
> +  - brightness-levels: Array of distinct LED brightness levels. These
> +      are in the range from 0 to 255, passed to the LED class driver.
> +  - default-brightness-level: the default brightness level (index into the
> +      array defined by the "brightness-levels" property)
> +  - power-supply: regulator for supply voltage

Hi Tomi

Maybe this regulator should be optional? I could imagine blacklights
without one, in none power sensitive cases, e.g. industrial PC with a
touch screen display, train ticket machine, etc.

      Andrew
