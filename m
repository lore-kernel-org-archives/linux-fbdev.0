From: James Simmons <jsimmons@infradead.org>
Subject: Re: [BK PATCHS] fbdev updates.
Date: Fri, 18 Oct 2002 10:05:54 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210180951500.10832-100000@maxwell.earthlink.net>
References: <20021015100024.A9771@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 182afv-0005wv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Oct 2002 10:12:39 -0700
In-Reply-To: <20021015100024.A9771@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


> I'm not sure this "set var" business has been thought out as much as it
> should be.

<snip>

   I see it coming. With the next set of changes it will be possible to
have fbdev with the VT system. So I have been putting into place the
ability to power down the framebuffer via the ioctl. So I want the flow
to be with fbcon from high level console to fbcon layer to fbdev driver.
Without fbcon to go from userland to the fbdev driver directly.
   Also we have mode changing. Soon I will add hooks to the VT layer to
allow use to change a single VC via stty. VT_RESIZE can replace the
current method of changing the size of all VCS instead of the fbdev layer
doing it.
   So you will see the necessary changes to handle all this.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
