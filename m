From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Make config firmware EDID default to yes
Date: Fri, 24 Feb 2006 13:44:36 +0800
Message-ID: <43FE9D44.6040907@gmail.com>
References: <43FDA3C2.2010109@gmail.com>	<20060223163438.63ce04e8.akpm@osdl.org>	<43FE83DA.3050505@gmail.com> <20060223201030.d5a70121.akpm@osdl.org> <43FE9898.3030801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FCVlX-0001sa-P4
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 21:45:19 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FCVlX-0005yu-Ma
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 23 Feb 2006 21:45:19 -0800
Received: by pproxy.gmail.com with SMTP id i75so283812pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 23 Feb 2006 21:45:19 -0800 (PST)
In-Reply-To: <43FE9898.3030801@gmail.com>
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
Cc: linux-fbdev-devel@lists.sourceforge.net

- Make CONFIG_FB_FIRMWARE_EDID default to yes
- Add more info to Kconfig help section on when to select N for this option

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

Antonino A. Daplas wrote:
> Andrew Morton wrote:
>> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
>> Hmm.  You're right, 'default y' looks better. Would you like me to send you
> a patch, or would you rather take care of it?

On second thought, I'll just send you an update.

Tony

 drivers/video/Kconfig |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index e6a02d6..e9b5045 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -73,14 +73,18 @@ config FB_MACMODES
 config FB_FIRMWARE_EDID
        bool "Enable firmware EDID"
        depends on FB
-       default n
+       default y
        ---help---
          This enables access to the EDID transferred from the firmware.
 	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
 	 transfers do not work for your driver and if you are using
 	 nvidiafb, i810fb or savagefb.
 
-	 If unsure, say N.
+	 In general, choosing Y for this option is safe.  If you 
+	 experience extremely long delays while booting before you get
+	 something on your display, try setting this to N.  Matrox cards in
+	 combination with certain motherboards and monitors are known to
+	 suffer from this problem.
 
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
