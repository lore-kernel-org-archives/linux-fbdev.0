From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Some thoughts on Rage128/Radeon EDID
Date: 17 Aug 2003 10:05:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1061107558.641.14.camel@gaston>
References: <20030817063234.75420.qmail@web14910.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-3-2.w193-253.abo.wanadoo.fr ([193.253.250.2] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19oIZE-0005p4-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Aug 2003 01:07:12 -0700
In-Reply-To: <20030817063234.75420.qmail@web14910.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>, Paul Mackerras <paulus@samba.org>

On Sun, 2003-08-17 at 08:32, Jon Smirl wrote:
> I looked through the 2.4 radeon driver and I see all
> of the code for parsing the EDID blocks. This is a lot
> of code and it is seldom used (compared to something
> like an interrupt handler).

Yup. Which is a reason, btw, why a think the radeon driver
should be split into multiple files (and possibly share
some code with aty128), but I haven't had time to play with
that much.

> Somewhat complete I2C driver code exists in the KATOS
> project.
> http://www.core.binghamton.edu/~insomnia/gatos/katos/src/katos-0.5.tar.gz
> 
> These next thoughts just apply to 2.6, not 2.4.
> 
> There are a lot of things on the I2C bus on the these
> cards: EDID,  video capture, teletext, tv out and mpeg
> decoding control, etc..
> 
> 1) How about making the fb driver register itself as
> an I2C bus so that it appears in /proc/bus/I2C? I've
> never touched I2C code so I don't know what this
> involves.

I don't much like the Linux i2c layer because I think it's bloated
and not very convenient to use, but if you want to go that way, then
it's ok ;) Whatever i2c API we expose, be it custom or via the linux
i2c layer...

> 2) Making the card appear in /proc/bus/I2C makes it
> easy to get to from user space.  A user level app can
> read the EDID info, diff it off against card
> capabilities and IOCTL the new mode in. Maybe modify
> fbset.

Well... I'd rather have an in-kernel monitor "driver" module that
would access the EDID to provide a default mode, validate modes
etc... It could expose the raw EDID data via sysfs. We want proper
mode detection & probing at boot time. Note that the linux i2c
layer also allows for in-kernel clients, not only userland interface.
 
> 3) Doesn't the video hardware always power on to a
> visible state? So setting an alternate mode can wait
> until we can run user space apps. I'm not sure it is
> worth all of the kernel code  just to get a 50 line
> display with valid EDID during the first few seconds
> of boot.

Unfortunately, not all cards power on with a visible state... Well,
in most cases they do, and we have offb on powermac to use as a basic
text console (since we don't have VGA text mode), so we could eventually
have this transition done later on.

> 4) Once we have access to the other devices maybe
> people will write apps that use them.

Maybe... I see your point in wanting to expose those i2c busses
to userland. I think it makes sense for things like teletext or tv out
control. But I still prefer having monitor & edid management be an
in-kernel driver (same for capture btw).

Ben.



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
