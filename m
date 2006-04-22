From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/4] suspend: Documentation update for IBM Thinkpad X30
Date: Sat, 22 Apr 2006 10:50:00 +0800
Message-ID: <444999D8.6090104@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX8Ez-0003cQ-3C
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 19:52:57 -0700
Received: from pproxy.gmail.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FX8Ew-0001zL-V9
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 19:52:57 -0700
Received: by pproxy.gmail.com with SMTP id i49so647147pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Apr 2006 19:52:54 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Pavel Machek <pavel@suse.cz>

As reported in Bugzilla Bug 6406, resume from S3 results in a blank
screen.

For the IBM Thinkpad X30 using vesafb as the console driver, successful
resume from S3 requires option acpi_sleep=s3_bios,s3_mode.  Update
documentation.

I would presume that, in any hardware, using vesafb as the console driver will
require as a minimum s3_mode.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Documentation/power/video.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/power/video.txt b/Documentation/power/video.txt
index d18a57d..51ea8ce 100644
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -140,7 +140,7 @@ IBM TP T41p			s3_bios (2), switch to X a
 IBM TP T42			s3_bios (2)
 IBM ThinkPad T42p (2373-GTG)	s3_bios (2)
 IBM TP X20			??? (*)
-IBM TP X30			s3_bios (2)
+IBM TP X30			s3_bios (2), s3_bios,s3_mode (4) if vesafb
 IBM TP X31 / Type 2672-XXH      none (1), use radeontool (http://fdd.com/software/radeon/) to turn off backlight.
 IBM TP X32			none (1), but backlight is on and video is trashed after long suspend. s3_bios,s3_mode (4) works too. Perhaps that gets better results?
 IBM Thinkpad X40 Type 2371-7JG  s3_bios,s3_mode (4)




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
