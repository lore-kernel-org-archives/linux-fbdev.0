From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: fb accel capabilities - second draft of patches coming
Date: Thu, 13 May 2004 15:48:38 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1084481318.40a3df264d552@mail.theboonies.us>
Reply-To: David Eger <eger-dated-1085086121.170f6f@theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BON8F-0007kp-Q8
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 13:48:43 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BON8F-0002XC-Ik
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 13:48:43 -0700
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

After trying a third batch of driver conversion (this time the matrox/ drivers),
I've decided my first-draft fb accel capabilities patch is flawed... so while i
  re-work them, please send me your thoughts...

In the first pass (these past five patches), I had:

#define FB_HWACCEL_DISABLED     0x0000
#define FB_HWACCEL_COPYAREA     0x0001
#define FB_HWACCEL_FILLRECT     0x0002
#define FB_HWACCEL_ROTATE       0x0004

The problem here is that the DISABLED functionality -- turning acceleration off
-- is orthogonal to whether a driver knows how to frob the accel engine.  So
for a second try, I'm taking the ever-present "noaccel" variable, and making it
a separate flag, as follows:

#define FB_HWACCEL_CAPABILITIES_MASk 0x0FFF
#define FB_HWACCEL_NONE         0x0000
#define FB_HWACCEL_COPYAREA     0x0001
#define FB_HWACCEL_FILLRECT     0x0002
#define FB_HWACCEL_ROTATE       0x0004
#define FB_HWACCEL_IMAGEBLIT    0x0008

#define FB_HWACCEL_DISABLED     0x8000

Still, some capabilities are advertized elsewise: being able to pan or wrap are
indicated by non-zero values in fix.xpanstep, fix.ypanstep, and fix.ywrapstep. 
I'm somewhat inclined to duplicate this information in the .hwaccel field (as,
for instance, the divides() macro in fbcon misinterprets the current
implementation)... so say:

#define FB_HWACCEL_XPAN         0x0010
#define FB_HWACCEL_YPAN         0x0020
#define FB_HWACCEL_YWRAP        0x0040
#define FB_HWACCEL_READSFAST    0x0080 /* software copying is usually faster
than re-r
endering */

Comments before I dive in for a second round?

-dte

ps, geert - i'm just now grokking var.vmode -- as an implisit extra
   argument to pan_display()... i can't decide whether it's a horrible hack,
   or just a warm reminder of closures in the lambda calculus...



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
