From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2 2.6.24] fbdev: platforming
	metronomefb and am200epd
Date: Thu, 3 Apr 2008 18:22:47 -0700
Message-ID: <20080403182247.5ff0fd4d.akpm@linux-foundation.org>
References: <20080403051908.29628.86131.sendpatchset@apodmy1>
	<20080403153226.71ce93df.akpm@linux-foundation.org>
	<45a44e480804031758t794dc55bh9a06d540eb534582@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jhads-0007fp-79 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 18:22:56 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jhadq-0004f8-Su
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 18:22:56 -0700
In-Reply-To: <45a44e480804031758t794dc55bh9a06d540eb534582@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 3 Apr 2008 20:58:53 -0400 "Jaya Kumar" <jayakumar.lkml@gmail.com> wrote:

> >
> >  Please don't mix huge code-motion changes into the same patch with bugfixes!
> >
> >  a) we want to be able to look at and review that bugfix in isolation
> 
> Ok. I guess I need to figure out how to do this. I will do a separate
> patch that only fixes the bug and then patches on top of that to
> platformize.

yes please, that's the best order in which to make the changes.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
