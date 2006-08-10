From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/8] atyfb: Honor the return value
 of pci_register_driver
Date: Thu, 10 Aug 2006 14:11:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0608101410390.718@pademelon.sonytel.be>
References: <44DB1DA4.3000703@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GB9Nm-0004KF-1g for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 05:11:26 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GB9Nk-0000jT-DW
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 05:11:25 -0700
In-Reply-To: <44DB1DA4.3000703@gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

On Thu, 10 Aug 2006, Antonino A. Daplas wrote:
> Do not ignore the return value of pci_register_driver().
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>
> ---
> 
>  drivers/video/aty/atyfb_base.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index 053ff63..605fb7e 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -3868,12 +3868,11 @@ #ifndef MODULE
>  #endif
>  
>  #ifdef CONFIG_PCI
> -    pci_register_driver(&atyfb_driver);
> +    return pci_register_driver(&atyfb_driver);
>  #endif
>  #ifdef CONFIG_ATARI
> -    atyfb_atari_probe();
> +    return atyfb_atari_probe();
>  #endif
> -    return 0;
>  }

Actually it's a bit more complicated, as some Ataris do have PCI (although
currently Atari Hades PCI support is broken).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
