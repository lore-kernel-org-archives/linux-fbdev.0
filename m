From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] packed pixel image blit
	optimizations.
Date: Thu, 3 May 2007 15:04:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705031503300.15445@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0705022123490.12422@pentafluge.infradead.org>
	<1178141603.4606.44.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hjbv5-0002cp-21 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 07:04:32 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hjbv3-0005Os-Bv
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 07:04:30 -0700
In-Reply-To: <1178141603.4606.44.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net


> On Wed, 2007-05-02 at 21:50 +0100, James Simmons wrote:
> > This patch is the start of my original work. The goal was:
> > 
> > 1) One function for to draw at any color depth.
> > 
> > 2) 16 color image data does need special padding.
> > 
> > 3) Use fb_pixmap to control drawing to the hardware.
> 
> I'm getting rejects with this patch.  Did you benchmark this and
> compared the performance with the old one?

Need to update patch to newest kernel. Not yet, there are still bugs to 
hammer away on.


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
