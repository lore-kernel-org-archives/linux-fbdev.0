From: Luca <kronos@people.it>
Subject: Re: unpriv'd 2.6.12-rc4 oops reading /sys/module/intelfb/parameters/*
Date: Fri, 13 May 2005 21:14:20 +0200
Message-ID: <20050513191420.GB7891@dreamland.darkstar.lan>
References: <1115995414.5648.64.camel@mcmanus.datapower.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DWfc9-0005RG-Q7
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 12:14:25 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DWfc6-0005Zc-KZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 May 2005 12:14:25 -0700
Content-Disposition: inline
In-Reply-To: <1115995414.5648.64.camel@mcmanus.datapower.com>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Patrick McManus <mcmanus@ducksong.com>

Il Fri, May 13, 2005 at 10:43:34AM -0400, patrick mcmanus ha scritto: 
> Signed-off-by: Patrick McManus <mcmanus@ducksong.com>
> 
> Index: drivers/video/intelfb/intelfbdrv.c
> ===================================================================
> --- b44e6db42c986f858d2487a6a41ee0cbdd2cf670/drivers/video/intelfb/intelfbdrv.c  (mode:100644 sha1:549e229392604359f46ed629d916b4ea89674226)
> +++ uncommitted/drivers/video/intelfb/intelfbdrv.c  (mode:100644)
> @@ -228,17 +228,17 @@
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_DEVICE_TABLE(pci, intelfb_pci_table);
>  
> -static int accel        __initdata = 1;
> -static int vram         __initdata = 4;
> -static int hwcursor     __initdata = 1;
> -static int mtrr         __initdata = 1;
> -static int fixed        __initdata = 0;
> -static int noinit       __initdata = 0;
> -static int noregister   __initdata = 0;
> -static int probeonly    __initdata = 0;
> -static int idonly       __initdata = 0;
> -static int bailearly    __initdata = 0;
> -static char *mode       __initdata = NULL;
> +static int accel        = 1;
> +static int vram         = 4;
> +static int hwcursor     = 1;
> +static int mtrr         = 1;
> +static int fixed        = 0;
> +static int noinit       = 0;
> +static int noregister   = 0;
> +static int probeonly    = 0;
> +static int idonly       = 0;
> +static int bailearly    = 0;
> +static char *mode       = NULL;

Hi,
while you are at it, initializing static vars to 0 (or NULL) is
superfluous and take them out of BSS.

Luca
-- 
Home: http://kronoz.cjb.net
"L'amore consiste nell'essere cretini insieme." -- P. Valery


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
