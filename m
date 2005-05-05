From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Fri, 6 May 2005 00:47:33 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505060046490.15586@pentafluge.infradead.org>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <Pine.LNX.4.56.0505021843060.24395@pentafluge.infradead.org> 
 <9e473391050504104529f1f080@mail.gmail.com> 
 <Pine.LNX.4.56.0505041902470.27026@pentafluge.infradead.org> 
 <9e47339105050416415f4dfb1f@mail.gmail.com> 
 <Pine.LNX.4.56.0505051737280.15586@pentafluge.infradead.org> 
 <9e47339105050511522f6eff30@mail.gmail.com> 
 <Pine.LNX.4.56.0505051959350.15586@pentafluge.infradead.org> 
 <9e473391050505122635f1cf@mail.gmail.com>  <Pine.LNX.4.56.0505052141360.15586@pentafluge.infradead.org>
 <9e4733910505051402789440db@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTq4B-0002iL-EY
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 May 2005 16:47:39 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DTq49-0006H7-Rf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 May 2005 16:47:39 -0700
In-Reply-To: <9e4733910505051402789440db@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: James Simmons <jsimmons@pentafluge.infradead.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>


> > I can't say off the top of my head. We should assume there are apps that
> > do use those functions.
> 
> fb_read/write has been broken on radeon for a couple of years now and
> nobody has noticed.

I have a hard time believing that. Do a cat /dev/urandom > /dev/fb0
and see what the results are. I can give it a try.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
