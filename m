From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: ioremap problem on highmem
Date: Tue, 14 Oct 2003 07:42:19 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031014144219.73671.qmail@web14914.mail.yahoo.com>
References: <Pine.GSO.4.21.0310141031320.8202-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9QNS-0000bC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Oct 2003 07:42:22 -0700
Received: from web14914.mail.yahoo.com ([216.136.225.241])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A9QNQ-0000IJ-2d
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Oct 2003 07:42:20 -0700
In-Reply-To: <Pine.GSO.4.21.0310141031320.8202-100000@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Otto Solares <solca@guug.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

--- Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Mon, 13 Oct 2003, Jon Smirl wrote:
> > Fix is not that simple. There is a basic conflict with mapping framebuffers
> > into the kernel address space and the kernel's need of that address space
> for
> > other purposes. Drivers need to be rewritten to do one of:
> > 
> > 1) Map the frame buffer into the kernel address space a few pages at a
> time.
> > This is how kernel high mem support works.
> > 2) Map the minimal amount of address space necessary for visible
> framebuffer.
> > This is what the VGA driver does. It works most of the time.
> > 3) Use a user space program to map the framebuffer and do the drawing.
> > 4) Use the reserve= to reserve the needed address space. This boots
> performance
> > sensitive page tables into highmem while keeping your slow framebuffer in
> > lowmem.
> > 
> > It is only fbconsole that uses the kernel mapped framebuffer. If you aren't
> > using fbconsole you could just delete the ioremap code from the framebuffer
> > driver. Another quick fix would be to eliminate the framebuffer ioremaps
> from
> > each driver and instead do it in the fbconsole driver. This would let
> people
> > still load fb drivers and not load fbconsole.
> 
> Another approach: on fully-accelerated drivers, you don't need the ioremap(),
> so there's no problem.
> 
> On non-accelerated drivers, you need the ioremap(), but usually unaccelerated
> hardware is old and has only a few MiB of graphics memory anyway, so there's
> no
> problem.
> 
> On partially-accelerated drivers, we can limit the amount of graphics memory
> that's ioremapped(), and thus limit the (virtual) screen size. The remaining
> problem here is that user space may want to know about the full graphics
> memory
> size, while fbcon cannot handle that.
> 

How about removing all ioremaps from the fb drivers. Then fbcon can check if
they are accelerated or not and do the ioremap in fbcon if they are not.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________
Do you Yahoo!?
The New Yahoo! Shopping - with improved product search
http://shopping.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
