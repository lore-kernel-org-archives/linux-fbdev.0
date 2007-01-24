From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Recognize video=gx1fb:... option
Date: Wed, 24 Jan 2007 00:48:26 -0800
Message-ID: <20070124004826.0d1adffe.akpm@osdl.org>
References: <20070119211051.GC5013@martell.zuzino.mipt.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9do3-0002LA-Da for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Jan 2007 00:48:36 -0800
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1H9do2-0000yz-41
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 24 Jan 2007 00:48:35 -0800
In-Reply-To: <20070119211051.GC5013@martell.zuzino.mipt.ru>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Jordan Crouse <jordan.crouse@amd.com>

On Sat, 20 Jan 2007 00:10:51 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Juergen Beisert reported that the following option doesn't work for him
> 
> 	video=gx1fb:1024x768-16@60
> 
> though sisfb was able to parse similar option correctly.
> 

And does this patch fix it for him? ;)

> ---
> 
>  drivers/video/geode/gx1fb_core.c |   29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> --- a/drivers/video/geode/gx1fb_core.c
> +++ b/drivers/video/geode/gx1fb_core.c
> @@ -401,6 +401,30 @@ static void gx1fb_remove(struct pci_dev 
>  	framebuffer_release(info);
>  }
>  
> +#ifndef MODULE
> +static void __init gx1fb_setup(char *options)
> +{
> +	char *this_opt;
> +
> +	if (!options || !*options)
> +		return;
> +
> +	while ((this_opt = strsep(&options, ","))) {
> +		if (!*this_opt)
> +			continue;
> +
> +		if (!strncmp(this_opt, "mode:", 5))
> +			strlcpy(mode_option, this_opt + 5, sizeof(mode_option));
> +		else if (!strncmp(this_opt, "crt:", 4))
> +			crt_option = !!simple_strtoul(this_opt + 4, NULL, 0);
> +		else if (!strncmp(this_opt, "panel:", 6))
> +			strlcpy(panel_option, this_opt + 6, sizeof(panel_option));
> +		else
> +			strlcpy(mode_option, this_opt, sizeof(mode_option));
> +	}
> +}
> +#endif
> +
>  static struct pci_device_id gx1fb_id_table[] = {
>  	{ PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5530_VIDEO,
>  	  PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY << 16,
> @@ -420,8 +444,11 @@ static struct pci_driver gx1fb_driver = 
>  static int __init gx1fb_init(void)
>  {
>  #ifndef MODULE
> -	if (fb_get_options("gx1fb", NULL))
> +	char *option = NULL;
> +
> +	if (fb_get_options("gx1fb", &option))
>  		return -ENODEV;
> +	gx1fb_setup(option);
>  #endif
>  	return pci_register_driver(&gx1fb_driver);
>  }

Possibly this should go through Jordan's git-geode tree.  But that tree
seems to be kinda dead, so I'll file this under fbdev.


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
