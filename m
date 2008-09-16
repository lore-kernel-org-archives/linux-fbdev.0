From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: Re: [fbdev] Lockdep error
Date: Tue, 16 Sep 2008 23:39:16 +0200
Message-ID: <20080916233916.4f9c0dfd.krzysztof.h1@wp.pl>
References: <20080915122152.GA4570@doriath.ww600.siemens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KfiFz-00047g-ST for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Sep 2008 14:38:47 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KfiFy-0004gH-G7
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 16 Sep 2008 14:38:47 -0700
In-Reply-To: <20080915122152.GA4570@doriath.ww600.siemens.net>
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
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: rpurdie@rpsys.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

On Mon, 15 Sep 2008 16:21:52 +0400
Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:

> Hi,
> 
> After doing
> # echo 1 > /sys/class/graphics/fb0/blank
> I got the following in my kernel log:
> 
> =============================================
> [ INFO: possible recursive locking detected ]
> 2.6.27-rc6-00086-gda63874-dirty #97
> ---------------------------------------------
> echo/1564 is trying to acquire lock:
>  ((fb_notifier_list).rwsem){..--}, at: [<c005a384>] __blocking_notifier_call_chain+0x38/0x6c
> 

Does the patch below fix the problem for you?

Kind regards,
Krzysztof

diff -urp linux-ref/drivers/video/console/fbcon.c linux-mm/drivers/video/console/fbcon.c
--- linux-ref/drivers/video/console/fbcon.c	2008-09-05 23:38:47.000000000 +0200
+++ linux-mm/drivers/video/console/fbcon.c	2008-09-16 23:30:52.309604454 +0200
@@ -2400,11 +2400,15 @@ static int fbcon_blank(struct vc_data *v
 
  	if (!fbcon_is_inactive(vc, info)) {
 		if (ops->blank_state != blank) {
+			int ret = 1;
+
 			ops->blank_state = blank;
 			fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
 			ops->cursor_flash = (!blank);
 
-			if (fb_blank(info, blank))
+			if (info->fbops->fb_blank)
+				ret = info->fbops->fb_blank(blank, info);
+			if (ret)
 				fbcon_generic_blank(vc, info, blank);
 		}
 

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
