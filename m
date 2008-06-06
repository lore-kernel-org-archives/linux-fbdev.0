From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RESEND] [PATCH] convert sticore.c to PCI
	ROM API
Date: Fri, 6 Jun 2008 20:52:53 +0200
Message-ID: <20080606205253.6858ea7a.krzysztof.h1@poczta.fm>
References: <20080605231327.af9cc9e6.krzysztof.h1@poczta.fm>
	<20080605151122.a9ac8fbe.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K4h1H-0001v0-B5 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 11:50:35 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K4h1F-0008HI-Qc
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 06 Jun 2008 11:50:35 -0700
In-Reply-To: <20080605151122.a9ac8fbe.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: deller@gmx.de, Jon Smirl <jonsmirl@yahoo.com>, linux-fbdev-devel@lists.sourceforge.net, linux-parisc@vger.kernel.org

On Thu, 5 Jun 2008 15:11:22 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Thu, 5 Jun 2008 23:13:27 +0200
> Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > Convert console/sticore.c file to use PCI ROM API.
> > 
> > Addresses http://bugzilla.kernel.org/show_bug.cgi?id=9425
> 
> I'm unable to understand that bug report.  Is this just a cleanup
> or does it fix some runtime error, or...?
> 

It is conversion to a new API after the API was introduced (code change/cleanup).

AFAIK, it does not fix any known error.

Regards,
Krzysztof

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e22 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
