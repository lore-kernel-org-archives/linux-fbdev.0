From: "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: [RFC: 2.6 patch] drivers/video/: remove unused exports
Date: Mon, 01 May 2006 16:02:57 +0800
Message-ID: <4455C0B1.1070403@pol.net>
References: <20060501071116.GZ3570@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FaTN7-0007aH-II
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 May 2006 01:03:09 -0700
Received: from xproxy.gmail.com ([66.249.82.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FaTN6-00037W-5h
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 May 2006 01:03:09 -0700
Received: by xproxy.gmail.com with SMTP id t4so1688042wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 May 2006 01:03:06 -0700 (PDT)
In-Reply-To: <20060501071116.GZ3570@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net

Adrian Bunk wrote:
> This patch removes the following unused EXPORT_SYMBOL's:
> - fbcvt.c: fb_find_mode_cvt
> - fbmem.c: fb_con_duit
> - fbmem.c: fb_new_modelist
> - macmodes.c: mac_var_to_vmode

mac_var_to_vmode is used by valkyriefb, platinumfb and
controlfb, but they cannot be compiled as modules, so
yes, no need to export this.

> - modedb.c: fb_delete_videomode
> - modedb.c: fb_destroy_modelist

These are meant to be used by other modules, but okay,
we'll just do the exporting later as needed.

> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Antonino Daplas <adaplas@pol.net>



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
