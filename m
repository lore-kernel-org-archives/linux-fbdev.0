From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] aty: remove unnecessary CONFIG_PCI
Date: Tue, 10 Jan 2006 21:27:14 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0601102124340.3646@pademelon.sonytel.be>
References: <200601101728.k0AHSlWh018934@hera.kernel.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EwQ5d-0004u0-6E
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Jan 2006 12:27:33 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EwQ5b-0003wr-M9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Jan 2006 12:27:33 -0800
In-Reply-To: <200601101728.k0AHSlWh018934@hera.kernel.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 10 Jan 2006, Linux Kernel Mailing List wrote:
> tree 2567482d480da5d320cc7af065f03716e41dbbd6
> parent 2b4f2f4b0132afa9f441171285cca354377bf5d0
> author Richard Knutsson <ricknu-0@student.ltu.se> Tue, 10 Jan 2006 12:52:55 -0800
> committer Linus Torvalds <torvalds@g5.osdl.org> Wed, 11 Jan 2006 00:01:42 -0800
> 
> [PATCH] aty: remove unnecessary CONFIG_PCI
> 
> Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
> Cc: "Antonino A. Daplas" <adaplas@pol.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
>  drivers/video/aty/atyfb_base.c |    4 ----
>  1 files changed, 4 deletions(-)
> 
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index 3fefdb0..d8195f7 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -3692,9 +3692,7 @@ static int __init atyfb_init(void)
>      atyfb_setup(option);
>  #endif
>  
> -#ifdef CONFIG_PCI
>      pci_register_driver(&atyfb_driver);
> -#endif
>  #ifdef CONFIG_ATARI
>      atyfb_atari_probe();
>  #endif
> @@ -3703,9 +3701,7 @@ static int __init atyfb_init(void)
>  
>  static void __exit atyfb_exit(void)
>  {
> -#ifdef CONFIG_PCI
>  	pci_unregister_driver(&atyfb_driver);
> -#endif
>  }

Have you compile-tested this? Since atyfb_driver is not defined if CONFIG_PCI
is not set and pci_register_driver() is not a macro but an inline function (so
the compiler will see the reference to atyfb_driver), I'm afraid it will break
the non-CONFIG_PCI build.

[Disclaimer: I'm not in a position to compile-test it myself right now]

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
