From: James Simmons <captain_delete@yahoo.com>
Subject: Re: 2.5 atyfb on Sparc question
Date: Tue, 6 Aug 2002 09:06:48 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020806160648.63207.qmail@web13001.mail.yahoo.com>
References: <61DB42B180EAB34E9D28346C11535A780112F965@nocmail101.ma.tmpw.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web13001.mail.yahoo.com ([216.136.174.11])
	by usw-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17c6rA-0006L8-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 06 Aug 2002 09:06:48 -0700
In-Reply-To: <61DB42B180EAB34E9D28346C11535A780112F965@nocmail101.ma.tmpw.net>
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
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>, "'linux-fbdev-devel@lists.sourceforge.net'" <linux-fbdev-devel@lists.sourceforge.net>


> Quick question..  I was wondering if there is still
> a bk tree for fbdev
> work, or are you pushing direct to Linus?
> 
> I am getting the following errors when compiling on
> a sparc64 machine from
> the latest BK 2.5 tree, and was wondering if a fix
> may already be around.  I
> am not subscribed to this list, but a quick search
> didn't turn up anything.
> Thanks in advance..

Yes. I received a fix. I added to my BK repository but
I need to work on the driver a little bit more before
I push stuff. The next set of patches will break alot
of drivers but I need to do this to get people to port
there stuff over to the new api.

__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
