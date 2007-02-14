From: "Dave Airlie" <airlied@gmail.com>
Subject: Re: intelfb with 855GME and DVI?
Date: Wed, 14 Feb 2007 16:26:42 +1100
Message-ID: <21d7e9970702132126r537a2458t4e53eade7bf135ed@mail.gmail.com>
References: <Pine.LNX.4.64.0702130101030.16307@phoenix.arasphere.net>
	<21d7e9970702121733n2a6dc1d6wa2ad2afa03ce7af0@mail.gmail.com>
	<eqruu3$3s0$1@sea.gmane.org>
	<a728f9f90702130629g5e05865ayc787084bf1c0a165@mail.gmail.com>
	<eqst7l$sak$1@sea.gmane.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HHCfF-000712-J1 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Feb 2007 21:26:45 -0800
Received: from ug-out-1314.google.com ([66.249.92.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HHCfD-0001OX-TI
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Feb 2007 21:26:45 -0800
Received: by ug-out-1314.google.com with SMTP id z38so73704ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 13 Feb 2007 21:26:42 -0800 (PST)
In-Reply-To: <eqst7l$sak$1@sea.gmane.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

>
> >> Does that mean that a laptop display (Thinkpad) won't work either?
> >
> > correct.
>
> Well, that explains my problems then. :-)
>
> Shouldn't this be documented somewhere (like in Kconfig or
> Documentation/fb/intelfb.txt), or am I missing something obvious?
>
> And didn't the i810fb driver work with laptops?

No idea, I doubt it somehow, as there is no code to control the
external devices in either codebase, maybe i810 worked for some
reason,

maybe it should be documented, it does print it out when you boot that
it can't change the mode on non-CRT hardware..

Dave.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
