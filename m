From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Framebuffer: 2nd try: client
	notification mecanism & PM
Date: 07 Aug 2003 16:37:11 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1060267031.722.3.camel@gaston>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
	 <1060249101.1077.67.camel@gaston>  <20030807100309.GB166@elf.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mix-lyon-107-1-204.w193-249.abo.wanadoo.fr ([193.249.22.204] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19klyx-0004zu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 07 Aug 2003 07:43:12 -0700
In-Reply-To: <20030807100309.GB166@elf.ucw.cz>
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
To: Pavel Machek <pavel@suse.cz>
Cc: James Simmons <jsimmons@infradead.org>, linux-kernel mailing list <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Machek <pavel@ucw.cz>


> I believe solution to this is simple: always switch to kernel-owned
> console during suspend. (swsusp does it, there's patch for S3 to do
> the same). That way, Xfree (or qtopia or whoever) should clean up
> after themselves and leave the console to the kernel. (See
> kernel/power/console.c)

I tried using it on pmac, but it causes hell with XFree. I'm not sure
what's up yet, I suspect it may be XFree still doing things after
calling the RELDISP ioctl but I'm not completely sure yet.

The setup XFree + DRI is working without switching to suspend console
(with only the apm_bios emulation for XFree to suspend/restore itself)
but not when switching to suspend console right before doing the apm
emulation callbacks (which should be ignored by X since it's no longer
the frontmost process at this point).

For some reason, it seems that after we have switched to the suspend
console, we race with the X server on accel engine, and on resume, the X
server just crashes.

Ben.
 


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
