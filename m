From: James Simmons <jsimmons@infradead.org>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Thu, 22 Feb 2007 01:13:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702220112440.17121@pentafluge.infradead.org>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
	<877iub9mu2.fsf@sycorax.lbl.gov>
	<1172097718.5790.29.camel@localhost.localdomain>
	<87fy8z6pdd.fsf@sycorax.lbl.gov>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK2WS-0003KU-C3 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:13:26 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK2WQ-0006ZQ-VT
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 17:13:24 -0800
In-Reply-To: <87fy8z6pdd.fsf@sycorax.lbl.gov>
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
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-fbdev-devel@lists.sourceforge.net, Yaroslav Halchenko <kernel@onerussian.com>, Richard Purdie <rpurdie@rpsys.net>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org


> Richard Purdie <rpurdie@rpsys.net> writes:
> 
> > If FB_RADEON_BACKLIGHT wasn't set for 2.6.20, can you try 2.6.21-rc1
> > with that option disabled?
> 
> i don't have my laptop with me but i am pretty sure
> FB_RADEON_BACKLIGHT wasn't set for 2.6.20 (i think it showed up as a
> new option when i did make oldconfig). i'll post the difference when i
> get home tonight and also try disabling it.

Correct. You need to enable the backlight for the radeon card.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
