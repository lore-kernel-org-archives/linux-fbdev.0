From: Kronos <kronos@people.it>
Subject: Re: New kernel API for ROMs
Date: Sat, 7 Aug 2004 18:37:33 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040807163733.GD3714@dreamland.darkstar.lan>
References: <Pine.GSO.4.58.0408071515350.3475@waterleaf.sonytel.be> <20040807145929.77135.qmail@web14923.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040807145929.77135.qmail@web14923.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

Il Sat, Aug 07, 2004 at 07:59:29AM -0700, Jon Smirl ha scritto: 
> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> Maximum size of a standard PCI ROM is 128KB.

This is the maximun that kmalloc can allocate.

> On non-x86 platforms the code will pick the length up from the size of
> the PCI window. That window has no limit.

Hum, this is bad... what's the tipical size of video ROMs?

> On the other hand, map_rom_copy is only called by the device driver for
> a board that has minimal PCI decoding. The PCI spec allows the address
> decoding for something like the ROM and framebuffer to be shared. A few
> vendors have implemented this and the result is that you can't read the
> ROM and framebuffer at the same time. This is why you need to make the
> copy.  We only know of a couple PCI boards that have implemented this.
> 
> This memory is not performance critical and can be swapped, is there a
> better way to allocate it?

Problem is that kmalloc may be unable to find many contiguous memory
pages.

You can check and see if the ROM is really big and use vmalloc, if not
then you use kmalloc (if I remember correctly my radeon has a 4KB ROM -
vmalloc would be overkill).

Luca
-- 
Home: http://kronoz.cjb.net
Ci sono due cose che l'uomo non puo` nascondere:
essere ubriaco ed essere innamorato.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
