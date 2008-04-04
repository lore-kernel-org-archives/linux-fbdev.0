From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [PATCH 0/4 2.6.24] fbdev: metronomefb and
	hecubafb bugfix and platforming
Date: Thu, 03 Apr 2008 21:03:19 -0400
Message-ID: <20080404010318.17144.4354.sendpatchset@hit-nxdomain.opendns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JhbFG-00036V-I0 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 19:01:34 -0700
Received: from qb-out-0506.google.com ([72.14.204.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JhbFF-0003uT-05
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 03 Apr 2008 19:01:34 -0700
Received: by qb-out-0506.google.com with SMTP id a33so2038141qbd.0
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 03 Apr 2008 19:01:31 -0700 (PDT)
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, Jaya Kumar <jayakumar.lkml@gmail.com>

Hi Tony, Geert, Andrew, fbdev,

This patchset has 4 patches. They are:

1 - bugfix for metronomefb
2 - bugfix for hecubafb
3 - platforming metronomefb
4 - platforming hecubafb

The improvement over the last post is that the bugfixes are split into
individual patches.

I would be grateful for any feedback on this.

Thanks,
jaya


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
