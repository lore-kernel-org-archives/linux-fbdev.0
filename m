From: Eric Anholt <eta@lclark.edu>
Subject: DRM and pci_driver conversion
Date: Mon, 20 Oct 2003 19:31:56 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1066703516.646.24.camel__10617.616287391$1066713459@leguin>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ABorG-000754-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Oct 2003 22:15:03 -0700
Received: from paclaw.org ([149.175.1.5] helo=lewis.lclark.edu)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1ABoNc-0005Ay-NL
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 20 Oct 2003 21:44:24 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

I recently committed a change to the DRM for Linux in DRI CVS that
converted it to use pci_driver and that probe system.  Unfortunately,
we've found that there is a conflict between the DRM now and at least
the radeon framebuffer.  Both want to attach to the same device, and
with pci_driver, the second one to come along doesn't get probe called
for that device.  Is there any way to mark things shared, or in some
other way get the DRM to attach to a device that's already attached to,
in the new model?

Please CC me on replies as I'm not subscribed to these lists.

-- 
Eric Anholt                                eta@lclark.edu          
http://people.freebsd.org/~anholt/         anholt@FreeBSD.org




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
