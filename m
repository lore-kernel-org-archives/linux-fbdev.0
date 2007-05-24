From: thunder7@xs4all.nl
Subject: Re: framebuffer with nvidia 7600GS shows
	corrupt screen
Date: Thu, 24 May 2007 14:36:11 +0200
Message-ID: <20070524123611.GA7084@amd64.of.nowhere>
References: <20070523181826.GA4331@amd64.of.nowhere>
	<4655536C.3080305@vc.cvut.cz>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HrCYX-0004mr-1J for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 May 2007 05:36:37 -0700
Received: from smtp-vbr9.xs4all.nl ([194.109.24.29])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HrCYV-0003wE-Ef
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 24 May 2007 05:36:36 -0700
Received: from rivierenland.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr9.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4OCaU9X078128
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 24 May 2007 14:36:30 +0200 (CEST)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
In-Reply-To: <4655536C.3080305@vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev-devel@lists.sourceforge.net

From: Petr Vandrovec <vandrove@vc.cvut.cz>
Date: Thu, May 24, 2007 at 01:57:16AM -0700
> jurriaan wrote:
> >I've swapped my nvidia 6600 for a 7600GS, because it has dual-link DVI
> >output. That broke my framebuffer!
> >
> >If I boot like this:
> >
> >Command line: root=/dev/md2 video=nvidiafb:640x480-32@60 atkbd.softrepeat=1
> >
> >I see this:
> >
> >nvidiafb: Device ID: 10de0392 
> >nvidiafb: CRTC0 analog found
> >nvidiafb: CRTC1 analog not found
> >nvidiafb: EDID found from BUS1
> 
> Mmm, and what you have connected to that dual-link DVI output?  It looks 
> like that framebuffer believes that you've connected analog monitor to 
> it, which I'm not sure is quite correct given your note that you 
> upgraded to get dual link DVI.  You may want to hardcode values for 
> FlatPanel & CRTCNumber into NVCommonSetup instead of allowing 
> autodetection...

I haven't yet - a plain old CRT monitor is attached currently. I haven't
bought a LCD yet. The messages seem correct. The monitor is attached via
a dvi->vga15 converter, of which I've tried two known working ones.

Thanks,
Jurriaan
-- 
+#if defined(__alpha__) && defined(CONFIG_PCI)
+       /*
+        * The meaning of life, the universe, and everything. Plus
+        * this makes the year come out right.
+        */
+       year -= 42;
+#endif
	From the patch for 1.3.2: (kernel/time.c), submitted by Marcus Meissner
Debian (Unstable) GNU/Linux 2.6.21-mm2 2x2010 bogomips load 4.21
the Jack Vance Integral Edition: http://www.integralarchive.org

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
