From: David Eger <eger@havoc.gtf.org>
Subject: Re: Mach64 GX driver problems in post 2.4.22 kernels
Date: Wed, 23 Jun 2004 14:31:33 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040623183133.GA9205@havoc.gtf.org>
References: <20040605185647.GG5668@mercury.jahnsnet.de> <20040606104530.GA2231@mercury.jahnsnet.de> <20040618094852.GA9466@mercury.jahnsnet.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BdCX7-0002WL-PA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:31:41 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BdCX7-0007s4-El
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 23 Jun 2004 11:31:41 -0700
Content-Disposition: inline
In-Reply-To: <20040618094852.GA9466@mercury.jahnsnet.de>
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
Content-Transfer-Encoding: 7bit
To: Thomas Jahns <Thomas.Jahns@epost.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

Dear Thomas,

> my problem of non-working display with atyfb and a Mach64 GX card in a  
> Powermac 7500 is still unsolved and my posting here got no replies.
> 

James just posted a framebuffer update against 2.6.7 that he says
includes Mach64 updates. It looks like he did a lot of cleanup, and
possibly some logical changes -- you might try his patch and let him/us
know if it's any help.

his patch: http://www.infradead.org/~jsimmons/changes.diff

-dte



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
