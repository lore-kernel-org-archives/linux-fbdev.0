From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Reading the EDID block for x86 machines
Date: 17 Mar 2003 07:00:21 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047855536.1220.74.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303130748470.21784-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18uhAT-0001kX-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Mar 2003 15:03:49 -0800
In-Reply-To: <Pine.GSO.4.21.0303130748470.21784-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 2003-03-13 at 14:50, Geert Uytterhoeven wrote:
> On 13 Mar 2003, Antonino Daplas wrote:
> > On Thu, 2003-03-13 at 02:16, Jon Smirl wrote:
> > > --- Antonino Daplas <adaplas@pol.net> wrote:
> > > > Unless I missed some imported BIOS calls or other
> > > > methods to do this or
> > > > something similar in real-mode...
> > > 
> > > You missed something. The address of the VBIOS ROM can
> > > be controlled by writing to the PCI config space. You
> > > can make the ROM appear anywhere you want it to.
> > > 
> > > This happens even for the boot video device. 
> > > Somewhere very early in the boot the system BIOS
> > > enabled the VBIOS ROM and copied it to C000. This is
> > > the "shadow BIOS" option.
> > > 
> > 
> > So the steps needed would be:
> > 
> > 1.  scan for pci devices looking for the vga controller type
> > 
> > 2.  if 1 is found other than the primary, disable the current controller
> > 
> > 3.  write to PCI config space of secondary controller the address you
> > want it to appear (ie C000:0000).  Can I use other addresses?

I checked the PCI 2.2 specs, and it doesn't have this capability.  It
will give you the address of the expansion ROM, but you still have to
manually copy the ROM and place it in any of the expansion areas. 
Unfortunately for VGA controllers, it's always C000:0000.  

There's a big problem in real mode:

1.  COOO:0000 will be write protected by the BIOS upon initialization of
the first VGA controller.  This will prevent copying of the succeeding
ROMS into that segment (unless you have a BIOS that supports read-write
shadow ROM's).

2.  Real mode does not support paging (ie copy on write tricks will not
work)


> > 
> > 4. enable the controller
> > 
> > 5. far call c000:0003
> > 
> > 6. disable the controller
> > 
> > 7. repeat
> > 
> > Besides the finer points, did I miss anything obvious?
> 
> Write a portable x86 emulator for non-ia32 platforms. Besides, you may even
> want to use it on ia32 to make it less dependent on BIOS quirks (or for
> machines without a PC BIOS).
> 

I read Kendall's thread, and it seems a userspace vm86/vm86emu daemon
might do the job.

Tony



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
