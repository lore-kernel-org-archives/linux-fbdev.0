From: jsimmons@pentafluge.infradead.org
Subject: Re: Sane behavior of fbset
Date: Wed, 23 Jun 2004 19:57:34 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406231956480.27210@pentafluge.infradead.org>
References: <200406180945.12444.adaplas@hotpop.com> <200406190240.26228.adaplas@hotpop.com>
 <20040619031650.GC14319@havoc.gtf.org> <200406191413.28339.adaplas@hotpop.com>
 <40D462C7.30908@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdCwG-0005EE-Tl
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:57:40 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BdCwG-0004Yt-2H
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:57:40 -0700
In-Reply-To: <40D462C7.30908@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Zielinski <grim@undead.cc>
Cc: adaplas@pol.net, David Eger <eger@havoc.gtf.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >The flow of fbset is upstream:  fbset->fbdev->fbcon->vc (2.4 code)
> >The flow of stty is downstream: stty->vc->fbcon->fbdev (2.6 code)
> >  
> >
> The flow of fbset in 2.6: fbset->fbdev->fbcon
> The flow of fbset after my patch: fbset->fbdev->fbcon->vc
> The flow of fbset if calc error: 
> fbset->fbdev->fbcon->vc->fbcon->fbdev->fbcon->vc-> etc.
> 
> As long as  graphics_res / font_size = text_res then fbcon will not try 
> to resize the vc.  If there are any errors introduced into the 
> calculations then you end up with an infinite loop.

That shouldn't be the case. fbcon picks a rounded up mode from the text 
resolution. It is a best fit match.



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
