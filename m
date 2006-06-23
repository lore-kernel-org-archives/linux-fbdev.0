From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [GIT PATCH] Geode patches for 2.6.17
Date: Fri, 23 Jun 2006 11:00:58 -0600
Message-ID: <20060623170058.GA12819@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ftox5-0003Da-9O for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 09:56:15 -0700
Received: from outbound-fra.frontbridge.com ([62.209.45.174]
	helo=outbound1-fra-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Ftox2-0000gi-7d
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 Jun 2006 09:56:15 -0700
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linux-fbdev-devel@lists.sourceforge.net

Hi - 

Please consider pulling from:
git://git.infradead.net/users/jcrouse/geode.git linus-upstream

This is the new home for patches for the AMD Geode family of processors.

For 2.6.18, we offer up patches to support the One Laptop
Per Child effort - namely framebuffer tweaks, plus an attempt to remove
automagic probing of VGA registers (which we don't have on the OLPC
platform).

Here is the shortlog:

Jordan Crouse:
      GEODE: Update and fixup the PCI IDs for the CS5535
      FB: Get the Geode GX frambuffer size from the BIOS
      Add a configuration option to avoid automatically probing VGA
      gxfb: Fixups for the AMD Geode GX framebuffer driver

--
Jordan Crouse
Senior Linux Engineer
Advanced Micro Devices, Inc.
<www.amd.com/embeddedprocessors>



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
