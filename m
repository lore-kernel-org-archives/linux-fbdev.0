From: Otto Solares <solca@guug.org>
Subject: Re: ioremap problem on highmem
Date: Tue, 14 Oct 2003 19:13:54 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031015011354.GA9654@guug.org>
References: <20031014015656.GE454@guug.org> <20031014045143.53369.qmail@web14912.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9aFx-0003Rd-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Oct 2003 18:15:17 -0700
Received: from guug.org ([168.234.203.30] helo=guug.galileo.edu)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9aFv-0003t1-Oc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Oct 2003 18:15:15 -0700
Content-Disposition: inline
In-Reply-To: <20031014045143.53369.qmail@web14912.mail.yahoo.com>
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
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Oct 13, 2003 at 09:51:43PM -0700, Jon Smirl wrote:
> --- Otto Solares <solca@guug.org> wrote:
> 
> I almost have the DRI changes done. 

Good.

> I haven't tried adjusting the DRI Creator3D driver for my changes since I don't
> have Sparc hardware.  Does sparc use the same kind of PCI ID probing that x86
> does in a kernel module? Which 3D hardware do you have?

I have written several patches for sparc linux and i never noted a
difference in PCI management from x86 & sparc64, drivers use the same
kernel api for such things, but i am no expert in that matter, maybe
sparc guru David Miller can help you.

My main 3D card is a Radeon 9200 at home and a Nvidia Ti4600 at work.

> I'll check the DRI changes in as soon as they work; they are pretty minor. Then
> I can get back to working on standalone Mesa. The whole purpose in doing this
> is to fix things so that standalone Mesa doesn't need a config file.
> 
> Dummy con is spac equivalent of VGA con on X86.

Sparc equivalent is epromcon, dummycon is just a kernel requirement
to have something registered as a console, but is useless to display
something.

> > Without fbcon, where the printk goes?
> How does klogd get the printk's? I think it reads them from /proc/kmsg. The
> terminal program can get them the same way.

If something goes wrong nobody will see it, a practical solution will be
that people use their favorite console (fbcon,vgacon,epromcon,dummycon,serialcon).
when they quit exiting a standalone mesa program with your dri changes (if i
understand correctly your dri changes entirely bypass fbdev) we simply return
from vt graphics mode to vt text mode, is kernel responsability to restore
the console to a usable state, IMO.  I don't know if that is the {fb,vga}con case.

Also we are protected from hardware access by other programs using the vt
layer assuming we install proper vt switching signal handlers correctly
AND the others programs respect vt switching.

> > Hey, this sound too cool to be true ;) any code yet? i would like to develop
> > on such beast.
> Want to write the terminal program? or work on the user libs? Go ahead and
> start coding. See the drmtest program in the mesa tree.

Ok, let me hack a bit, i have proper vt and input working code.

-solca



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
