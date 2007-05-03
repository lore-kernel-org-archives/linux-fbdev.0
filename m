From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] packed pixel image
	blit	optimizations.
Date: Fri, 04 May 2007 03:24:37 +0800
Message-ID: <1178220277.28617.7.camel@daplas>
References: <Pine.LNX.4.64.0705022123490.12422@pentafluge.infradead.org>
	<1178141603.4606.44.camel@daplas>
	<Pine.LNX.4.64.0705031503300.15445@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hjguy-0002VE-PD for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 12:24:44 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hjgux-00006V-ED
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 12:24:44 -0700
Received: by py-out-1112.google.com with SMTP id a29so503022pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 03 May 2007 12:24:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705031503300.15445@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Thu, 2007-05-03 at 15:04 +0100, James Simmons wrote:
> > On Wed, 2007-05-02 at 21:50 +0100, James Simmons wrote:
> > > This patch is the start of my original work. The goal was:
> > > 
> > > 1) One function for to draw at any color depth.
> > > 
> > > 2) 16 color image data does need special padding.
> > > 
> > > 3) Use fb_pixmap to control drawing to the hardware.
> > 
> > I'm getting rejects with this patch.  Did you benchmark this and
> > compared the performance with the old one?
> 
> Need to update patch to newest kernel. Not yet, there are still bugs to 
> hammer away on.

I don't have to test the patch to see that it is not endian-correct and
that it will be many times slower than the old code.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
