From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Framebuffer work is coming back.
Date: Tue, 13 Jan 2004 18:37:29 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200401131837.29304.alex.kern@gmx.de>
References: <Pine.LNX.4.44.0401072236030.2265-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgSU6-0002TL-Hn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 09:37:46 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AgSU5-0004Rj-SI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 13 Jan 2004 09:37:46 -0800
In-Reply-To: <Pine.LNX.4.44.0401072236030.2265-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Am Mittwoch, 7. Januar 2004 23:58 schrieben Sie:
> > here is a one more patch for MACH64. This is an accelerated imgblit.
>
> Nice !!! ;-) Only one problem I found when testing. If you pick the sun
> 12x22 fonts at boot up some of the fonts are distorted. Once X starts
> and you go back to the console this problem goes away completely. This
> is using a non accelerated X server.
>
> P.S
> Also I noticed that in the accelerated function you have HOST_XBPP. I like
> to give it a try for color expension. This would be cool sine this means
> we could have the 4 bpp penguin shown on any depth display!!!
I trying to investigate this problem, but found nothing. I suspect the 
bytealigning of images, are they all bytealigned, 12x22 too?

Cheers Alex

P.S. 4bpp penguin on any bpp will not work! Mach64 supports only monoblit
extension, colorblit only if source and destination have the same depth. 



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
