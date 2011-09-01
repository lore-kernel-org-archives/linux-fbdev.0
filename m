From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 01 Sep 2011 13:01:48 +0000
Subject: Re: [PATCH RESEND] video: mxsfb: add missing include of linux/module.h
Message-Id: <4E5F823C.9000200@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314835919.2208.1.camel@phoenix>
In-Reply-To: <1314835919.2208.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org

On 09/01/2011 12:11 AM, Axel Lin wrote:
> Include linux/module.h to fix below build error:
> 
>                  from drivers/video/mxsfb.c:42:
> arch/arm/mach-mxs/include/mach/memory.h:22:1: warning: this is the location of the previous definition
> drivers/video/mxsfb.c:574: error: 'THIS_MODULE' undeclared here (not in a function)
> drivers/video/mxsfb.c:893: warning: data definition has no type or storage class
> drivers/video/mxsfb.c:893: warning: type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
> drivers/video/mxsfb.c:893: warning: parameter names (without types) in function declaration
> drivers/video/mxsfb.c:917: error: expected declaration specifiers or '...' before string constant
> drivers/video/mxsfb.c:917: warning: data definition has no type or storage class
> drivers/video/mxsfb.c:917: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
> drivers/video/mxsfb.c:917: warning: function declaration isn't a prototype
> drivers/video/mxsfb.c:918: error: expected declaration specifiers or '...' before string constant
> drivers/video/mxsfb.c:918: warning: data definition has no type or storage class
> drivers/video/mxsfb.c:918: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
> drivers/video/mxsfb.c:918: warning: function declaration isn't a prototype
> drivers/video/mxsfb.c:919: error: expected declaration specifiers or '...' before string constant
> drivers/video/mxsfb.c:919: warning: data definition has no type or storage class
> drivers/video/mxsfb.c:919: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
> drivers/video/mxsfb.c:919: warning: function declaration isn't a prototype
> make[2]: *** [drivers/video/mxsfb.o] Error 1
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/mxsfb.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index 0b2f2dd..d837d63 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -39,6 +39,7 @@
>   * the required value in the imx_fb_videomode structure.
>   */
>  
> +#include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>

