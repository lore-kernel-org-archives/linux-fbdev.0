From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK updates] More updates.
Date: Tue, 11 Mar 2003 16:09:03 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303111608420.23668-100000@phoenix.infradead.org>
References: <1046916643.7318.1.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.infradead.org ([195.224.96.167])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18smK1-0001XO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Mar 2003 08:09:46 -0800
In-Reply-To: <1046916643.7318.1.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >     I just pieced together various patches. I think we need to push this 
> > code to linus. It has gotten pretty big.. Can people test  it please 
> > before I sen it.
> > 
> > Diff:  http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> James,
> 
> Something's wrong with the patch, it removed fb.h, the Makefiles and
> possibly a bunch of other files.

UG. Forgot a bk -r co -q. I think the latest patch is right.




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
