From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb: remove dead code
Date: Sun, 26 Aug 2007 18:36:18 +0300
Message-ID: <20070826153618.GB6003@sci.fi>
References: <20070826091237.GA17667@aepfle.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPKA5-0006Lg-4U for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 08:36:25 -0700
Received: from smtp4.pp.htv.fi ([213.243.153.38])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPKA3-00049G-KA
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 08:36:25 -0700
Content-Disposition: inline
In-Reply-To: <20070826091237.GA17667@aepfle.de>
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
To: Olaf Hering <olaf@aepfle.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sun, Aug 26, 2007 at 11:12:37AM +0200, Olaf Hering wrote:
> Remove dead code.
> =

> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> =

> ---
>  drivers/video/aty/atyfb_base.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> =

> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -2767,8 +2767,7 @@ static int atyfb_blank(int blank, struct
>  	if (par->lock_blank || par->asleep)
>  		return 0;
>  =

> -#ifdef CONFIG_FB_ATY_BACKLIGHT
> -#elif defined(CONFIG_FB_ATY_GENERIC_LCD)
> +#ifdef CONFIG_FB_ATY_GENERIC_LCD
>  	if (par->lcd_table && blank > FB_BLANK_NORMAL &&
>  	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
>  		u32 pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);

This will change the behavior of the code. I basically agree with the
change because the current code will not control the backlight when the
kernel is built with CONFIG_FB_ATY_BACKLIGHT but the system doesn't
support the backlight interface (ie. non-pmac system). However someone
should check that it doesn't cause problems for pmac users.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
