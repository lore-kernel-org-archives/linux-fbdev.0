From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [2.6.10-rc2] Regression in cursor code
Date: Sat, 20 Nov 2004 05:12:20 +0800
Message-ID: <200411200512.22249.adaplas@hotpop.com>
References: <20041119174542.GA5002@dreamland.darkstar.lan>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVGHY-0007fE-9Z
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 13:27:04 -0800
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CVGHU-0000XT-Ig
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 13:27:03 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8BA04769FB
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 21:26:43 +0000 (UTC)
In-Reply-To: <20041119174542.GA5002@dreamland.darkstar.lan>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net, Kronos <kronos@people.it>

On Saturday 20 November 2004 01:45, Kronos wrote:
> Hi,
> I just tried 2.6.10-rc2 and there's a regression in cursor code. The
> cursor disappear when I start a ncurses-based application and the switch
> to another console.
>
> Step to reproduce:
> 1) Start a ncurses application (like tin, mutt, alsamixer)
> 2) Switch vt: cursor is gone.
>
> With tin, mutt, alsamixer it's 100% reproducible. It doesn't happen with
> ViM though...
>
> I'm using radeonfb (new one) on a R300; I tried with and without X and
> it doesn't make any difference.
>
> I'm sorry that I can't be more precise about the bug but I'm very busy.
> I can try to track it down next week if it's needed.

Try 2.6.10-rc2-mm1 or apply this particular changeset:

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm5/broken-out/fbcon-disable-fbcon-cursor-if-vt-softcursor-is-enabled.patch

Tony




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
