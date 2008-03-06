From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] tridentfb: resource management
 fixes in probe function
Date: Thu, 6 Mar 2008 18:34:01 +0100
Message-ID: <20080306183401.c4ae49ef.krzysztof.h1@poczta.fm>
References: <20071031220524.54ed8dae.krzysztof.h1@poczta.fm>
	<20080305222939.87fc7e34.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXJtw-0002z3-7k for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 09:29:04 -0800
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JXJsS-00044M-9E
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 06 Mar 2008 09:27:34 -0800
In-Reply-To: <20080305222939.87fc7e34.akpm@linux-foundation.org>
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

On Wed, 5 Mar 2008 22:29:39 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 31 Oct 2007 22:05:24 +0100 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> 
> > From: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > The most important fix  is to disable the mmio mode on error. Otherwise,
> > the console is left in unusable state (garbled fonts at least, lock up at worst).
> > 
> > Other changes balance release and request of memory regions
> > in case of error and few minor style errors.
> > 
> > Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> > 
> > ---
> > The patch was done against the 2.6.24-rc1 kernel.
> 
> Could you please redo and resend these tridentfb patches if they are still
> needed?
> 

I'll do but I need more time now. I have another Trident card to test and not all patches gives better results on both models (and I am about acquiring the third model to test even more).

Regards,
Krzysztof

----------------------------------------------------------------------
Wojna wampirow trwa - po ktorej jestes stronie?
Zagraj >>> http://link.interia.pl/f1cf4


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
