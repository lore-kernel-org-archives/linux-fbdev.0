From: "Buttchereit, Axel (XL)" <XL@XLsigned.net>
Subject: Re: [patch] allow fb_find_mode() w/ default db
 from modules
Date: Thu, 10 Feb 2005 17:37:14 +0100
Message-ID: <420B8DBA.50105@XLsigned.net>
References: <420B8AEE.5090500@arcom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CzHJn-00016V-Lf
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 08:37:27 -0800
Received: from mail.goracer.de ([62.75.192.134])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CzHJl-0006eC-0A
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 10 Feb 2005 08:37:27 -0800
In-Reply-To: <420B8AEE.5090500@arcom.com>
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

Is there any reason why this has been originally flagged "__init"?
"vesa_modes" is not "__init". That's why I changed "intelfb" to
use "vesa_modes".

--Axel   

David Vrabel wrote:
> Remove the __init from modedb in modedb.c so it can be used from modules
> as the default db in fb_find_mode().
> 
> Signed-off-by: David Vrabel
> 
> Index: linux-2.6-i386/drivers/video/modedb.c
> ===================================================================
> --- linux-2.6-i386.orig/drivers/video/modedb.c	2005-02-10
> 15:54:58.682358203 +0000
> +++ linux-2.6-i386/drivers/video/modedb.c	2005-02-10 15:57:29.956725460
> +0000
> @@ -39,7 +39,7 @@
> 
>  #define DEFAULT_MODEDB_INDEX	0
> 
> -static const __init struct fb_videomode modedb[] = {
> +static const struct fb_videomode modedb[] = {
>      {
>  	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
>  	NULL, 70, 640, 400, 39721, 40, 24, 39, 9, 96, 2,


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
