From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: directcolor colormap question
Date: Mon, 19 Sep 2005 23:00:25 +0800
Message-ID: <432ED289.1010102@gmail.com>
References: <432EC48F.40804@ums.usu.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHN8o-0007oJ-QZ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 08:01:10 -0700
Received: from zproxy.gmail.com ([64.233.162.205])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EHN8n-0001bs-A9
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 19 Sep 2005 08:01:10 -0700
Received: by zproxy.gmail.com with SMTP id i11so1160632nzh
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 19 Sep 2005 08:01:01 -0700 (PDT)
In-Reply-To: <432EC48F.40804@ums.usu.ru>
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
Cc: "Alexander E. Patrakov" <patrakov@ums.usu.ru>

Alexander E. Patrakov wrote:
> Hello,
> 
> I am still writing a framebuffer driver for S3 Trio 3D/2X cards. Since
> this card supports (hardware) gamma correction in Windows 98, I decided
> to implement directcolor visuals (Xorg guys: you can set SR1B to 0x18 if
> bpp>8, and then standard VGA PEL registers will alter the hardware
> colormap).
> 
> The problem here is that I don't know the proper semantics for colormap
> persistence.
> 
> Consider the following scenario:
> 
> fbset -depth 16 -rgba 5,5,5,1 -nonstd 1
> run some program that sets a colormap, e.g. Xorg with the "fbdev" driver
> fbset -depth 16 -rgba 5,6,5,0 -nonstd 1
> (oops, the text is all purple!)

This should not happen, I think.

> 
> The problem is that the program sets the following colormap:
> 
> reg 0 -> (0,0,0)
> reg 1 -> (8,4,8)
> ...
> reg 31 -> (255,125,255)
> reg 32 -> (0,129,0)
> reg 33 -> (0,133,0)
> ...
> reg 62 -> (0,250,0)
> reg 63 -> (0,255,0)
> 
> (i.e. just a linear colormap for 16 bpp). When I switch the framebuffer
> to 15bpp, the colormap persists, but it is no longer a proper colormap
> for that mode! Is this colormap persistence an expected behaviour, or

It is the job of the application to make sure that the colormap is correct
for each mode change.  In this case, it would be fbcon.

> should I somehow initialize the colormap to something sane on depth
> switch?

No, you don't have to do that.

 If that's a bug in my driver, could you please point me where
> some other driver does this colormap initialization?

It might be a bug in the fbcon layer. Try inserting

fbcon_set_palette(vc, color_table) in

drivers/video/console/fbcon.c:fbcon_blank();

	if (mode_switch) {
		struct fb_var_screeninfo var = info->var;

		ops->graphics = 1;

		if (!blank) {
			var.activate = FB_ACTIVATE_NOW | FB_ACTIVATE_FORCE;
			fb_set_var(info, &var);
						<--- insert it here
			ops->graphics = 0;
		}
	}


If the above does not work, insert printk's in all functions in
fbcon.c where fbcon_set_palette() gets called.  Include also the
current virtual console (vc->vc_num)

Tony.



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
