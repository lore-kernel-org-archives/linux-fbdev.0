From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: 2.5 atyfb on Sparc question
Date: Thu, 8 Aug 2002 20:51:08 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1730A970D4F@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from zikova.cvut.cz ([147.32.235.100])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17csNu-0004Bf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 08 Aug 2002 11:51:46 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: bruce.holzrichter@monster.com, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On  8 Aug 02 at 11:32, James Simmons wrote:
> > On  8 Aug 02 at 11:16, James Simmons wrote:
> > > > I also hope that performance problems will be solved
> > > > before we are
> > > > forced to not use putcs.
> > >
> > > It will be :-) I need to one align the data. Second I
> > > plan to implement the patch recently posted here.
> >
> > Patch still showed about 100% slowdown against 2.4.x, if I interpreted
> > yesterday's table correctly. It is better than 1000% slowdown, but still...
> 
> I could believe a slow down of 2x but 1000 I don't think so.

Message from Antonio Daplas
(http://www.geocrawler.com/lists/3/SourceForge/9276/0/9249087/)
says:
2.5 old (with offscreen buffers) 10.708
2.5 new                           4.378
2.4                               2.098

His first message 
(http://www.geocrawler.com/lists/3/SourceForge/9276/25/9237029/)
listed 13.586 for old 2.5 code.

So you are right, old code was not 1000% slowdown, only 500%. But main
problem is not speed of old code, but speed of new code. And if numbers
are right, new code is still 100% slower than 2.4.x code was.
                                                Petr Vandrovec
                                                


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
