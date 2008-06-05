From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI
	ROM API
Date: Thu, 5 Jun 2008 15:11:22 -0700
Message-ID: <20080605151122.a9ac8fbe.akpm@linux-foundation.org>
References: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4Ngi-0008DS-1R for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 15:12:04 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K4Ngh-0003yu-75
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 05 Jun 2008 15:12:03 -0700
In-Reply-To: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: deller@gmx.de, Jon Smirl <jonsmirl@yahoo.com>, linux-fbdev-devel@lists.sourceforge.net, linux-parisc@vger.kernel.org

On Thu, 5 Jun 2008 23:13:27 +0200
Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> Convert console/sticore.c file to use PCI ROM API.
> 
> Addresses http://bugzilla.kernel.org/show_bug.cgi?id=9425

I'm unable to understand that bug report.  Is this just a cleanup
or does it fix some runtime error, or...?

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
