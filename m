From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Framebuffer: 2nd try: client
	notification mecanism & PM
Date: 07 Aug 2003 15:32:49 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1060263168.593.77.camel@gaston>
References: <Pine.LNX.4.44.0308070000540.17315-100000@phoenix.infradead.org>
	 <1060249101.1077.67.camel@gaston>  <20030807100309.GB166@elf.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mix-lyon-107-1-254.w193-249.abo.wanadoo.fr ([193.249.22.254] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19kku4-0002ep-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 07 Aug 2003 06:34:04 -0700
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

On Thu, 2003-08-07 at 12:03, Pavel Machek wrote:

> I believe solution to this is simple: always switch to kernel-owned
> console during suspend. (swsusp does it, there's patch for S3 to do
> the same). That way, Xfree (or qtopia or whoever) should clean up
> after themselves and leave the console to the kernel. (See
> kernel/power/console.c)

I admit I quite like this solution. It would also help displaying
something sane (blank, pattern, whatever) on screen during driver
teardown instead of the junk left by X...

I'll look into including that switch into my pmac code as well
and see if it works properly in all cases (I think so). Also,
recent DRI CVS finally has working suspend/resume (works on
console switch too).

Ben.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
