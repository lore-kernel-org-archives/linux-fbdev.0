From: James Simmons <captain_delete@yahoo.com>
Subject: Re: Re: new api example or docs ?
Date: Mon, 5 Aug 2002 23:26:44 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020806062644.76953.qmail@web13007.mail.yahoo.com>
References: <20020805080411.GA1204@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web13007.mail.yahoo.com ([216.136.174.17])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17bxno-0003n5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 05 Aug 2002 23:26:44 -0700
In-Reply-To: <20020805080411.GA1204@iliana>
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
Content-Transfer-Encoding: 7bit
To: Sven LUTHER <luther@dpt-info.u-strasbg.fr>, Jani Monoses <jani@iv.ro>
Cc: linux-fbdev-devel@lists.sourceforge.net


> > It also help with power management..
> 
> Well, but i thought the skeletonfb was to be used as
> a model/skeleton/guide
> to creating a new framebuffer device.

It is but it is a very primitive model. Especially for
pci based cards. Alot of extra code is needed.

> So it should include this as well, should it not ?

The reason I didn't included it was because alot of
fbdev drivers are not PCI based. Maybe I should add
this pseudo code? 



__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
