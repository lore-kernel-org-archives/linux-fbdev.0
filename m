From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 17 Mar 2003 15:00:14 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047883995.1234.7.camel@localhost.localdomain>
References: <20030317040051.35768.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uoeo-000866-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Mar 2003 23:03:38 -0800
In-Reply-To: <20030317040051.35768.qmail@web14911.mail.yahoo.com>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-03-17 at 12:00, Jon Smirl wrote:
> --- Antonino Daplas <adaplas@pol.net> wrote:
> > > > 3.  write to PCI config space of secondary
> > controller the address you
> > > > want it to appear (ie C000:0000).  Can I use
> > other addresses?
> > 
> > I checked the PCI 2.2 specs, and it doesn't have
> > this capability.  It
> > will give you the address of the expansion ROM, but
> > you still have to
> > manually copy the ROM and place it in any of the
> > expansion areas. 
> > Unfortunately for VGA controllers, it's always
> > C000:0000.  
> 
> You can very definitely move the ROMs to where ever
> you want that isn't occupied by something else. I have
> written code that does it. Also, the system BIOS must
> be moving the ROMs in order to sort things out so that
> they don't all appear on top of each other.
> 

You're talking about other device's expansion ROM's.  VGA ROM's,
especially for the x86, are an exception and has to be always mapped at
c000:0000.


> You don't even need to move the ROM. Just enable it
> and read it's address form PCI space.  The system BIOS
> will have sorted the addresses out so that they don't
> overlap. PCI config Region 6 is always the ROM see
> include/linux/pci.h
> 
> > 1.  COOO:0000 will be write protected by the BIOS
> > upon initialization of
> > the first VGA controller.  This will prevent copying
> > of the succeeding
> > ROMS into that segment (unless you have a BIOS that
> > supports read-write
> > shadow ROM's).
> 
> How is C000 write protected? I'm pretty sure that the
> ATI ROM are writing to C000.

It is.  C000 is write enabled by the BIOS before init.  Then it calls
the INIT procedure, which adjusts the initialization size before
returning.  Afterwards, the BIOS write-protects the block equivalent to
the initialization size.  Suceeding ROM's will then be mapped after this
block.

Remember, ROM's are supposed to be read-only, so even if they are
shadowed, the BIOS write protects it.

Tony




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
