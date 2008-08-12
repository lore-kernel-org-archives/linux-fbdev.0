From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/13 v3] viafb: fix for the
 description of the VX800 2D acceleration issue in viafb.txt.
Date: Tue, 12 Aug 2008 16:09:34 -0700
Message-ID: <20080812160934.9371732e.akpm@linux-foundation.org>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078F4A00@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KT2zv-0008BG-EC for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Aug 2008 16:09:51 -0700
Received: from smtp1.linux-foundation.org ([140.211.169.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KT2zu-0006hl-3w
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 12 Aug 2008 16:09:51 -0700
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8078F4A00@exchtp03.taipei.via.com.tw>
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
Cc: JosephChan@via.com.tw, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Tue, 12 Aug 2008 08:53:47 +0800
<JosephChan@via.com.tw> wrote:

> Correct the description of VX800 2D acceleration, the driver diables the acceleration
> function by defualt if you use VX800 chip.
> Correct via_fb_ to viafb_ and remove the Kconfig part in viafb.txt.

The difference betwee this patch and the previous one
(viafb-viafbmodes-viafbtxt.patch) is:

--- a/Documentation/fb/viafb.txt~viafb-viafbmodes-viafbtxt-fix
+++ a/Documentation/fb/viafb.txt
@@ -182,8 +182,9 @@ Notes:
        instead of calling common ioctl function FBIOPUT_VSCREENINFO since
        viafb doesn't support multi-head well, or it will cause screen crush.
     4. VX800 2D accelerator hasn't been supported in this driver yet. When
-       using driver on VX800, one should add parameter "viafb_accel=0" to
-       disable 2D accelerator.
+       using driver on VX800, the driver will disable the acceleration funciton.
+       as default.
+
 
 [Configure viafb with "fbset" tool]
 -----------------------------------
_

Which does not fully meet your description of it?

I'll fix the "funciton" spelling.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
