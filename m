From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Wed, 11 May 2005 23:46:23 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505112345230.4268@pentafluge.infradead.org>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <9e47339105050511522f6eff30@mail.gmail.com> 
 <Pine.LNX.4.56.0505051959350.15586@pentafluge.infradead.org> 
 <9e473391050505122635f1cf@mail.gmail.com>  <Pine.LNX.4.56.0505052141360.15586@pentafluge.infradead.org>
  <9e4733910505051402789440db@mail.gmail.com> 
 <Pine.LNX.4.56.0505060046490.15586@pentafluge.infradead.org> 
 <9e473391050505170161b0a38d@mail.gmail.com>  <9e47339105050517083fadaee0@mail.gmail.com>
  <Pine.LNX.4.56.0505062008090.6914@pentafluge.infradead.org>
 <9e47339105050615097bdfcdcb@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVzyF-0003PH-Vs
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 May 2005 15:46:27 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DVzyE-0004d4-8Q
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 May 2005 15:46:27 -0700
In-Reply-To: <9e47339105050615097bdfcdcb@mail.gmail.com>
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


> > Yuck. Why not just us the image blitter for reading and writing the
> > framebuffer?
> 
> Could you generically rewrite fb_read/write to just use the image blitter? 

Yes.

> Is this a solution to eliminating the kernel mmap?

Yes.

We would need to make imageblit bi-directional tho for all the drivers.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
