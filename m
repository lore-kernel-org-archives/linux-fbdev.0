From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH] pxafb: add support for overlay1 and overlay2 as
	framebuffer devices
Date: Tue, 23 Dec 2008 13:07:06 +0100
Message-ID: <20081223120706.GK9472@pengutronix.de>
References: <f17812d70812230247l78bd6010v4fd6c94e49523175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <f17812d70812230247l78bd6010v4fd6c94e49523175@mail.gmail.com>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Eric Miao <eric.y.miao@gmail.com>, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, Sascha Hauer <sha@pengutronix.de>

Guennadi,

On Tue, Dec 23, 2008 at 06:47:32PM +0800, Eric Miao wrote:
> PXA27x and later processors support overlay1 and overlay2 on-top of the
> base framebuffer (although under-neath the base is also possible).

[...]

> +     Applications should follow the sequence below to operate an overlay
> +     framebuffer:
> +
> +         a. open("/dev/fb[1-2]", ...)
> +	 b. ioctl(fd, FBIOGET_VSCREENINFO, ...)
> +	 c. modify 'var' with desired parameters:
> +	    1) var->xres and var->yres
> +	    2) larger var->yres_virtual if more memory is required,
> +	       usually for double-buffering
> +	    3) var->nonstd for starting (x, y) and color format
> +	    4) var->{red, green, blue, transp} if RGB mode is to be used
> +	 d. ioctl(fd, FBIOPUT_VSCREENINFO, ...)
> +	 e. ioctl(fd, FBIOGET_FSCREENINFO, ...)
> +	 f. mmap
> +	 g. ...

That looks like a good pattern to me and we should re-use it on i.MX.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
