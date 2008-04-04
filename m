From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [PATCH 0/4 2.6.24] fbdev: metronomefb and
	hecubafb bugfix and platforming v4
Date: Fri, 04 Apr 2008 08:23:59 -0400
Message-ID: <20080404122358.6404.54652.sendpatchset@hit-nxdomain.opendns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jhls7-00044n-OM for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 06:22:23 -0700
Received: from yw-out-1718.google.com ([74.125.46.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jhls6-0007kF-45
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 04 Apr 2008 06:22:23 -0700
Received: by yw-out-1718.google.com with SMTP id 4so7401ywq.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 04 Apr 2008 06:22:15 -0700 (PDT)
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

This is version4 of the metronomefb and hecubafb bugfix and platforming
patchset. It has 4 patches, which are as follows:

1 - bugfix for metronomefb
2 - bugfix for hecubafb
3 - platforming metronomefb
4 - platforming hecubafb

The improvement over v2 is that the bugfixes are split into
individual patches and that the Kconfig/Makefile changes for hecubafb
are moved in patch 4 (as they should be) rather than patch 3. Thanks Geert.

I would be grateful for any feedback on this.

Thanks,
jaya


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
