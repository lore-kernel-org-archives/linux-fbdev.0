From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Re: fbdev cursor part 1.
Date: Fri, 5 Mar 2004 10:03:45 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403051003.45536.alex.kern@gmx.de>
References: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AzBTO-0000Et-7E
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 01:18:26 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AzAv0-0000h9-7G
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 05 Mar 2004 00:42:54 -0800
In-Reply-To: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Am Sonntag, 22. Februar 2004 23:37 schrieb James Simmons:
> > > > Andrew, that one seem to work fine for me, been hammered for some
> > > > time in the fbdev tree. It should go to -mm for a while imho so we
> > > > get more broader testing, and eventually in 2.6.4
> > >
> > > Please do.
> >
> > Hi,
> >
> > James, would you do part 2 of cursor patch? I convert here
> > mach64 driver to pci_table solution, it works ok on my notebook. Base is
> > 2.6.3 + fix_double_console_init + cursor_part 1, but cursor is broken. On
> > console it is invisible, in mc it looks correct.
> >
> > The difference to todays aty driver in mainline is too big, and it can
> > broke old errata rich chip versions, which I'm not own. Should it be
> > submitted as aty_new? Just like a radeon driver did it?
> >
> > Regards Alex
> >
> > P.S. I have trouble to merge your patches from mailing-list. Have you
> > they somewhere in internet? Or send they as attachment ;-)
>
> I plan to submit the latets mach64 driver from BK to linus as soon as the
> first part of the cursor patch goes in. It gives enough of the new
> cursor api to do a dump of all the drivers in the 2.5 fbdev tree. Could you
> make your patch against the fbdev-2.5 bk tree? Try my patch
>
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>
> If it doesn't work I will put a new one you there.
looks good, but does not compile

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x9d9bf): In function `register_framebuffer':
drivers/video/fbmem.c:1286: undefined reference to `fb_add_class_device'
drivers/built-in.o(.init.text+0x51d8): In function `fbmem_init':
drivers/video/fbmem.c:1415: undefined reference to `fb_class'
make: *** [.tmp_vmlinux1] Error 1


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
