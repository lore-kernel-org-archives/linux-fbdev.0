From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH] video: s3c_fb.c: fix build with CONFIG_HOTPLUG=n
Date: Mon, 8 Jun 2009 15:39:28 +0100
Message-ID: <20090608143928.GC8320@trinity.fluff.org>
References: <1244379939-23641-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <1244379939-23641-1-git-send-email-jacmet@sunsite.dk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Peter Korsgaard <jacmet@sunsite.dk>
Cc: ben-linux@fluff.org, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, wookey@wookware.org

On Sun, Jun 07, 2009 at 03:05:39PM +0200, Peter Korsgaard wrote:
> Fixes `s3c_fb_remove' referenced in section `.data' of
> drivers/built-in.o: defined in discarded section `.devexit.text' of
> drivers/built-in.o
> 
> With CONFIG_HOTPLUG=n functions marked with __devexit gets removed, so
> make sure we use __devexit_p when referencing pointers to them.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/video/s3c-fb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
> index d3a568e..db71de1 100644
> --- a/drivers/video/s3c-fb.c
> +++ b/drivers/video/s3c-fb.c
> @@ -1018,7 +1018,7 @@ static int s3c_fb_resume(struct platform_device *pdev)
>  
>  static struct platform_driver s3c_fb_driver = {
>  	.probe		= s3c_fb_probe,
> -	.remove		= s3c_fb_remove,
> +	.remove		= __devexit_p(s3c_fb_remove),
>  	.suspend	= s3c_fb_suspend,
>  	.resume		= s3c_fb_resume,
>  	.driver		= {
> -- 
> 1.6.2
> 
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
