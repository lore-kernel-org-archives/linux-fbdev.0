From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] packed pixel image
	blit	optimizations.
Date: Fri, 04 May 2007 03:44:53 +0800
Message-ID: <1178221493.28617.21.camel@daplas>
References: <Pine.LNX.4.64.0705022123490.12422@pentafluge.infradead.org>
	<1178141603.4606.44.camel@daplas>
	<Pine.LNX.4.64.0705031503300.15445@pentafluge.infradead.org>
	<1178220277.28617.7.camel@daplas>
	<Pine.LNX.4.64.0705032029520.25194@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjhEZ-0003gZ-2u for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 12:44:59 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HjhEY-0004fo-Pr
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 May 2007 12:44:59 -0700
Received: by py-out-1112.google.com with SMTP id a29so508020pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 03 May 2007 12:44:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705032029520.25194@pentafluge.infradead.org>
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

On Thu, 2007-05-03 at 20:34 +0100, James Simmons wrote:
> > > > > This patch is the start of my original work. The goal was:
> > > > > 
> > > > > 1) One function for to draw at any color depth.
> > > > > 
> > > > > 2) 16 color image data does need special padding.
> > > > > 
> > > > > 3) Use fb_pixmap to control drawing to the hardware.
> > > > 
> > > > I'm getting rejects with this patch.  Did you benchmark this and
> > > > compared the performance with the old one?
> > > 
> > > Need to update patch to newest kernel. Not yet, there are still bugs to 
> > > hammer away on.
> > 
> > I don't have to test the patch to see that it is not endian-correct and
> > that it will be many times slower than the old code.
> 
> I have tested on big endian framebuffers and it does work.

How about little-endian?

>  I was attempting
> to shrink the code for embedded devices. We can have the fastest code possible
> but its no good if a cell phone can't run it :-(

Nonsense, the difference is a few kb at most. And I'm not talking about
a few percent speed difference, I'm talking 2, 3 maybe 5x slower.

Please do basic tests first.

Tony


> 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
