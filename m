From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: no backlight on radeon after recent kernel
	"upgrade"s
Date: Thu, 22 Feb 2007 09:56:16 +0000
Message-ID: <1172138176.5837.27.camel@localhost.localdomain>
References: <20070219044616.GC25659@washoe.onerussian.com>
	<20070219000412.acad13de.akpm@linux-foundation.org>
	<1171876788.6046.3.camel@localhost.localdomain>
	<877iub9mu2.fsf@sycorax.lbl.gov>
	<1172097718.5790.29.camel@localhost.localdomain>
	<87fy8z6pdd.fsf@sycorax.lbl.gov>
	<Pine.LNX.4.64.0702220112440.17121@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HKAgk-00029p-Cj for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 01:56:36 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HKAgi-0006nx-1s
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Feb 2007 01:56:33 -0800
In-Reply-To: <Pine.LNX.4.64.0702220112440.17121@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Yaroslav Halchenko <kernel@onerussian.com>, Alex Romosan <romosan@sycorax.lbl.gov>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

On Thu, 2007-02-22 at 01:13 +0000, James Simmons wrote:
> > Richard Purdie <rpurdie@rpsys.net> writes:
> > 
> > > If FB_RADEON_BACKLIGHT wasn't set for 2.6.20, can you try 2.6.21-rc1
> > > with that option disabled?
> > 
> > i don't have my laptop with me but i am pretty sure
> > FB_RADEON_BACKLIGHT wasn't set for 2.6.20 (i think it showed up as a
> > new option when i did make oldconfig). i'll post the difference when i
> > get home tonight and also try disabling it.
> 
> Correct. You need to enable the backlight for the radeon card.

The problem is when that is set, the device doesn't work as they need
the ibm ACPI driver, not the raedon one.

Richard


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
