From: Theodore Kilgore <kilgota@banach.math.auburn.edu>
Subject: Re: aty128fb problems on iMac, kernel 2.8.1
 (fwd)
Date: Thu, 23 Sep 2004 10:22:35 -0500 (CDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409231007460.3894@banach.math.auburn.edu>
References: <Pine.GSO.4.61.0409231022110.7127@waterleaf.sonytel.be>
 <20040923113148.GA8333@uvt316-2.ruk.cuni.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAW3Z-0005qL-GQ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 09:02:53 -0700
Received: from banach.math.auburn.edu ([131.204.45.3])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CAW3X-0007Pq-Ra
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Sep 2004 09:02:53 -0700
In-Reply-To: <20040923113148.GA8333@uvt316-2.ruk.cuni.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

No time to reply to both messages, but this is to let you know I am still
here.


> Does it give the error messages during compilation or during module
> loading?

Both. At this point I _did_ try installing and using the module.

> If during module loading, you are probably missing some additional
> module.

Easily possible, but which one in that case? That brings up the question
of exactly what I _do_ need. Some examples (all of which are currently
thre, to be loaded as modules -- see discussion below about what chip is
there)

agpgart
r128
(the above under "Character devices" but the system ignores them)

and under Video

framebuffer support
aty128fb suport
(and the following again I have no idea if they are needed, or not)
aty support
radeon support
and then there are three different kinds of Apple support --palatinum and
Valkyrie and something else, and I have no idea of the relevance or
irrelevance of these, either)

I guess you can see  that one of the problems is that I am proceeding by
guesswork, because I cannot seem to find any relevant documentation which
would provide a roadmap. For example, does the AGP support have anything
at all to do with the price of eggs in China, on a system like mine? Or
are AGP support and framebuffer support sort of orthoghonal to one
another? I don't know and there does not seem to be any place to find out.

> I had no problem with 2.6.7 kernel but I compiled the ati framebuffer
> directly into kernel to get some usable console from the start.

A possibility. But I have no problem to get a usable text console and
fbset does report a setting if one runs it. And BTW I can get a lousy X
support by choosing for my drivers "vga" and "fbdev" (though with lots of
artifacts which will disappear if one does some VT-flipping, which seems
to release and reset something).

> I cannot curruntly say what exact ati chip the iMac has

Well, I could. But I am not in front of the machine, either. It is at home
and I am at work. I can only quote what I vaguely remember from lspci
output, at this point:

(paraphrasing) it says it has an Ati Rage 128 running as an AGP 4X card.

or what was my
> kernel config because it is running OS X right now and I am not
> physically at the machine.
> You should definitely try to compile the aty128fb into kernel to avoid
> problems with current fbcons.
>
a possibility. Byt as I understand the module is supposed to work and to
be automatically loaded by X?

> If you cannot solve the problem I can look at my config later. It would
> run X fine.
>
As far as my ignorant mind can see, the problem is not in X nor in the X
configuration. I could be wrong, of course.

Theodore Kilgore


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
