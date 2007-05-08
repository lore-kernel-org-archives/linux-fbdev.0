From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] packed pixel image
	blit	optimizations.
Date: Wed, 09 May 2007 07:10:28 +0800
Message-ID: <1178665828.4747.11.camel@daplas>
References: <Pine.LNX.4.64.0705022123490.12422@pentafluge.infradead.org>
	<1178141603.4606.44.camel@daplas>
	<Pine.LNX.4.64.0705031503300.15445@pentafluge.infradead.org>
	<1178220277.28617.7.camel@daplas>
	<Pine.LNX.4.64.0705032029520.25194@pentafluge.infradead.org>
	<1178221493.28617.21.camel@daplas>
	<Pine.LNX.4.64.0705032055200.25194@pentafluge.infradead.org>
	<1178222819.28617.33.camel@daplas>
	<Pine.LNX.4.64.0705082056180.2324@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HlYpJ-00053M-Po for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 16:10:37 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HlYpI-0001pm-5i
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 08 May 2007 16:10:37 -0700
Received: by py-out-1112.google.com with SMTP id a29so3499pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 May 2007 16:10:35 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705082056180.2324@pentafluge.infradead.org>
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

On Tue, 2007-05-08 at 20:58 +0100, James Simmons wrote:
> > On Thu, 2007-05-03 at 20:55 +0100, James Simmons wrote:
> > > > > > I don't have to test the patch to see that it is not endian-correct and
> > > > > > that it will be many times slower than the old code.
> > > > > 
> > > > > I have tested on big endian framebuffers and it does work.
> > > > 
> > > > How about little-endian?
> > > 
> > > Worked as well.
> > >  
> > 
> > Not for me, vesafb 8x16 font at 1024x768-8.
> 
> How did you do the test below if it doesn't work on little endian? If you 
> are the only one allowed to work on the core system you need to make 
> people aware of it. I won't invade you space anymore.

I get corrupted characters and this is with vesafb, the most widely used
framebuffer driver. I just copied the last screen output to a text file
and opened it in X.  Look, everyone is free to try your patch for
testing, and if they report that it works for them with no speed
degradation, then I'll examine it further where it failed.

So people, can you try James Simmon's patch posted here?

http://marc.info/?l=linux-fbdev-devel&m=117821517710515&w=2

Tony

PS: The reason your patch is slow is because you are using swab32().

The old code does this:

table lookup

Your patch does this:

table lookup + swab32()

And swab32 consists of 4 OR's, 4 bitshifts, and 2 ANDS. This is very
expensive especially if this is done for each 4 bytes of data (thats 1
pixel in 32 bpp).



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
