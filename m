From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH] Tile Blitting
Date: 04 Mar 2003 05:32:17 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1046725840.1277.8.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0303021312400.9181-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18pxWj-0000T0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 03 Mar 2003 13:31:13 -0800
In-Reply-To: <Pine.GSO.4.21.0303021312400.9181-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-03-02 at 20:14, Geert Uytterhoeven wrote:
> On Thu, 27 Feb 2003, James Simmons wrote:
> > > On Don, 2003-02-27 at 15:15, Antonino Daplas wrote: 
> > > > On Thu, 2003-02-27 at 09:18, James Simmons wrote:
> > > >  
> > > > > > Thus, the restriction that the buffer must be completely copied by the
> > > > > > driver before returning.  And because of this restriction, an extra copy
> > > > > > which might be unnecessary cannot be avoided (this was noted by Petr).
> > > > > > 
> > > > > > Treating the buffer as a ringbuffer, we eliminate these restrictions.
> > > > > 
> > > > > I didn't realize that the below was a ringbuffer implementation. The name
> > > > > threw me off. 
> > > > 
> > > > Well, it's not strictly a ringbuffer implementation.  This would require
> > > > a head and tail pointer where fbcon will adjust the tail and the
> > > > driver/hardware will adjust the head.  This will be very difficult to
> > > > implement in a device independent manner.  So we just cheat by issuing
> > > > an fb_sync() per loop to flush all pending commands.
> > > 
> > > That still seems suboptimal though. What the DRM often does is have the
> > > chip write an age value to a scratch register when it's done processing
> > > something. Maybe something like that could be used to avoid waiting for
> > > the chip to go idle at all?
> > 
> > Don't waste your time. I'm removing all the changes that have been done 
> > since 2.5.51. After that I will no longer be co-maintainter of the 
> > framebuffer layer. 
> 
> Are you sure about that?!?!?
> 

I agree.  Actually, I'm not worried about Tile blitting.  It should be
mature since it's basically a rehash of the 2.4 API.  If I'm going to
worry about something, it's the standard accel_putcs() code, especially
if thread-safety is an issue.

Is thread-safety a real problem?  That was also my concern before, which
is why I looked at vt.c.  From what I can see, there's always an
"acquire_console_sem()" before calling any of the console methods. The
console semaphore is supposed to guarantee serialization and exclusive
access to the console (see linux/kernel/printk.c).

Tony



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
