From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: FBdev updates.
Date: 10 Mar 2003 07:44:31 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1047253415.1208.66.camel@localhost.localdomain>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
	<20030220150201.GD13507@codemonkey.org.uk>
	<20030220182941.GK14445@vana.vc.cvut.cz>
	<1045787031.2051.9.camel@localhost.localdomain>
	<20030303203500.GA2916@vana.vc.cvut.cz>
	<20030304212906.GA1115@middle.of.nowhere>
	<20030309212903.GC16578@vana.vc.cvut.cz>
	<1047248782.1208.45.camel@localhost.localdomain> 
	<20030309225455.GD16578@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18sAVa-0003bS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 09 Mar 2003 15:47:10 -0800
In-Reply-To: <20030309225455.GD16578@vana.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 2003-03-10 at 06:54, Petr Vandrovec wrote:
> On Mon, Mar 10, 2003 at 06:27:14AM +0800, Antonino Daplas wrote:
> > On Mon, 2003-03-10 at 05:29, Petr Vandrovec wrote:
> > 
> > As for synchronization, I was meaning to ask some pointers on that.  The
> > setup currently works like this:
> > 
> >                         (blink)
> > fbcon_cursor         fbcon_vbl_handler (interrupt or timer)   
> >      |                     |
> >      -----------------------
> >                |
> >            accel_cursor
> >                |
> >      -----------------------
> >      |                      |
> >   hardware              soft_cursor    accel_putcs    accel_putc
> >                             |              |               |
> >                             -------------- -----------------
> >                                            | 
> >                                    fb_get_buffer_offset
> >                                            |
> >                                      xxxfb_imageblit
> >                                            |
> >                                   -------------------
> >                                   |                  |
> >                               hardware           software
> > 
> > 
> > I was thinking of placing locks in accel_cursor and
> > fb_get_buffer_offset, but I'm not sure.
> 
> Maybe just auditing code is enough: cursor_on should be zero while
> we are inside accel_putc/putcs (or inside any other fb function), and
> if cursor_on is zero, fbcon_vbl_handler should do nothing. So just making
> sure that fbcon_vbl_handler is not running on other CPU while we set
> cursor_on = 0 should be enough.

I think that's what happens.  cursor_on is set to 0 at the beginning of
fbcon_cursor(), and it remains 0 until the next fbcon_cursor() is
CM_DRAW or CM_MOVE.  And while cursor_on is 0, fbcon_vbl_handler just
exits immediately.  Yes, it's basically the code in 2.4, but instead of
using revc, it uses imageblit, and instead of allowing the drivers to do
the blinking, fbcon does it entirely, whether a hardware or software
cursor method is installed.  

> 
> > >     if fbdev provides hardware cursor... And HZ/50 delay after
> > >     putcs makes orientation on screen very complicated, as there
> > >     is no cursor while new characters are appearing on screen.
> > 
> > The delay is only for the blinking.  After drawing a character/stream of
> > characters, an explicit "draw cursor" command immediately follows (I
> > think) via fbcon_cursor.
> 
> Why we schedule cursor painting at all then? While we are inside putcs,
> we cannot paint cursor anyway (as we are busy with painting characters

I don't think any cursor painting is done while doing putcs, if the
CM_ERASE, putc/putcs, CM_DRAW/CM_MOVE sequence is followed.  Note that I
haven't verified if that particular sequence is followed, I just assume
the console layer does.

Tony




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
