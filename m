From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: vga softboot code repository
Date: Mon, 13 Sep 2004 12:06:10 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <9e473391040913090647737266@mail.gmail.com>
References: <Pine.GSO.4.58.0409041304080.3434@waterleaf.sonytel.be>
	 <413B4925.5000706@comcast.net> <200409060926.07163.adaplas@hotpop.com>
	 <413CC0EA.8070709@comcast.net>
	 <9e4733910409061402372095b1@mail.gmail.com>
	 <1094505860.31465.211.camel@admin.tel.thor.asgaard.local>
	 <9e47339104090707172cdc258d@mail.gmail.com>
	 <1094572321.6095.10.camel@admin.tel.thor.asgaard.local>
	 <9e47339104090722437b81b373@mail.gmail.com>
	 <4145C2D0.1080202@bitworks.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C6tLS-0003gV-6Q
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Sep 2004 09:06:22 -0700
Received: from rproxy.gmail.com ([64.233.170.198] helo=mproxy.gmail.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C6tLR-00067W-L5
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Sep 2004 09:06:22 -0700
Received: by mproxy.gmail.com with SMTP id 77so516539rnl
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 13 Sep 2004 09:06:19 -0700 (PDT)
In-Reply-To: <4145C2D0.1080202@bitworks.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

There is a big thread on lkml right now called radeon-pre-2. Alan Cox
is going to redesign the base fbdev and DRI layers.  This includes the
DOSEMU part for reset. I'd attach your issues to the end of that
thread so that Alan can see them.

This is the root of the thread
http://lkml.org/lkml/2004/9/10/206
There are about 100 messages in it. The part about the VGA driver is
at the very end.


On Mon, 13 Sep 2004 10:54:56 -0500, Richard Smith <rsmith@bitworks.com> wrote:
> Jon,
> 
> Reciently theres been a lot of talk on the LinuxBIOS list on the
> softbooting of vga cards and all the various forks there are of the
> x86emu code.  X, LinuxBIOS, DRI and probally a few others.  What works
> with what card, etc.
> 
> Its Egbert Eich's wish that we try to unify these things into a
> libsoftboot that all projects could use.  That way fixes and improvments
> will be shared by all rather than just each specific project.
> 
> A GNU Arch repository is being created on openbios.org to host
> developement.
> 
> You seem the be the man for the DRI x86emu.  Interested in trying to
> merge your stuff into the project?  I know that your ROM map and  setup
> stuff is quite different than X or LB but you still use basically the
> same core right?
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
> 



-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
