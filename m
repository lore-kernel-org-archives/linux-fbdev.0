From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 30 Dec 2016 08:23:59 +0000
Subject: Re: [PATCH 0/4] video: ARM CLCD: add support of an optional GPIO to enable panel
Message-Id: <CACRpkdZE6VgJA27+Wh=Gxd7yOXpLMyT7yCB2PYA36y0gvosHFQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20161221032717.13154-1-vz@mleia.com>
In-Reply-To: <20161221032717.13154-1-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 21, 2016 at 4:27 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:

> The changeset contains a number of cleanups, changed semantics of
> init_panel() callback, which allows to simplify getting of panel
> properties from panel device tree node, and a handling of optional
> "enable-gpios" panel property, the latter is described in
> display/panel/panel-dpi.txt device tree binding documentation, but
> it has been unsupported by the ARM CLCD driver.
>
> Vladimir Zapolskiy (4):
>   video: ARM CLCD: sort included headers out alphabetically
>   video: ARM CLCD: use panel device node for panel initialization
>   video: ARM CLCD: use panel device node for getting backlight and mode
>   video: ARM CLCD: add support of an optional GPIO to enable panel

As you may have seen Tomi has stepped down as FBDEV maintainer and
this subsystem is now orphaned.

I guess Andrew Morton merges patches for it in this case, he usually does.

But what we should actually do is create a new DRM driver for CLCD
in drivers/gpu/drm/arm/clcd*

It's maybe not a small undertaking :(

But in case you're interested in the job, I will pitch in and test the result
on all ARM reference designs plus Nomadik.

Yours,
Linus Walleij
