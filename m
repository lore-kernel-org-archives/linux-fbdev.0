From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: implementing vga16fb
Date: Tue, 23 Mar 2004 10:47:17 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0403231045120.4928@waterleaf.sonytel.be>
References: <405FCB00.2070601@GameBox.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5iVI-0003Gk-Lg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 01:47:24 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B5iVG-0000Ms-OR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Mar 2004 01:47:22 -0800
In-Reply-To: <405FCB00.2070601@GameBox.net>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Suresh Chandra Mannava <Mannava@GameBox.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 23 Mar 2004, Suresh Chandra Mannava wrote:
> I read that VESAfb is only for Intel(x86) platforms, has any body
> implemented Vesafb on other platforms?

Vesafb relies on the BIOS setting up the video mode _before_ the kernel is
started.

> Is vga16fb a CPU architecture dependent? Even though I didn't find any
> architecture dependent sections in the code, Is there any code section
> that to be modified in vga16fb.c?

I used vga16fb on PPC a while ago. Make sure the video RAM address in ISA
memory space is correct.

> And lastly, we are testing this framebuffer on 2.6Mhz FPGA(0.16
> Bogomips) with kernel 2.4.7. Are there any other methods (solutions) for
> debugging framebuffer code with out using printk's?

I assume you mean `printk() on the frame buffer'.
printk() on a serial port?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
