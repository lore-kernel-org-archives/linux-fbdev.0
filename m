From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/17] Add Texas Instruments OMAP LCD
	driver-v2
Date: Tue, 26 Jun 2007 17:25:12 -0700
Message-ID: <20070626172512.c6894d07.akpm@linux-foundation.org>
References: <5d5443650706260530x11b6ce8el542eabbe3800b4d6@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I3LLb-0006ES-R8 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 17:25:27 -0700
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I3LLb-0005VT-D1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Jun 2007 17:25:27 -0700
In-Reply-To: <5d5443650706260530x11b6ce8el542eabbe3800b4d6@mail.gmail.com>
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
To: Trilok Soni <soni.trilok@gmail.com>
Cc: juha.yrjola@solidboot.com, imre.deak@solidboot.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org

On Tue, 26 Jun 2007 18:00:22 +0530
"Trilok Soni" <soni.trilok@gmail.com> wrote:

> This patch series contains Texas Instruments OMAP LCD framebuffer
> drivers. This driver is divided into
> 
> * main omapfb driver, which handles most common functions across
> processor series, like platform driver registration, ioctl handling,
> much like fb skeleton.
> 
> This driver then gets through the callback based on the
> internal/external lcd controller and panel registered to it based on
> processor and board. Internal/External LCD controller as per lcd panel
> data registration is being done in separate files and so does patches.
> 
> Overall this patches contains framebuffer driver for TI OMAP1
> (OMAP1510/1610/1710) and OMAP2 (OMAP2420/2430) and external
> controllers used in Nokia Internal Tablets (N770/N800).
> 
> These drivers were very well tested on OMAP GIT [1] tree from long
> time. Most of the code for this driver is written by Imre Deak
> <imre.deak@solidboot.com>.

It seems churlish to complain about the 10-15 minutes spent reassembling
the mime mess when so much effort has gone into this work.  But for the
long-term, pleeeeeeeeze do have a talk with your email setup so that you no
longer need to send patches as attachments, OK?

> Also CCed to LKML for wider review, and this v2 went through checkpatch.pl and
> I have modified the patches to accept most of checkpatch comments.

Maybe you had an old version of checkpatch:

trailing statements should be on next line
#520: FILE: drivers/video/omap/omapfb_main.c:402:
+	else switch (var->bits_per_pixel) {

line over 80 characters
#1136: FILE: drivers/video/omap/omapfb_main.c:1018:
+static enum omapfb_update_mode omapfb_get_update_mode(struct omapfb_device *fbdev)

do not use assignment in if condition
#1251: FILE: drivers/video/omap/omapfb_main.c:1133:
+		if ((r = omapfb_query_plane(fbi, &p.plane_info)) < 0)

do not use assignment in if condition
#1265: FILE: drivers/video/omap/omapfb_main.c:1147:
+		if ((r = omapfb_query_mem(fbi, &p.mem_info)) < 0)

do not use assignment in if condition
#1279: FILE: drivers/video/omap/omapfb_main.c:1161:
+		if ((r = omapfb_get_color_key(fbdev, &p.color_key)) < 0)

do not use assignment in if condition
#1535: FILE: drivers/video/omap/omapfb_main.c:1417:
+	if ((r = device_create_file(fbdev->dev, &dev_attr_caps_num)))

do not use assignment in if condition
#1538: FILE: drivers/video/omap/omapfb_main.c:1420:
+	if ((r = device_create_file(fbdev->dev, &dev_attr_caps_text)))

do not use assignment in if condition
#1541: FILE: drivers/video/omap/omapfb_main.c:1423:
+	if ((r = sysfs_create_group(&fbdev->dev->kobj, &panel_attr_grp)))

do not use assignment in if condition
#1544: FILE: drivers/video/omap/omapfb_main.c:1426:
+	if ((r = sysfs_create_group(&fbdev->dev->kobj, &ctrl_attr_grp)))

do not use assignment in if condition
#1646: FILE: drivers/video/omap/omapfb_main.c:1528:
+		if ((r = fbinfo_init(fbdev, fbi)) < 0) {

else should follow close brace
#2001: FILE: drivers/video/omap/omapfb_main.c:1883:
+		}
+		else if (!strncmp(this_opt, "vxres:", 6))

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

Plus there are quite a large number of extern declarations in C files,
which is poor practice, which checkpatch failed to detect (maintainer has
been notified).



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
