From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 17:13:18 +0200
Message-ID: <20050312151318.GA27200@sci.fi>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DA8Iu-0001Zz-6v
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 07:13:24 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DA8Is-0006hi-7L
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 07:13:23 -0800
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 9AD33BA0E9
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 17:13:18 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <1110636406.5997.86.camel@atlantis.netenviron.com>
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

On Sat, Mar 12, 2005 at 02:06:45PM +0000, Torgeir Veimo wrote:
> This is an implementation of the FB_WAITFORVSYNC ioctl for the radeonfb=
.
> A small test application is attached at the end. This patch is against
> vanilla 2.6.11.

Some comements below.

Also adding support for FB_ACTIVATE_VBL should be quite simple now.

> --- linux-2.6.11-orig/drivers/video/aty/radeonfb.h	2005-03-02 07:38:37.=
000000000 +0000
> +++ linux-2.6.11/drivers/video/aty/radeonfb.h	2005-03-03 17:09:23.00000=
0000 +0000
<snip>
> @@ -344,6 +349,11 @@
>  	struct timer_list	lvds_timer;
>  	u32			pending_lvds_gen_cntl;
> =20
> +	int			open;
> +	struct radeon_interrupt	vblank;
> +	unsigned long		irq_flags;
> +	spinlock_t		int_lock;
> +

Unused spinlock.

>  #ifdef CONFIG_FB_RADEON_I2C
>  	struct radeon_i2c_chan 	i2c[4];
>  #endif
> --- linux-2.6.11-orig/drivers/video/aty/radeon_base.c	2005-03-02 07:37:=
54.000000000 +0000
> +++ linux-2.6.11/drivers/video/aty/radeon_base.c	2005-03-12 13:53:32.00=
0000000 +0000
> @@ -68,6 +68,9 @@
>  #include <linux/ioport.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> +#include <linux/interrupt.h>
> +#include <linux/spinlock.h>

Unused spinlock so no need for the header.

> +#include <linux/wait.h>
>  #include <linux/vmalloc.h>
>  #include <linux/device.h>
>  #include <linux/i2c.h>
> @@ -863,6 +866,97 @@
>  }
> =20
> =20
> +static irqreturn_t radeon_irq(int irq, void *dev_id, struct pt_regs *f=
p)
> +{
> +	struct radeonfb_info *rinfo =3D dev_id;
> +	u32 int_cntl =3D 0;
> +	u32 stat =3D 0;
> +
> +	int_cntl =3D INREG(GEN_INT_CNTL);
> +	stat =3D INREG(GEN_INT_STATUS) & (CRTC_VBLANK_MASK);=20
> +	if (!stat)
> +		return IRQ_NONE;
> +	if (stat) {
> +		/* clear interrupt */
> +		OUTREG(GEN_INT_STATUS, stat);
> +
> +		(rinfo->vblank.count)++;

Nitpick: Drop the parentheses.

> +		wake_up_interruptible(&rinfo->vblank.wait);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static int radeon_enable_irq(struct radeonfb_info *rinfo, int reenable=
)
> +{
> +	u32 int_cntl;
> +
> +	if (!test_and_set_bit(0, &rinfo->irq_flags)) {
> +		if (request_irq(rinfo->pdev->irq, radeon_irq, SA_SHIRQ,=20
> +			"radeonfb", rinfo)) {
> +			printk("radeonfb: request_irq failed..\n");
> +			clear_bit(0, &rinfo->irq_flags);
> +			return -EINVAL;
> +		}
> +		int_cntl =3D INREG(GEN_INT_CNTL) & CRTC_VBLANK_MASK;
> +		/* clear interrupt */
> +		//OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_STAT_ACK);

Why is this commented out?

> +		/* enable interrupt */
> +		OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN);
> +		printk("radeonfb: enabled IRQ\n");
> +	} else if (reenable) {
> +		int_cntl =3D INREG(GEN_INT_CNTL) & CRTC_VBLANK_MASK;
> +		if (!(int_cntl & CRTC_VBLANK_INT_EN)) {
> +			printk("radeonfb: someone disabled IRQ [%08x]\n", int_cntl);
> +			/* re-enable interrupt */
> +			OUTREG(GEN_INT_CNTL, int_cntl | CRTC_VBLANK_INT_EN);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
<snip>
> @@ -2338,6 +2460,10 @@
>  	radeon_create_i2c_busses(rinfo);
>  #endif
> =20
> +	rinfo->irq_flags =3D 0;

Nitpick: No need to set to 0. rinfo is memset() to 0 by=20
framebuffer_alloc().

> +	init_waitqueue_head(&rinfo->vblank.wait);
> +	spin_lock_init(&(rinfo->int_lock));
> +

Unused spinlock.

>  	/* set all the vital stuff */
>  	radeon_set_fbinfo (rinfo);

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
