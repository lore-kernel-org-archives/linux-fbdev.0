From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 16 Nov 2017 12:32:00 +0000
Subject: Re: [PATCH v2 1/4] omapdrm: fix compatible string for td028ttec1
Message-Id: <4753a425-d050-7f2d-35ae-b387accfd99e@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1510822218.git.hns@goldelico.com>
 <474bfc72b67e1d0e2a223084a69f04d2baa1dda8.1510822218.git.hns@goldelico.com>
In-Reply-To: <474bfc72b67e1d0e2a223084a69f04d2baa1dda8.1510822218.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, letux-kernel@openphoenux.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-fbdev@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 16/11/17 10:50, H. Nikolaus Schaller wrote:
> The vendor name was "toppoly" but other panels and the vendor list
> have defined it as "tpo". So let's fix it in driver and bindings.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---


> -MODULE_ALIAS("spi:toppoly,td028ttec1");
> +MODULE_ALIAS("spi:tpo,td028ttec1");

Doesn't this mean that the module won't load if you have old bindings?
Can't we have two module aliases?

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
