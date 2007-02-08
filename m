From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] mfd: SM501 core driver
Date: Thu, 8 Feb 2007 17:56:02 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702081755290.7686@pentafluge.infradead.org>
References: <20070206192628.GA13644@fluff.org.uk>
	<20070206210930.fc814bf6.akpm@linux-foundation.org>
	<20070207114825.GA21120@fluff.org.uk>
	<20070207085225.c2371cfd.akpm@linux-foundation.org>
	<20070207170949.GD21120@fluff.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFDVK-0004ZU-Mp for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 09:56:19 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HFDVH-00025x-41
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 09:56:18 -0800
In-Reply-To: <20070207170949.GD21120@fluff.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben-linux@fluff.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org



Do you have a new patch?


> > No, that shuldn't be necessary.  If it was, the compiler would optimise
> > away the first readl() in 
> > 
> > 	my_local = readl(foo);
> > 	my_local = readl(bar);
> > 
> > which would break stuff.  readl() implementations use volatile to prevent
> > this.
> 
> Ok, i've moved these into their own function called
> sm501_sync_regs() to make it more explicit what it is
> being used for.
> 
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
