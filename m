From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] updated
	proper-backlight-selection-for-fbdev-drivers.patch
Date: Thu, 14 Dec 2006 08:40:02 +0200
Message-ID: <20061214064002.GB12910@sci.fi>
References: <Pine.LNX.4.64.0612131530340.4484@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GukGL-0001m4-1f for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 22:40:13 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GukGI-0002UU-HW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 13 Dec 2006 22:40:13 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612131530340.4484@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Dec 13, 2006 at 03:32:09PM +0000, James Simmons wrote:
> =

> Signed-Off-By: James Simmons <jsimmons@www.infradead.org>
> =

> Here is the updated patch for proper backlight selection.
> =

> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
...
> @@ -1135,8 +1140,7 @@ config FB_ATY_GX
>  =

>  config FB_ATY_BACKLIGHT
>  	bool "Support for backlight control"
> -	depends on FB_ATY && PMAC_BACKLIGHT
> -	select FB_BACKLIGHT
> +	depends on FB_ATY
>  	default y
>  	help
>  	  Say Y here if you want to control the backlight of your display.

Is there some non-Mac hardware on which the backlight control actually =

works? IIRC I tried it on some x86 laptops at some point and it didn't =

do anything, and that is why I added the generic backlight voltage =

on/off thing. Just to be sure I can re-test my laptops next weekend...

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
