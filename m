From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5.42 compiler error in video/vga16fb.c
Date: Fri, 18 Oct 2002 09:47:34 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210180944520.10832-100000@maxwell.earthlink.net>
References: <20021013015301.GB1508@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182aNz-0003Bz-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 09:54:07 -0700
In-Reply-To: <20021013015301.GB1508@ppc.vc.cvut.cz>
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
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Bob Billson <reb@bhive.dhs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> It looks like that nobody is interested in VGA anymore. Are there
> any objections against patch below? It is for current 2.5.42-bk,
> and it fixes vga16fb compilability, and adds -depth 8 (to get 320x200, or
> 360x480 in planar mode) and -depth 0 (to get fast textmode) to the vga16fb.

I'm working on it.

> If there are no objections, I'll split it up and send to Linus. But as

Wait. I have your work already in the fbdev BK tree. I'm porting it to the
new api. I just need to write up a fillrect and copy area function for vga
planes mode.

> I already said (and already asked), I'm not going to be vga16fb maintainer
> (because of I use matroxfb everywhere), so if there is somebody else
> who has vga16fb fixes, or who wants to maintain vga16fb, please step up...

I guess I can do it. I need to rewrite vgacon in the near future anyways.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
