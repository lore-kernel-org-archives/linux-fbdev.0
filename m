From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] tridentfb: acceleration code
	improvements
Date: Fri, 16 May 2008 06:46:02 +0200
Message-ID: <20080516064602.f4313fef.krzysztof.h1@poczta.fm>
References: <20080514071200.4f2409b0.krzysztof.h1@poczta.fm>
	<20080515155614.ca818e04.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JwsB6-0007gG-Sh for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 May 2008 22:08:25 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JwsB5-0001NP-Cs
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 May 2008 22:08:24 -0700
In-Reply-To: <20080515155614.ca818e04.akpm@linux-foundation.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 15 May 2008 15:56:14 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 14 May 2008 07:12:00 +0200
> checkpatch whines:
> 
> ERROR: space required after that ',' (ctx:VxV)
(...)

How do you run the checkpatch? I am not getting these warning even with the "--strict" option (stock linux-2.6.26-rc2 kernel scripts). Do you have another version?
I'd like to have the same version as you.

> 
> Also that macro is plain wrong:
> 
> 	if (foo)
> 		debug(...);
> 	else
> 		something();
> 
> won't compile.  Using the do{...}while(0) thing or perhaps {(...)} will fix.
> 
I'll fix it.

Regards,
Krzysztof

----------------------------------------------------------------------
Od slicznej Mariolki swieze pomidorki!
http://link.interia.pl/f1de2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
