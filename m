From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: video/fb: cleanup FB_MAJOR usage
Date: Fri, 25 Jul 2008 02:15:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807250213520.9222@anakin>
References: <200807242325.m6ONP5hG015643@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KMAy4-0002wZ-So for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Jul 2008 17:15:33 -0700
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KMAy3-0001MR-5V
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 Jul 2008 17:15:32 -0700
In-Reply-To: <200807242325.m6ONP5hG015643@hera.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Philippe De Muyter <phdm@macqel.be>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thu, 24 Jul 2008, Linux Kernel Mailing List wrote:
> Gitweb:     http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=5bb49fcd501aa9fd3d321a22b7c01d9b0db7ab36
> Commit:     5bb49fcd501aa9fd3d321a22b7c01d9b0db7ab36
> Parent:     cba603bf514c101bf48f6adf393c3d00ed457a57
> Author:     Philippe De Muyter <phdm@macqel.be>
> AuthorDate: Wed Jul 23 21:31:50 2008 -0700
> Committer:  Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Thu Jul 24 10:47:41 2008 -0700
> 
>     video/fb: cleanup FB_MAJOR usage
>     
>     Currently, linux/major.h defines a GRAPHDEV_MAJOR (29) that nobody uses,
>     and linux/fb.h defines the real FB_MAJOR (also 29), that only fbmem.c
>     needs.  Drop GRAPHDEV_MAJOR from major.h, move FB_MAJOR definition from
>     fb.h to major.h, and fix fbmem.c to use major.h's definition.

<linux/fb.h> is exported to userspace, so this may affect userspace
applications.

>     Signed-off-by: Philippe De Muyter <phdm@macqel.be>
>     Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
>     Cc: "Antonino A. Daplas" <adaplas@pol.net>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>     Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  drivers/video/fbmem.c |    1 +
>  include/linux/fb.h    |    1 -
>  include/linux/major.h |    2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
> index 6b48780..5d84b34 100644
> --- a/drivers/video/fbmem.c
> +++ b/drivers/video/fbmem.c
> @@ -35,6 +35,7 @@
>  #include <linux/device.h>
>  #include <linux/efi.h>
>  #include <linux/fb.h>
> +#include <linux/major.h>
>  
>  #include <asm/fb.h>
>  
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index a084d13..3b8870e 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -8,7 +8,6 @@ struct dentry;
>  
>  /* Definitions of frame buffers						*/
>  
> -#define FB_MAJOR		29
>  #define FB_MAX			32	/* sufficient for now */
>  
>  /* ioctls
> diff --git a/include/linux/major.h b/include/linux/major.h
> index 0cb9805..53d5faf 100644
> --- a/include/linux/major.h
> +++ b/include/linux/major.h
> @@ -53,7 +53,7 @@
>  #define STL_SIOMEMMAJOR		28
>  #define ACSI_MAJOR		28
>  #define AZTECH_CDROM_MAJOR	29
> -#define GRAPHDEV_MAJOR		29   /* SparcLinux & Linux/68k /dev/fb */
> +#define FB_MAJOR		29   /* /dev/fb* framebuffers */
>  #define CM206_CDROM_MAJOR	32
>  #define IDE2_MAJOR		33
>  #define IDE3_MAJOR		34

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
