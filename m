From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: [PATCH 6/8] fbcon/fbdev: Remove fbc
Date: Tue, 2 Nov 2004 13:46:56 +0200
Message-ID: <82235870BEB@vcnet.vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1COy2E-0005z7-Dx
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 04:45:14 -0800
Received: from mailgw.cvut.cz ([147.32.3.235])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1COy2D-00074W-B1
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 04:45:14 -0800
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
Content-Type: text/plain; charset="us-ascii"
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, akpm@osdl.org

On  2 Nov 04 at 19:46, Antonino A. Daplas wrote:

> diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
> --- a/drivers/video/matrox/matroxfb_base.c  2004-10-23 02:52:37 +08:00
> +++ b/drivers/video/matrox/matroxfb_base.c  2004-11-01 08:32:54 +08:00
> @@ -1877,16 +1876,21 @@
>     }
>     printk("fb%d: %s frame buffer device\n",
>            ACCESS_FBINFO(fbcon.node), ACCESS_FBINFO(fbcon.fix.id));
> -   if (ACCESS_FBINFO(fbcon.currcon) < 0) {
> -       /* there is no console on this fb... but we have to initialize hardware
> -        * until someone tells me what is proper thing to do */
> -       printk(KERN_INFO "fb%d: initializing hardware\n",
> -           ACCESS_FBINFO(fbcon.node));
> -       /* We have to use FB_ACTIVATE_FORCE, as we had to put vesafb_defined to the fbcon.var
> -        * already before, so register_framebuffer works correctly. */
> -       vesafb_defined.activate |= FB_ACTIVATE_FORCE;
> -       fb_set_var(&ACCESS_FBINFO(fbcon), &vesafb_defined);
> -   }
> +   /*
> +    * Tony: If this driver is to be mapped to the console, then
> +    *       fbcon will automatically do a set_par for us.  The code below
> +    *       may not be needed.
> +    */

Code below (which you made unconditional now) was executed if and only if
there is no fbcon attached to this device.  If there is fbcon attached
to this device, fbcon.currcon would be >= 0 after register_framebuffer()
(and fbcon's startup already did needed set_*).  If there is no fbcon,
this adapter is secondary, and it must be initialized too before leaving 
driver.  But it must not be initialized before call to register_framebuffer,
as otherwise taking over vgacon won't work correctly.

You could put some 'ACCESS_FBINFO(flags.hw_initialized) = 1' somewhere
into matroxfb's set_par and then test this flag instead of fbcon.currcon.

But your current code probably does not work very well on primary adapter.
                                                    Petr

> +   /* there is no console on this fb... but we have to initialize hardware
> +    * until someone tells me what is proper thing to do */
> +   printk(KERN_INFO "fb%d: initializing hardware\n",
> +          ACCESS_FBINFO(fbcon.node));
> +   /* We have to use FB_ACTIVATE_FORCE, as we had to put vesafb_defined to the fbcon.var
> +    * already before, so register_framebuffer works correctly. */
> +   vesafb_defined.activate |= FB_ACTIVATE_FORCE;
> +   fb_set_var(&ACCESS_FBINFO(fbcon), &vesafb_defined);
> +
>     return 0;
>  failVideoIO:;
>     matroxfb_g450_shutdown(PMINFO2);



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
