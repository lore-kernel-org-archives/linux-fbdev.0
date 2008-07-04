From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: Enabling Hardware acceleration in existing
 framebuffer driver
Date: Fri, 4 Jul 2008 18:22:15 +0200
Message-ID: <20080704182215.6f64f848.krzysztof.h1@poczta.fm>
References: <486E4812.5070803@linuxinstruments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KEnzE-0004hi-43 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 09:18:16 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KEnzC-0007ca-LN
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Jul 2008 09:18:16 -0700
In-Reply-To: <486E4812.5070803@linuxinstruments.com>
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
To: Keith Williams <espian@linuxinstruments.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Fri, 04 Jul 2008 11:56:02 -0400
Keith Williams <espian@linuxinstruments.com> wrote:

> Hi, all,
> 

> The '506 does have some 2D hardware acceleration capabilities.  Last 
> night I wrote a fillrect routine as an initial test of how much 
> performance improvement I could potentially see from enabling acceleration.
> 
> However, neither DirectFB nor fbset is picking up on the enabled 
> acceleration.  I'm not sure if there is something more that I need to do.
> 

The fillrect acceleration is probably used but rarely. 
One sure way to trigger it is to issue the "clear" command on the 
frame buffer console. Try "time clear" on a big resolution screen with and 
without your change. You should see a difference from few to few tens times
in speed.

The more useful is both the copyarea and imageblit acceleration. Both are
used during console scrolling (the imageblit is preferred but on some cards
the copyarea is faster).

I don't know about the DirectFB so I cannot comment.

Regards,
Krzysztof

----------------------------------------------------------------------
Nie ma jak Hold'em. Zagraj w pokera!
Kliknij >>> http://link.interia.pl/f1e68


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
