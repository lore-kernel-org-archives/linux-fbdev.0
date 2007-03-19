From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8232] New: Creator3D
 Framebuffer (sparc64) on Sbus/UPA workstation
Date: Mon, 19 Mar 2007 03:34:25 -0800
Message-ID: <20070319033425.b0be2d95.akpm@linux-foundation.org>
References: <200703191019.l2JAJVH5018137@fire-2.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HTG98-0005Lp-D1 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 04:35:26 -0700
Received: from smtp.osdl.org ([65.172.181.24])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HTG97-0000nI-UF
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Mar 2007 04:35:26 -0700
In-Reply-To: <200703191019.l2JAJVH5018137@fire-2.osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Cc: mt1@systella.fr, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>

On Mon, 19 Mar 2007 03:19:31 -0700 bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=8232
> 
>            Summary: Creator3D Framebuffer (sparc64) on Sbus/UPA workstation
>     Kernel Version: ALL 2.6
>             Status: NEW
>           Severity: normal
>              Owner: jsimmons@infradead.org
>          Submitter: mt1@systella.fr
> 
> 
> Most recent kernel where this bug did *NOT* occur: 2.4.34.1
> Distribution: Debian/testing
> Hardware Environment: U1E/170 with Creator3D (UPA), U2 with creator3D
> Software Environment: debian without X on U1E, debian with Xorg on U2
> Problem Description: Console is white foreground and blanck background by
> default. Sometimes, the screen is cut like this :
> 
> N | N | N | N
> --+---+---+---
> N | G | G | G
> --+---+---+---
> N | W | W | W
> --+---+---+---
> N | G | G | G
> 
> 
> where N is a 'normal' console, 'G' a 'like grey' console (black and white pixels
> like snow), and 'W' a white console (many white pixels). I have tested some
> differents Creator3D fb and this trouble only occurs on Sbus/UPA workstation. On
> a U60 (PCI/UPA), I never see it.
> 
> When I launch Xorg, problem goes away.
> 
> Sometimes, on the same configuration, when X is running, console is not usable
> because foreground _and_ background are black (and a signal is given by the
> framebuffer, screen remains on).
> 
> Steps to reproduce: U1 or U2 with 2.6 kernel and Creator3D fb on UPA Slot.
> I have tested with Creator3D Rev1.
> 
> Regards,
> 
> JKB
> 
> ------- You are receiving this mail because: -------
> You are on the CC list for the bug, or are watching someone who is.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
