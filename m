From: Richard Henderson <rth@twiddle.net>
Subject: Re: [FB PATCH]
Date: Fri, 27 Dec 2002 15:54:51 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021227155451.A3942@twiddle.net>
References: <20021227150934.A3005@twiddle.net> <Pine.GSO.4.21.0212280025150.17067-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from are.twiddle.net ([64.81.246.98])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18S4KI-0006RF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Dec 2002 15:55:38 -0800
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0212280025150.17067-100000@vervain.sonytel.be>; from Geert.Uytterhoeven@sonycom.com on Sat, Dec 28, 2002 at 12:25:58AM +0100
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>

On Sat, Dec 28, 2002 at 12:25:58AM +0100, Geert Uytterhoeven wrote:
> Strange, it's defined in drivers/video/fbmem.c in my copy of 2.5.53.

Ah.  It's not exported, so fbcon as a module fails.
Not sure how I missed it with a grep...


r~


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
