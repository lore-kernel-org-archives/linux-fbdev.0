From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Radeon EDID
Date: Sat, 23 Aug 2003 10:41:28 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030823174128.7904.qmail@web14913.mail.yahoo.com>
References: <20030823165021.GA773@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14913.mail.yahoo.com ([216.136.225.240])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19qcOH-0004JR-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 23 Aug 2003 10:41:29 -0700
In-Reply-To: <20030823165021.GA773@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kronos@kronoz.cjb.net
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, Andreas Oberritter <obi@saftware.de>

Other neat I2C features: TV Out, video capture, closed captions, TV tuner, etc.
Build your own TIVO.

To get Radeon docs you have to register with ATI and then request them:
http://apps.ati.com/developers/devform1.asp
Follow this by praying to the moon for two months and making various
sacrifices. Send numerous follow-ups singing the praises of ATI. After the
appropriate amount of groveling they might let you have the doc under NDA.

I've only been sucessful in getting full Rage128-AIW docs. No luck yet with
Radeon docs, but I have only been groveling for nine months now. 95% of my
contacts with their dev relations are never returned, but every once in a while
I get lucky.

On the other hand, most of what you need to know can be extracted from the
Gatos/Katos project. Most of the I2C devices are standard chips and you can
simply get the datasheets from the various manufacturers. TDA8425 (sound) and
BT879 (video capture)

http://www.semiconductors.philips.com/pip/TDA8425.html#datasheet
http://www.conexant.com/products/entry.jsp?id=272

The AIW cards can be had pretty cheap, I have a Rage128 AIW PCI so that I can
run my AGP Radeon in the same machine. This lets me switch between working on
Rage and Radeon in same machine.

Radeon 7000 AIW PCI $61 -
http://www.fticomputer.com/cgis/detail.cgi?product=VB-ATI-AIW7000&ses=&cat=VB
AGP versions can be had for $50.  Search pricewatch for radeon/wonder or AIW.
You can get 9800 AIW but it is expensive.

I can't find Rage AIW ones anymore, but don't dismiss Rage. I just bought a
Dell last week that came with a Rage128 integrated into the motherboard.


--- Kronos <kronos@kronoz.cjb.net> wrote:
> Il Sat, Aug 23, 2003 at 08:57:28AM -0700, Jon Smirl ha scritto: 
> > I merged in Radeon EDID with my ROM based Radeon driver. Results are at:
> > bk://mesa3d.bkbits.net/linux-2.5
> > I needed to fix some error handling in the init code, and remove =y from
> the
> > Kconfig.
> 
> If radeonfb  is build  into the kernel  we need  i2c-algo-bit also. What
> about this:
> 
> depends on FB_RADEON && (I2C_ALGOBIT=FB_RADEON || I2C_ALGOBIT=y)
> 
> > Now that I2C is there, is it hard to make the rest of the I2C devices
> > accessible?
> 
> Such as the tvout? We need another  i2c adapter (and a driver of course)
> because the  current one deals with  only with DDC registers. If  I find
> some docs I can write something, but I don't hw to test.
> 
> Btw, where can I find some docs about i2c on radeon? Can't find anything
> on ATI web site. My work is based on XFree code...
> 
> Luca
> -- 
> Reply-To: kronos@kronoz.cjb.net
> Home: http://kronoz.cjb.net
> Io mi ricordo sempre il compleanno della mia ragazza:
> cade il giorno dopo di quando lei me lo ricorda


=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines
at the same time. Free trial click here:http://www.vmware.com/wl/offer/358/0
