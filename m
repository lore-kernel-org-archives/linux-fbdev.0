From: David Eger <eger@havoc.gtf.org>
Subject: Re: [PATCH][RIVAFB]: Updates to rivafb driver
Date: Tue, 15 Jun 2004 18:17:10 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040615221710.GA24416@havoc.gtf.org>
References: <200406160406.07060.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaMFO-0006Q8-QE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 15:17:38 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaMFO-000070-EE
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 15:17:38 -0700
Content-Disposition: inline
In-Reply-To: <200406160406.07060.adaplas@hotpop.com>
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
To: adaplas@pol.net
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


hey tony,

your patch against drivers/video/riva/fbdev.c chokes on hunk 2 when
applied to 2.6.7-rc3-mm2.  resend, and i'll test it on my TNT2 :)

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
