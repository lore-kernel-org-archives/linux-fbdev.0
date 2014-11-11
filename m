From: Grant Likely <grant.likely@linaro.org>
Date: Tue, 11 Nov 2014 21:42:17 +0000
Subject: Re: [PATCH v4 2/5] dt-bindings: Add a clocks property to the simple-framebuffer binding
Message-Id: <20141111214217.19EF5C41610@trevor.secretlab.ca>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413996311-4287-1-git-send-email-hdegoede@redhat.com>
 <1413996311-4287-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1413996311-4287-3-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 22 Oct 2014 18:45:08 +0200
, Hans de Goede <hdegoede@redhat.com>
 wrote:
> A simple-framebuffer node represents a framebuffer setup by the firmware /
> bootloader. Such a framebuffer may have a number of clocks in use, add a
> property to communicate this to the OS.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Mike Turquette <mturquette@linaro.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> --
> Changes in v2:
> -Added Reviewed-by: Mike Turquette <mturquette@linaro.org>
> Changes in v3:
> -Updated description to make clear simplefb deals with more then just memory
> ---
>  Documentation/devicetree/bindings/video/simple-framebuffer.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> index 70c26f3..172ad5f 100644
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
> +been set up to scan out from the memory pointed to by the reg property.
>  
>  Required properties:
>  - compatible: "simple-framebuffer"
> @@ -14,6 +14,9 @@ Required properties:
>    - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
>    - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
>  
> +Optional properties:
> +- clocks : List of clocks used by the framebuffer

Please change to the following:
- clocks : List of clocks used by the framebuffer. Clocks listed here
           are expected to already be configured correctly. The OS must
           ensure these clocks are not modified or disabled while the
           simple framebuffer remains active.

g.


