From: Tobias Jakobi <liquid.acid@gmx.net>
Subject: Re: [Bugme-new] [Bug 13509] New: VT switch
	causes system to lockup
Date: Fri, 12 Jun 2009 10:38:44 +0200
Message-ID: <4A321414.20703@gmx.net>
References: <bug-13509-10286@http.bugzilla.kernel.org/>
	<20090611160424.fd597dce.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liquid.acid@gmx.net>) id 1MF2KC-0006m2-3j
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Jun 2009 08:41:24 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 29vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MF2Iw-0006dM-Uz for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Jun 2009 08:41:23 +0000
In-Reply-To: <20090611160424.fd597dce.akpm@linux-foundation.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, bugzilla-daemon@bugzilla.kernel.org, Michal Januszewski <spock@gentoo.org>, bugme-daemon@bugzilla.kernel.org, jb.faq@gmx.de

Andrew Morton wrote:
> 
> hm, 2.6.27->2.6.30 is a large hop.
Hi Andrew!

Yeah, I know. I was going to build a 2.6.29 though, since the fglrx
driver seems to have some problems with the 30 one.
I'm going to check then if the problem also occurs with 29.


> 
> Perhaps you were using vesafb in 2.6.27 and you're now using uvesafb?
> 
Nope, I can assure you that. :)
The 27 kernel has uvesafb activated and is also using it. In fact I just
used make oldconfig to port the 27 config over to 30 (I'm not using any
distro tools for kernel compiling, just plain make).

Greets,
Tobias

------------------------------------------------------------------------------
