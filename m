From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sun, 31 Mar 2019 18:33:33 +0000
Subject: Re: [PATCH v2 4/7] fbdev: sm712fb: add 32-bit color modes, drops some other modes.
Message-Id: <20190331183333.kpyt2hm5iy6m5u34@debian>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-5-tomli@tomli.me>
In-Reply-To: <20190322051759.15007-5-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yifeng Li <tomli@tomli.me>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, linux-kernel@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

On Fri, Mar 22, 2019 at 01:17:56PM +0800, Yifeng Li wrote:
> The modesetting in sm712fb is an ugly hack. First, all the registers
> are programmed by hardcoded register arrays, which makes it difficult
> to support different variations of color depths, refresh rates, CRT/LCD
> panel, etc of the same resolution. Second, it means the standard
> fb_find_mode() cannot be used and a confusing non-standard "vga="
> parameter is needed. Third, there's only minimum differences between
> some modes, yet around 70 lines of code and 100 registers are needed to
> be indepentently specified for each mode. Fourth, the register between
> some modes are inconsistent: the register configuration of different
> color depths in 640 x 480 modes are identical, but for 800 x 600 modes
> it's completely different. Also, some modes can drive the LCD panel
> properly yet some other modes will only show a white screen of death on
> the LCD panel. Fifth, some modes, such as 32-bit color modes, are
> supported but never listed, and some modes are listed, such as 1280x1024
> modes, but never supported by the register configuration arrays. And
> some modes are partially implemented but neither listed nor supported,
> i.e. the 8-bit color modes.
> 
> Fixing these problems requires a complete rewrite of modesetting code,
> which is well-beyond my motivation. This commit only perform a minimum
> cleanup:
> 
> 1. Remove the 320 x 240 register settings, since there are never listed
> and never actually being used. This resolution is not even supported by
> vesafb, so it's safe to assume that no one is using such hardware. Future
> developers who needs them can simply recover them from the git history.

Why are you removing existing functionality from the driver? These are
supported but were never listed so could not be used. I think you can
just add these to vesa_mode_table[] and they can be used. I have an old
CRT in India which supports 320x240 mode and can test there when I am
there next.

> 
> 2. Remove 1280x1024 modes and 8-bit color modes. They are listed but never
> supported by the register array. So it doesn't work in the beginning, and
> only gives a black screen.
> 
> 3. Add 32-bit color modes. They are supported but never listed, and are
> useful to some users.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  drivers/video/fbdev/sm712fb.c | 158 +++++++---------------------------
>  1 file changed, 31 insertions(+), 127 deletions(-)
> 
> diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
> index 75d60ea63883..5e887653ef5d 100644
> --- a/drivers/video/fbdev/sm712fb.c
> +++ b/drivers/video/fbdev/sm712fb.c
> @@ -118,25 +118,48 @@ struct vesa_mode {
>  };
>  
>  static const struct vesa_mode vesa_mode_table[] = {
> -	{"0x301", 640,  480,  8},
> -	{"0x303", 800,  600,  8},
> -	{"0x305", 1024, 768,  8},
> -	{"0x307", 1280, 1024, 8},
> -
>  	{"0x311", 640,  480,  16},
>  	{"0x314", 800,  600,  16},
>  	{"0x317", 1024, 768,  16},
> -	{"0x31A", 1280, 1024, 16},
>  
>  	{"0x312", 640,  480,  24},
>  	{"0x315", 800,  600,  24},
>  	{"0x318", 1024, 768,  24},
> -	{"0x31B", 1280, 1024, 24},
> +
> +	{"0x329", 640,  480,  32},
> +	{"0x32e", 800,  600,  32},
> +	{"0x338", 1024, 768,  32},
>  };
>  
>  /**********************************************************************
>  			 SM712 Mode table.
> - **********************************************************************/
> +
> + The modesetting in sm712fb is an ugly hack. First, all the registers
> + are programmed by hardcoded register arrays, which makes it difficult
> + to support different variations of color depths, refresh rates, CRT/LCD
> + panel, etc of the same resolution. Second, it means the standard
> + fb_find_mode() cannot be used and a confusing non-standard "vga="
> + parameter is needed. Third, there's only minimum differences between
> + some modes, yet around 70 lines of code and 100 registers are needed to
> + be indepentently specified for each mode. Fourth, the register between
> + some modes are inconsistent: the register configuration of different
> + color depths in 640 x 480 modes are identical, but for 800 x 600 modes
> + it's completely different. Also, some modes can drive the LCD panel
> + properly yet some other modes will only show a white screen of death on
> + the LCD panel. Fifth, there is a specific hack for Lemote Loongson 8089D
> + laptop, the 1024x768, 16-bit color mode was modified to drive its LCD panel
> + and changed to 1024x600, but the original mode was not preserved, so
> + 1024x768 16-bit color mode is completely unsupported. And previously,
> + some modes are listed, such as 1280x1024 modes, but never supported by
> + the register configuration arrays, so they are now removed. And some modes
> + are partially implemented but neither listed nor supported, i.e. the 8-bit
> + color modes, so they have been removed from vesa_mode_table, too.

I think this comment sounds more like a commit message instead of a
code comment. Does this improve readability?

> +
> + I'm not the original author of the code, fixing these problems requires a
> + complete rewrite of modesetting code, which is well-beyond my motivation.
> +
> + See Documentation/fb/sm712fb.txt for more information.
> +**********************************************************************/

Is this needed? Many of the commits of the driver are done by people who
are not the original author.

--
Regards
Sudip
