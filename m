From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New fbdev updates.
Date: Fri, 4 Jul 2003 13:46:08 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030704114608.GB1085@dreamland.darkstar.lan>
References: <Pine.LNX.4.44.0307031847570.16727-100000@phoenix.infradead.org> <20030703235039.GB502@phunnypharm.org>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19YP10-0005FB-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Jul 2003 04:46:11 -0700
Content-Disposition: inline
In-Reply-To: <20030703235039.GB502@phunnypharm.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Ben Collins <bcollins@debian.org>

Il Thu, Jul 03, 2003 at 07:50:39PM -0400, Ben Collins ha scritto: 
> >    I have updates to the framebuffer layer. Alot of bug fixes accumlated. 
> > A couple of driver updates as well. I have more code to go in but haven't 
> > had time to add them in. Please test. This is not the final code going in 
> > just yet. More needs to be done. The patches are at the usual
> 
> Seems my old corrupt cursor is fixed, but with your new code I am
> getting ghost cursors left behind while moving around in vim over ssh
> with syntax on.

Same here. I can see the ghost cursor also when typing fast on the shell
(via ssh) and the hit backspace, arrows, home, end. I don't see it using
normal tty (the kernel is the same, I just did ssh ::1).

Btw, the cursor doesn't disappear  anymore switching back and forth from
X.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
It can't rain forever,
but you can die before seeing the sun again.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
