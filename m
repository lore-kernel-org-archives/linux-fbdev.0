From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: small radeon frame buffer issues
Date: Mon, 11 Apr 2005 09:17:02 +1000
Message-ID: <1113175022.9518.512.camel@gaston>
References: <200504101159.36819.post@hendrik-sattler.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DKlhx-00080U-5F
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 16:19:13 -0700
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DKlhs-00050m-Ii
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Apr 2005 16:19:13 -0700
In-Reply-To: <200504101159.36819.post@hendrik-sattler.de>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>

On Sun, 2005-04-10 at 11:59 +0200, Hendrik Sattler wrote:
> Hi,
> 
> I write this to you because you are also in the MAINTAINERS file for 
> linux-2.6.11.
> I have some issues with the radeonfb, rather minor but I want to tell you 
> anyways. I am not subscribed to the list, so please CC me when answering.
> 
> 1.
> RADEON FRAMEBUFFER DISPLAY DRIVER
> P:      Ani Joshi
> M:      ajoshi@shell.unixbox.com
> is unreachable. The file should be updated.

Indeed, Andrew, please put that in -mm:

This patch does the long overdue updates to MAINTAINERS file for
aty128fb and radeonfb.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/MAINTAINERS
===================================================================
--- linux-work.orig/MAINTAINERS	2005-04-05 14:22:32.000000000 +1000
+++ linux-work/MAINTAINERS	2005-04-11 09:14:58.000000000 +1000
@@ -1860,14 +1860,14 @@
 S:	Maintained
 
 RADEON FRAMEBUFFER DISPLAY DRIVER
-P:	Ani Joshi
-M:	ajoshi@shell.unixbox.com
+P:	Benjamin Herrenschmidt
+M:	benh@kernel.crashing.org
 L:	linux-fbdev-devel@lists.sourceforge.net
 S:	Maintained
 
 RAGE128 FRAMEBUFFER DISPLAY DRIVER
-P:	Ani Joshi
-M:	ajoshi@shell.unixbox.com
+P:	Paul Mackerras
+M:	paulus@samba.org
 L:	linux-fbdev-devel@lists.sourceforge.net
 S:	Maintained
 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
