From: James Simmons <jsimmons@infradead.org>
Subject: Re: ioremap problem on highmem
Date: Thu, 16 Oct 2003 00:11:39 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310160008440.13660-100000@phoenix.infradead.org>
References: <20031015011354.GA9654@guug.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9uok-00049K-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 16:12:34 -0700
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A9uod-0003o1-Hf
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 15 Oct 2003 16:12:27 -0700
In-Reply-To: <20031015011354.GA9654@guug.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Otto Solares <solca@guug.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, linux-fbdev-devel@lists.sourceforge.net


> If something goes wrong nobody will see it, a practical solution will be
> that people use their favorite console (fbcon,vgacon,epromcon,dummycon,serialcon).
> when they quit exiting a standalone mesa program with your dri changes (if i
> understand correctly your dri changes entirely bypass fbdev) we simply return
> from vt graphics mode to vt text mode, is kernel responsability to restore
> the console to a usable state, IMO.  I don't know if that is the {fb,vga}con
> case.

Its is the userland responability to restore the console state after 
leaving KDGRAPHICS mode. You need to save the hardware state before you 
leave KDTEXT mode as well. 

> Also we are protected from hardware access by other programs using the vt
> layer assuming we install proper vt switching signal handlers correctly
> AND the others programs respect vt switching.

:-( 

> > Want to write the terminal program? or work on the user libs? Go ahead and
> > start coding. See the drmtest program in the mesa tree.
> 
> Ok, let me hack a bit, i have proper vt and input working code.

Doesn't help much on non intel platforms. I guess this Mesa solution is 
only x86 specific :-(




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
