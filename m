From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 11:32:51 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207051123240.25589-100000@www.transvirtual.com>
References: <20020705185754.C27920@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QXt6-0000N9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 11:33:00 -0700
In-Reply-To: <20020705185754.C27920@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> >     We pretty much have this today. Each driver has so much excess code
> > because they want to create their own special structs. Lost of bloat for
> > no reason! I will NOT put up with that anymore!!!! Sorry!
>
> James, you're OTT here.

I apologize I'm sorry. I did get upset. Its just this has been discussed
time and time again. It gets annoying after awhile and it stopped me from
completing the fbdev changes in the last development series. I don't want
that again.

> It's part of the deal.  Either you allow driver writers to cleanly code
> the way they see fit, or you take over maintainence of those drivers.
> You break it, you fix it.  What's it to be?

I'm not going to fight with you about it. I can revert the changes back to
the way you had it before if you want.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
