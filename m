From: Jordan Crouse <jordan.crouse@amd.com>
Subject: X patch
Date: Thu, 13 Mar 2008 15:31:25 -0600
Message-ID: <20080313213125.GE6284@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qcHopEYAB45HaUaB"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JZv0T-0004ez-Nv for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 14:30:37 -0700
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]
	helo=outbound5-wa4-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JZv0N-0006G9-L9
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Mar 2008 14:30:32 -0700
Received: from outbound5-wa4.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound5-wa4-R.bigfish.com (Postfix) with ESMTP id 1EA1B1843A2D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 21:30:20 +0000 (UTC)
Received: from mail51-wa4-R.bigfish.com (si1-wa4 [10.8.14.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by outbound5-wa4.bigfish.com (Postfix) with ESMTP id 1CF17F08079
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 21:30:20 +0000 (UTC)
Received: from mail51-wa4 (localhost.localdomain [127.0.0.1])
	by mail51-wa4-R.bigfish.com (Postfix) with ESMTP id 027C9BF984D
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 21:30:20 +0000 (UTC)
Received: from ausb3extmailp01.amd.com (unknown [163.181.251.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail51-wa4.bigfish.com (Postfix) with ESMTP id B7258788187
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 21:30:19 +0000 (UTC)
Received: from ausb3twp02.amd.com ([163.181.250.38])
	by ausb3extmailp01.amd.com (Switch-3.2.7/Switch-3.2.7) with ESMTP id
	m2DLXF8J003610 for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 16:33:18 -0500
Received: from sausexbh2.amd.com (SAUSEXBH2.amd.com [163.181.22.102])
	by ausb3twp02.amd.com (Tumbleweed MailGate 3.5.1) with ESMTP id
	2E52E16A0B0A for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 16:30:01 -0500 (CDT)
Received: from cosmic.amd.com (cosmic.amd.com [165.204.144.72])
	by ldcmail.amd.com (Postfix) with ESMTP id 3228022F4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Mar 2008 15:30:08 -0600 (MDT)
Content-Disposition: inline
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


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This should do the right thing for the panel - you'll still have a virtual
desktop if your specified size != the size of the panel, but it won't be
all funky anymore.

J

--qcHopEYAB45HaUaB
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="gxpanel.patch"

diff --git a/src/amd_gx_driver.c b/src/amd_gx_driver.c
index 3c66d05..635482b 100644
--- a/src/amd_gx_driver.c
+++ b/src/amd_gx_driver.c
@@ -807,6 +807,7 @@ GXSetVideoMode(ScrnInfoPtr pScrni, DisplayModePtr pMode)
 {
   GeodeRec *pGeode = GEODEPTR(pScrni);
   int flags = 0;
+  int custom = 0;
 
   pScrni->vtSema = TRUE;
 
@@ -817,14 +818,17 @@ GXSetVideoMode(ScrnInfoPtr pScrni, DisplayModePtr pMode)
   if (pMode->Flags & V_NVSYNC)
     flags |= 2;
 
-  /* XXX Question - why even use set_display_mode at all - shouldn't the
-   * mode timings be the same that we advertise? */
+  /* Check to see if we should use custom or built-in timings */
 
-  /* Only use the panel mode for built in modes */
+  if (pMode->Panel)
+	custom = (pMode->type & M_T_USERDEF);
+  else
+	custom = !(pMode->type & (M_T_BUILTIN | M_T_DEFAULT));
 
- if ((pMode->type & M_T_BUILTIN) || (pMode->type & M_T_DEFAULT)
-	&& pGeode->Panel) {
+  /* If we're not doing a custom mode, then just set the fixed timings,
+   * otherwise, do the whole shooting match */
 
+  if (!custom) {
     GFX(set_fixed_timings(pGeode->PanelX, pGeode->PanelY,
 			  pMode->CrtcHDisplay, pMode->CrtcVDisplay,
 			  pScrni->bitsPerPixel));
@@ -1430,11 +1434,16 @@ GXValidMode(int scrnIndex, DisplayModePtr pMode, Bool Verbose, int flags)
   ScrnInfoPtr pScrni = xf86Screens[scrnIndex];
   GeodeRec *pGeode = GEODEPTR(pScrni);
   int p, ret;
+  int custom = 0;
 
-  /* Use the durango lookup for builtin or default modes only */
+  if (pGeode->Panel)
+	custom = (pMode->type & M_T_USERDEF);
+  else
+	custom = (pMode->type & (M_T_BUILTIN | M_T_DEFAULT));
 
-  if ((pMode->type & M_T_BUILTIN) || (pMode->type & M_T_DEFAULT)) {
+  /* Use the durango lookup for !custom modes */
 
+  if (!custom) {
     if (pGeode->Panel) {
       if (pMode->CrtcHDisplay > pGeode->PanelX ||
 	  pMode->CrtcVDisplay > pGeode->PanelY ||
@@ -1450,9 +1459,8 @@ GXValidMode(int scrnIndex, DisplayModePtr pMode, Bool Verbose, int flags)
 					pMode->CrtcVDisplay,
 					pScrni->bitsPerPixel, 
 					GeodeGetRefreshRate(pMode));
-    if (ret < 0) {
+    if (ret < 0)
       return MODE_BAD;
-    }
   }
 
   if (pMode->Flags & V_INTERLACE)

--qcHopEYAB45HaUaB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--qcHopEYAB45HaUaB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--qcHopEYAB45HaUaB--
