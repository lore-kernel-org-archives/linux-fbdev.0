From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdev and power management
Date: 14 Jul 2003 18:34:06 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1058200445.515.23.camel@gaston>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org>
	 <1057750557.514.22.camel@gaston>
	 <20030709151032.A22612@flint.arm.linux.org.uk>
	 <20020105111340.GA2254@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-2-223.w193-253.abo.wanadoo.fr ([193.253.217.223] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19c6IM-00016y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Jul 2003 09:35:22 -0700
In-Reply-To: <20020105111340.GA2254@zaurus.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2002-01-05 at 12:13, Pavel Machek wrote:
> Hi!
> 
> > I'm slightly concerned by this.  There are a growing amount of drivers
> > in 2.5 which are being made to work with the existing power management
> > system.  This "new" system seems to have been hanging around for about
> > 4 months now with no visible further work, presumably so that a paper
> > can be presented before its release.
> 
> I believe it is bad idea to change driver
> model again in 2.6.x-pre. I believe current
> solution is pretty much okay.

Current solution is not okay and actually, the save_state/suspend
distinction makes no sense. We have designed a working solution
a while ago now, Patrick has it implemented for month, it must
get in now or 2.6 will not have proper power management but just
"might work" kind of crap

Ben.




-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
