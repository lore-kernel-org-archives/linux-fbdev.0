From: Otto Solares <solca@guug.org>
Subject: Re: help with consolupdate on modechange in driver
Date: Mon, 22 Sep 2003 16:46:25 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030922224625.GB22713@guug.org>
References: <20030922181651.GA22713@guug.org> <Pine.LNX.4.44.0309221945250.6431-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1ZVP-00054s-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 15:50:07 -0700
Received: from opensource-ca.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1ZVN-0005Zs-Jk
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 15:50:05 -0700
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309221945250.6431-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Sep 22, 2003 at 07:50:50PM +0100, James Simmons wrote:
> 
> > > I have just implemented modechange in my driver and while it
> > > works, the consol *still* thinks we working in the old mode.
> > > 
> > > How do I inform the console layer that the driver (through fbset)
> > > have changed the actual mode on the screen?
> > 
> > rivafb has this same problem.
> 
> stty is the program you want to use to change the resolution on a tty. At 
> present fbset is not functioning. Patches are in the works to restore 
> this.

probably we would not need fbset anymore if drivers support sysfs
AND they export valid modes for the current card as the drivers know
far better that crappy /etc/fb.modes, any progress or this is not
the plan?

In other point, i am including fb.h from the latest development linux
kernel (2.6.0-test5-bk3) and is not suitable for use from userpace, here
is a tiny patch to fix it, but i am not sure if the struct fb_pixmap
is needed from userspace as i never have used it?

3a4,5
> #include <linux/tty.h>
> #include <linux/workqueue.h>
4a7
> #include <asm/io.h>
326,327d328
< #ifdef __KERNEL__
<
345a347
> #ifdef __KERNEL__
347,348d348
< #include <linux/tty.h>
< #include <linux/workqueue.h>
351d350
< #include <asm/io.h>

-solca



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
