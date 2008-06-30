From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 7/13] viafb: iface.c, iface.h,
	ioctl.c, ioctl.h
Date: Mon, 30 Jun 2008 21:52:11 +0200
Message-ID: <4869396B.8060401@gmail.com>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7804@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KDPSR-0005YS-2Q for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 12:54:39 -0700
Received: from mu-out-0910.google.com ([209.85.134.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KDPSP-0007OV-B4
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 30 Jun 2008 12:54:39 -0700
Received: by mu-out-0910.google.com with SMTP id g7so761425muf.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 30 Jun 2008 12:54:31 -0700 (PDT)
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB8074E7804@exchtp03.taipei.via.com.tw>
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
To: JosephChan@via.com.tw
Cc: geert@linux-m68k.org, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

> diff -Nur a/drivers/video/via/ioctl.h b/drivers/video/via/ioctl.h
> --- a/drivers/video/via/ioctl.h	1970-01-01 08:00:00.000000000 +0800
> +++ b/drivers/video/via/ioctl.h	2008-06-30 08:53:33.000000000 +0800
> @@ -0,0 +1,212 @@
[...]
> +struct device_t {
> +	unsigned short crt:1;
> +	unsigned short dvi:1;
> +	unsigned short lcd:1;
> +	unsigned short samm:1;
> +	unsigned short primary_dev;
> +
> +	unsigned short lcd_dsp_cent:1;
> +	unsigned char lcd_panel_id;
> +	unsigned char lcd_mode:1;
> +
> +	unsigned short xres, yres;
> +	unsigned short xres1, yres1;
> +	unsigned short refresh;
> +	unsigned short bpp;
> +	unsigned short refresh1;
> +	unsigned short bpp1;
> +	unsigned short sequence;
> +
> +	unsigned short epia_dvi:1;
> +	unsigned short lcd_dual_edge:1;
> +	unsigned short bus_width;
> +	unsigned short lcd2:1;
> +};

Bitfields suck (and generate ugly code).

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
