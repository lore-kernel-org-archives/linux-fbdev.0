From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] include/video/newport.h: "extern inline" -> "static inline"
Date: Mon, 12 Dec 2005 02:35:39 +0100
Message-ID: <20051212013539.GH23349@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ElccC-0000K7-BY
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Dec 2005 17:36:32 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by mail.sourceforge.net with smtp (Exim 4.44)
	id 1ElccA-0002W6-PF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Dec 2005 17:36:32 -0800
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

"extern inline" doesn't make much sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Nov 2005

 include/video/newport.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc1-mm2-full/include/video/newport.h.old	2005-11-19 02:34:35.000000000 +0100
+++ linux-2.6.15-rc1-mm2-full/include/video/newport.h	2005-11-19 02:35:42.000000000 +0100
@@ -382,7 +382,8 @@
 #define VC2_IREG_CONTROL       0x10
 #define VC2_IREG_CONFIG        0x20
 
-extern __inline__ void newport_vc2_set(struct newport_regs *regs, unsigned char vc2ireg,
+static inline void newport_vc2_set(struct newport_regs *regs,
+				   unsigned char vc2ireg,
 				   unsigned short val)
 {
 	regs->set.dcbmode = (NPORT_DMODE_AVC2 | VC2_REGADDR_INDEX | NPORT_DMODE_W3 |
@@ -390,7 +391,7 @@
 	regs->set.dcbdata0.byword = (vc2ireg << 24) | (val << 8);
 }
 
-extern __inline__ unsigned short newport_vc2_get(struct newport_regs *regs,
+static inline unsigned short newport_vc2_get(struct newport_regs *regs,
 					     unsigned char vc2ireg)
 {
 	regs->set.dcbmode = (NPORT_DMODE_AVC2 | VC2_REGADDR_INDEX | NPORT_DMODE_W1 |



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
