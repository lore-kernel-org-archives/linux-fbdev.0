From: Antonino Daplas <adaplas@pol.net>
Subject: Re: Re: New logo code [CONFIG OPTIONS]
Date: 19 Feb 2003 05:58:04 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045605436.1233.14.camel@localhost.localdomain>
References: <200302171932.h1HJWuiY011149@darkstar.example.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18lFk4-0007P8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Feb 2003 13:57:32 -0800
In-Reply-To: <200302171932.h1HJWuiY011149@darkstar.example.net>
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
To: John Bradford <john@grabjohn.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, schottelius@wdt.de, thoffman@arnor.net, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel List <linux-kernel@vger.kernel.org>

On Tue, 2003-02-18 at 03:32, John Bradford wrote:
> > So how about making the logo "float" above/obscure the text (ie,
> > overlay)?  It's not difficult to implement since fbcon.c has "redraw"
> > versions of fbcon_bmove() and fbcon_clear().  All that needs to be done
> > is do a "scissors" test before an fb_imageblit().  
> 
> On the subject of the new logo code, would it be worth making it do
> something, (change colour, move, or animate), during a console bell?
> 

Possibly, it depends on the console/input developers if they want to add
something like fb_flash_logo() besides doing a kd_mksound(). Also, if
you don't mind compiling in a bunch of logo images to your kernel.

On a more practical note, the "scissors test" (I should have named this
"exclusive clipping test") can perhaps be enabled arbitrarily by
userland clients.  You'll be left with a rectangular screen space that
will not be touched by the console.  Then a distributor can do whatever
it wants with that screen estate, say an animating splash or a pop-up
window, which in theory can be triggered any time.

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
