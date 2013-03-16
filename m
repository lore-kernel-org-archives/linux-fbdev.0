From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 16 Mar 2013 20:09:05 +0000
Subject: Shifted framebuffer after X11 starts on mx28
Message-Id: <CAOMZO5CDuODRrJEEaDKm5nepfkuvuF77ZQmarB69hL6gg386ww@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

I am running 3.8.2 kernel on a mx28evk and when I start X11 I get a
"shifted" framebuffer.

The framebuffer works well if X11 is not called.

There is no issue with X11 when running with Freescale  2.6.35 kernel.

Looking at drivers/video/mxsfb.c there is the following comment:

	/*
	 * It seems, you can't re-program the controller if it is still running.
	 * This may lead into shifted pictures (FIFO issue?).
	 * So, first stop the controller and drain its FIFOs
	 */

So, it looks like that I am still facing this issue when X11 starts.

If anyone has any suggestions, please let me know.

Thanks,

Fabio Estevam
