From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: request_mem_region problem ...
Date: Fri, 1 Nov 2002 20:52:07 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021101195207.GA931@iliana>
References: <20021030130016.GA1573@iliana> <1036024416.644.23.camel@daplas> <20021031081007.GB617@iliana> <1036062270.638.25.camel@daplas> <20021101105242.GA702@iliana> <1036179467.572.42.camel@daplas>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25] helo=mel-rto6.wanadoo.fr)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187hqB-0007oB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Nov 2002 11:52:23 -0800
Content-Disposition: inline
In-Reply-To: <1036179467.572.42.camel@daplas>
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

On Sat, Nov 02, 2002 at 03:42:14AM +0800, Antonino Daplas wrote:
> On Fri, 2002-11-01 at 18:52, Sven Luther wrote:
> > On Thu, Oct 31, 2002 at 07:05:13PM +0800, Antonino Daplas wrote:
> > > Running ksymoops on that might help.  The source can be found at
> > > ftp.kernel.org.  
> > 
> > Ok, got it from the debian package :)))
> > 
> > Erm, i am no more running the same kernel, so i specified the -o and the
> > -m options, but it looks at the wrong /proc/ksyms, should i save the
> > /proc/ksyms of kernel before/after insmodding the pm3fb module ?
> > 
> Save the symbols after the insmod.

Ok,

> > Ok, i did copy the cfb_ functions to the driver, it works better (the
> > box does not hang anymore), the console apprently works (the cursor
> > blinks in the right place, and it could type stuff, switch VT and
> > shutdown the box) but there is nothing else written.
> > 
> > BTW, what is the difference between the full cursor and the underline
> > one ?
> The block cursor most probably comes from fbcon's software cursor, the
> underline is probably your hardware's?

Mmm, maybe the other way around ? i get block cursor with the old
accelerated pm3fb, and since i did enter no acceleration whatsoever yet
in the new driver, i don't believe it can be using the hardware cursor.

> > Anyway, here are the two Oops :
> > 
> > 
> [...]
> > I don't believe the result of running ksymoops on these are valid, i
> > will have to reboot in the 2.5.44 kernel for it.
> > 
> > > If you did not define fb_set_var at all, then info->disp.dispsw must
> > > point to valid console drawing hooks before you register the
> > > framebuffer.  (Actually, all fields in struct display must be valid
> > > before you register the framebuffer)
> > 
> > Mmm, still need to check those.
> > 
> > > Your oops tracing points to fbcon_cursor as the culprit.  If
> > > dispsw->cursor is NULL, then you must have a valid dispsw->revc.
> > 
> > There where two oops, the first in fbcon_setup, and the second in
> > fbcon_cursor, i think i will be looking in the first oops first.
> > 
> Might as well try to port your driver using the latest fbdev patch
> posted by James, hopefully, this is the last major change.  This should
> give you less things to worry about.

Well, yes, i was going to donwload the BK tree, but james was speaking
about a 2.5.45 diff, which was finally not the right one.

Will do that nextly.

Friendly,

Sven Luther


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
