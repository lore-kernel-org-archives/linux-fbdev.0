From: James Simmons <jsimmons@infradead.org>
Subject: Re: Feature Freeze?
Date: Wed, 5 Mar 2003 23:59:41 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303052358500.32553-100000@phoenix.infradead.org>
References: <20030305211727.GA3839@g-kabel.si>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qio4-00055i-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 16:00:16 -0800
In-Reply-To: <20030305211727.GA3839@g-kabel.si>
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
To: Boris Bezlaj <boris@gajba.net>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Wed, Mar 05, 2003 at 06:34:45PM +0000, James Simmons wrote:
> > 
> > imsttfb.c    <- I have a nearly done driver. The old driver doesn't work 
> > 		on ix86. I tried it. Oh wells.
> 
> Is this patch in the bk/main patch ? If not, could you send it to me for
> testing purposes? I have some problems under 2.4 and i haven't tried 2.5
> on ppc yet.

I just placed it into the BK repository. I will soon be making a new 
patch. I have a bunch of new changes including some fb_pixmap cleanups.
Fbdev developement has picked up some steam the last few days.




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
