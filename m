From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Fri, 13 May 2005 21:35:51 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505132134320.10736@pentafluge.infradead.org>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <Pine.LNX.4.56.0505060046490.15586@pentafluge.infradead.org> 
 <9e47339105050517083fadaee0@mail.gmail.com> 
 <Pine.LNX.4.56.0505062008090.6914@pentafluge.infradead.org> 
 <9e47339105050615097bdfcdcb@mail.gmail.com> 
 <Pine.LNX.4.56.0505112345230.4268@pentafluge.infradead.org> 
 <Pine.LNX.4.62.0505121112320.15959@numbat.sonytel.be> 
 <Pine.LNX.4.56.0505121648020.19137@pentafluge.infradead.org> 
 <9e47339105051210385a41e54e@mail.gmail.com>  <Pine.LNX.4.62.0505122151530.16269@numbat.sonytel.be>
 <9e473391050512131268248c3f@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWgt4-0000p6-U5
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 13:35:58 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DWgt3-0005jB-Dw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 13:35:58 -0700
In-Reply-To: <9e473391050512131268248c3f@mail.gmail.com>
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@pentafluge.infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>


> > > Before we get too far into this, has anyone determined if any user
> > > space app exists that does read/write from fbdev? I can't see a real
> > > need to keep this feature if no one is using it. If no one is using
> > > it, it would be much simpler just to remove the functions.
> > 
> > I think the only programs really using this are some screenshot programs, like
> > cfb8toppm (which I wrote as a frame buffer sample program many years ago),
> > fbshot, and fbgrap (in Debian).
> > 
> > Of course these can be converted to use mmap().
> 
> Seems to me that it would be easier to drop the feature and update the apps.

Since you are in a hurry why not just create a write and a read function 
for radeon that just returns EINVAL. There are hooks in fb_info for this.



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
