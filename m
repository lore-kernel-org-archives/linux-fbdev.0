From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: [PATCH 0/3] fb accel capabilities (aka fast radeon fb, the right way)
Date: Thu, 13 May 2004 01:45:57 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
Reply-To: David Eger <eger-dated-1085010079.06feaf@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BO3Lp-0001oF-N0
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 16:41:25 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BO3Lp-0002sX-Er
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 May 2004 16:41:25 -0700
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, jsimmons@infradead.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>


I fleshed out Geert's idea from the last radeonfb thread on bringing
fbcon's interaction with the underlying framebuffer drivers up-to-date.
Now fbcon should be smart and actually *use* fb-driver provided accel
functions ;-)

Specifically, I've added a .hwaccel field to fb_fix_screeninfo, which
should serve as the way framebuffers pass hints to higher layers.
This should totally obsolete the accel_flags in var (which till now has
had one half-heartedly used value FB_ACCELF_TEXT).

The patches that follow are:

1) my radeonfb copyarea() fix.  this is already in -mm.
2) James's fbcon init cleanup, modified for benh's tree.
3) my fb-accel-capabilities patch

When I boot with this, I have a nice accelerated framebuffer, huzzah.
This *shouldn't* break anyone's setup.  Please, test this patch!
Look good?  Comments?

Still not done:
- get rid of old comments in include/linux/fb.h
- get rid of all old references to useless var.accel_flags
- update other drivers to indicate if they have fast accel() funcs

-dte

---
getting bounce messages from me? let me know and you'll go on my whitelist


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
