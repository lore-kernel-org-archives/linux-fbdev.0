From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Thu, 22 Feb 2007 17:08:39 +0000
Message-ID: <1172164119.5837.98.camel@localhost.localdomain>
References: <1171876788.6046.3.camel@localhost.localdomain>
	<877iub9mu2.fsf@sycorax.lbl.gov>
	<1172097718.5790.29.camel@localhost.localdomain>
	<20070221231706.GA3336@khazad-dum.debian.net>
	<1172103159.5790.45.camel@localhost.localdomain>
	<20070222005122.GA7928@khazad-dum.debian.net>
	<20070222011017.GA8845@khazad-dum.debian.net>
	<1172138450.5837.34.camel@localhost.localdomain>
	<20070222145613.GD25887@khazad-dum.debian.net>
	<1172157592.5837.89.camel@localhost.localdomain>
	<20070222163405.GF25887@khazad-dum.debian.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKHR8-0005sV-Bz for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:08:54 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HKHR6-0007AE-HN
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 09:08:54 -0800
In-Reply-To: <20070222163405.GF25887@khazad-dum.debian.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: James Simmons <jsimmons@infradead.org>, Alex Romosan <romosan@sycorax.lbl.gov>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Yaroslav Halchenko <kernel@onerussian.com>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 2007-02-22 at 14:34 -0200, Henrique de Moraes Holschuh wrote:
> On Thu, 22 Feb 2007, Richard Purdie wrote:
> > If you really care, add a a call to backlight_update_status() after you
> > set the brightness attribute like some of the other drivers have. The
> 
> I will.  Do you ACK the patch, then?

Yes, it can have an Acked-by: Richard Purdie <rpurdie@rpsys.net>.

> > Have a look at what corgi_bl does. It can know what state it set the
> > hardware too as it keeps track itself, it just can't read that state
> 
> You are assuming nothing else is changing the hardware behind the driver's
> back. 

Which it can't in the corgi_bl case (excluding poking things
like /dev/mem). Its safe to assume it has exclusive access.

>  I am against such assumptions when they can be avoided, but that's a
> particular PoV and not much more than that.  IMHO, if you cannot query the
> hardware, you shouldn't provide a way to query the current brightness that
> will be right only if nobody else messed with the device.
> 
> Maybe for corgi, that doesn't hold much strength, but for stuff tied to
> ACPI, it does.  And in a ThinkPad's case, where even writes to /dev/nvram
> can change the brightness, well, if there weren't a way to ask the EC the
> current real brightness, there is NO way I'd be implementing it based on a
> memory cache.

Right, I'd be against such a driver. On the embedded hardware we can
safely assume there is nothing else playing with the brightness settings
though and such a driver is perfectly valid.

> > > Howerver, I *do* strongly wish for a way to combine various drivers into a
> > > single backlight device, where radeon/intelfb takes care of some stuff,
> > > ibm-acpi/asus-laptop/sony-laptop takes care of other stuff, etc.  Also, a
> > > standard naming for the builtin screen(s) would help, calling it "ibm",
> > > "asus", "sony" is not good IMHO.
> > 
> > I wasn't aware of this problem. If some devices need bits from both
> > raedon/whatever and acpi, the current implementations are just plain
> > wrong. Its not really a backlight class problem and more of an
> > implementation and interaction problem between acpi and the framebuffer
> > drivers. They should be presenting and registering *one* backlight class
> 
> I.e. we should add hooks to the framebuffer drivers?  It would work, that's
> for sure.

If the backlight controls would then power off the backlight properly
that would be desirable as we've have a more standard interface.

Richard


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
