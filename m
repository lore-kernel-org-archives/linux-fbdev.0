From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: PATCH
Date: Sun, 22 Feb 2004 17:08:29 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040222160829.GA1522@dreamland.darkstar.lan>
References: <1077410677.9577.4.camel@localhost.localdomain>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuwHD-0006Ri-Lb
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 08:16:19 -0800
Received: from mailr-2.tiscali.it ([212.123.84.82])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuwA7-0004Ib-7E
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 08:08:59 -0800
Content-Disposition: inline
In-Reply-To: <1077410677.9577.4.camel@localhost.localdomain>
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
To: Pete Popov <pete_popov@yahoo.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Il Sat, Feb 21, 2004 at 04:44:37PM -0800, Pete Popov ha scritto: 
> diff -Naur --exclude=CVS linux-2.4-orig/drivers/video/Config.in linux-2.4-dev/drivers/video/Config.in
> --- linux-2.4-orig/drivers/video/Config.in	2004-01-13 21:51:28.000000000 -0800
> +++ linux-2.4-dev/drivers/video/Config.in	2004-02-21 16:19:24.000000000 -0800
> @@ -159,6 +159,7 @@
>  	    bool '    SIS 300 series support' CONFIG_FB_SIS_300
>  	    bool '    SIS 315/330 series support' CONFIG_FB_SIS_315
>  	 fi
> +	 bool '  SiliconMotion 501 Driver' CONFIG_FB_SMI501
>  	 tristate '  NeoMagic display support (EXPERIMENTAL)' CONFIG_FB_NEOMAGIC
>  	 tristate '  3Dfx Banshee/Voodoo3 display support (EXPERIMENTAL)' CONFIG_FB_3DFX
>  	 tristate '  3Dfx Voodoo Graphics (sst1) support (EXPERIMENTAL)' CONFIG_FB_VOODOO1

Why bool? It doesn't work as a module?

Luca
-- 
Home: http://kronoz.cjb.net
Non ho ancora capito se il mio cane e` maschio o femmina:
quando fa la pipi` si chiude in bagno


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
