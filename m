From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC] double buffering for atmel_lcdfb
Date: Wed, 6 Aug 2008 11:55:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808061151150.25079@anakin>
References: <200808061136.16783.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQfsd-0002hv-Ca for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 03:04:31 -0700
Received: from monty.telenet-ops.be ([195.130.132.56])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KQfkO-000297-TW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 02:56:01 -0700
In-Reply-To: <200808061136.16783.stf_xl@wp.pl>
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
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 6 Aug 2008, Stanislaw Gruszka wrote:
> I try to implement double buffering for Atmel LCD display on AT91SAM9263 based 
> board. I could not find any document about panning display on linux 
> framebuffer, so I have some question about it and generic question about 
> double buffer design. 
> 
> 1) Is FBIOPAN_DISPLAY ioctl right way to implement double buffering?

Yes.

> 2) What is the difference between ypanstep and ywrapstep, which one should be 
> used for double buffering.

Ypanstep is the allowed step increment for panning vertically.
E.g. for a screen with 200 lines and y.offset = 50, it will display
lines 50-249 of the frame buffer.

Ywrapstep is the allowed step increment for wrapping the screen
vertically.
E.g. for a screen with 200 lines and y.offset = 50, it will display
lines 50-199 followed by lines 0-49 of the frame buffer.

> 3) Does double buffer stuff should be turned on using module parameter, 
> compile time parameter, board specific parameter (flag from platform device).
> As it consume 2x memory I don't thing anyone want it by default.

No, let userspace ask for it when it specifies a large
fb_var_screeninfo.yres_virtual, if possible. If you have to allocate all
frame buffer memory at initialization time, you can use a board specific
parameter or a kernel command line parameter.

> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index b004036..d0b2bed 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -7,7 +7,6 @@
>   * License.  See the file COPYING in the main directory of this archive for
>   * more details.
>   */
> -
>  #include <linux/kernel.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> @@ -41,6 +40,8 @@
>  #if defined(CONFIG_ARCH_AT91)
>  #define	ATMEL_LCDFB_FBINFO_DEFAULT	FBINFO_DEFAULT
>  
> +static int double_buffering = 1;
> +
>  static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
>  					struct fb_var_screeninfo *var)
>  {
> @@ -789,7 +790,13 @@ static int __init atmel_lcdfb_probe(struct 
> platform_device *pdev)
>  		 * Don't clear the framebuffer -- someone may have set
>  		 * up a splash image.
>  		 */
> +		double_buffering = 0;
> + 		dev_info(dev, "dissable double buffering\n");
>  	} else {
> + 		if (double_buffering) {
> + 			info->fix.ypanstep = info->var.yres_virtual;

I would set it to 1, if there's no hardware limitation preventing this.

> + 			info->var.yres_virtual *= 2;

This is done at initialization time, hence it cannot be changed later by
using the ioctls?

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
