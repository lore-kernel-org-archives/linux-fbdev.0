From: Brian Maly <bmaly@redhat.com>
Subject: [PATCH] efifb: dmi set video type
Date: Mon, 23 Mar 2009 13:49:16 -0400
Message-ID: <49C7CB9C.7090009@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050101080107030106040802"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bmaly@redhat.com>) id 1LloH4-0004cj-Ll
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 17:49:22 +0000
Received: from mx2.redhat.com ([66.187.237.31])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LloH1-0002EW-Sw for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 17:49:22 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net
Cc: ying.huang@intel.com

This is a multi-part message in MIME format.
--------------050101080107030106040802
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I had posted this to LKML and should have CC'd this list too, so instead 
Im reposting to this list.
Initial post: http://lkml.org/lkml/2009/3/21/284



The current logic for dmi matching in efifb does not allow efifb to load 
on all hardware that we can dmi match for. We should trust a dmi match 
and set video type too if we dont already have one passed in from the 
bootloader. Currently this info needs to be set by the bootloader just 
to proceed to looking for a dmi match.

For a real world example, boot with elilo (3.7 or 3.8 vanilla) and on a 
Apple (MacBook) and EFI framebuffer driver will not load (you will have 
no video).
This specific hardware is efi v1.10, so we have UGA and not GOP. Without 
special bootloader magic (i.e. extra elilo patches for UGA graphics 
detection) no screen info will be passed to the kernel and as a result 
efifb will not load.

This patch allows the dmi match to happen by moving it to earlier in 
efifb_init, and sets the video type (in set_system) so that efifb can 
load when we have a valid dmi match and already know the specifics of 
the hardware.

Without this patch the efifb driver will fail to load in the event 
screen info is not found and passed in by the bootloader, being that we 
will never get to look for a dmi match. A primary reason for matching 
with dmi is because not all bootloaders detect the video info properly. 
The solution is that in the event of a dmi match, we should set 
screen_info.orig_video_isVGA too. Many bootloaders fail to set screen 
info on Apple hardware, and this is a big problem for people who want to 
use Apple hardware.

Tested on a MacBook SantaRosa with elilo-3.8 (vanilla) and resolves the 
issue, the dmi match now works, EFI framebuffer now loads and video works.


Signed-off-by: Brian Maly <bmaly@redhat>


 efifb.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


--------------050101080107030106040802
Content-Type: text/x-patch; name="linux-2.6.29-efifb-dmi-set-video_isVGA.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="linux-2.6.29-efifb-dmi-set-video_isVGA.patch"

--- a/drivers/video/efifb.c	2009-03-21 21:05:08.000000000 -0400
+++ b/drivers/video/efifb.c	2009-03-21 21:16:20.000000000 -0400
@@ -129,6 +129,8 @@ static int set_system(const struct dmi_s
 		screen_info.lfb_width = info->width;
 	if (screen_info.lfb_height == 0)
 		screen_info.lfb_height = info->height;
+	if (screen_info.orig_video_isVGA == 0)
+		screen_info.orig_video_isVGA = VIDEO_TYPE_EFI;
 
 	return 0;
 }
@@ -374,9 +376,10 @@ static int __init efifb_init(void)
 	int ret;
 	char *option = NULL;
 
+	dmi_check_system(dmi_system_table);
+
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
 		return -ENODEV;
-	dmi_check_system(dmi_system_table);
 
 	if (fb_get_options("efifb", &option))
 		return -ENODEV;

--------------050101080107030106040802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
--------------050101080107030106040802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------050101080107030106040802--
