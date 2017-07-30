From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Jul 2017 18:10:59 +0000
Subject: Re: [PATCH 1/6] drm/tinydrm: Add parameter for MIPI DCS pixel format
Message-Id: <CAHp75Vd9=gK3tsXbw5=7j75BJkOJVkqf7rf7WRQ9gF5+XP19cg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <1501355870-13960-2-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-2-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Sat, Jul 29, 2017 at 10:17 PM, David Lechner <david@lechnology.com> wrote:
> This adds a parameter for MIPI DCS pixel format to mipi_dbi_init().
> This is in preparation for supporting displays that don't use a 16bpp
> memory layout.

>  /* MIPI DCS pixel formats */
> -#define MIPI_DCS_PIXEL_FMT_24BIT       7
> -#define MIPI_DCS_PIXEL_FMT_18BIT       6
> -#define MIPI_DCS_PIXEL_FMT_16BIT       5
> -#define MIPI_DCS_PIXEL_FMT_12BIT       3
> -#define MIPI_DCS_PIXEL_FMT_8BIT                2
> -#define MIPI_DCS_PIXEL_FMT_3BIT                1
> +enum mipi_dcs_pixel_format {
> +       MIPI_DCS_PIXEL_FMT_24BIT        = 7,
> +       MIPI_DCS_PIXEL_FMT_18BIT        = 6,
> +       MIPI_DCS_PIXEL_FMT_16BIT        = 5,
> +       MIPI_DCS_PIXEL_FMT_12BIT        = 3,
> +       MIPI_DCS_PIXEL_FMT_8BIT         = 2,
> +       MIPI_DCS_PIXEL_FMT_3BIT         = 1,
> +};

May I ask what prevents us to arrange enums in natural
 ordering (you may keep = X parts, of course)?

-- 
With Best Regards,
Andy Shevchenko
