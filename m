From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 10/15] sunxvr500: fix cmap memory
	leaks
Date: Sun, 8 Feb 2009 17:50:24 -0800
Message-ID: <20090208175024.6e58671f.akpm@linux-foundation.org>
References: <20090207121540.0e618d0f@ephemeral>
	<20090208.165925.240846008.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1LWLJN-0002wD-Nb
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Feb 2009 01:51:49 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LWLJM-00036x-5L
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Feb 2009 01:51:49 +0000
In-Reply-To: <20090208.165925.240846008.davem@davemloft.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, dilinger@queued.net

On Sun, 08 Feb 2009 16:59:25 -0800 (PST) David Miller <davem@davemloft.net> wrote:

> From: Andres Salomon <dilinger@queued.net>
> Date: Sat, 7 Feb 2009 12:15:40 -0500
> 
> [ Fixed typo in adaplas's email address ]
> 
> >  - fix cmap leak in removal path
> >  - fix cmap leak when register_framebuffer fails
> > 
> > Signed-off-by: Andres Salomon <dilinger@debian.org>
> 
> I assume the fbdev folks will pick this up or should I take
> it in my sparc tree?

(fbdev folks == me) at present.  I'll crunch on these 15 patches
tomorrow.  If you want to queue it in in a sparc tree so that it gets
more-than-zero runtine testing then go for it.


------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
