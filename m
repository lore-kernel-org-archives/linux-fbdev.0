From: James Simmons <jsimmons@infradead.org>
Subject: Re: New FBDev patch
Date: Fri, 9 Jan 2004 19:54:50 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401090035270.17957-100000@phoenix.infradead.org>
References: <20040108232621.B25760@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Af2ig-00051s-KC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 11:54:58 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Af2ig-0005U9-5T
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 11:54:58 -0800
In-Reply-To: <20040108232621.B25760@flint.arm.linux.org.uk>
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
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> > This is the latest patch against 2.6.0-rc3. Give it a try.
> > 
> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> This looks wrong (cyber2000fb.c):

Yeap it is. Typo. 

> sizeof(u32) != 32.  Proper fix is to place the pseudopalette array
> inside cfb_info, and dispense with this addition here.

You have to make sure the struct fb_info pseudopalette points to the data 
in cfb_info. Actually only drivers should allocate the pseudopalette at 
boot time if the hardware doesn't support mode change. In the other case 
the pseudopalette should be allocated in set_par. 




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
