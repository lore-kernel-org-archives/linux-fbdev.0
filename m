From: James Simmons <jsimmons@infradead.org>
Subject: Re: grayscale penguin?
Date: Tue, 10 Dec 2002 14:20:55 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0212101418570.2617-100000@maxwell.earthlink.net>
References: <Pine.GSO.4.21.0212101455170.13391-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from flamingo.mail.pas.earthlink.net ([207.217.120.232])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Lrw6-0006BC-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 10 Dec 2002 13:29:02 -0800
In-Reply-To: <Pine.GSO.4.21.0212101455170.13391-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> Should we add a penguin logo for greyscale displays as well?
>
> Simon Budig already created one a while ago (cfr.
> http://home.tvd.be/cr26864/Linux/fbdev/logo.html and
> http://www.home.unix-ag.org/simon/kernel-pingu/).

Hm. Do we need it? A few drivers fake greyscale by creating a grey scale
colormap. We should try it with the default image. If it doesn't work then
we can include it.





-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
