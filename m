From: David Eger <eger@havoc.gtf.org>
Subject: Re: [PATCH 3/3][FBDEV]: Set capabilities flag for vesafb and vga16fb
Date: Tue, 6 Jul 2004 01:35:45 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040706053545.GA2375@havoc.gtf.org>
References: <200407060634.43963.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BhicW-0006Qp-VC
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 22:35:56 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BhicW-0006FQ-MI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jul 2004 22:35:56 -0700
Content-Disposition: inline
In-Reply-To: <200407060634.43963.adaplas@hotpop.com>
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
Cc: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Thanks for getting these; I've been lazy and not gotten to them.

I do want FBINFO_FLAG_DEFAULT to go away though... it's now
FBINFO_DEFAULT.  I also don't see anything in vga16fb that precludes
FBINFO_HWACCEL_XPAN, though I don't see anyone who uses that flag,
either.  *shrug*

The big performance patch also looks like good work, though I've
not tested it.  Thanks :)

-dte


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
