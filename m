From: James Simmons <jsimmons@www.infradead.org>
Subject: Re: Mapping the framebuffer into kernel space
Date: Fri, 6 May 2005 20:07:46 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505061958470.6914@pentafluge.infradead.org>
References: <9e473391050428205517f3c8c0@mail.gmail.com> 
 <Pine.LNX.4.56.0505021843060.24395@pentafluge.infradead.org> 
 <9e473391050504104529f1f080@mail.gmail.com> 
 <Pine.LNX.4.56.0505041902470.27026@pentafluge.infradead.org>
 <9e47339105050416415f4dfb1f@mail.gmail.com> <Pine.LNX.4.56.0505051737280.15586@pentafluge.infradead.org>
 <Pine.LNX.4.62.0505061129480.5272@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DU8Ay-0004uK-Pi
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 12:07:52 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DU8Ax-0005MY-7T
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 06 May 2005 12:07:52 -0700
In-Reply-To: <Pine.LNX.4.62.0505061129480.5272@numbat.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Jon Smirl <jonsmirl@gmail.com>, James Simmons <jsimmons@pentafluge.infradead.org>, "Antonino A. Daplas" <adaplas@hotpop.com>


> >    So first we have to come up with a standard way to handling image 
> > blitting from card memory to system memory without breaking badly the 
> > current api. Second we have to add bi directional blitting to every 
> > driver. Then once we are done we can convert the fb_read and fb_write 
> > functions to using the fb_imageblit functon. Have have plans to do this 
> > but have not yet done it.
> 
> What if the graphics memory format is not chunked pixels? In that case
> fb_{read,write}() will behave differently than mmap().

Is that a bad thing? It would be nice to have a application behave sanely 
in all cases. Even for pack pixel formated cards they might misbehave. 
For the Epson135X family we have the issue of only being able to write 16
bits at a time to the framebuffer memory. Unless you write the code 
knowing before hand this issue you will drop every other pixel for both 
mmap and write cases. Now if we rework fb_write then that chip would 
behave the same as other chips for the read/write function. The other 
bonus with a nice read/write function is you can NFS mount the fbdev 
device and read/write to it. To my knowledge you can't use mmap remotely.



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
