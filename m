From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [RFC 2.6.26-rc3 05/10] pxafb: add shared
	framebuffer interface
Date: Sun, 15 Jun 2008 08:26:53 +0200
Message-ID: <20080615082653.e63a25dd.krzysztof.h1@poczta.fm>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-6-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1213289961-1562-6-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, 12 Jun 2008 12:59:16 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index 89f1b48..434587f 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -1701,8 +1725,12 @@ static int __devinit pxafb_probe(struct platform_device *dev)
>  	}
>  
>  	/* Initialize video memory */
> -	ret = pxafb_map_video_memory(fbi);
> -	if (ret) {
> +	ret = pxafb_map_video_memory(fbi, inf);
> +	if (ret == -ENODEV) {
> +		dev_err(&dev->dev, "Failed device binding: %d\n", ret);
> +		ret = -ENODEV;

This line is redundant as the ret is already -ENODEV.

> +		goto failed_free_mem;
> +	} else if (ret) {
>  		dev_err(&dev->dev, "Failed to allocate video RAM: %d\n", ret);
>  		ret = -ENOMEM;

Probably, there is no need to change the error code (ret). You can drop this line.

Regards,
Krzysztof

----------------------------------------------------------------------
Z Map24 Twoja droga jest prosta! Sprawdz!
kliknij >>> http://link.interia.pl/f1e3b


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
