From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3] pxafb: allow pxafb_set_par() to start from arbitrary
	yoffset
Date: Wed, 17 Dec 2008 20:31:03 +0000
Message-ID: <20081217203103.GD5864@flint.arm.linux.org.uk>
References: <f17812d70812170059j64f7130fi8131c6ad60642ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <f17812d70812170059j64f7130fi8131c6ad60642ec6@mail.gmail.com>
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
To: Eric Miao <eric.y.miao@gmail.com>
Cc: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net

On Wed, Dec 17, 2008 at 04:59:00PM +0800, Eric Miao wrote:
> @@ -345,10 +343,9 @@ static int pxafb_check_var(struct
> fb_var_screeninfo *var, struct fb_info *info)
>  			return -EINVAL;
>  	}
> 
> -	var->xres_virtual =
> -		max(var->xres_virtual, var->xres);
> -	var->yres_virtual =
> -		max(var->yres_virtual, var->yres);
> +	var->xres_virtual = var->xres;
> +	var->yres_virtual = fbi->fb.fix.smem_len /
> +				(var->xres * var->bits_per_pixel / 8);

Previous experience of doing this with the X server and acornfb is that
it causes all sorts of problems - it seems to force the X server into
assuming that the framebuffer should be panned no matter what settings
you ask it for.

The recommended workaround (implemented in acornfb) is to only do these
kinds of adjustments if text mode acceleration is enabled.  IIRC, the X
server should be disabling text mode acceleration when it maps the
framebuffer.  I seem to remember that there are X servers which forget
to do that though.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
