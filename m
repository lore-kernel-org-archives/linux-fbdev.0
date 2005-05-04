From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Wed, 4 May 2005 19:08:45 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505041902470.27026@pentafluge.infradead.org>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <Pine.LNX.4.56.0505021843060.24395@pentafluge.infradead.org>
 <9e473391050504104529f1f080@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTOIl-0005Jc-Oi
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 May 2005 11:08:51 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DTOIk-0003UN-AE
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 04 May 2005 11:08:51 -0700
In-Reply-To: <9e473391050504104529f1f080@mail.gmail.com>
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


> I don't see a good solution here for implementing fb_read/write for
> the framebuffer. I would still vote for removing all kernel
> framebuffer mapping from the fbdev driver. Then fbconsole would kernel
> map just the piece it needs to implement the console.

I like to see the mappings go away as well. The solution is for fb_read 
and fb_write to use fb_imageblit. We don't need to touch the framebuffer 
memory in that case. The logic is a little tricky. You could have 1 to 3 
images blitted to the display.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
