From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Thu, 5 May 2005 19:59:47 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505051959350.15586@pentafluge.infradead.org>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <Pine.LNX.4.56.0505021843060.24395@pentafluge.infradead.org> 
 <9e473391050504104529f1f080@mail.gmail.com> 
 <Pine.LNX.4.56.0505041902470.27026@pentafluge.infradead.org> 
 <9e47339105050416415f4dfb1f@mail.gmail.com> 
 <Pine.LNX.4.56.0505051737280.15586@pentafluge.infradead.org>
 <9e47339105050511522f6eff30@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTlZi-0005cO-7J
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 May 2005 11:59:54 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DTlZg-00075x-6i
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 05 May 2005 11:59:53 -0700
In-Reply-To: <9e47339105050511522f6eff30@mail.gmail.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@pentafluge.infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>


> >    fbconsole does use only fb_imageblit. The only place where screen_base
> > is used is fb_write and fb_read in fbmem.c. If that could be converted to use
> > the accelerated image blitting functions then we could replace it. To do
> 
> So if fbconsole doesn't use fb_read/write then who does?

/dev/fb



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
