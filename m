From: Rob Herring <robh@kernel.org>
Date: Tue, 14 Jun 2016 20:09:36 +0000
Subject: Re: [PATCH v2] backlight: lp855x: Add enable regulator
Message-Id: <20160614200936.GA9318@rob-hp-laptop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1465587597-131467-1-git-send-email-briannorris@chromium.org>
In-Reply-To: <1465587597-131467-1-git-send-email-briannorris@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Norris <briannorris@chromium.org>
Cc: Milo Kim <milo.kim@ti.com>, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Stephen Barber <smbarber@chromium.org>, Doug Anderson <dianders@chromium.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

On Fri, Jun 10, 2016 at 12:39:57PM -0700, Brian Norris wrote:
> The LP8556 datasheet describes an EN/VDDIO input, which serves "both as
> a chip enable and as a power supply reference for PWM, SDA, and SCL
> inputs." The LP8556 that I'm testing doesn't respond properly if I try
> to talk I2C to it too quickly after enabling VDDIO, and the LP8555
> datasheet mentions a t_RESPONSE delay of up to 1 millisecond.
> 
> Support this EN/VDDIO by adding a regulator property to the binding;
> enabling this regulator at probe time; and sleeping for 1 to 2ms, if the
> EN/VDDIO regulator was provided.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2: s/TS8555/LP8555/ in comment (typo)
> 
>  .../devicetree/bindings/leds/backlight/lp855x.txt  |  2 ++

I would have picked 'vddio' as the name, but it's fine.

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/video/backlight/lp855x_bl.c                | 29 ++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
