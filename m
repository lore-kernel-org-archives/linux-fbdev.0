From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] ATI Mach64 accelerated imgblit
 (sligthly improved)
Date: Fri, 30 Jan 2004 21:49:22 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0401302148520.22830-100000@phoenix.infradead.org>
References: <200401231858.28965.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AmgVx-0002gx-MY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jan 2004 13:49:25 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AmgVx-0006kR-11
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 30 Jan 2004 13:49:25 -0800
In-Reply-To: <200401231858.28965.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: fbdev <linux-fbdev-devel@lists.sourceforge.net>


I have a new patch at 
http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz.


On Fri, 23 Jan 2004, Alexander Kern wrote:

> Am Montag, 19. Januar 2004 19:11 schrieben Sie:
> > > No, it's only imageblit, which has issue.
> > > Regards
> > > Alex Kern
> >
> > Applied your patch. I tested it and it works wonderful. I haven't tested
> > in 24 bpp mode tho. I think that is a minor issue.
> Hi James,
> 
> will you update your fbdev.diff.gz? What about resync and submit it again to 
> mm tree?
> 
> Here is one better patch for accelerated imageblit. It looks like mach64 has a 
> problems with buildin trippler and unaligned data. Manual tripple path works 
> now!
> 
> Regards Alex
> 



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
