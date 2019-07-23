From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Jul 2019 08:27:30 +0000
Subject: Re: [PATCH 4/4] video: amba-clcd: Spout an error if of_get_display_timing() gives an error
Message-Id: <CACRpkdazAx_5rxwYbKwMs_a7G2K5ETnxj0nUQ7TGarsv6bAv5A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190722182439.44844-1-dianders@chromium.org>
 <20190722182439.44844-5-dianders@chromium.org>
In-Reply-To: <20190722182439.44844-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Douglas Anderson <dianders@chromium.org>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Russell King <linux@armlinux.org.uk>, "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sam Ravnborg <sam@ravnborg.org>

On Mon, Jul 22, 2019 at 8:25 PM Douglas Anderson <dianders@chromium.org> wrote:

> In the patch ("video: of: display_timing: Don't yell if no timing node
> is present") we'll stop spouting an error directly in
> of_get_display_timing() if no node is present.  Presumably amba-clcd
> should take charge of spouting its own error now.
>
> NOTE: we'll print two errors if the node was present but there were
> problems parsing the timing node (one in of_parse_display_timing() and
> this new one).  Since this is a fatal error for the driver's probe
> (and presumably someone will be debugging), this should be OK.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
