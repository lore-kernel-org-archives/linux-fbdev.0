From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Framebuffer console not working with matroxfb on 2.6
Date: Thu, 16 Sep 2004 21:03:00 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409162103.00940.adaplas@hotpop.com>
References: <20040915060926.GM18257@uvt316-2.ruk.cuni.cz> <200409152111.49959.adaplas@hotpop.com> <20040916114258.GP18257@uvt316-2.ruk.cuni.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7vuV-00045b-00
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Sep 2004 06:02:51 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C7vuT-0006GQ-DM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 16 Sep 2004 06:02:50 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 2932383C075
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 16 Sep 2004 13:02:41 +0000 (UTC)
In-Reply-To: <20040916114258.GP18257@uvt316-2.ruk.cuni.cz>
Content-Disposition: inline
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
To: Michal 'hramrach' Suchanek <hramrach@centrum.cz>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, vandrove@vc.cvut.cz

On Thursday 16 September 2004 19:42, Michal 'hramrach' Suchanek wrote:
> On Wed, Sep 15, 2004 at 09:11:49PM +0800, Antonino A. Daplas wrote:
> > In matroxfb_accel.c:matroxfb_imageblit(), try changing this line:
> >
> > if (image->depth == 0)
> >
> > to
> >
> > if (image->depth == 1)
>
> May I ask what this change is suposed to do?

Because image->depth will never be equal to 0.  (The use of image->depth == 0
is long gone). Anyway, this will not explain why you don't have a console,
so my mistake.  However, matroxfb will always default to
unaccelerated imageblit with this test.  (Is matroxfb_imageblit broken?) To
use matroxfb's accelerated imageblit routine the test must be changed to

if (image->depth == 1)

Try changing it and compare the time with 'time cat /usr/src/linux/MAINTAINERS'
with and without that minor change.

(Petr, this is probably the reason why copyarea is always fast with your
driver.  Most of the time, I find that imageblit > copyarea if y-pan is
disabled, copyarea > imageblit if y-pan is enabled, and imageblit > copyarea
if acceleration is disabled, whether y-pan is enabled or not.)
 
> As already explained the driver works if compiled into kernel as opposed
> to loading it as a module. This change seems too small to fix module
> loading :)
>

This particular problem (xxxfb == module and fb console != module resulting
to no console) is not specific to matroxfb. This bug/regression should be
fixed in 2.6.9-rc2 or 2.6.9-rc1-mm5.

Tony 




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
