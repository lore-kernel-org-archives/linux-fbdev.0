From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: request_mem_region problem ...
Date: Thu, 31 Oct 2002 09:10:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021031081007.GB617@iliana>
References: <20021030130016.GA1573@iliana> <1036024416.644.23.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233] helo=mel-rto3.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187APL-0005ab-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 31 Oct 2002 00:10:27 -0800
Content-Disposition: inline
In-Reply-To: <1036024416.644.23.camel@daplas>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Oct 31, 2002 at 08:34:05AM +0800, Antonino Daplas wrote:
> On Wed, 2002-10-30 at 21:00, Sven Luther wrote:
> > Hello, ...
> > 
> > I have begun porting pm3fb to the new api, well, more exactly i am
> > adapting tdfxfb to handle pm3 chips, and will port parts of pm3fb to it
> > as i need them.
> > 
> > I have a problem when loading pm3fb as a module, and that is that
> > request_mem_region fails. I know that pm3_fix.mmio_start and
> > pm3_fix.mmio_len are correct, but request_mem_region still fails.
> > 
> > I am still searching the definition of request_mem_region in the source,
> > but any help would be most welcome.
> > 
> > Note, this is with stock 2.5.44.
> > 
> Try doing a pci_enable_device() before request_mem_region, maybe that
> will help.

I already solutioned this problem.

BTW, i don't understand how the tdfxfb does not have this problem, as it
is from there that i tried to sole this.

The problem was that i did :

        /* Find the mmio register area */
	pm3_fix.mmio_start = pci_resource_start(pdev, 0);
	pm3_fix.mmio_len = pci_resource_len(pdev, 0);

And later :

	if (!request_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0), ...

Changing this to :

	if (!request_mem_region(pm3_fix.mmio_start, pm3_fix.mmio_len, ...

Solved the problem, so it seems that the pci_resource_ functions can be
called only one time. Is this true ?

Now, i seem to have everything fine, but it still hangs in
register_framebuffer, a bit of searching has it that it is when
register_framebuffer calls take_over_console. I didn't have time for
looking into it more yesterday.

Still the screen is black, and i see a small (underscore) blinking
cursor at the bottom left of the screen. The machine was dead though :

Oct 30 23:15:53 iliana kernel:  printing eip:
Oct 30 23:15:53 iliana kernel: c023affc
Oct 30 23:15:53 iliana kernel: Oops: 0000
Oct 30 23:15:53 iliana kernel: pm3fb nls_iso8859-15 nls_cp437 sym53c8xx
Oct 30 23:15:53 iliana kernel: CPU:    0
Oct 30 23:15:53 iliana kernel: EIP:    0060:[fbcon_cursor+108/480] Not tainted
Oct 30 23:15:53 iliana kernel: EFLAGS: 00010246
Oct 30 23:15:53 iliana kernel: eax: 00000000   ebx: 00000000   ecx: 00000000   edx: c1143240
Oct 30 23:15:53 iliana kernel: esi: c042d280   edi: 00000002   ebp: 00000018   esp: c4dcbc10
Oct 30 23:15:53 iliana kernel: ds: 0068   es: 0068   ss: 0068
Oct 30 23:15:53 iliana kernel: Process modprobe (pid: 495, threadinfo=c4dca000 task=c6bec040)
Oct 30 23:15:53 iliana kernel: Stack: 00000000 c04156c0 00000000 00000000 c01f21f8 c1143240 00000002 00000000
Oct 30 23:15:53 iliana kernel:        c04156c0 c01f5435 00000000 c039ef20 c03dfe9f 0000339f 000033cf c0414a30
Oct 30 23:15:53 iliana kernel:        00002adf c01275e1 00000000 c0119439 c039ef20 c03dfe9f 00000030 000033cf

How, well, maybe i should wait for the new patches from James to be
accepted into the linus tree.

Notice, maybe this is due to me not having defined yet any of the
check_var, set_par, blank, ... functions, but my idea, for the howto
afterward, was to write first the most minimal working fbdev.

BTW, should i work on james BK tree directly ? Is there an howto on how
to do that ? Or could it be possible to get a patch against 2.5.44 ?

> > Also, if i register the framebuffer, without defining any of the
> > fillrect, copyarea and imageblit functions (even the generic ones) i
> > suppose it is normal i only get a black screen, isn't it ?
> > 
> Yes.

Ok, as i thought, still :

when i try to use the cfb_xxx functions, it does not work. i copied the
neofb line in the Makefile so that pm3fb should have added the 3 cfbxxx
objects, but it does not work. When loading the cfbxxx.o object files as
modules, insmod complains about lack of version in them, so i guess they
are not modules. Still, they don't get linked with the pm3fb.o (and
neither with the neofb.o when i tried it), and when loading pm3fb.o, i
get a message about missing symbols cfb_xxx.

So, does the cfb_xxx generic accel stuff get linked correctly when
building as modules or am i missing something ?

Anyway, thanks for your help.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
