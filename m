From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: [PATCH] 2.5.24 matroxfb off by one error
Date: Mon, 1 Jul 2002 10:05:47 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207011005350.21874-100000@www.transvirtual.com>
References: <20020630003410.GH25118@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17P4ca-0002cY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Jul 2002 10:05:52 -0700
In-Reply-To: <20020630003410.GH25118@ppc.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net


Applyed to the fbdev BK tree.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=(___/

On Sun, 30 Jun 2002, Petr Vandrovec wrote:

> Hi Linus,
>    please apply patch below.
>
>    It fixes off by one error in getcolreg/setcolreg in matroxfb's
> secondary head driver.
> 					Thanks,
> 						Petr Vandrovec
> 						vandrove@vc.cvut.cz
>
>
> diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
> --- linux/drivers/video/matrox/matroxfb_crtc2.c	Fri Jun 21 00:53:48 2002
> +++ linux/drivers/video/matrox/matroxfb_crtc2.c	Sat Jun 29 00:09:09 2002
> @@ -29,7 +29,7 @@
>  static int matroxfb_dh_getcolreg(unsigned regno, unsigned *red, unsigned *green,
>  		unsigned *blue, unsigned *transp, struct fb_info* info) {
>  #define m2info ((struct matroxfb_dh_fb_info*)info)
> -	if (regno > 16)
> +	if (regno >= 16)
>  		return 1;
>  	*red = m2info->palette[regno].red;
>  	*blue = m2info->palette[regno].blue;
> @@ -44,7 +44,7 @@
>  #define m2info ((struct matroxfb_dh_fb_info*)info)
>  	struct display* p;
>
> -	if (regno > 16)
> +	if (regno >= 16)
>  		return 1;
>  	m2info->palette[regno].red = red;
>  	m2info->palette[regno].blue = blue;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
