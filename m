From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 30 Jul 2017 18:26:15 +0000
Subject: Re: [PATCH 5/6] drm/tinydrm: add support for LEGO MINDSTORMS EV3 LCD
Message-Id: <CAHp75VdEcsdnhzi9PX6ziDTbp3KWNtyCZdBseYZ8_yNzus0-ng@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1501355870-13960-1-git-send-email-david@lechnology.com>
 <1501355870-13960-6-git-send-email-david@lechnology.com>
In-Reply-To: <1501355870-13960-6-git-send-email-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Lechner <david@lechnology.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, linux-fbdev@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Sat, Jul 29, 2017 at 10:17 PM, David Lechner <david@lechnology.com> wrote:
> LEGO MINDSTORMS EV3 has an LCD with a ST7586 controller. This adds a new
> module for the ST7586 controller with parameters for the EV3 LCD dispay.

>  .../devicetree/bindings/display/mipi-panel.txt     |  2 +-
>  drivers/gpu/drm/tinydrm/mipi-panel.c               | 87 ++++++++++++++++++++++\]

C'mon, changes here have nothing to do with the framework itself!

Header, OTOH, has been looking fine.

-- 
With Best Regards,
Andy Shevchenko
