From: Richard Zidlicky <rz@linux-m68k.org>
Subject: Re: Oops in fbcon_setup
Date: Sun, 1 Sep 2002 23:16:34 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020901231634.A1604@linux-m68k.org>
References: <20020831222000.A205@linux-m68k.org> <Pine.GSO.4.21.0209011123290.6530-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17lcSS-0004rM-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 01 Sep 2002 14:40:36 -0700
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0209011123290.6530-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Sun, Sep 01, 2002 at 11:24:57AM +0200
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
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Sun, Sep 01, 2002 at 11:24:57AM +0200, Geert Uytterhoeven wrote:

> 
> Since fbcon_cfb16 is going to go away, what about using fbcon_accel and
> cfb{copyarea,fillrect,imgblt}.c instead?

it appears it oopsed because FBCON_HAS_ACCEL was not defined, the
name of the config option is slightly misleading.

Now the penguin is prefect, however text is unreadable and in some 
strange blueish colour. Text background (empty lines etc) are filed 
with some strange symbol.

Any ideas? This is still 2.5.31 if that matters.

Richard


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
