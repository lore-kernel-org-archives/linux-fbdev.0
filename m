From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [RFC] driving a LCD panel via I2C
Date: Tue, 25 Sep 2007 00:03:04 +0100
Message-ID: <1190674984.19359.114.camel@localhost.localdomain>
References: <41784.213.84.50.107.1190624288.squirrel@webmail.enneenne.com>
	<20070924123408.596a3c69@dhcp-255-175.norway.atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IZwy6-0002Ty-7Y for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 16:03:58 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IZwy1-0003IM-U8
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 24 Sep 2007 16:03:54 -0700
In-Reply-To: <20070924123408.596a3c69@dhcp-255-175.norway.atmel.com>
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
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, i2c@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 2007-09-24 at 12:34 +0200, Haavard Skinnemoen wrote: 
> On Mon, 24 Sep 2007 10:58:08 +0200 (CEST)
> "Rodolfo Giometti" <giometti@enneenne.com> wrote:
> > I have an LCD panel on a custom PXA27x based board and it must be
> > turned on/off by some special commands via a GPIO throught a I2C chip.
> > 
> > I'd like some suggestion about I can easily manage this situation.
> 
> I have a similar panel in the sense that it needs a bunch of SPI
> commands to get started. I implemented a LCD driver
> (drivers/video/backlight) for it so that it is automatically turned
> on/off at bootup/shutdown, and can be manually turned on/off
> through /sys/class/lcd/ltv350qv/power. AFAIK the driver is currently
> sitting in the backlight tree scheduled for inclusion in 2.6.24.

It is, its queued as
http://git.o-hand.com/?p=linux-rpurdie-backlight;a=commitdiff;h=c962fe18c64ae9139028ee674ab3c380449ce052

Its also worth noting that corgi-bl.c has a variant (akita) that uses a
gpio over an I2C IO expander for the backlight control. The code paths
are a little convoluted since other gpios are used by other drivers. The
base driver is in arch/arm/mach-pxa/akita-ioexp.c, the set_intensity
function is in arch/arm/mach-pxa/corgi_lcd.c and the base backlight
device in arch/arm/mach-pxa/spitz.c. I will be moving the set_intensity
to spitz.c to make things a little clearer.

Also, I'm in the process of turning corgi-bl.c into a generic backlight
driver which might help you, see:

http://git.o-hand.com/?p=linux-rpurdie-backlight;a=commitdiff;h=c74f241bf53bf5251c7c10f65041c20979f6c694

Now, the GPIO framework could help too (it didn't exist when I wrote
akita-ioexp)...

Regards,

Richard


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
