From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2014 08:38:58 +0000
Subject: Re: [PATCH 1/4] dt-bindings: simplefb: Specify node location and handoff related properties
Message-Id: <CAMuHMdU4YTwyMrD5U1i3DYy=cvpocmzXqajySUfgBKVRhcAJVw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 12, 2014 at 11:08 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Since simplefb nodes do not relate directly to hw typically they have been
> placed in the root of the devicetree. As the represent runtime information
> having them as sub-nodes of /chosen is more logical, specify this.
>
> Also specify when to set the chosen stdout-path property to a simplefb node.
>
> For reliable handover to a hardware specific driver, that driver needs to
> know which simplefb to unregister when taking over, specify how the hw driver
> can find the matching simplefb node.
>
> Last add some advice on how to fill and use simplefb nodes from a firmware
> pov.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> ---
>  .../bindings/video/simple-framebuffer.txt          | 37 +++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> index 8f35718..95fe284 100644
> --- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> @@ -4,6 +4,26 @@ A simple frame-buffer describes a frame-buffer setup by firmware or
>  the bootloader, with the assumption that the display hardware has already
>  been set up to scan out from the memory pointed to by the reg property.
>
> +Since simplefb nodes represent runtime information they must be sub-nodes of
> +the chosen node (*). The primary display node must be named framebuffer0,
> +additional nodes must be called framebuffer1, etc.
> +
> +If a simplefb node represents the preferred console for user interaction,
> +then the chosen node's stdout-path property must point to it.

You may want to add an stdout-path property to the example.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
