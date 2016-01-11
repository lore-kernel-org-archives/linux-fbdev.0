From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 11 Jan 2016 07:16:31 +0000
Subject: Re: imxfb does not turn on automatically
Message-Id: <20160111071631.GI13058@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAOMZO5CZ3aFGbfb39XoXpFvbn4TTrCbTHOXtQKruruCis3Ptvw@mail.gmail.com>
 <CAD7j7Q8gANUxM5zGmn3YyhUr9yZv02x4oxi_WWLnxCYemBRYZA@mail.gmail.com>
In-Reply-To: <CAD7j7Q8gANUxM5zGmn3YyhUr9yZv02x4oxi_WWLnxCYemBRYZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Carlos,

On Fri, Jan 08, 2016 at 09:18:41PM +0100, Carlos Soto wrote:
> 2015-02-21 16:18 GMT+01:00 Fabio Estevam <festevam@gmail.com>:
> >
> > Hi,
> >
> > Carlos Soto uses a Karo mx25 and he noticed that the LCD only works if we do:
> >
> > echo 1 > /sys/class/graphics/fb0/blank
> > echo 0 > /sys/class/graphics/fb0/blank
> >
> > I can confirm the same on mx25pdk running 3.19 [1], but I could not
> > understand why the display does not start turned on by default.
> >
> > [1] http://www.spinics.net/lists/arm-kernel/msg399949.html
> >
> > Any ideas?
> >
> > Thanks,
> >
> > Fabio Estevam
> 
> 
> 
> Hi,
> I know it's been a long time since Fabio posted the issue but recently
> I had some time to work on it again, and I've narrowed it down a
> little.
> 
> The problem seems to be related to the IPG clock used by the iMX25
> framebuffer. All clocks used by the fb are enabled in
> imxfb_enable_controller(...)
> 
> ...
> clk_prepare_enable(fbi->clk_ipg);
> clk_prepare_enable(fbi->clk_ahb);
> clk_prepare_enable(fbi->clk_per);
> fbi->enabled = true;
> 
> ...
> 
> 
> But if the IPG clock is disabled and enabled right after, the LCD
> works fine.
> 
> The changes made in imxfb.c were:
> ...
> 
> clk_prepare_enable(fbi->clk_ipg);
> clk_disable_unprepare(fbi->clk_ipg);
> clk_prepare_enable(fbi->clk_ipg);
> 
> clk_prepare_enable(fbi->clk_ahb);
> clk_prepare_enable(fbi->clk_per);
> fbi->enabled = true;
> 
> ...
> 
> It was suggested by Fabio that this could be caused by a wrong clock
> reference count which prevented the IPG fb clock to be enabled, but
> I've checked in debugfs, and both enable_cnt  and prepare_cnt seem OK
> for all three FB clocks.

Unfortunately this LCD controller does not have an enable bit. The
controller starts directly when the clocks are enabled. If the clocks
are enabled when the controller is not yet programmed with proper
register values then it just goes into some undefined state. What I
suspect is that the clocks already were enabled before driver probe,
presumably by the bootloader, so the controller is already in undefined
state when entering Linux. Now by dis/enabling the ipg clock you
effectively reset the controller. Since you have programmed it with
valid register values in the mean time it starts working after this
reset.
To verify you could try to disable the LCDC related clock gates with
direct register writes in drivers/clk/imx/clk-imx25.c.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
