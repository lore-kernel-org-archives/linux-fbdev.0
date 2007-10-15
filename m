From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control
	with ATI Radeon	display support on HP nx6125.
Date: Tue, 16 Oct 2007 06:57:44 +1000
Message-ID: <1192481864.11795.27.camel@pasglop>
References: <bug-9155-10286@http.bugzilla.kernel.org/>
	<200710142155.09345.rjw@sisk.pl> <1192468342.6249.9.camel@localhost>
	<200710152232.35324.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IhX1S-00063j-7C for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Oct 2007 13:58:46 -0700
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+J6s51zA0cr/fXOegVkc/iaTMH2ECO59A=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IhX1Q-0000yn-PP
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 15 Oct 2007 13:58:46 -0700
In-Reply-To: <200710152232.35324.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net, Daniel =?ISO-8859-1?Q?W=FCrfel?= <daniel.wuerfel@gmx.net>, linux-acpi@vger.kernel.org, bugme-daemon@bugzilla.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>


On Mon, 2007-10-15 at 22:32 +0200, Rafael J. Wysocki wrote:
> 
> Thanks for having narrowed this, good job.
> 
> Now, the question is why the radeonfb compiled in statically has this effect.
> 
> Can you please attach your current .config to the bugzilla entry?

I don't have the beginning of an idea of why radeonfb would cause that
indeed. (And especially not cause it when compiled as a module).

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
