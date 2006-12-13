From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 2.6.19 0/6] tgafb: Various fixes
Date: Wed, 13 Dec 2006 17:10:22 +0000 (GMT)
Message-ID: <Pine.LNX.4.64N.0612131532320.24220@blysk.ds.pg.gda.pl>
Reply-To: Linux on Alpha processors <axp-list@redhat.com>
Mime-Version: 1.0
Return-path: <axp-list-bounces@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/axp-list>
List-Post: <mailto:axp-list@redhat.com>
List-Help: <mailto:axp-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=subscribe>
Sender: axp-list-bounces@redhat.com
Errors-To: axp-list-bounces@redhat.com
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: axp-list@redhat.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hello,

 In the course of adding support for the TURBOchannel bus to the tgafb 
driver I discovered and fixed a few problems and did a few cleanups.  
They form this series of patches.  I have tested them all successfully on 
an 8-plane and a 32-plane board, but they are both TURBOchannel options 
(ZLX-E1 and ZLX-E3, respectively).  I do not have any PCI TGA cards, so 
please anybody who cares about them and have suitable hardware do a little 
bit of testing.

  Maciej
