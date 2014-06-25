From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 25 Jun 2014 09:32:59 +0000
Subject: Re: [RFC v3 2/2] backlight: device tree: add new tps611xx backlight driver
Message-Id: <20140625093259.GC29789@leverpostej>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403594330-15387-1-git-send-email-gshark.jeong@gmail.com>
 <1403594330-15387-3-git-send-email-gshark.jeong@gmail.com>
In-Reply-To: <1403594330-15387-3-git-send-email-gshark.jeong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Jeong <gshark.jeong@gmail.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Daniel Jeong <daniel.jeong@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

Hello,

Please fix the subject: this is a _binding_, not a driver.

On Tue, Jun 24, 2014 at 08:18:50AM +0100, Daniel Jeong wrote:
> This commit is about tps611xx device tree documentation.
> 
> Signed-off-by: Daniel Jeong <gshark.jeong@gmail.com>
> ---
>  .../video/backlight/tps611xx-backlight.txt         |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
> new file mode 100644
> index 0000000..01f110d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/tps611xx-backlight.txt
> @@ -0,0 +1,16 @@
> +TPS611xx family of backlight driver based on EasyScale.
> +
> +It supports tps61158, tps61161, tps61163 and tps61165.

What supports these? The driver?

The binding should describe the _hardware_, not the driver.

> +Required properties:
> +- compatible: "ti,tps61158_bl", "ti,tps61161_bl", "ti,tps61163_bl", "ti,tps61165_bl"

Use '-' rather than '_' in compatible strings and properties.

Is there any reason for the "bl" suffix? Does that actually form part of
the name of the unit, or is that just to point out it's a backlight? If
it's the latter, drop it.

Are these all very similar? Can I use a particular string as a fallback?

To allow for future expansion, the addition of notes, and to make this
easier to read, I would recommend formatting this something like:

- compatible: should contain at least one of:
  * "ti,tps61158"
  * "ti,tps61161"
  * "ti,tps61163"
  * "ti,tps61165"

> +- rfa_en: enable request for acknowledge. ( 0 : disable , 1 : enable )

Use empty properties for describing booleans.

That said, why does this need to be in the DT? When would I want this
and when wouldn't I? Why can't the driver choose?

> +- en_gpio_num: gpio number for en pin.

Use the GPIO bindings. The numbering Linux uses internally is completely
arbitrary, so this is completely broken.

Are there other pins we might need to describe? Regulators? Clocks?

Mark.
