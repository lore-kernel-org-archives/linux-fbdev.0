From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Re: [wx-dev] Linux GUI considerations
Date: Wed, 5 Feb 2003 21:13:19 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030205201318.GA1146@iliana>
References: <3E403C75.2DBCC9F8@bluewin.ch> <3E416980.2B2F85@bluewin.ch>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254] helo=mel-rto2.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18gVvL-0006DV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Feb 2003 12:13:35 -0800
Content-Disposition: inline
In-Reply-To: <3E416980.2B2F85@bluewin.ch>
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
To: Otto Wyss <otto.wyss@bluewin.ch>
Cc: wx-dev@lists.wxwindows.org, linux-fbdev-devel@lists.sourceforge.net

On Wed, Feb 05, 2003 at 08:44:00PM +0100, Otto Wyss wrote:
> > From: Julian Smart
> > I would certainly be keen to encourage better uptake of Linux through
> > use of wxWindows, but I have to take issue with the argument that
> > a framebuffer-based approach is going to help this. XFree86 has had years
> > of development and tweaking. Are you really saying that we could
> > write a better X11 replacement? Even if we did and managed to write
> > a 3rd super-duper desktop environment with all the required little apps,
> > we'd face a huge struggle in persuading people to use our particular
> > environment instead of X11.
> > 
> XFree86 has done a tremendous amount of effort. Still large part of this
> is simply spent in the wrong places. Instead of keeping writing directly
> to the hardware they should concentrate in building kernel drivers,
> maybe separate maybe together with the framebuffer people. Currently it

Well, remember that X don't run on just Linux, so i guess they are
afraid of duplicating the work, having to rewrite the driver for each OS
they run on. And as a X driver writer, i understand that concern.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
