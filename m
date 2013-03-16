From: Marek Vasut <marex@denx.de>
Date: Sat, 16 Mar 2013 21:00:38 +0000
Subject: Re: Shifted framebuffer after X11 starts on mx28
Message-Id: <201303162200.38990.marex@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
 <201303162155.28230.marex@denx.de>
In-Reply-To: <201303162155.28230.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Dear Marek Vasut,

> Dear Fabio Estevam,
> 
> > Hi,
> > 
> > I am running 3.8.2 kernel on a mx28evk and when I start X11 I get a
> > "shifted" framebuffer.
> > 
> > The framebuffer works well if X11 is not called.
> > 
> > There is no issue with X11 when running with Freescale  2.6.35 kernel.
> > 
> > Looking at drivers/video/mxsfb.c there is the following comment:
> > 	/*
> > 	
> > 	 * It seems, you can't re-program the controller if it is still running.
> > 	 * This may lead into shifted pictures (FIFO issue?).
> > 	 * So, first stop the controller and drain its FIFOs
> > 	 */
> > 
> > So, it looks like that I am still facing this issue when X11 starts.
> > 
> > If anyone has any suggestions, please let me know.
> 
> This is not it, I almost hunted the bug down. Hang on.
> 
> Basically check mxsfb_set_par() and observe fb_info->var.sync . It's set to
> "something" during regular framebuffer operation and it's set to "something
> else" during Xorg operation. And that's what causes it to get broken. I
> forced fb_info->var.sync to the "something" value by hardcoding it in
> kernel just now for a quick test and X works for me.

Uh, being in hacking-mode and replying to email doesn't work well together :-)

In my case, fb_info->var.sync is set to FB_SYNC_DATA_ENABLE_HIGH_ACT during 
regular operation (framebuffer console), but if X11 starts, this fb_info-
>var.sync is forced to value 0 which causes the malfunction. Now back into 
hacking-mode ;-)

Best regards,
Marek Vasut
