From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 1/4] fbdev: make fb_find_mode
	look	for a mode with the	highest refresh rate
Date: Thu, 12 Jul 2007 16:31:25 +0800
Message-ID: <1184229085.4504.29.camel@daplas>
References: <20070623105046.GB12623@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8u5J-0000T3-5h for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 01:31:37 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8u5H-0002Nj-KB
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 01:31:37 -0700
Received: by py-out-1112.google.com with SMTP id a25so151018pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 01:31:35 -0700 (PDT)
In-Reply-To: <20070623105046.GB12623@spock.one.pl>
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
To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

On Sat, 2007-06-23 at 12:50 +0200, Michal Januszewski wrote:
> If the refresh rate hasn't been explicitly specified, fd_find_mode
> currently returns the first mode with the requested resolution. Change
> it so that it returns a mode with the requested resolution and the
> highest refresh rate.
> 
> Also export fb_destroy_modelist, which is used in uvesafb.
> 
> Signed-off-by: Michal Januszewski <spock@gentoo.org>
> ---
> drivers/video/modedb.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
> index 3741ad7..98ee77b 100644
> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> @@ -606,16 +606,18 @@ done:
>  	DPRINTK("Trying specified video mode%s %ix%i\n",
>  	    refresh_specified ? "" : " (ignoring refresh rate)", xres, yres);
>  
> +	if (!refresh_specified)
> +		refresh = 200;
>  	diff = refresh;

How about..?

	if (!refresh_specified)
		diff = 0;
	else
		diff = refresh;

>  	best = -1;
>  	for (i = 0; i < dbsize; i++) {
>  		if (name_matches(db[i], name, namelen) ||
>  		    (res_specified && res_matches(db[i], xres, yres))) {
>  			if(!fb_try_mode(var, info, &db[i], bpp)) {
> -				if(!refresh_specified || db[i].refresh == refresh)
> +				if (refresh_specified && db[i].refresh == refresh)
>  					return 1;
>  				else {
> -					if(diff > abs(db[i].refresh - refresh)) {
> +					if (diff > abs(db[i].refresh - refresh)) {
>  						diff = abs(db[i].refresh - refresh);
>  						best = i;
>  					}
then
					if (diff < db[i].refresh) {
						diff = db[i].refresh;
						best = i;
					}

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
