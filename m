From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/4] suspend: Documentation update for IBM Thinkpad X30
Date: Sat, 22 Apr 2006 11:01:16 +0200
Message-ID: <20060422090116.GE3590@elf.ucw.cz>
References: <444999D8.6090104@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FXDzz-0004lU-0g
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Apr 2006 02:01:51 -0700
Received: from gprs189-60.eurotel.cz ([160.218.189.60] helo=amd.ucw.cz)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FXDzv-00087v-G9
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 22 Apr 2006 02:01:51 -0700
Content-Disposition: inline
In-Reply-To: <444999D8.6090104@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On So 22-04-06 10:50:00, Antonino A. Daplas wrote:
> As reported in Bugzilla Bug 6406, resume from S3 results in a blank
> screen.
> 
> For the IBM Thinkpad X30 using vesafb as the console driver, successful
> resume from S3 requires option acpi_sleep=s3_bios,s3_mode.  Update
> documentation.
> 
> I would presume that, in any hardware, using vesafb as the console driver will
> require as a minimum s3_mode.

Well, some hardware just preserves video state, but you are right that
anything that needs s3_bios probably needs s3_mode, too.

Do you think you could try code from suspend.sf.net and fix whitelist
there? It is really wrong to have whitelist in .txt, when it should
have been machine-readable.

(I applied this:

diff --git a/Documentation/power/video.txt
b/Documentation/power/video.txt
index a8004cc..d859faa 100644
--- a/Documentation/power/video.txt
+++ b/Documentation/power/video.txt
@@ -143,7 +143,7 @@ IBM TP T41p                 s3_bios (2), switch to
X a
 IBM TP T42                     s3_bios (2)
 IBM ThinkPad T42p (2373-GTG)   s3_bios (2)
 IBM TP X20                     ??? (*)
-IBM TP X30                     s3_bios (2)
+IBM TP X30                     s3_bios, s3_mode (4)

...we do not want to give wrong options.)
								Pavel
-- 
Thanks for all the (sleeping) penguins.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
