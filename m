From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] Fix atyfb build on ppc
Date: Fri, 1 Apr 2005 10:45:59 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0504011045030.6801@numbat.sonytel.be>
References: <200503311828.j2VISgPd028711@hera.kernel.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DHHn6-0004J9-4z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Apr 2005 00:46:08 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DHHn3-0005gl-Dd
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 01 Apr 2005 00:46:08 -0800
In-Reply-To: <200503311828.j2VISgPd028711@hera.kernel.org>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thu, 31 Mar 2005, Linux Kernel Mailing List wrote:

> ChangeSet 1.2305, 2005/03/31 08:49:44-08:00, benh@kernel.crashing.org
> 
> 	[PATCH] Fix atyfb build on ppc
> 	
> 	This patch fixes a build problem with atyfb on ppc.  It uses the stuff in
> 	macmodes.c, but doesn't trigger the build of it.  So if no other driver
> 	using macmodes is built, the link will fail.
> 	
> 	Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> 	Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> 
> 
>  Makefile |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
> --- a/drivers/video/Makefile	2005-03-31 10:28:55 -08:00
> +++ b/drivers/video/Makefile	2005-03-31 10:28:55 -08:00
> @@ -30,8 +30,8 @@
>  obj-$(CONFIG_FB_MATROX)		  += matrox/
>  obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
>  obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
> -obj-$(CONFIG_FB_ATY)		  += aty/
> -obj-$(CONFIG_FB_ATY128)		  += aty/
> +obj-$(CONFIG_FB_ATY)		  += aty/ macmodes.o
> +obj-$(CONFIG_FB_ATY128)		  += aty/ macmodes.o
>  obj-$(CONFIG_FB_RADEON)		  += aty/
>  obj-$(CONFIG_FB_SIS)		  += sis/
>  obj-$(CONFIG_FB_KYRO)             += kyro/

Isn't this one obsoleted by `fbdev: Kconfig fix for macmodes and PPC', which
also went in?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/info/Sentarus/hamr30
