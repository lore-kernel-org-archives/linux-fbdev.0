From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: SM501 framebuffer driver
Date: Mon, 22 Jan 2007 07:55:20 +0000 (UTC)
Message-ID: <loom.20070122T084752-664@post.gmane.org>
References: <20070115013124.GA19486@home.fluff.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H8uB1-00034z-PU for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 00:05:15 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H8uB0-0002oD-5Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 00:05:15 -0800
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H8uAo-0000XB-FZ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 09:05:04 +0100
Received: from gate.msc-ge.com ([212.86.197.209])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 22 Jan 2007 09:05:02 +0100
Received: from mano by gate.msc-ge.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 22 Jan 2007 09:05:02 +0100
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi Ben,

Ben Dooks <ben-fbdev <at> fluff.org> writes:

> This is a resend of the SM501 patch, with all
> the previous comments addressed, and some more
> support for items such as blanking and display
> panning. A number of code paths are now handled
> by common blocks where possible to make the code
> easier to change.

Is there an updates patchset for the MFD part?
(I'm using the one you posted on Dec 13, 2006 to LKML)
I get a few compile errors in this driver, all
referencing missing constants:

sm501fb.c: In function `sm501fb_set_par_common':
sm501fb.c:411: error: `SM501_ADDR_FLIP' undeclared (first use in this function)
sm501fb.c:411: error: (Each undeclared identifier is reported only once
sm501fb.c:411: error: for each function it appears in.)
sm501fb.c: In function `sm501fb_set_par_geometry':
sm501fb.c:462: error: `SM501_OFF_DC_H_TOT' undeclared (first use in this 
function)
sm501fb.c:469: error: `SM501_OFF_DC_H_SYNC' undeclared (first use in this
function)
sm501fb.c:476: error: `SM501_OFF_DC_V_TOT' undeclared (first use in this 
function)
sm501fb.c:482: error: `SM501_OFF_DC_V_SYNC' undeclared (first use in this 
function)
sm501fb.c: In function `sm501fb_pan_crt':
sm501fb.c:523: error: `SM501_DC_CRT_CONTROL_PIXEL_MASK' undeclared (first use in
 this function)
sm501fb.c:529: error: `SM501_ADDR_FLIP' undeclared (first use in this function)

(and so on...)

Thanks!

-- 
 Manuel Lauss



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
