From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: Re: [PATCH] fbdev updates.
Date: Fri, 5 Jul 2002 12:32:57 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207051228510.30731-100000@www.transvirtual.com>
References: <Pine.BSF.4.44.0207051222060.63178-100000@shell.unixbox.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17QYpI-0007DG-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 05 Jul 2002 12:33:08 -0700
In-Reply-To: <Pine.BSF.4.44.0207051222060.63178-100000@shell.unixbox.com>
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
To: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> If you are going to back out the changes you did to RK's drivers could you
> please also back out the changes you made to my drivers?  Specifically I
> noticed several changes done to rivafb which introduce a riva_par, which I
> also don't like to use in my drivers.  My drivers share a very common
> structure and I'd like to keep it that way.  I'm not sure if you have done
> any changes to the other drivers (radeonfb or aty128fb) but if you could
> please backout your changes to rivafb that would be nice.  I will try my
> best to free up some time next week and fixup the drivers to go along with
> this new API.

I did change aty128fb.c. Okay I will revert all the changes I have done.
No more lower level drivers for me.

> The reason I haven't done so yet is that it seems from the traffic on
> the list, this "new API" its somewhat of a changing theory so far and its
> not yet defined well.

It has been in the works for over a year. In CVS, has been tested and even
documented. Been discussed on the mailing list.

I haven't noticed any other driver maintainers
> updating their drivers to this new API (if they are, perhaps I'm looking
> at the wrong places) so I am hessitant to do this as it seems its still
> 'iffy' if this work will actually go into the mainline kernel.  Could
> someone please clear up the confusion about this?

It is and has started to got into the mainline kernel. The thing was I was
bending over backwards to not break peoples drivers.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
