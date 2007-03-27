From: David Johnson <dj@david-web.co.uk>
Subject: Re: [Bugme-new] [Bug 8232] New: Creator3D
	Framebuffer (sparc64) on Sbus/UPA workstation
Date: Tue, 27 Mar 2007 10:25:35 +0100
Message-ID: <200703271025.35767.dj@david-web.co.uk>
References: <200703191019.l2JAJVH5018137@fire-2.osdl.org>
	<20070319033425.b0be2d95.akpm@linux-foundation.org>
	<20070326.161215.74749546.davem@davemloft.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HW7w7-0001FK-Qf for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 02:25:51 -0700
Received: from lug.demon.co.uk ([83.104.159.110])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HW7w6-0004fr-B6
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 02:25:51 -0700
In-Reply-To: <20070326.161215.74749546.davem@davemloft.net>
Content-Disposition: inline
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
To: David Miller <davem@davemloft.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugme-daemon@bugzilla.kernel.org

On Tuesday 27 March 2007 00:12, David Miller wrote:
>
> A quick audit found that we're using the ->dac_rev value before
> setting it properly.  One difference between the older creator
> cards and the newer ones is the DAC, so perhaps this was the
> bug.
>
> Can you test the following patch?  Thanks.  I'll fire up some of
> my older systems to see if I can reproduce this one.
>

I've also been seeing this issue, so I can test your fix. Unfortunately this 
is not something that reproduces itself reliably, so it may be a while before 
I can be sure if the fix has worked.

Thanks,
David.

-- 
David Johnson
www.david-web.co.uk

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
