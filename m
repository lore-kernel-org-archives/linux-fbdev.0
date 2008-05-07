From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [Linux-fbdev-devel] [PATCH 7/9] viafb: VIA Frame Buffer Device
 Driver
Date: Wed, 7 May 2008 18:50:14 +0200
Message-ID: <20080507185014.d15da044.krzysztof.h1@poczta.fm>
References: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F6775A@exchtp03.taipei.via.com.tw>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762976AbYEGQva@vger.kernel.org>
In-Reply-To: <C80EF34A3D2E494DBAF9AC29C7AE4EB806F6775A@exchtp03.taipei.via.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: JosephChan@via.com.tw
Cc: akpm@linux-foundation.org, geert@linux-m68k.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, 7 May 2008 19:09:44 +0800
<JosephChan@via.com.tw> wrote:

> Signed-off-by: Joseph Chan <josephchan@via.com.tw>
> 
> diff -Nur a/drivers/video/via/viafbdev.h b/drivers/video/via/viafbdev.h
> --- a/drivers/video/via/viafbdev.h	1969-12-31 19:00:00.000000000 -0500
> +++ b/drivers/video/via/viafbdev.h	2008-04-29 04:27:46.000000000 -0400
> @@ -0,0 +1,114 @@

(...)
> +
> +struct viafb_par {
> +	struct fb_var_screeninfo var;
> +	int bpp;
> +	int hres;
> +	int vres;
> +	int linelength;
> +	int vclk;		/*in MHz */
> +
> +	int vtotal;
> +	int vdispend;
> +	int vsyncstart;
> +	int vsyncend;
> +	int vblankstart;
> +	int vblankend;
> +
> +	int htotal;
> +	int hdispend;
> +	int hsyncstart;
> +	int hsyncend;
> +	int hblankstart;
> +	int hblankend;
> +
> +	int accel;		/* Acceleration Flags */

A random pick of "accel", "hblankstart" and "hblankend" shows that they are only set and never checked. Try to remove all unused fields here.

Regards,
Krzysztof

----------------------------------------------------------------------
Lepszy niz zakladki. 	
Kliknij >>> http://link.interia.pl/f1db1
