From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git patches] two warning fixes
Date: Thu, 19 Jul 2007 11:19:05 +1000
Message-ID: <1184807945.25235.289.camel@localhost.localdomain>
References: <20070718235504.GA9601@havoc.gtf.org>
	<200707190159.22654.ak@suse.de>  <469EAABD.4010504@garzik.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBKfo-000275-JW for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 18:19:20 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX19mySD7yyGa0jMtIYrTw3rATp+E72xZy84=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBKfo-0001Vk-3q
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 18:19:20 -0700
In-Reply-To: <469EAABD.4010504@garzik.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, 2007-07-18 at 20:05 -0400, Jeff Garzik wrote:
> Andi Kleen wrote:
> > On Thursday 19 July 2007 01:55:04 Jeff Garzik wrote:
> >> Please pull from 'warnings' branch of
> >> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git warnings
> >>
> >> to receive the following updates:
> >>
> >>  drivers/video/aty/radeon_base.c |   23 ++++++++++++++++++-----
> >>  include/asm-x86_64/tlbflush.h   |    6 +++++-
> >>  2 files changed, 23 insertions(+), 6 deletions(-)
> >>
> >> Jeff Garzik (2):
> >>       drivers/video/aty/radeon_base: fix radeonfb_pci_register() err handling
> >>       [X86-64] make flush_tlb_kernel_range() a static inline function
> > 
> > I already got that patch queued. Why don't you send them through the maintainers?
> 
> Because in both cases the maintainers never responded to me, indicating 
> they were queued?

I suppose I should have acked the radeonfb one... I'm a bit of a slacker
with radeonfb maintainership lately.

However, in this case, I think I'll NACK it. I don't think it's fair to
fail the fb initialization because it couldn't create the EDID files. A
warning in dmesg is enough. For lots of machines, failing the fb init
means no console at all...

In general, I share paulus point of view here that forcing us to test
all those result code from sysfs file creation functions is just a major
PITA and adds bloat all over the kernel. There are many many cases where
the "obvious" thing of erroring out is actually not good policy. In many
cases, the failure to create some random sysfs file shouldn't prevent
the driver from operating, because the consequences of doing the later
are worse than the consequences of not having that sysfs file in the
first place. Thus, warnings are a better thing to do. But multiply the
number of sysfs_* calls by the code size of adding a test & printk and
you'll get the direct non-configurable-out bloat to the kernel.

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
