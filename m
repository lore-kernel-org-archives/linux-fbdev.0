From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Sane behavior of fbset
Date: Thu, 24 Jun 2004 07:50:01 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406240750.01162.adaplas@hotpop.com>
References: <200406180945.12444.adaplas@hotpop.com> <Pine.LNX.4.56.0406232058280.27210@pentafluge.infradead.org> <1088021550.1855.170.camel@gaston>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdHSz-0007ux-7I
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 16:47:45 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BdHSy-0005Ie-SV
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 16:47:44 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id C3049642378
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 23 Jun 2004 23:07:35 +0000 (UTC)
In-Reply-To: <1088021550.1855.170.camel@gaston>
Content-Disposition: inline
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, jsimmons@pentafluge.infradead.org
Cc: adaplas@pol.net, David Eger <eger@havoc.gtf.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thursday 24 June 2004 04:12, Benjamin Herrenschmidt wrote:
> > Just do a web search on POSIX and TIOCSWINSZ.
>
> And besides, that's irrelevant, especially since there are way too much
> cases where we simply won't do the right thing (monitors lying about
> their modes or incorrectly detected for example). There is a reason why
> most OSes have this dialog asking you to confirm a resolution change and
> click OK... It's fine with scaled flat panels to scale to pretty much
> anything, but other cases are a bit more dodgy.
>
> Anyway, the point is, such an option has NOTHING to do in the fbcon
> layer unless we have fully implemented & properly working monitor
> detection, which we are only starting to have and only in some drivers.
>

stty has its pros, such as allowing a user to at least set the video resolution
without being root.

And, of course, its cons, such as crashing the machine simply by using stty,
iff fbdev cannot handle these mode requests properly.

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
