From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [Linux-fbdev-devel] New kernel API for ROMs
Date: Sat, 7 Aug 2004 09:54:57 -0700 (PDT)
Sender: dri-devel-admin@lists.sourceforge.net
Message-ID: <20040807165457.22743.qmail@web14921.mail.yahoo.com>
References: <20040807163733.GD3714@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <dri-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040807163733.GD3714@dreamland.darkstar.lan>
Errors-To: dri-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:dri-devel@lists.sourceforge.net>
List-Help: <mailto:dri-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=dri-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kronos <kronos@people.it>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, dri-devel <dri-devel@lists.sourceforge.net>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

All of the video ROMs I have are 48KB - 64KB in size. But, the copy
code is only triggered by the driver for older PCI cards with minimal
decoding. I am unaware of any video cards with this problem so they
won't make the copy. The only cards I seem to recall having this
problem are some older QLogic disk controllers. We should fix this
alloc as best as we can but most normal users will never see it. 

Another solution I'll add is a pci_disable_rom() call that will make
the ROM disappear from sysfs. This would give the minimally decoded PCI
board the option of avoiding the copy and just disabling it. The copy
only needs to happen if user space apps are going to use the ROM
contents after the device driver has loaded.

To get the true size of your ROM look at the front of it for 55 AA the
third byte is then len / 512. Fourth byte is the JMP for the reset
vector.

Note that the code does not copy SHADOW ROMs. These ROMs have already
been copied by the system BIOS to C0000. The code uses the existing
copy.

--- Kronos <kronos@people.it> wrote:
> > This memory is not performance critical and can be swapped, is
> there a
> > better way to allocate it?
> 
> Problem is that kmalloc may be unable to find many contiguous memory
> pages.
> 
> You can check and see if the ROM is really big and use vmalloc, if
> not
> then you use kmalloc (if I remember correctly my radeon has a 4KB ROM
> -
> vmalloc would be overkill).
> 
> Luca
> -- 
> Home: http://kronoz.cjb.net
> Ci sono due cose che l'uomo non puo` nascondere:
> essere ubriaco ed essere innamorato.
> 

=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
--
