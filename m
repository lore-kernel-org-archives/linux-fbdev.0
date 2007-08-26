From: Michal Januszewski <spock@gentoo.org>
Subject: Re: [PATCH] uvesafb: select connector in	Kconfig
Date: Sun, 26 Aug 2007 11:35:44 +0200
Message-ID: <20070826093544.GA4865@spock.one.pl>
References: <20070825085931.GA9318@spock.one.pl>
	<20070825082341.e939e38e.randy.dunlap@oracle.com>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPEXI-00010s-7X for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 02:36:00 -0700
Received: from 219.63.79.83.cust.bluewin.ch ([83.79.63.219] helo=spock.one.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPEXG-0007vC-PJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 02:36:00 -0700
Content-Disposition: inline
In-Reply-To: <20070825082341.e939e38e.randy.dunlap@oracle.com>
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
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, Aug 25, 2007 at 08:23:41AM -0700, Randy Dunlap wrote:

> There are 2 problems with this.
> 
> a.  CONNECTOR depends on NET, but select won't enable NET, so if
> NET is not enabled otherwise, CONNECTOR still won't build.
> This is a longstanding select/kconfig issue.
> 
> b.  CONNECTOR depends on NET, so if select did follow the depends
> chain and enable NET, it would be enabling the networking subsystem,
> which is something that should not be done quietly.
> 
> select should only be used for enabling small library-like code
> (if even then).  Avoid it whenever possible.

OK, thanks for pointing this out.  Let's keep the original dependency
on CONNECTOR then.

Best regards,
Michal

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
