From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?commit_66c1ca_breaks_fbdev_mode_swi?= =?utf-8?q?tching?=
Date: 07 Apr 2009 08:11:36 +0200
Message-ID: <20090407061136.E94711BAC63__15490.4545787305$1239084928$gmane$org@f42.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Lr4XD-0006oh-To
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Apr 2009 06:11:47 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lr4XA-00021d-8H for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Apr 2009 06:11:47 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Andrea Righi <righi.andrea@gmail.com>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrey Borzenkov <arvidja>

Andrea Righi napisa=B3(a):
> On Mon, Apr 06, 2009 at 08:47:18PM +0200, Krzysztof Helt wrote:
> > Hi,
> > =

> > The commit 66c1ca breaks fbdev mode switching. The first mode
> > (selected with mode_option or during boot) is ok but every mode
> > switch with fbset locks up computer. If the commit is reverted
> > mode switching works correctly.
> > =

> > I do not understand why. I would be grateful if someone else
> > can confirm the problem as well.
> > =

> > The commit&#039;s details are:
> > =

> > commit 66c1ca019078220dc1bf968f2bb18421100ef147
> > Author: Andrea Righi >righi.andrea@gmail.com>
> > Date:   Tue Mar 31 15:25:18 2009 -0700
> > =

> >     fbmem: fix fb_info->lock and mm->mmap_sem circular locking
> dependency
> >     =

> > =

> > Regards,
> > Krzysztof
> =

> Any lockdep info or oops? it just locks up the system?
> =


It just locked up. I can try with more debug info enabled.

Regards,
Krzysztof

----------------------------------------------------------------------
10% zysku na lokacie bankowej z gwarancja BFG. Sprawdz!
http://link.interia.pl/f20fd


---------------------------------------------------------------------------=
---
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
