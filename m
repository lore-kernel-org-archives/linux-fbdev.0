From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.11-rc5
Date: Sat, 26 Feb 2005 12:13:09 +1100
Message-ID: <1109380389.15026.112.camel@gaston>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <20050224145049.GA21313@suse.de>  <20050226004137.GA25539@suse.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D4qX3-000054-UZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 17:14:09 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D4qX3-0004Y9-1F
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 25 Feb 2005 17:14:09 -0800
In-Reply-To: <20050226004137.GA25539@suse.de>
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
To: Olaf Hering <olh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, 2005-02-26 at 01:41 +0100, Olaf Hering wrote:

> 
> modedb can not be __init because fb_find_mode() may get db == NULL.
> fb_find_mode() is called from modules.

Ahhh, good catch ! I though that was fixed long ago, looks like I was
wrong.

Ben.

> Signed-off-by: Olaf Hering <eolh@suse.de>
> 
> diff -purNx tags linux-2.6.11-rc5.orig/drivers/video/modedb.c linux-2.6.11-rc5/drivers/video/modedb.c
> --- linux-2.6.11-rc5.orig/drivers/video/modedb.c	2005-02-24 17:40:24.000000000 +0100
> +++ linux-2.6.11-rc5/drivers/video/modedb.c	2005-02-26 01:37:43.138003474 +0100
> @@ -37,7 +37,7 @@ const char *global_mode_option;
>  
>  #define DEFAULT_MODEDB_INDEX	0
>  
> -static const __init struct fb_videomode modedb[] = {
> +static const struct fb_videomode modedb[] = {
>      {
>  	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
>  	NULL, 70, 640, 400, 39721, 40, 24, 39, 9, 96, 2,
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
