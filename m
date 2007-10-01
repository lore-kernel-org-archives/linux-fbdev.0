From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 0/6] Patch series to add of_platform
	binding to xilinxfb
Date: Mon, 01 Oct 2007 09:57:27 -0600
Message-ID: <20071001155024.6114.47993.stgit@trillian.cg.shawcable.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcNfI-0003wC-NH for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 08:58:37 -0700
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]
	helo=pd4mo3so.prod.shaw.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IcNfG-00036n-JB
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 08:58:36 -0700
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JP8001EWPNT29A0@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:57:29 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP800C4TPNTUA20@pd2mr6so.prod.shaw.ca> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:57:29 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004)) with ESMTP id <0JP800456PNSBL24@l-daemon> for
	linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 09:57:28 -0600 (MDT)
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
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, akonovalov@ru.mvista.com, linuxppc@ozlabs.org, adaplas@gmail.com

(resend due to mailer issues.  Apologies to anyone receiving this twice)

This patch series reworks the Xilinx framebuffer driver and then adds
an of_platform bus binding.  The of_platform bus binding is needed to use
the driver in arch/powerpc platforms.

Antonino,

Assuming there are no major issues, I'd like to get this patch series
queued up for inclusion in 2.6.24.

Thanks,
g.

--
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
