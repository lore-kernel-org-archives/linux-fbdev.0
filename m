From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] neofb patches
Date: Sat, 24 Apr 2004 00:00:23 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0404232241260.5826-100000@phoenix.infradead.org>
References: <56202.64.139.3.221.1082702638.squirrel@www.foogod.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BH9en-0005qL-IO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 16:00:29 -0700
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BH9el-0005Ny-Mi
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 23 Apr 2004 16:00:27 -0700
In-Reply-To: <56202.64.139.3.221.1082702638.squirrel@www.foogod.com>
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
To: Alex Stewart <alex@foogod.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> Ok, I've got everything except the blanking patch (which isn't finished
> anyway) converted to apply cleanly to James' patched driver source. 
> Everything works fine on my laptop as far as I can tell.  Additional
> feedback is welcome.
> 
> I've put up a web page for the patches.  They can be found at
> http://www.foogod.com/~alex/neofb/

Got it. I merged your patches. I also did a few fixes. The code had issues 
with non byte align images, i.e sparc 12x22 fonts. Now it works. I posted 
at

http://phoenix.infradead.org:~/jsimmons/neofb.diff.gz

This is against the latest kernel.





-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
