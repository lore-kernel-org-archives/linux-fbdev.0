From: James Simmons <jsimmons@infradead.org>
Subject: Re: request_mem_region problem ...
Date: Fri, 1 Nov 2002 15:23:29 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211011522190.11313-100000@maxwell.earthlink.net>
References: <20021101184307.GA356@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 187kJ3-0000cr-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 01 Nov 2002 14:30:21 -0800
In-Reply-To: <20021101184307.GA356@iliana>
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
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Antonino Daplas <adaplas@pol.net>, fbdev <linux-fbdev-devel@lists.sourceforge.net>


> > > You're correct, the neofb line in the Makefile is for static building
> > > only.  The cfb_xxx will not compile as modules, yet.  If your driver has
> > > its own Makefile, just add cfb_xxx.o objects to directly link to them.
> >
> > In the next set of changes the cfb* files should be able to be built as
> > modules!!!!
>
> The ones in the patches you failed to send or the one thereafter ?

None of them. Still in local tree. I will be sending up stuff in the next
few minutes.

> BTW, do you think the latest set of changes will be in 2.4.46 or
> something such ?

I hope so. I do know they are going in. When is the question. I don't mind
the deal since that means I can fix more things.



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
