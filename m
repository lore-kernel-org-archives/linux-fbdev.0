From: jsimmons@pentafluge.infradead.org
Subject: Re: [PATCH][RIVAFB]: Updates to rivafb driver
Date: Tue, 15 Jun 2004 23:18:56 +0100 (BST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406152318040.4653@pentafluge.infradead.org>
References: <200406160406.07060.adaplas@hotpop.com> <20040615221710.GA24416@havoc.gtf.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaMGt-0006pb-AW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 15:19:11 -0700
Received: from [213.146.154.40] (helo=pentafluge.infradead.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BaMGo-00015P-Sb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 15:19:07 -0700
In-Reply-To: <20040615221710.GA24416@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: adaplas@pol.net, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


I wil give it a try tonight. I'm working on the riva driver as well. I got 
a oops in the i2c code. This is from the code in the fbdev-2.5 BK branch.

On Tue, 15 Jun 2004, David Eger wrote:

> 
> hey tony,
> 
> your patch against drivers/video/riva/fbdev.c chokes on hunk 2 when
> applied to 2.6.7-rc3-mm2.  resend, and i'll test it on my TNT2 :)
> 
> -dte
> 


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
