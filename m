From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev: find mode with
	highest	refresh rate in fb_find_mode()
Date: Mon, 27 Aug 2007 06:49:33 +0800
Message-ID: <1188168573.4806.5.camel@daplas>
References: <20070718084102.GA22694@spock.one.pl>
	<20070718143803.GA5787@localhost.localdomain>
	<1184771895.4523.33.camel@daplas> <20070826190913.GA24286@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPQw0-00088X-KP for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 15:50:23 -0700
Received: from qb-out-0506.google.com ([72.14.204.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPQw0-0006Uv-BQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 15:50:20 -0700
Received: by qb-out-0506.google.com with SMTP id c8so1547287qbc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 15:50:19 -0700 (PDT)
In-Reply-To: <20070826190913.GA24286@spock.one.pl>
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
To: spock@gentoo.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, 2007-08-26 at 21:09 +0200, Michal Januszewski wrote:
> On Wed, Jul 18, 2007 at 11:18:15PM +0800, Antonino A. Daplas wrote:
> 
> How about modifying it so that it looks for a mode with the highest
> refresh rate if either a non-generic modedb is used or
> info.monspecs.{vfmin,vfmax,hfmin,hfmax,dclkmax} are all non-zero,
> and for a mode with refresh rate closest to 60 Hz otherwise?

I would opt for combining the two, return the highest refresh rate only
if the modedb was built by the driver and with the mode checked against
the display's operating limits.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
