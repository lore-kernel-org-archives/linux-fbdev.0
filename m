From: Pavel Machek <pavel@ucw.cz>
Subject: Re: fbdev and power management
Date: Sat, 5 Jan 2002 12:13:40 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020105111340.GA2254@zaurus.ucw.cz>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org> <1057750557.514.22.camel@gaston> <20030709151032.A22612@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123] ident=postfix)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19c2ht-0003aL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Jul 2003 05:45:29 -0700
Content-Disposition: inline
In-Reply-To: <20030709151032.A22612@flint.arm.linux.org.uk>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi!

> I'm slightly concerned by this.  There are a growing amount of drivers
> in 2.5 which are being made to work with the existing power management
> system.  This "new" system seems to have been hanging around for about
> 4 months now with no visible further work, presumably so that a paper
> can be presented before its release.

I believe it is bad idea to change driver
model again in 2.6.x-pre. I believe current
solution is pretty much okay.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
