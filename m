From: Pavel Machek <pavel@suse.cz>
Subject: Re: fbdev and power management
Date: Mon, 14 Jul 2003 22:11:43 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030714201143.GE902@elf.ucw.cz>
References: <Pine.LNX.4.44.0307090024170.32323-100000@phoenix.infradead.org> <1057750557.514.22.camel@gaston> <20030709151032.A22612@flint.arm.linux.org.uk> <20020105111340.GA2254@zaurus.ucw.cz> <1058200445.515.23.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out2.iol.cz ([194.228.2.87])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19c9gA-0007aF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Jul 2003 13:12:10 -0700
Content-Disposition: inline
In-Reply-To: <1058200445.515.23.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi!

> > > I'm slightly concerned by this.  There are a growing amount of drivers
> > > in 2.5 which are being made to work with the existing power management
> > > system.  This "new" system seems to have been hanging around for about
> > > 4 months now with no visible further work, presumably so that a paper
> > > can be presented before its release.
> > 
> > I believe it is bad idea to change driver
> > model again in 2.6.x-pre. I believe current
> > solution is pretty much okay.
> 
> Current solution is not okay and actually, the save_state/suspend
> distinction makes no sense. 
> We have designed a working solution
> a while ago now, Patrick has it implemented for month, it must
> get in now or 2.6 will not have proper power management but just
> "might work" kind of crap

save_state/suspend distinction may be irrelevant, but I don't see how
it makes whole current code "might work" kind of crap.

Can you describe some significant problem with current code? I do not
think it is good idea to have to touch all drivers in 2.6.0-test time
without some *good* reason.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
