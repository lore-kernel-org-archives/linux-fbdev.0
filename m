From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] Tile Blitting
Date: Thu, 27 Feb 2003 19:48:47 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302271946340.8243-100000@phoenix.infradead.org>
References: <1046370303.12970.27.camel@thor>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from phoenix.mvhi.com ([195.224.96.167] helo=phoenix.infradead.org)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18oU20-0001zO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Feb 2003 11:49:24 -0800
In-Reply-To: <1046370303.12970.27.camel@thor>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> On Don, 2003-02-27 at 15:15, Antonino Daplas wrote: 
> > On Thu, 2003-02-27 at 09:18, James Simmons wrote:
> >  
> > > > Thus, the restriction that the buffer must be completely copied by the
> > > > driver before returning.  And because of this restriction, an extra copy
> > > > which might be unnecessary cannot be avoided (this was noted by Petr).
> > > > 
> > > > Treating the buffer as a ringbuffer, we eliminate these restrictions.
> > > 
> > > I didn't realize that the below was a ringbuffer implementation. The name
> > > threw me off. 
> > 
> > Well, it's not strictly a ringbuffer implementation.  This would require
> > a head and tail pointer where fbcon will adjust the tail and the
> > driver/hardware will adjust the head.  This will be very difficult to
> > implement in a device independent manner.  So we just cheat by issuing
> > an fb_sync() per loop to flush all pending commands.
> 
> That still seems suboptimal though. What the DRM often does is have the
> chip write an age value to a scratch register when it's done processing
> something. Maybe something like that could be used to avoid waiting for
> the chip to go idle at all?

Don't waste your time. I'm removing all the changes that have been done 
since 2.5.51. After that I will no longer be co-maintainter of the 
framebuffer layer. 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
