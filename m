From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 18:54:28 +0000
Subject: Re: [PATCH v2 5/7] Documentation: fb: sm712fb: add information mainly about 2D.
Message-Id: <20190331185428.mpqbaq32cmm7izfv@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-6-tomli@tomli.me>
In-Reply-To: <20190322051759.15007-6-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Teddy Wang <teddy.wang@siliconmotion.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:57PM +0800, Yifeng Li wrote:
> This commits add information about 32-bit color, 2D acceleration,
> as well as adding additional, general information about the hardware
> and many existing problems of the sm712fb driver.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  Documentation/fb/sm712fb.txt | 123 +++++++++++++++++++++++++++++++----
>  1 file changed, 110 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.txt
> index c388442edf51..906b48aa40e4 100644
> --- a/Documentation/fb/sm712fb.txt
> +++ b/Documentation/fb/sm712fb.txt
> @@ -1,31 +1,128 @@
>  What is sm712fb?
>  ========>  
> -This is a graphics framebuffer driver for Silicon Motion SM712 based processors.
> +"sm712fb" is a graphics framebuffer driver for Silicon Motion SM710 (LynxEM),
> +SM712 (LynxEM+), and SM720 (Lynx3DM, Lynx3DM+, aka. LynxEM4+) series of
> +video controllers. This series of video controller is a legacy from ~1998,
> +and was used on many classic, "prehistoric" laptops from 1998-2004, such as
> +IBM Thinkpad S30 and 240X. It was also used on some servers, industrial
> +computers, x86 and non-x86 embedded devices where only basic graphics was
> +needed.

I think this is wrong. Loongson 3A Notebook was released around 2011-2012
and had SM712.

> +
> +Notably, Lemote YeeLoong 8089, a MIPS laptop based on the Chinese Loongson

<snip>

> +	* More VGA modes.
>  	* dual-head support
> +	* hardware cursor support
> +
> +The first feature is planned to be implemented soon, but the maintainer
> +does not receive any monetary or hardware support from any company or OEMs,
> +and he has to purchase a test platform personally. The 1998's hardware
> +still costs 200 USD+, so don't expected an ETA. If you have a Big-Endian
> +platform and willing to help testing, please contact the maintainer, thanks!

I am not sure why will you want to mention about monetary or hardware
support. Maintainers are supposed to work voluntarily.

> +
> +Other VGA modes, dual-head, or hardware cursor support should be possible to
> +implement, but parts of the code must be rewritten, and there's little demand
> +for them on this legacy (retro?) platform, so there's no plan to implement them.
> +If you have a genuine need for them, please contact the maintainers.

If there is any need for new features then I think the plan should be to
make a drm driver.

> +
> +Maintainers
> +========
> +
> +This driver is maintained by
> +
> +	* Tom Li <tomli@tomli.me>

??
I didn't know this. MAINTAINERS file doesnot say so.

> +	* Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> +	* Teddy Wang <teddy.wang@siliconmotion.com>
> +
> +Tom Li was the last contributor of this driver who implemented 2D acceleration,
> +and is the main author of this documentation, please send any bug reports or
> +requests to Tom, but don't forget to CC other maintainers as well to make everyone
> +be informed.

There is a MAINTAINERS file to list the maintainers. There is no need to
add that in documentation.

--
Regards
Sudip
