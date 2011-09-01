From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Thu, 01 Sep 2011 13:04:30 +0000
Subject: Re: [PATCH RESEND] video: nuc900fb: remove include of mach/clkdev.h
Message-Id: <4E5F82DE.2060207@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1314836018.2208.3.camel@phoenix>
In-Reply-To: <1314836018.2208.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 09/01/2011 12:13 AM, Axel Lin wrote:
> Since commit aa3831cf9d29cfeaebd8c2169378b74111364487
> "ARM: Consolidate the clkdev header files",
> the header file arch/arm/mach-nuc93x/include/mach/clkdev.h is removed.
> 
> This patch fixes below build error:
> 
> drivers/video/nuc900fb.c:42:25: error: mach/clkdev.h: No such file or directory
> make[2]: *** [drivers/video/nuc900fb.o] Error 1
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied.
I'm wondering whether this build regression was unavoidable...


Thanks,

Florian Tobias Schandinat


> ---
>  drivers/video/nuc900fb.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
> index 0fff5978..37dd850 100644
> --- a/drivers/video/nuc900fb.c
> +++ b/drivers/video/nuc900fb.c
> @@ -39,7 +39,6 @@
>  #include <mach/regs-clock.h>
>  #include <mach/regs-ldm.h>
>  #include <mach/fb.h>
> -#include <mach/clkdev.h>
>  
>  #include "nuc900fb.h"
>  

