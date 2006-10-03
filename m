From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] video: Get the default mode from
 the right database
Date: Tue, 3 Oct 2006 09:04:38 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0610030901070.28197@pademelon.sonytel.be>
References: <20061002225738.GD7716@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GUeKg-000229-9n for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Oct 2006 00:04:50 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GUeKf-000321-H6
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 03 Oct 2006 00:04:50 -0700
In-Reply-To: <20061002225738.GD7716@cosmic.amd.com>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, devel@laptop.org

On Mon, 2 Oct 2006, Jordan Crouse wrote:
> fb_find_mode() is behaving in an non-intuitive way.  When I specify my
> own video mode database, and no default mode, I would have expected it
> to assume the first mode in my database as the default mode.  Instead, it
> uses the built in database:
> 
> > if (!db) {
> >     db = modedb;
> >     dbsize = ARRAY_SIZE(modedb);
> > }
> > if (!default_mode)
> >     default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> 
> Personally, I think this is incorrect - if an alternate database is
> specified, it should be always using that.  Patch is attached.

> --- a/drivers/video/modedb.c
> +++ b/drivers/video/modedb.c
> @@ -506,7 +506,7 @@ int fb_find_mode(struct fb_var_screeninf
>  	dbsize = ARRAY_SIZE(modedb);
>      }
>      if (!default_mode)
> -	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> +	default_mode = &db[DEFAULT_MODEDB_INDEX];
>      if (!default_bpp)
>  	default_bpp = 8;

Although currently DEFAULT_MODEDB_INDEX is defined to be 0, perhaps we need a
more rigorous check now it may apply to the custom video mode database?
Probably you always want the first mode of your custom video mode database to
be the default?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
