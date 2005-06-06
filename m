From: James Simmons <jsimmons@www.infradead.org>
Subject: New pci id for chipsfb
Date: Mon, 6 Jun 2005 20:39:06 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506062037270.18266@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfNRI-0004pa-OO
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:39:12 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DfNRG-0007vf-14
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 06 Jun 2005 12:39:12 -0700
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Signed-off-by: James Simmons <jsimmons@www.infradead.org>

Patch adds pci ID for CT 69000 chipset.

--- linus-2.6/include/linux/pci_ids.h	2005-06-04 10:33:42.000000000 -0700
+++ fbdev-2.6/include/linux/pci_ids.h	2005-06-06 12:15:12.000000000 -0700
@@ -575,6 +575,7 @@
 #define PCI_DEVICE_ID_CT_65550		0x00e0
 #define PCI_DEVICE_ID_CT_65554		0x00e4
 #define PCI_DEVICE_ID_CT_65555		0x00e5
+#define PCI_DEVICE_ID_CT_69000		0x00c0
 
 #define PCI_VENDOR_ID_MIRO		0x1031
 #define PCI_DEVICE_ID_MIRO_36050	0x5601


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
