From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Re: FBdev updates.
Date: Sun, 9 Mar 2003 23:54:56 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030309225455.GD16578@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk> <20030220182941.GK14445@vana.vc.cvut.cz> <1045787031.2051.9.camel@localhost.localdomain> <20030303203500.GA2916@vana.vc.cvut.cz> <20030304212906.GA1115@middle.of.nowhere> <20030309212903.GC16578@vana.vc.cvut.cz> <1047248782.1208.45.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from vana.vc.cvut.cz ([147.32.240.58] ident=root)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18s9h8-0006wu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 09 Mar 2003 14:55:02 -0800
Content-Disposition: inline
In-Reply-To: <1047248782.1208.45.camel@localhost.localdomain>
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
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, Mar 10, 2003 at 06:27:14AM +0800, Antonino Daplas wrote:
> On Mon, 2003-03-10 at 05:29, Petr Vandrovec wrote:
> 
> As for synchronization, I was meaning to ask some pointers on that.  The
> setup currently works like this:
> 
>                         (blink)
> fbcon_cursor         fbcon_vbl_handler (interrupt or timer)   
>      |                     |
>      -----------------------
>                |
>            accel_cursor
>                |
>      -----------------------
>      |                      |
>   hardware              soft_cursor    accel_putcs    accel_putc
>                             |              |               |
>                             -------------- -----------------
>                                            | 
>                                    fb_get_buffer_offset
>                                            |
>                                      xxxfb_imageblit
>                                            |
>                                   -------------------
>                                   |                  |
>                               hardware           software
> 
> 
> I was thinking of placing locks in accel_cursor and
> fb_get_buffer_offset, but I'm not sure.

Maybe just auditing code is enough: cursor_on should be zero while
we are inside accel_putc/putcs (or inside any other fb function), and
if cursor_on is zero, fbcon_vbl_handler should do nothing. So just making
sure that fbcon_vbl_handler is not running on other CPU while we set
cursor_on = 0 should be enough.

> >     if fbdev provides hardware cursor... And HZ/50 delay after
> >     putcs makes orientation on screen very complicated, as there
> >     is no cursor while new characters are appearing on screen.
> 
> The delay is only for the blinking.  After drawing a character/stream of
> characters, an explicit "draw cursor" command immediately follows (I
> think) via fbcon_cursor.

Why we schedule cursor painting at all then? While we are inside putcs,
we cannot paint cursor anyway (as we are busy with painting characters
at cursor position...) and fbcon_cursor(CM_DRAW) should restart timer interval
anyway (so you see cursor while you type characters, and not like Solaris
where cursor appears after you stop typing characters) (unfortunately when 
I tried to verify how it behaves on secondary head of matrox (which does not
have hardware cursor), I made a typo and ...

Unable to handle kernel NULL pointer dereference at virtual address 00000196
 printing eip:
c02f9258
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c02f9258>]    Tainted: PFS
EFLAGS: 00010202
EIP is at fb_open+0x28/0xf0
eax: c6ed2c30   ebx: 00000020   ecx: 00000001   edx: c04848e0
esi: 00000002   edi: 00000000   ebp: c6ed2c30   esp: c4bb3f18
ds: 007b   es: 007b   ss: 0068
Process con2fb (pid: 18180, threadinfo=c4bb2000 task=d874d940)
Stack: 00000006 c8a8aae4 c4bb2000 00000000 c8a8aae4 c01669ea c6ed2c30 c8a8aae4
       dffe6830 c01435e3 c8a8aae4 c6ed2c30 dffe6830 00000000 c015af91 c6ed2c30
       c8a8aae4 00000002 bffffe7a dcaa5000 c4bb2000 c015adb7 ca74978c dffe6830
Call Trace:
 [<c01669ea>] chrdev_open+0xaa/0x110
 [<c01435e3>] file_ra_state_init+0x23/0x40
 [<c015af91>] dentry_open+0x1d1/0x1f0
 [<c015adb7>] filp_open+0x67/0x70
 [<c015b26b>] sys_open+0x5b/0x90
 [<c0109983>] syscall_call+0x7/0xb

Code: 8b 86 94 01 00 00 b9 01 00 00 00 8b 10 85 d2 74 1c b8 00 e0

so I'll have to check it tomorrow on real dualhead system...)

						Petr Vandrovec
						vandrove@vc.cvut.cz





-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
