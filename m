From: Rob Herring <robherring2@gmail.com>
Date: Fri, 03 Oct 2014 13:20:15 +0000
Subject: Re: [PATCH v2 2/5] dt-bindings: Add a clocks property to the simple-framebuffer binding
Message-Id: <CAL_Jsq+mG1WnPBADdSVxShZp4-Gaw12gLWzBt2_zYmqWogoknQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
 <1412337125-14388-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1412337125-14388-3-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Oct 3, 2014 at 6:52 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> A simple-framebuffer node represents a framebuffer setup by the firmware /
> bootloader. Such a framebuffer may have a number of clocks in use, add a
> property to communicate this to the OS.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Mike Turquette <mturquette@linaro.org>
> ---
>  Documentation/devicetree/bindings/video/simple-framebuffer.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> index 70c26f3..e75478e 100644
> --- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> @@ -14,6 +14,9 @@ Required properties:
>    - r5g6b5 (16-bit pixels, d[15:11]=r, d[10:5]=g, d[4:0]=b).
>    - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
>
> +Optional properties:
> +- clocks : List of clocks used by the framebuffer

A simple framebuffer represents a memory region. So now you are saying
this memory region has a clock. That does not make sense and the
description of simple framebuffer is no longer correct.

I assume you are trying to work around the clock framework turning off
clocks on you. If you bothered to describe the clock such that it can
be turned off by the kernel, you should then describe it's actual
connection to the hardware.

Furthermore, when you do add actual driver(s) for the hardware, that
driver will not be able to turn off the clocks because the simplefb
has forced them on. I can see the cases where you want to use
simple-framebuffer early for splash screen or something before the
real driver is up and use it to provide the default video mode for the
real driver.

Rob
