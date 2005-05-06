From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Fri, 6 May 2005 20:08:50 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505062008090.6914@pentafluge.infradead.org>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <9e47339105050416415f4dfb1f@mail.gmail.com> 
 <Pine.LNX.4.56.0505051737280.15586@pentafluge.infradead.org> 
 <9e47339105050511522f6eff30@mail.gmail.com> 
 <Pine.LNX.4.56.0505051959350.15586@pentafluge.infradead.org> 
 <9e473391050505122635f1cf@mail.gmail.com>  <Pine.LNX.4.56.0505052141360.15586@pentafluge.infradead.org>
  <9e4733910505051402789440db@mail.gmail.com> 
 <Pine.LNX.4.56.0505060046490.15586@pentafluge.infradead.org> 
 <9e473391050505170161b0a38d@mail.gmail.com> <9e47339105050517083fadaee0@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DU8C0-0004wB-SS
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 12:08:56 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DU8By-0005Um-UO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 12:08:56 -0700
In-Reply-To: <9e47339105050517083fadaee0@mail.gmail.com>
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


> This does imply that we could switch read/write to kernel map VRAM a
> page or two at a time on demand. But this is significant work and I
> don't think there are any apps using read/write. If we find one it
> would just be easier to convert it to mmap than to support read/write
> in the kernel.

Yuck. Why not just us the image blitter for reading and writing the 
framebuffer?



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
