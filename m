From: "Paul A. Clarke" <pc@us.ibm.com>
Subject: [PATCH][matroxfb] G450 jittery display on ppc systems
Date: Wed, 29 Mar 2006 10:39:20 -0600
Message-ID: <442AB838.1030200@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOdhl-00048l-Be
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Mar 2006 08:39:33 -0800
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FOdhl-00050y-2i
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 29 Mar 2006 08:39:33 -0800
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k2TGdNxj011757
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Mar 2006 11:39:23 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k2TGaC6L261130
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Mar 2006 09:36:12 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id k2TGdNhr008010
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 29 Mar 2006 09:39:23 -0700
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: idr@us.ibm.com

There has been a longstanding problem with the Matrox G450 and perhaps other similar cards, with modes "above"
1280x1024-60 on ppc/ppc64 boxes running Linux.  Higher resolutions and/or higher refresh rates resulted in a very
noticably "jittery" display, and sometimes no display, depending on the phyiscal monitor.  This patch fixes that problem
on the systems I have easy access to...

I've tested with SLES9SP3 (2.6.5+ kernel) and 2.6.16-rc6 custom kernels on an IBM eServer p5 520 w/G450 (a.k.a GXT135P
on IBM's ppc64 systems) , and a colleague of mine (Ian Romanick) tested it successfully on an Apple ppc32 box
(w/GXT135P).  I also tested it on IA32 box I have with a GXT135P to verify that it didn't obviously break anything.  In
my testing, I covered single-card, single and dual-head setups using both HD15 and DVI-D signals, on both the IA32 and
ppc64 boxes.  While everything appeared fine on both boxes, I did encounter one problem: I can't get any signal on the
DVI-D output on the ppc64 box.  However, this is also the case without my patch.

Hmm, I just noticed that screen-blanking only occurs on the primary display as well.

I guess those are the next problems to work on...  :-)

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
Signed-off-by: Ian Romanick <idr@us.ibm.com>
-- 
Regards,
Paul Clarke, IBM

diff -rup /usr/src/linux/drivers/video/matrox/g450_pll.c linux/drivers/video/matrox/g450_pll.c
--- /usr/src/linux/drivers/video/matrox/g450_pll.c	2006-03-20 10:17:05.147957832 -0600
+++ linux/drivers/video/matrox/g450_pll.c	2006-03-20 10:15:19.495912080 -0600
@@ -316,14 +316,24 @@ static int __g450_setclk(WPMINFO unsigne
  		case M_PIXEL_PLL_B:
  		case M_PIXEL_PLL_C:
  			{
-				u_int8_t tmp;
+				u_int8_t tmp, xpwrctrl;
  				unsigned long flags;
  				
  				matroxfb_DAC_lock_irqsave(flags);
+
+				xpwrctrl = matroxfb_DAC_in(PMINFO M1064_XPWRCTRL);
+				matroxfb_DAC_out(PMINFO M1064_XPWRCTRL, xpwrctrl & ~M1064_XPWRCTRL_PANELPDN);
+				mga_outb(M_SEQ_INDEX, M_SEQ1);
+				mga_outb(M_SEQ_DATA, mga_inb(M_SEQ_DATA) | M_SEQ1_SCROFF);
  				tmp = matroxfb_DAC_in(PMINFO M1064_XPIXCLKCTRL);
+				tmp |= M1064_XPIXCLKCTRL_DIS;
  				if (!(tmp & M1064_XPIXCLKCTRL_PLL_UP)) {
-					matroxfb_DAC_out(PMINFO M1064_XPIXCLKCTRL, tmp | M1064_XPIXCLKCTRL_PLL_UP);
+					tmp |= M1064_XPIXCLKCTRL_PLL_UP;
  				}
+				matroxfb_DAC_out(PMINFO M1064_XPIXCLKCTRL, tmp);
+				matroxfb_DAC_out(PMINFO M1064_XDVICLKCTRL, 0);
+				matroxfb_DAC_out(PMINFO M1064_XPWRCTRL, xpwrctrl);
+
  				matroxfb_DAC_unlock_irqrestore(flags);
  			}
  			{
@@ -418,6 +428,15 @@ static int __g450_setclk(WPMINFO unsigne
  				   frequency to higher - with <= lowest wins, while
  				   with < highest one wins */
  				if (delta <= deltaarray[idx-1]) {
+					/* all else being equal except VCO,
+					 * choose VCO not near (within 1/16th or so) VCOmin
+					 * (freqs near VCOmin aren't as stable)
+					 */
+					if (delta == deltaarray[idx-1]
+					    && vco != g450_mnp2vco(PMINFO mnparray[idx-1])
+					    && vco < (pi->vcomin * 17 / 16)) {
+						break;
+					}
  					mnparray[idx] = mnparray[idx-1];
  					deltaarray[idx] = deltaarray[idx-1];
  				} else {
diff -rup /usr/src/linux/drivers/video/matrox/matroxfb_DAC1064.h linux/drivers/video/matrox/matroxfb_DAC1064.h
--- /usr/src/linux/drivers/video/matrox/matroxfb_DAC1064.h	2004-04-03 21:38:21.000000000 -0600
+++ linux/drivers/video/matrox/matroxfb_DAC1064.h	2006-03-20 12:54:38.145911344 -0600
@@ -41,6 +41,7 @@ void DAC1064_global_restore(WPMINFO2);
  #define M1064_XCURCOL1RED	0x0C
  #define M1064_XCURCOL1GREEN	0x0D
  #define M1064_XCURCOL1BLUE	0x0E
+#define M1064_XDVICLKCTRL	0x0F
  #define M1064_XCURCOL2RED	0x10
  #define M1064_XCURCOL2GREEN	0x11
  #define M1064_XCURCOL2BLUE	0x12
@@ -145,6 +146,7 @@ void DAC1064_global_restore(WPMINFO2);
  #define M1064_XVIDPLLN		0x8F

  #define M1064_XPWRCTRL		0xA0
+#define     M1064_XPWRCTRL_PANELPDN	0x04

  #define M1064_XPANMODE		0xA2

diff -rup /usr/src/linux/drivers/video/matrox/matroxfb_base.h linux/drivers/video/matrox/matroxfb_base.h
--- /usr/src/linux/drivers/video/matrox/matroxfb_base.h	2004-04-03 21:37:07.000000000 -0600
+++ linux/drivers/video/matrox/matroxfb_base.h	2006-03-16 11:02:09.000000000 -0600
@@ -748,6 +748,8 @@ void matroxfb_unregister_driver(struct m

  #define M_SEQ_INDEX	0x1FC4
  #define M_SEQ_DATA	0x1FC5
+#define     M_SEQ1		0x01
+#define        M_SEQ1_SCROFF		0x20

  #define M_MISC_REG_READ	0x1FCC






-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
