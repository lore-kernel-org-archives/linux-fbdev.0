From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] packed pixel image blit
	optimizations.
Date: Tue, 8 May 2007 20:58:27 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705082056180.2324@pentafluge.infradead.org>
References: <Pine.LNX.4.64.0705022123490.12422@pentafluge.infradead.org> 
	<1178141603.4606.44.camel@daplas>
	<Pine.LNX.4.64.0705031503300.15445@pentafluge.infradead.org>
	<1178220277.28617.7.camel@daplas>
	<Pine.LNX.4.64.0705032029520.25194@pentafluge.infradead.org>
	<1178221493.28617.21.camel@daplas>
	<Pine.LNX.4.64.0705032055200.25194@pentafluge.infradead.org>
	<1178222819.28617.33.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlVpP-0002g5-IZ for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 12:58:31 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HlVpP-0007Cr-8S
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 12:58:31 -0700
In-Reply-To: <1178222819.28617.33.camel@daplas>
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

> On Thu, 2007-05-03 at 20:55 +0100, James Simmons wrote:
> > > > > I don't have to test the patch to see that it is not endian-correct and
> > > > > that it will be many times slower than the old code.
> > > > 
> > > > I have tested on big endian framebuffers and it does work.
> > > 
> > > How about little-endian?
> > 
> > Worked as well.
> >  
> 
> Not for me, vesafb 8x16 font at 1024x768-8.

How did you do the test below if it doesn't work on little endian? If you 
are the only one allowed to work on the core system you need to make 
people aware of it. I won't invade you space anymore.
 
> 
> time cat linux/MAINTAINERS
> 
> old
> real    0m5.406s
> user    0m0.001s
> sys     0m5.401s
> 
> your patch
> real    0m36.859s
> user    0m0.002s
> sys     0m36.843s
> 
> Tony
> 
> 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
