From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH,
 trivial] Remove about 50 unneeded #includes in fbdev
Date: Tue, 27 Jun 2006 09:51:27 -0700
Message-ID: <20060627095127.441c543e.rdunlap@xenotime.net>
References: <9e4733910606270919n7819dbc0g8bd5c99f4b911583@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvGk5-0006DZ-3i for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 09:48:49 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FvGk4-0006k6-Qd
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 09:48:49 -0700
Received: from midway.site ([71.245.108.25]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 27 Jun 2006 09:48:45 -0700
In-Reply-To: <9e4733910606270919n7819dbc0g8bd5c99f4b911583@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jonsmirl@gmail.com, adaplas@gmail.com, linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 12:19:07 -0400 Jon Smirl wrote:

> Remove about 50 unneeded #includes in fbdev

Does this that
(a) these drivers build without these header files explicitly #included
or
(b) these drivers don't use *any* APIs or data from these header files?

They may build (a) but still use the APIs, so (b) is the requirement/target.
(I.e., other header files could suck in the required headers.)


> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> 
> diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
> index db878fd..e498a54 100644
> --- a/drivers/video/aty/aty128fb.c
> +++ b/drivers/video/aty/aty128fb.c
> @@ -46,26 +46,14 @@
>   */
> 
> 
> -#include <linux/config.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> -#include <linux/kernel.h>
>  #include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/mm.h>
> -#include <linux/tty.h>
> -#include <linux/slab.h>
> -#include <linux/vmalloc.h>
>  #include <linux/delay.h>
> -#include <linux/interrupt.h>
>  #include <asm/uaccess.h>
>   #include <linux/fb.h>
> -#include <linux/init.h>
>  #include <linux/pci.h>
> -#include <linux/ioport.h>
>  #include <linux/console.h>
> -#include <linux/backlight.h>
> -#include <asm/io.h>
> 
>   #ifdef CONFIG_PPC_PMAC
>  #include <asm/machdep.h>
> diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
> index c5185f7..5f4c76c 100644
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -49,26 +49,13 @@
>  ******************************************************************************/
> 
> 
> -#include <linux/config.h>
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/mm.h>
> -#include <linux/slab.h>
> -#include <linux/vmalloc.h>
>  #include <linux/delay.h>
>  #include <linux/console.h>
>   #include <linux/fb.h>
> -#include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/interrupt.h>
> -#include <linux/spinlock.h>
> -#include <linux/wait.h>
>  #include <linux/backlight.h>
> 
> -#include <asm/io.h>
>  #include <asm/uaccess.h>
> 
>  #include <video/mach64.h>
> diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
> index c5ecbb0..56445ea 100644
> --- a/drivers/video/aty/radeon_base.c
> +++ b/drivers/video/aty/radeon_base.c
> @@ -52,25 +52,6 @@
> 
>  #define RADEON_VERSION	"0.2.0"
> 
> -#include <linux/config.h>
> -#include <linux/module.h>
> -#include <linux/moduleparam.h>
> -#include <linux/kernel.h>
> -#include <linux/errno.h>
> -#include <linux/string.h>
> -#include <linux/mm.h>
> -#include <linux/tty.h>
> -#include <linux/slab.h>
> -#include <linux/delay.h>
> -#include <linux/time.h>
> -#include <linux/fb.h>
> -#include <linux/ioport.h>
> -#include <linux/init.h>
> -#include <linux/pci.h>
> -#include <linux/vmalloc.h>
> -#include <linux/device.h>
> -
> -#include <asm/io.h>
>  #include <asm/uaccess.h>
> 
>   #ifdef CONFIG_PPC_OF
> diff --git a/drivers/video/aty/radeon_i2c.c b/drivers/video/aty/radeon_i2c.c
> index a9d0414..4855c0a 100644
> --- a/drivers/video/aty/radeon_i2c.c
> +++ b/drivers/video/aty/radeon_i2c.c
> @@ -1,9 +1,3 @@
> -#include <linux/config.h>
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/sched.h>
> -#include <linux/delay.h>
> -#include <linux/pci.h>
>   #include <linux/fb.h>
> 
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 


---
~Randy

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
