From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 1/8] fbcon: Do not touch hardware if vc_mode != KD_TEXT
Date: Thu, 4 Nov 2004 08:58:15 +0800
Message-ID: <200411040857.27129.adaplas@hotpop.com>
References: <200411021946.06302.adaplas@hotpop.com> <200411031030.11430.adaplas@hotpop.com> <20041103155204.7eb2daa3.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPVxn-0002Mg-64
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 16:58:55 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPVxk-0002g1-VK
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 03 Nov 2004 16:58:55 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 697D59456B8
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  4 Nov 2004 00:58:40 +0000 (UTC)
In-Reply-To: <20041103155204.7eb2daa3.akpm@osdl.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org

On Thursday 04 November 2004 07:52, Andrew Morton wrote:
> "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> This patch conflicts with Ben's "fbdev: workaround for broken X servers"
> patch, which is in Linus's tree now.
>
> So fb_blank() will now look like this:
>
> int
> fb_blank(struct fb_info *info, int blank)
> {
> 	int err = -EINVAL;
>
> 	/* Workaround for broken X servers */
> 	if (blank > VESA_POWERDOWN)
> 		blank = VESA_POWERDOWN;
>
> 	if (info->fbops->fb_blank)
>  		err = info->fbops->fb_blank(blank, info);
>
> 	return err;
> }

Yes, that's correct.  Thanks.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
