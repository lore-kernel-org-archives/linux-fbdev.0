From: Anatolij Gustschin <agust@denx.de>
Date: Thu, 17 Jan 2013 22:48:08 +0000
Subject: Re: [PATCH 1/2] drivers/video: fsl-diu-fb: fix pixel formats for 24 and 16 bpp
Message-Id: <20130117234808.4fb94a7c@crub>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358454518-14032-1-git-send-email-agust@denx.de>
In-Reply-To: <1358454518-14032-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 17 Jan 2013 16:12:05 -0600
Timur Tabi <timur@tabi.org> wrote:

> Anatolij Gustschin wrote:
> >  		/* 0x88883316 */
> > -		return MAKE_PF(3, 2, 0, 1, 3, 8, 8, 8, 8);
> > +		return MAKE_PF(3, 2, 1, 0, 3, 8, 8, 8, 8);
> >  	case 24:
> >  		/* 0x88082219 */
> > -		return MAKE_PF(4, 0, 1, 2, 2, 0, 8, 8, 8);
> > +		return MAKE_PF(4, 0, 1, 2, 2, 8, 8, 8, 0);
> >  	case 16:
> >  		/* 0x65053118 */
> >  		return MAKE_PF(4, 2, 1, 0, 1, 5, 6, 5, 0);
> 
> You're right that the original values are incorrect, but I think your
> patch is changing the wrong lines.

No.

> I put this code in the driver:
> 
> 	printk(KERN_INFO "%s:%u 0x88883316 old %08x new %08x\n", __func__,
> __LINE__, MAKE_PF(3, 2, 0, 1, 3, 8, 8, 8, 8), MAKE_PF(3, 2, 1, 0, 3, 8, 8,
> 8, 8));
> 	printk(KERN_INFO "%s:%u 0x88082219 old %08x new %08x\n", __func__,
> __LINE__, MAKE_PF(4, 0, 1, 2, 2, 0, 8, 8, 8), MAKE_PF(4, 0, 1, 2, 2, 8, 8,
> 8, 0));
> 	printk(KERN_INFO "%s:%u 0x65053118 %08x\n", __func__, __LINE__,
> MAKE_PF(4, 2, 1, 0, 1, 5, 6, 5, 0));
> 
> 
> and it gave me this output:
> 
> fsl_diu_get_pixel_format:956 0x88883316 old 88883316 new 88889316
> 
> fsl_diu_get_pixel_format:957 0x88082219 old 8088c218 new 8808c218
> 
> fsl_diu_get_pixel_format:958 0x65053118 65059118
> 
> fsl_diu_get_pixel_format:956 0x88883316 old 88883316 new 88889316
> 
> fsl_diu_get_pixel_format:957 0x88082219 old 8088c218 new 8808c218
> 
> fsl_diu_get_pixel_format:958 0x65053118 65059118
> 
> Console: switching to colour frame buffer device 182x73
> 
> So the value for 32-bit is already correct, but your patch breaks it.

No, my patch doesn't break it. The patch also modifies the order of
red, blue, green arguments in the MAKE_PF() macro to red, green, blue
order since this is more natural:

-#define MAKE_PF(alpha, red, blue, green, size, c0, c1, c2, c3) \
+#define MAKE_PF(alpha, red, green, blue, size, c0, c1, c2, c3) \


> value for 24-bit is wrong, but your patch just gives me another wrong
> value.  The value for 16-bit is wrong, but you don't change that.

No. Please read the whole patch and commit message again.

Thanks,

Anatolij
