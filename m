From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [RFC] driving a LCD panel via I2C
Date: Wed, 26 Sep 2007 11:07:49 +0200
Message-ID: <20070926090749.GI12137@enneenne.com>
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
	id 1IaSq9-0002fg-WB for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 02:05:54 -0700
Received: from 81-174-11-161.static.ngi.it
	([81.174.11.161] helo=mail.enneenne.com ident=Debian-exim)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaSq8-0004Vs-Di
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 26 Sep 2007 02:05:53 -0700
Content-Disposition: inline
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
Cc: rpurdie@rpsys.net, linux-fbdev-devel@lists.sourceforge.net, i2c@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, Sep 24, 2007 at 12:34:08PM +0200, Haavard Skinnemoen wrote:
> 
> I have a similar panel in the sense that it needs a bunch of SPI
> commands to get started. I implemented a LCD driver
> (drivers/video/backlight) for it so that it is automatically turned
> on/off at bootup/shutdown, and can be manually turned on/off
> through /sys/class/lcd/ltv350qv/power. AFAIK the driver is currently
> sitting in the backlight tree scheduled for inclusion in 2.6.24.

Mmm... it seems a good solution! :)

> Just implement it as a regular I2C chip driver which registers a device
> with the LCD framework when it is successfully probed.

Thanks for your suggestion.

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
