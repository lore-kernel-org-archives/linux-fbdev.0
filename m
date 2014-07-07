From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 07 Jul 2014 07:57:09 +0000
Subject: Re: [PATCH] video: fbdev: sis: init.c:  Cleaning up redundant condition is always true
Message-Id: <20140707075709.GI25934@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404422121-11298-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404422121-11298-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Mauro Carvalho Chehab <m.chehab@samsung.com>, "Chen, Gong" <gong.chen@linux.intel.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jul 03, 2014 at 11:15:21PM +0200, Rickard Strandqvist wrote:
> diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
> index bd40f5e..9e2dd96 100644
> --- a/drivers/video/fbdev/sis/init.c
> +++ b/drivers/video/fbdev/sis/init.c
> @@ -355,12 +355,12 @@ SiS_GetModeID(int VGAEngine, unsigned int VBFlags, int HDisplay, int VDisplay,
>  		}
>  		break;
>  	case 400:
> -		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth >= 800) && (LCDwidth >= 600))) {
> +		if ((!(VBFlags & CRT1_LCDA)) || (LCDwidth >= 600)) {


It might be that this was supposed to be:

		if((!(VBFlags & CRT1_LCDA)) || ((LCDwidth <= 800) && (LCDwidth >= 600))) {

But why would people write a range from high to low?  That's crazy
people who write backwards code...

The second condition was supposed to do *something* although it's
unclear what.  I would normally say that we should leave the static
checker warning here instead of guessing.  Perhaps add a comment like
/* fixme:  huh?  What's with this nonsense condition? */  But in this
case it's all dead code because LCDwidth is always zero and the code
hasn't changed since 2.6.12 so I don't care.

regards,
dan carpenter

