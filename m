From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [PATCH][FBCON]: Mode Switch in fbcon_blank()
Date: Mon, 5 Jul 2004 06:35:23 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407050635.23803.adaplas@hotpop.com>
References: <200406301047.57423.adaplas@hotpop.com> <200407042347.46226.adaplas@hotpop.com> <20040704193230.GA2869@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhFcE-0003Yo-EN
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 15:37:42 -0700
Received: from snickers.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BhFZw-0005qt-C0
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 04 Jul 2004 15:37:42 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by snickers.hotpop.com (Postfix) with SMTP id 0B3B376025
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  4 Jul 2004 21:29:24 +0000 (UTC)
In-Reply-To: <20040704193230.GA2869@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>, adaplas@pol.net
Cc: Javier Marcet <javier-ml-gmane@marcet.info>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>

On Monday 05 July 2004 03:32, David Eger wrote:
> On Sun, Jul 04, 2004 at 11:47:46PM +0800, Antonino A. Daplas wrote:
> > On Friday 02 July 2004 18:25, Javier Marcet wrote:
> > > I use radeonfb and when switching from X to console my two monitors
> > > will go out of sync. The VT is actually there since I can type on it,
> > > but I can't see anything on neither of my two monitors :(
> >
> > Jurriaan's problem told me that I'm probably over-engineering the mode
> > switch code. Perhaps the ugly workaround patch is not necessary.  All
> > that is needed is to bypass fbcon_resize() and just do a simple
> > set_par().
> >
> > David, Javier, can you try the patch below?  Reverse the one with the big
> > HACK ALERT comment first.  If it works for you two, the code just became
> > simpler.
> >
> > Tony
>
> With this patch, X won't even get to the point of showing an X cursor :-(
>

Ok, so the hack is really needed.  Forget the patch then. 

Thanks

Tony




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
