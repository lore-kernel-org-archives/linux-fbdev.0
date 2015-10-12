From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 12 Oct 2015 17:10:18 +0000
Subject: Re: [PATCH RFC 1/2] dt-bindings: simplefb: Support a list of regulator supply properties
Message-Id: <20151012171018.GB3659@leverpostej>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1444669458-5588-1-git-send-email-wens@csie.org>
 <1444669458-5588-2-git-send-email-wens@csie.org>
In-Reply-To: <1444669458-5588-2-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 13, 2015 at 01:04:17AM +0800, Chen-Yu Tsai wrote:
> The physical display tied to the framebuffer may have regulators
> providing power to it, such as power for LCDs or interface conversion
> chips.
> 
> The number of regulators in use may vary, but the regulator supply
> binding can not be a list. Work around this by adding a "num-supplies"
> property to communicate the number of supplies, and a list of 0 ~ N
> "vinN-supply" properties for the actual regulator supply.

This is getting more complicated by the minute...

> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/video/simple-framebuffer.txt       | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/video/simple-framebuffer.txt b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> index 4474ef6e0b95..0cc43e1be8b5 100644
> --- a/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> +++ b/Documentation/devicetree/bindings/video/simple-framebuffer.txt
> @@ -47,10 +47,14 @@ Required properties:
>    - a8b8g8r8 (32-bit pixels, d[31:24]=a, d[23:16]=b, d[15:8]=g, d[7:0]=r).
>  
>  Optional properties:
> -- clocks : List of clocks used by the framebuffer. Clocks listed here
> -           are expected to already be configured correctly. The OS must
> -           ensure these clocks are not modified or disabled while the
> -           simple framebuffer remains active.
> +- clocks : List of clocks used by the framebuffer.
> +- num-supplies : The number of regulators used by the framebuffer.
> +- vinN-supply : The N-th (from 0) regulator used by the framebuffer.

I don't see why you need num-supplies. Why not just try probing
vin${N}-supply until such a property isn't present in the DT?

Thanks,
Mark.
