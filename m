From: James Simmons <jsimmons@infradead.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
Date: Thu, 30 Oct 2003 18:38:46 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0310301833140.4560-100000@phoenix.infradead.org>
References: <20031023234552.GB554@phunnypharm.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFHh9-0005ZN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 10:38:55 -0800
Received: from [213.86.99.234] (helo=phoenix.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AFHh8-0005lH-JC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 10:38:55 -0800
In-Reply-To: <20031023234552.GB554@phunnypharm.org>
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
To: Ben Collins <bcollins@debian.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> I noticed one thing, and that is that the mach64 used to use software
> cursor it seems (I remember wondering why atyfb_cursor was never used
> anywhere). It's now using the hw cursor.

Yeap. I'm in the process of getting several driver to use there hardware 
cursors.
 
> Also, I notice with this new code that the random vertical shifting of
> the console doesn't occur anymore like it does with current 2.6.0-test8
> code. For as long as I can remember 2.6.0-test, and way back into
> 2.5.5x, this has been a problem with highly active console programs
> (mutt, vim, etc...). Good to see it's going away :)

:-)

I have fixed the problems you have reported. I have a newer patch. Note 
this is updated with the LCD support. I like to see if the patch works on 
sparc. I has updates from the latest 2.4.X kernels. Please give it a try.

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

Let me know the results.






-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
