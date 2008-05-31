From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [RFC 2.6.26-rc3 5/5] mach-pxa: add am200epd
	support
Date: Sat, 31 May 2008 14:03:03 +0200
Message-ID: <20080531140303.06bb6386.krzysztof.h1@poczta.fm>
References: <1212208915-24544-1-git-send-email-jayakumar.lkml@gmail.com>
	<1212208915-24544-6-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1212208915-24544-6-git-send-email-jayakumar.lkml@gmail.com>
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

On Sat, 31 May 2008 00:41:55 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> am200epd implements mach-pxa support for the am200epd carrier board. It
> interfaces with metronomefb and pxafb in order to support various E-Ink
> panels.
> This patch does:
> - export pxa_device_fb to be accessed by am200epd
> - redo the metronomefb interface code to interface properly with am200epd
> - allow am200epd to handle different panels properly
> - cleanup to use dev_dbg instead of printk
> - remove mach-pxa like structure from metronomefb
> - add board support for am200epd
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---

I have tried to review this patch but failed miserably.
It is too long and changes too many things (I mean do completely
different type of changes: variable renaming, printk -> dev_err,
essential changes and even a new driver found its place).

Please create two patches before redoing this one:
- 1st patch which does non-essential stuff like printk to dev_err
changes and variable renaming (e.g. reval to ret).
- 2nd patch which correctly balances all error paths
  in the metronomefb as this patch brings more mistakes here

Then probably you should also break this patch into two pieces:
- changes which prepare existing stuff for a new driver but do 
not break existing things (like export pxa_device_fb) 
- the new driver itself (much smaller then)

This is my advice as it is too hard to get some understanding of changes.

I will review your next version of patches,
Krzysztof
PS. Some found issues are pointed below.

> diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
> new file mode 100644
> index 0000000..7aeee2c
> --- /dev/null
> +++ b/arch/arm/mach-pxa/am200epd.c
> @@ -0,0 +1,347 @@
(...)
> +
> +#define DEBUG 1

You have left the debug code enabled. If it is intentional it is ok.

> +static int am200_init_gpio_regs(struct metronomefb_par *par)
> +{

Many functions have metronomefb_par parameter, but do not use it.
You can remove the parameter for now.

> diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
> index cc4c038..ef2df4a 100644
> --- a/drivers/video/metronomefb.c
> +++ b/drivers/video/metronomefb.c
> @@ -18,6 +18,8 @@
>   * is provided as am200epd.c
>   *
>   */
> +#define DEBUG 1
> +

Again, the debug code is enabled.

> @@ -569,13 +579,16 @@ static int __devinit metronomefb_probe(struct platform_device *dev)
>  {
(...)

> +	fw = epd_frame_table[epd_dt_index].fw;
> +	fh = epd_frame_table[epd_dt_index].fh;
> +	videomemorysize = fw * fh;
>  	videomemory = vmalloc(videomemorysize);
>  	if (!videomemory)
>  		return -ENOMEM;

I suppose the put_module should be done before return (see the whole
function code).
In order to reduce number of goto labels you can do something
like this (for allocated pointers):

err_exit:
    if (pointer)
	free(pointer)
   do_something_more

instead

err_exit1:
  free(pointer)
err_exit2:
   do_something_more

>  static int __devexit metronomefb_remove(struct platform_device *dev)
> @@ -734,14 +764,13 @@ static int __devexit metronomefb_remove(struct platform_device *dev)
>  	if (info) {
>  		struct metronomefb_par *par = info->par;
>  		fb_deferred_io_cleanup(info);
> -		dma_free_writecombine(&dev->dev, par->metromemsize,
> -					par->metromem, par->metromem_dma);
>  		fb_dealloc_cmap(&info->cmap);
>  		vfree(par->csum_table);
>  		unregister_framebuffer(info);

I am not sure but to release the color map before
unregistering the framebuffer is probably a mistake.



----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>> http://link.interia.pl/f1e13  


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
