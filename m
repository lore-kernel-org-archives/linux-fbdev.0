From: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: Re: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 12:29:15 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.BSF.4.44.0207051222060.63178-100000@shell.unixbox.com>
References: <Pine.LNX.4.44.0207051123240.25589-100000@www.transvirtual.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from shell.unixbox.com ([207.211.45.65])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QYYo-0005Li-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 12:16:06 -0700
In-Reply-To: <Pine.LNX.4.44.0207051123240.25589-100000@www.transvirtual.com>
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
To: James Simmons <jsimmons@transvirtual.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Hi James,

On Fri, 5 Jul 2002, James Simmons wrote:

> > It's part of the deal.  Either you allow driver writers to cleanly code
> > the way they see fit, or you take over maintainence of those drivers.
> > You break it, you fix it.  What's it to be?
>
> I'm not going to fight with you about it. I can revert the changes back to
> the way you had it before if you want.

If you are going to back out the changes you did to RK's drivers could you
please also back out the changes you made to my drivers?  Specifically I
noticed several changes done to rivafb which introduce a riva_par, which I
also don't like to use in my drivers.  My drivers share a very common
structure and I'd like to keep it that way.  I'm not sure if you have done
any changes to the other drivers (radeonfb or aty128fb) but if you could
please backout your changes to rivafb that would be nice.  I will try my
best to free up some time next week and fixup the drivers to go along with
this new API.

The reason I haven't done so yet is that it seems from the traffic on
the list, this "new API" its somewhat of a changing theory so far and its
not yet defined well.  I haven't noticed any other driver maintainers
updating their drivers to this new API (if they are, perhaps I'm looking
at the wrong places) so I am hessitant to do this as it seems its still
'iffy' if this work will actually go into the mainline kernel.  Could
someone please clear up the confusion about this?


Thank you,

ani



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
