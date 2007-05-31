From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 7/8] [RESEND] fbdev: fbcon: Console
 unregistration from unregister_framebuffer
Date: Thu, 31 May 2007 15:39:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0705311538210.1591@pademelon.sonytel.be>
References: <465ECDBE.6010700@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Htksi-0003Jx-VN for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:40:01 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Htksh-0004ed-JM
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 May 2007 06:40:00 -0700
In-Reply-To: <465ECDBE.6010700@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jesse Barnes <jesse.barnes@intel.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

On Thu, 31 May 2007, Antonino A. Daplas wrote:
> The previous patch has a minor bug, please drop it.

But the new one introduced a new problem...

> Geert,
> 
> Is this patch suitable for your needs?

I'll check it out. Thx!

> --- a/drivers/video/console/fbcon.c
> +++ b/drivers/video/console/fbcon.c
> @@ -3003,6 +3003,45 @@ static int fbcon_mode_deleted(struct fb_
>  	return found;
>  }
>  
> +#ifdef CONFIG_VT_HW_CONSOLE_BINDING
> +static int fbcon_unbind(void)
> +{
> +	int ret;
> +
> +	ret = unbind_con_driver(&fb_con, first_fb_vc, last_fb_vc,
> +				fbcon_is_default);
> +	return ret;
> +}
> +#else
> +static fbcon_unbind(void)
          ^^^
Missing int (the previous one did have this).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
