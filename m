From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: fbdev upstream
Date: Tue, 06 Jan 2004 12:03:27 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1073351006.780.200.camel@gaston>
References: <Pine.LNX.4.44.0401060049180.7347-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdfeS-0002Mt-Ab
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 17:04:56 -0800
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AdfeR-0008NI-JR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 17:04:56 -0800
In-Reply-To: <Pine.LNX.4.44.0401060049180.7347-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: John Zielinski <grim@undead.cc>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2004-01-06 at 11:51, James Simmons wrote:
> > Of course, that means we'll have to update more drivers, and platforms
> > with fixed display, like embedded etc... will need some way to deal
> > with that properly in their drivers.
> 
> Fixed screen size drivers should provide there own modedb. 

Or just single mode... currently drivers don't export a modedb, they
keep one internally and do the validation... though it would make sense
to expose a modedb to userland, so we can have some nice GUI tools
showing you the available modes :) It would make sense for MacOnLinux
too which currently rely on the user to setup the list of modes
available to MacOS.

> > I don't know about that one. It would be interesting to redo some
> > comparison between XFree CVS "nv" driver and rivafb. I don't have any
> > nvidia HW at hand for now though. 
> 
> The changes have been alot. It would require me reworking the driver 
> again.

Heh, been there, done that in 2.4... quite painful indeed. We can
probably first get what we have merged upstream now, and think about
it later...

> > Also, we just completely lack proper locking, we should at least take
> > the console semaphore around all these operations, which we don't do
> > and thus are racy as hell... the HW cursor and blanking timers are
> > by definition racy too, we need to fix that some way.
> 
> The fbcon system has always lacked locking :-( Now it can be fixed.
> k
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
