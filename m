From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sun, 23 Sep 2012 19:36:22 +0000
Subject: Re: [PATCH] video: mbxfb: Include linux/io.h instead of asm/io.h
Message-Id: <505F64B6.9020901@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1346420343.3107.0.camel@phoenix>
In-Reply-To: <1346420343.3107.0.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mathieu Poirier <mathieu.poirier@linaro.org>, Damien Cassou <damien.cassou@lifl.fr>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 08/31/2012 01:39 PM, Axel Lin wrote:
> This fixes below build error:
> 
>   CC [M]  drivers/video/mbx/mbxfb.o
> drivers/video/mbx/mbxfb.c: In function 'mbxfb_probe':
> drivers/video/mbx/mbxfb.c:942:2: error: implicit declaration of function 'devm_ioremap_nocache' [-Werror=implicit-function-declaration]
> drivers/video/mbx/mbxfb.c:942:22: warning: assignment makes pointer from integer without a cast [enabled by default]
> drivers/video/mbx/mbxfb.c:952:21: warning: assignment makes pointer from integer without a cast [enabled by default]
> cc1: some warnings being treated as errors
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied. Thanks for pointing this out and fixing it.


Best regards,

Florian Tobias Schandinat

> ---
>  drivers/video/mbx/mbxfb.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/mbx/mbxfb.c b/drivers/video/mbx/mbxfb.c
> index 9229acf..6563e50 100644
> --- a/drivers/video/mbx/mbxfb.c
> +++ b/drivers/video/mbx/mbxfb.c
> @@ -26,8 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/uaccess.h>
> -
> -#include <asm/io.h>
> +#include <linux/io.h>
>  
>  #include <video/mbxfb.h>
>  

