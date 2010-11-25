From: Jimmy RUBIN <jimmy.rubin@stericsson.com>
Date: Thu, 25 Nov 2010 11:20:02 +0000
Subject: RE: [PATCH 10/10] ux500: MCDE: Add platform specific data
Message-Id: <F45880696056844FA6A73F415B568C695365E671A6@EXDCVYMBSTM006.EQ1STM.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289390653-6111-1-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-10-git-send-email-jimmy.rubin@stericsson.com>
	<1289390653-6111-11-git-send-email-jimmy.rubin@stericsson.com>
	<201011121703.52422.arnd@arndb.de>
In-Reply-To: <201011121703.52422.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,


> > +
> > +	if (ddev->id = PRIMARY_DISPLAY_ID && rotate_main) {
> > +		swap(width, height);
> > +#ifdef CONFIG_DISPLAY_GENERIC_DSI_PRIMARY_ROTATE_180_DEGREES
> > +		rotate = FB_ROTATE_CCW;
> > +#else
> > +		rotate = FB_ROTATE_CW;
> > +#endif
> > +	}
> > +
> > +	virtual_width = width;
> > +	virtual_height = height * 2;
> > +#ifdef CONFIG_DISPLAY_GENERIC_DSI_PRIMARY_AUTO_SYNC
> > +	if (ddev->id = PRIMARY_DISPLAY_ID)
> > +		virtual_height = height;
> > +#endif
> > +
> 
> The contents of the hardware description should really not
> be configuration dependent, because that breaks booting the same
> kernel on machines that have different requirements.
> 
> This is something that should be passed down from the boot loader.
The defines above is more configuration of the display driver than hardware dependant defines.

The define CONFIG_DISPLAY_GENERIC_DSI_PRIMARY_AUTO_SYNC is not hardware dependant.
It is used to tell mcde that it should not rely on pan_display for refreshing the display, it should rather refresh the display itself, currently using software triggers and it will also tell mcde that only one frame buffer should be used.
This mode can be used if the application system is for example X.

CONFIG_DISPLAY_GENERIC_DSI_PRIMARY_ROTATE_180_DEGREES is used for some boards that have the display rotated 90 instead of 270 degrees, so in a sense it is hardware dependant, but it will not break the kernel. This defines is going to be removed and replaced by one define that handles all rotations, 0, 90, 180, 270 degrees.

> 
> > +static void mcde_epod_enable(void)
> > +{
> > +	/* Power on DSS mem */
> > +	writel(PRCMU_ENABLE_DSS_MEM, PRCM_EPOD_C_SET);
> > +	mdelay(PRCMU_MCDE_DELAY);
> > +	/* Power on DSS logic */
> > +	writel(PRCMU_ENABLE_DSS_LOGIC, PRCM_EPOD_C_SET);
> > +	mdelay(PRCMU_MCDE_DELAY);
> > +}
> 
> In general, try to avoid using mdelay. Keeping the CPU busy for
> miliseconds
> or even microseconds for no reason is just wrong.
> 
> Reasonable hardware will not require this and do the right thing
> anyway.
> multiple writel calls are by design strictly ordered on the bus. If
> that is
> not the case on your hardware, you should find a proper way to ensure
> ordering and create a small wrapper for it with a comment that explains
> the breakage. Better get the hardware designers to fix their crap
> before
> releasing a product ;-)
> 
> If there is not even a way to reorder I/O by accessing other registers,
> use msleep() to let the CPU do something useful in the meantime and
> complain
> even more to the HW people.
> 
> 	Arnd
These registers are normally not accessed by the cpu and therefore it is required to use some delays between them, however I agree that msleep is better to use.
We are investigating how this can be removed but for now we have to keep it.

/Jimmy
