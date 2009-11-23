From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] SM501: Implement acceleration
 features
Date: Mon, 23 Nov 2009 12:40:59 -0800
Message-ID: <20091123124059.c576c1b0.akpm@linux-foundation.org>
References: <20091123160124.403392586@fluff.org.uk>
	<20091123160145.255937606@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <akpm@linux-foundation.org>) id 1NCfiu-0005ru-Us
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Nov 2009 20:41:24 +0000
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NCfio-0000xx-Bg
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Nov 2009 20:41:24 +0000
In-Reply-To: <20091123160145.255937606@fluff.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ben Dooks <ben@simtec.co.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, krzysztof.h1@wp.p, Vincent Sanders <vince@simtec.co.uk>, lethal@linux-sh.org, dilinger@debian.org, Simtec Linux Team <linux@simtec.co.uk>

On Mon, 23 Nov 2009 16:01:28 +0000
Ben Dooks <ben@simtec.co.uk> wrote:

> From: Vincent Sanders <vince@simtec.co.uk>
> 
> This patch provides the acceleration entry points for the SM501
> framebuffer driver.
> 
> This patch provides the sync, copyarea and fillrect entry points,
> using the SM501's 2D acceleration engine to perform the operations
> in-chip rather than across the bus.
> 
> Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>
> Signed-off-by: Vincent Sanders <vince@simtec.co.uk>

I merged patches 2, 3 and 4, thanks.

This patch was missing your Signed-off-by:. I added it.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
