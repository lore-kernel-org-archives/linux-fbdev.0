From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control
	with ATI Radeon display support on HP nx6125.
Date: Mon, 15 Oct 2007 23:17:56 +0200
Message-ID: <200710152317.57781.rjw@sisk.pl>
References: <bug-9155-10286@http.bugzilla.kernel.org/>
	<200710152232.35324.rjw@sisk.pl>
	<1192481864.11795.27.camel@pasglop>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IhX4n-0006RP-30 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Oct 2007 14:02:14 -0700
Received: from ogre.sisk.pl ([217.79.144.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IhX4k-0007Up-PT
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Oct 2007 14:02:12 -0700
In-Reply-To: <1192481864.11795.27.camel@pasglop>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Daniel =?iso-8859-15?q?W=FCrfel?= <daniel.wuerfel@gmx.net>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>

On Monday, 15 October 2007 22:57, Benjamin Herrenschmidt wrote:
> 
> On Mon, 2007-10-15 at 22:32 +0200, Rafael J. Wysocki wrote:
> > 
> > Thanks for having narrowed this, good job.
> > 
> > Now, the question is why the radeonfb compiled in statically has this effect.
> > 
> > Can you please attach your current .config to the bugzilla entry?
> 
> I don't have the beginning of an idea of why radeonfb would cause that
> indeed. (And especially not cause it when compiled as a module).

Me too, but I suspect an initialization ordering issue (or something along
these lines).

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
