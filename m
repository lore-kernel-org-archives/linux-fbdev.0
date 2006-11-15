From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] fb: modedb uses wrong
	default_mode
Date: Wed, 15 Nov 2006 15:29:52 -0800
Message-ID: <20061115152952.0e92c50d.akpm@osdl.org>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GkUD0-0007DD-0s for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 15:30:22 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GkUCv-00073p-0m
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 15 Nov 2006 15:30:21 -0800
In-Reply-To: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
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
To: Tero Roponen <teanropo@jyu.fi>
Cc: Jordan Crouse <jordan.crouse@amd.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 19:43:16 +0200 (EET)
Tero Roponen <teanropo@jyu.fi> wrote:

> 
> It seems that default_mode is always overwritten in
> fb_find_mode() if caller gives its own modedb; this
> patch should fix it.
> 
> dmesg diff before and after the following patch:
> 
>  neofb: mapped framebuffer at c4a80000
>  -Mode (640x400) won't display properly on LCD
>  -Mode (640x400) won't display properly on LCD
>  -neofb v0.4.2: 2048kB VRAM, using 640x480, 31.469kHz, 59Hz
>  -Console: switching to colour frame buffer device 80x30
>  +neofb v0.4.2: 2048kB VRAM, using 800x600, 37.878kHz, 60Hz
>  +Console: switching to colour frame buffer device 100x37
>   fb0: MagicGraph 128XD frame buffer device
> 
> Signed-off-by: Tero Roponen <teanropo@jyu.fi>
> ---
> 
> --- linux-2.6.19-rc5-mm2/drivers/video/modedb.c.orig	2006-11-15 19:03:03.000000000 +0200
> +++ linux-2.6.19-rc5-mm2/drivers/video/modedb.c	2006-11-15 19:02:57.000000000 +0200
> @@ -507,7 +507,7 @@ int fb_find_mode(struct fb_var_screeninf
>      }
>      if (!default_mode && db != modedb)
>  	default_mode = &db[0];
> -    else
> +    else if (!default_mode)
>  	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
>  
>      if (!default_bpp)

Sigh.

2.6.19-rc5 has:

    if (!default_mode)
	default_mode = &modedb[DEFAULT_MODEDB_INDEX];

and Jordan changed it to

    if (!default_mode && db != modedb)
	default_mode = &db[0];
    else
	default_mode = &modedb[DEFAULT_MODEDB_INDEX];

and you want to change it to

    if (!default_mode && db != modedb)
	default_mode = &db[0];
    else if (!default_mode)
	default_mode = &modedb[DEFAULT_MODEDB_INDEX];

which is actually a complicated way of doing

    if (!default_mode)
	default_mode = &db[DEFAULT_MODEDB_INDEX];

So let's do that.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
