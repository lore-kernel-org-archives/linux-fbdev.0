From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Linux 2.6.16: Cursor trouble on Matrox Millenium
 II framebuffer
Date: Fri, 24 Mar 2006 20:18:30 +0800
Message-ID: <4423E396.7070403@gmail.com>
References: <20060324003155.83478.qmail@web52902.mail.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMlFY-0004xi-Dn
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Mar 2006 04:18:40 -0800
Received: from pproxy.gmail.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FMlFX-00086C-4y
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Mar 2006 04:18:40 -0800
Received: by pproxy.gmail.com with SMTP id z59so662379pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Mar 2006 04:18:38 -0800 (PST)
In-Reply-To: <20060324003155.83478.qmail@web52902.mail.yahoo.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Dave Airlie <airlied@gmail.com>, rankincj@yahoo.com

Chris Rankin wrote:
> --- Dave Airlie <airlied@gmail.com> wrote:
>> Just to let you know what I do, I boot up in text mode, ssh in and
>> modprobe my fb driver then fbcon... I don't touch the console during
>> that time.. if I vt switch and come back it works fine..
> 
> If vt-switching "fixes" things then that would explain why I can't reproduce this bug now.
> 

Can you both try this patch?

Tony

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index eb46629..bf4aeb5 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1142,6 +1142,7 @@ static void fbcon_init(struct vc_data *v
 		set_blitting_type(vc, info);
 	}
 
+	ops->p = &fb_display[fg_console];
 }
 
 static void fbcon_deinit(struct vc_data *vc)


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
