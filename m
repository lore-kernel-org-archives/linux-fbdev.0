From: James Simmons <jsimmons@infradead.org>
Subject: Re: 2.5 atyfb on Sparc question
Date: Thu, 8 Aug 2002 11:19:46 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208081118440.15229-100000@maxwell.earthlink.net>
References: <20020808182142.93437.qmail@web13007.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17cryK-0006M3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Aug 2002 11:25:20 -0700
In-Reply-To: <20020808182142.93437.qmail@web13007.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Monoses <jani@iv.ro>
Cc: bruce.holzrichter@monster.com, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > > I push stuff. The next set of patches will break
> > alot
> > > of drivers but I need to do this to get people to
> > port
> > > there stuff over to the new api.
> >
> > Could you outline what the next set of patches will
> > change?

Oops. The next patch will remove get_fix and get_var. Also the internal
fbdev code will begin using the var and fix feilds in struct fb_info.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
