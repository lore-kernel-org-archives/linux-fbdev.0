From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Re: board with broken vga ...
Date: Mon, 22 Jul 2002 22:45:59 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <BA7D2B624A5@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17Wk4k-00080C-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Jul 2002 13:46:39 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Sven <luther@dpt-info.u-strasbg.fr>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 22 Jul 02 at 22:40, Sven wrote:
> 
> What would solve my problem in the easiest way would be to have some 
> framebuffer restore hook or something in the fbdev driver, which would get called
> in take_over_screen or something such, after the screen has been resized ?

Just put it into vc_screenbuf after register_framebuffer() returns, and
force redraw...
 
> Or Maybe simply tell vc_resize that we use a special way of reading the framebuffer.
> 
> Or i should implement the trick you use for setting the card in 
> graphic mode later on in the setvar stuff ?

If you'll override save_screen, and you'll put set_origin() into visual_init,
I believe that it will work:

(1) in take_over_console, copy data to screenbuf using your own save_screen.
(2) now vc_resize (with prior set_origin) will copy data from old screenbuf
    to reallocated screenbuf (instead of from videoram to reallocated
    screenbuf).
(3) and update_screen() will just paint data which are already on screen
    if resolution changed. If resolutions matched, it will put data on the
    screen.

                                                    Petr
                                                    


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
