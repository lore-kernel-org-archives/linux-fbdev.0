From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Sane behavior of fbset
Date: Wed, 23 Jun 2004 15:12:31 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1088021550.1855.170.camel@gaston>
References: <200406180945.12444.adaplas@hotpop.com>
	 <200406190240.26228.adaplas@hotpop.com>
	 <20040619031650.GC14319@havoc.gtf.org>
	 <200406191413.28339.adaplas@hotpop.com> <1088006149.1832.145.camel@gaston>
	 <Pine.LNX.4.56.0406231958340.27210@pentafluge.infradead.org>
	 <1088019524.1855.159.camel@gaston>
	 <Pine.LNX.4.56.0406232058280.27210@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdEDy-0004fG-2n
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 13:20:02 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdEDx-00040J-Kj
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 13:20:01 -0700
In-Reply-To: <Pine.LNX.4.56.0406232058280.27210@pentafluge.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: jsimmons@pentafluge.infradead.org
Cc: adaplas@pol.net, David Eger <eger@havoc.gtf.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 2004-06-23 at 15:03, jsimmons@pentafluge.infradead.org wrote:
> > > > can't rely on good enough monitor detection & mode list building to
> > > > be able to pick proper modes. Not only our code is far from ready for
> > > > that, but it will also call all sort of problems to users (remember
> > > > you monitors that need different subtle geometry settings for each
> > > > different mode you use ?)
> > > > 
> > > > It may have looked like a nice idea, but I think it's just wrong.
> > > 
> > > Its a POSIX standard. You need to yell at them. 
> > 
> > I don't remember seeing anything in POSIX regarding tweaking monitor
> > video modes ;)
> 
> Just do a web search on POSIX and TIOCSWINSZ.

And besides, that's irrelevant, especially since there are way too much
cases where we simply won't do the right thing (monitors lying about
their modes or incorrectly detected for example). There is a reason why
most OSes have this dialog asking you to confirm a resolution change and
click OK... It's fine with scaled flat panels to scale to pretty much
anything, but other cases are a bit more dodgy.

Anyway, the point is, such an option has NOTHING to do in the fbcon
layer unless we have fully implemented & properly working monitor
detection, which we are only starting to have and only in some drivers.

Ben.




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
