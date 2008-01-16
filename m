From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9762] New: radeonfb and
 Xpress 200m 5955
Date: Wed, 16 Jan 2008 11:12:33 -0800
Message-ID: <20080116111233.04c6df3a.akpm@linux-foundation.org>
References: <bug-9762-10286@http.bugzilla.kernel.org/>
	<20080116015707.4d551245.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0801161622060.7015@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFDh4-00035Q-Bw for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jan 2008 11:12:58 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFDh3-0006ka-Ne
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jan 2008 11:12:58 -0800
In-Reply-To: <Pine.LNX.4.64.0801161622060.7015@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin@sc8-sf-spam2.sourceforge.net, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Herrenschmidt <benh@kernel.crashing.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Sellout Bessie <sellout@beautyisfleeting.com>, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>, alevkovich@tut.by, "Antonino A. Daplas" <adaplas@pol.net>

On Wed, 16 Jan 2008 16:23:22 +0100 (CET) Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Wed, 16 Jan 2008, Andrew Morton wrote:
> > On Wed, 16 Jan 2008 01:33:25 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:
> > > http://bugzilla.kernel.org/show_bug.cgi?id=9762
> > > 
> > >            Summary: radeonfb and Xpress 200m 5955
> > >            Product: Drivers
> > >            Version: 2.5
> > >      KernelVersion: >=2.6.23
> > >           Platform: All
> > >         OS/Version: Linux
> > >               Tree: Mainline
> > >             Status: NEW
> > >           Severity: normal
> > >           Priority: P1
> > >          Component: Console/Framebuffers
> > >         AssignedTo: jsimmons@infradead.org
> > >         ReportedBy: alevkovich@tut.by
> > > 
> > > 
> > > Latest working kernel version: 2.6.23
> > > Earliest failing kernel version: any
> > > Distribution: gentoo
> > > Hardware Environment: Radeon XPress 200m 5955
> > > Software Environment: 
> > > Problem Description: framebuffer is ok only with default parameters only (it is
> > > 1280x800-8@60). If parameters are video=radeonfb:1280x800-32@60 then xres, yres
> > > and xres_virtual are ok but yres_virtual is 1024. It can be corrected by fbset
> > > utility so I think it can be corrected in the driver code also.
> > > 
> > > Steps to reproduce: video=radeonfb:1280x800-32@60 or
> > > video=radeonfb:1280x800-16@60
> > 
> > damn, another post-2.6.2 regression.
> > 
> > Does anyone know whether this is likely to be a radeonfb problem or an
> > fbdev core problem?
> 
> Perhaps
> 
> commit 1c5dd170927b1aa8e3a01d43d611b840336cdaf2
> Author: Michal Januszewski <spock@gentoo.org>
> Date:   Tue Oct 16 01:29:19 2007 -0700
> 
>     fbdev: find mode with the highest/safest refresh rate in fb_find_mode()
>     
>     Currently, if the refresh rate is not specified, fb_find_mode() returns the
>     first known video mode with the requested resolution, which provides no
>     guarantees wrt the refresh rate.  Change this so that the mode with the
>     highest refresh rate is returned when the driver provides a custom video mod
> e
>     database and the monitor limits, and a mode with the safe 60 Hz refresh rate
>     otherwise.

Thanks.

> M. alevkovich, can you please try to back out that change?
> 

Here's a patch against 2.6.24-rc8 which performs that reversion:

--- a/drivers/video/modedb.c~revert-1
+++ a/drivers/video/modedb.c
@@ -608,43 +608,26 @@ done:
 	DPRINTK("Trying specified video mode%s %ix%i\n",
 	    refresh_specified ? "" : " (ignoring refresh rate)", xres, yres);
 
-	if (!refresh_specified) {
-		/*
-		 * If the caller has provided a custom mode database and a
-		 * valid monspecs structure, we look for the mode with the
-		 * highest refresh rate.  Otherwise we play it safe it and
-		 * try to find a mode with a refresh rate closest to the
-		 * standard 60 Hz.
-		 */
-		if (db != modedb &&
-		    info->monspecs.vfmin && info->monspecs.vfmax &&
-		    info->monspecs.hfmin && info->monspecs.hfmax &&
-		    info->monspecs.dclkmax) {
-			refresh = 1000;
-		} else {
-			refresh = 60;
-		}
-	}
-
-	diff = -1;
+	diff = refresh;
 	best = -1;
 	for (i = 0; i < dbsize; i++) {
-		if ((name_matches(db[i], name, namelen) ||
-		    (res_specified && res_matches(db[i], xres, yres))) &&
-		    !fb_try_mode(var, info, &db[i], bpp)) {
-			if (refresh_specified && db[i].refresh == refresh) {
-				return 1;
-			} else {
-				if (abs(db[i].refresh - refresh) < diff) {
-					diff = abs(db[i].refresh - refresh);
-					best = i;
+		if (name_matches(db[i], name, namelen) ||
+		    (res_specified && res_matches(db[i], xres, yres))) {
+			if(!fb_try_mode(var, info, &db[i], bpp)) {
+				if(!refresh_specified || db[i].refresh == refresh)
+					return 1;
+				else {
+					if(diff > abs(db[i].refresh - refresh)) {
+						diff = abs(db[i].refresh - refresh);
+						best = i;
+					}
 				}
 			}
 		}
 	}
 	if (best != -1) {
 		fb_try_mode(var, info, &db[best], bpp);
-		return (refresh_specified) ? 2 : 1;
+		return 2;
 	}
 
 	diff = xres + yres;
_


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
