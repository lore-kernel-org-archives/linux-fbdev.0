From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Reading the EDID block for x86 machines
Date: Thu, 13 Mar 2003 07:50:38 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303130748470.21784-100000@vervain.sonytel.be>
References: <1047508652.1005.6.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18tMZ8-000587-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Mar 2003 22:51:47 -0800
In-Reply-To: <1047508652.1005.6.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 13 Mar 2003, Antonino Daplas wrote:
> On Thu, 2003-03-13 at 02:16, Jon Smirl wrote:
> > --- Antonino Daplas <adaplas@pol.net> wrote:
> > > Unless I missed some imported BIOS calls or other
> > > methods to do this or
> > > something similar in real-mode...
> > 
> > You missed something. The address of the VBIOS ROM can
> > be controlled by writing to the PCI config space. You
> > can make the ROM appear anywhere you want it to.
> > 
> > This happens even for the boot video device. 
> > Somewhere very early in the boot the system BIOS
> > enabled the VBIOS ROM and copied it to C000. This is
> > the "shadow BIOS" option.
> > 
> 
> So the steps needed would be:
> 
> 1.  scan for pci devices looking for the vga controller type
> 
> 2.  if 1 is found other than the primary, disable the current controller
> 
> 3.  write to PCI config space of secondary controller the address you
> want it to appear (ie C000:0000).  Can I use other addresses?
> 
> 4. enable the controller
> 
> 5. far call c000:0003
> 
> 6. disable the controller
> 
> 7. repeat
> 
> Besides the finer points, did I miss anything obvious?

Write a portable x86 emulator for non-ia32 platforms. Besides, you may even
want to use it on ia32 to make it less dependent on BIOS quirks (or for
machines without a PC BIOS).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
