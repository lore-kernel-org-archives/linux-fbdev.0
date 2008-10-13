From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] framebuffer: fix carminefb
	section mismatch
Date: Mon, 13 Oct 2008 10:41:44 +0200
Message-ID: <48F309C8.1060702@linutronix.de>
References: <48ED2431.40609@oracle.com>	<Pine.LNX.4.64.0810090927350.6769@anakin>	<48EE1ECF.6040707@oracle.com>
	<20081010132518.c6615b54.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bigeasy@linutronix.de>) id 1KpJdl-0002st-Kg
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Oct 2008 09:23:01 +0000
Received: from www.tglx.de ([62.245.132.106])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KpJbB-0004Z1-5z
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Oct 2008 09:23:01 +0000
In-Reply-To: <20081010132518.c6615b54.randy.dunlap@oracle.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, akpm <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Make alloc_carmine_fb() __devinit.
> 
> WARNING: drivers/video/carminefb.o(.text+0x81b): Section mismatch in reference from the function alloc_carmine_fb() to the variable .devinit.data:carminefb_fix
> The function alloc_carmine_fb() references
> the variable __devinitdata carminefb_fix.
> This is often because alloc_carmine_fb lacks a __devinitdata 
> annotation or the annotation of carminefb_fix is wrong.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> cc: Sebastian Siewior <bigeasy@linutronix.de>
Thx for the patch Randy. I see Andrew slipped it allready in his queue.

Sebastian

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
