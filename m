From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Rivafb won't work with DVI connector
Date: Wed, 24 Nov 2004 06:44:13 +0800
Message-ID: <200411240638.51261.adaplas@hotpop.com>
References: <200411191137.14649.andrew@walrond.org> <Pine.GSO.4.61.0411232057280.6094@waterleaf.sonytel.be> <200411232053.28741.andrew@walrond.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_907oBluTXZsKiev"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWjOf-00017s-KN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 14:44:29 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWjOe-0000Pw-20
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Nov 2004 14:44:29 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 6E66112008DB
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Nov 2004 22:44:11 +0000 (UTC)
In-Reply-To: <200411232053.28741.andrew@walrond.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Walrond <andrew@walrond.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Chad Daelhousen <cd9@cse.buffalo.edu>


--Boundary-00=_907oBluTXZsKiev
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 24 November 2004 04:53, Andrew Walrond wrote:
> On Tuesday 23 Nov 2004 19:59, Geert Uytterhoeven wrote:
> > No, this will use the BIOS to switch to a 1280x1024 mode before starting
> > the kernel. Remember that Tony told you the panel size is set up by the
> > BIOS. If that's really the case, it should help.

When the input is digital, it seems that there are other registers that are
programmed besides that of the CRTC registers.  During the setup, some
of the registers are actually read by the code, and these are the panel width
and height.  The rest of the registers we don't know about (no
documentation).

So the safe approach is to accept what the BIOS programmed for us, use
scaling for res < panel size, and reject all res > panel size. If we know
how to program the rest of the registers, then this should be no problem.

Therefore, using vesafb to pre-program the registers for higher resolutions
means that the BIOS can setup the undocumented registers for us so we can
have a limit greater than 1024x768.

If the input is analog, then all that is required are the CRTC registers. The
panel size is actually not read in analog input. And since we know what to
do with CRTC registers, even if the preferred mode is 1024x768 but the EDID
tells us that it can support timings other than that, we can still use that
mode.

In short, the main difference is the type of input and lack of documentation.

>
> Hi Geert,
>
> I got that. I guess I'm asking whether the problem is self imposed by our
> driver by rejecting modes > panel size. Ie could we just ignore the panel
> size and allow any EDID supported modes?

As I've said, you can try to ignore the registers pre-programmed by the
BIOS, but I don't know the side effects of this.

> Or, is it the video card that in any case would not allow us to set modes >
> panel size?

No, it's the undocumented registers that prevents us from using modes >
panel size.

>
> Chad explains it well in his email.

Yes, what Chad said is true if the input is analog.  It's a different story if
the input is digital.

Anyway, attached is a patch that prevents an oops if the boot mode is
illegal.  It will still limit your resolution to panel size if input is digital.

Tony

BTW: How does X behave if the input is digital.  Does it accept modes
greater than panel size?  If it does, then the documentation is actually
there.  I'll look at the X code again.  And I'll probably do some googling
on this.  If you happen to encounter any kind of programming info about
this, let me know also.

Thanks for testing.



--Boundary-00=_907oBluTXZsKiev
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="nvidiafb2-inc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nvidiafb2-inc4.diff"

diff -Nru a/drivers/video/nvidia/nvidia.c b/drivers/video/nvidia/nvidia.c
--- a/drivers/video/nvidia/nvidia.c	2004-11-23 06:01:00 +08:00
+++ b/drivers/video/nvidia/nvidia.c	2004-11-24 06:15:15 +08:00
@@ -1101,15 +1101,16 @@
                     | FBINFO_HWACCEL_YPAN
 	            | FBINFO_MISC_MODESWITCHLATE;
 
-	info->var = nvidiafb_default_var;
-	if (mode_option) {
-		fb_find_mode(&info->var, info, mode_option, specs->modedb,
-			     specs->modedb_len, NULL, 8);
-	} else if (specs->modedb != NULL) {
+	fb_videomode_to_modelist(info->monspecs.modedb,
+				 info->monspecs.modedb_len,
+				 &info->modelist);
+	fb_var_to_videomode(&modedb, &nvidiafb_default_var);
+
+	if (specs->modedb != NULL) {
 		/* get preferred timing */
 		if (specs->misc & FB_MISC_1ST_DETAIL) {
 			int i;
-
+			
 			for (i = 0; i < specs->modedb_len; i++) {
 				if (specs->modedb[i].flag & FB_MODE_IS_FIRST) {
 					modedb = specs->modedb[i];
@@ -1121,16 +1122,18 @@
 			modedb = specs->modedb[0];
 		}
 		info->var.bits_per_pixel = 8;
-		fb_videomode_to_var(&info->var, &modedb);
+		fb_videomode_to_var(&nvidiafb_default_var, &modedb);
 	}
 
+	if (mode_option)
+		fb_find_mode(&nvidiafb_default_var, info, mode_option,
+			     specs->modedb, specs->modedb_len, &modedb, 8);
+
+	info->var = nvidiafb_default_var;
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 	info->pseudo_palette = par->pseudo_palette;
 	fb_alloc_cmap(&info->cmap, 256, 0);	
-	fb_videomode_to_modelist(info->monspecs.modedb,
-				 info->monspecs.modedb_len,
-				 &info->modelist);
 	fb_destroy_modedb(info->monspecs.modedb);
 	info->monspecs.modedb = NULL;
 

--Boundary-00=_907oBluTXZsKiev--




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
