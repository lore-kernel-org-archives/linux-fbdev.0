From: Tero Roponen <teanropo@jyu.fi>
Subject: Re: [Linux-fbdev-devel] fb: modedb uses wrong default_mode
Date: Sat, 18 Nov 2006 12:39:07 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0611181235490.22722@jalava.cc.jyu.fi>
References: <Pine.LNX.4.64.0611151933070.12799@jalava.cc.jyu.fi>
 <20061115152952.0e92c50d.akpm@osdl.org> <20061115234456.GB3674@cosmic.amd.com>
 <Pine.LNX.4.64.0611171919090.9851@pentafluge.infradead.org>
 <20061117124013.b6e4183d.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754385AbWKRKjq@vger.kernel.org>
In-Reply-To: <20061117124013.b6e4183d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: James Simmons <jsimmons@infradead.org>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Fri, 17 Nov 2006, Andrew Morton wrote:
> 
> Here's the current version of this monster patch:
> 
> From: Jordan Crouse <jordan.crouse@amd.com>
> 
> If no default mode is specified, it should be grabbed from the supplied
> database, not the default one.
> 
> [teanropo@jyu.fi: fix it]
> [akpm@osdl.org: simplify it]
> [akpm@osdl.org: remove pointless DEFAULT_MODEDB_INDEX]
> Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "Antonino A. Daplas" <adaplas@pol.net>
> Signed-off-by: Tero Roponen <teanropo@jyu.fi>
> Cc: James Simmons <jsimmons@infradead.org>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/video/modedb.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff -puN drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database drivers/video/modedb.c
> --- a/drivers/video/modedb.c~video-get-the-default-mode-from-the-right-database
> +++ a/drivers/video/modedb.c
> @@ -34,8 +34,6 @@ const char *global_mode_option;
>       *  Standard video mode definitions (taken from XFree86)
>       */
>  
> -#define DEFAULT_MODEDB_INDEX	0
> -
>  static const struct fb_videomode modedb[] = {
>      {
>  	/* 640x400 @ 70 Hz, 31.5 kHz hsync */
> @@ -505,8 +503,10 @@ int fb_find_mode(struct fb_var_screeninf
>  	db = modedb;
>  	dbsize = ARRAY_SIZE(modedb);
>      }
> +
>      if (!default_mode)
> -	default_mode = &modedb[DEFAULT_MODEDB_INDEX];
> +	default_mode = &db[0];
> +
>      if (!default_bpp)
>  	default_bpp = 8;
>  
> _

I'm using neofb and this Works For Me (TM).

Thanks,
Tero Roponen
