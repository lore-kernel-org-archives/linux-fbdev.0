From: James Simmons <jsimmons@infradead.org>
Subject: Re: New FBDev patch
Date: Fri, 9 Jan 2004 20:06:06 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401092005410.27985-100000@phoenix.infradead.org>
References: <20040109171733.GA13027@dreamland.darkstar.lan>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Af2tW-0005fP-E1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 12:06:10 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Af2tV-0004Z5-PJ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 12:06:10 -0800
In-Reply-To: <20040109171733.GA13027@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>



> > http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
> 
> > <kronos@kronoz.cjb.net> (03/09/17 1.1267.40.1)
> >    Add new API framebuffer_alloc and framebuffer_release.
> >    
> >    Framebuffer info structure (ie. struct fb_info) must be obtained from
> >    framebuffer_alloc. When it is no longer needed (after unregister_framebuffer
> >    and clean up) it can be released using framebuffer_release.
> >    
> >    If the framebuffer is not registered yet (eg. on error path) then fb_info must
> >    be released via kfree. 
> 
> 
> Are we sure that we want this for 2.6? Greg KH has a much less intrusive
> patch, maybe you should take that instead and keep my work 2.7.
> 
> If you decide to go with framebuffer_alloc then I have more patches for
> you ;)

I have been using it for awhile on various cards. 




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
