From: Rob Herring <robherring2@gmail.com>
Date: Fri, 03 Oct 2014 15:57:28 +0000
Subject: Re: [PATCH v3] dt-bindings: Add a clocks property to the simple-framebuffer binding
Message-Id: <CAL_JsqKU2n8p=YfJua3k-mR40bG_4SiZY8_-SL-MXtuWN5NeHg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412345120-24588-1-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1412345120-24588-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 3, 2014 at 9:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> A simple-framebuffer node represents a framebuffer setup by the firmware /
> bootloader. Such a framebuffer may have a number of clocks in use, add a
> property to communicate this to the OS.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Mike Turquette <mturquette@linaro.org>
>
> --
> Changes in v2:
> -Added Reviewed-by: Mike Turquette <mturquette@linaro.org>
> Changes in v3:
> -Updated description to make clear simplefb deals with more then just memory

NAK. "Fixing" the description is not what I meant and does not address
my concerns. Currently, simplefb is configuration data. It is
auxiliary data about how a chunk of memory is used. Using it or not
has no side effects on the hardware setup, but you are changing that
aspect. You are mixing in a hardware description that is simply
inaccurate.

The kernel has made the decision to turn off "unused" clocks. If its
determination of what is unused is wrong, then it is not a problem to
fix in DT.

Rob

> ---
>  Documentation/devicetree/bindings/video/simple-framebuffer.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> index 70c26f3..91176ee 100644
> --- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> @@ -1,8 +1,8 @@
>  Simple Framebuffer
>
> -A simple frame-buffer describes a raw memory region that may be rendered to,
> -with the assumption that the display hardware has already been set up to scan
> -out from that buffer.
> +A simple frame-buffer describes a frame-buffer setup by firmware or
> +the bootloader, with the assumption that the display hardware has already
> +been set up to scan out from the memory pointed to by the ref property.
>
>  Required properties:
>  - compatible: "simple-framebuffer"
> @@ -14,6 +14,9 @@ Required properties:
>    - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
>    - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
>
> +Optional properties:
> +- clocks : List of clocks used by the framebuffer
> +
>  Example:
>
>         framebuffer {
> --
> 2.1.0
>
