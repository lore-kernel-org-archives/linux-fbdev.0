From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: Re: [PATCH] s3fb: mode selection fixes
Date: Sun, 30 Sep 2007 22:31:37 +0200
Message-ID: <20070930203136.GA1829@localhost.localdomain>
References: <20070930161020.e6a01fa0.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ic5SV-0001qn-FG for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Sep 2007 13:32:12 -0700
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ic5SU-0005yq-OW
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 30 Sep 2007 13:32:11 -0700
Content-Disposition: inline
In-Reply-To: <20070930161020.e6a01fa0.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, Sep 30, 2007 at 04:10:20PM +0200, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch fixes bugs related to mode selection in the s3fb driver:
> - fixes definition of the 32-bit format,
> - fixes wrong error value returned when format is not supported
>   by chip,
> - sets r,g,b length field from the bits_per_pixel value otherwise
>   the fbset fails in simple case like switching depths: 
>   8bpp ->32bpp -> 8bpp
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

NACK

> diff -urp linux-2.6.22/drivers/video/s3fb.c linux-2.6.23/drivers/video/s3fb.c
> --- linux-2.6.22/drivers/video/s3fb.c	2007-07-09 01:32:17.000000000 +0200
> +++ linux-2.6.23/drivers/video/s3fb.c	2007-09-30 13:26:11.000000000 +0200
> @@ -58,7 +58,7 @@ static const struct svga_fb_format s3fb_
>  		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_TRUECOLOR, 2, 4},
>  	{24,  {16, 8, 0}, {8, 8, 0},  {0, 8, 0}, {0, 0, 0}, 0,
>  		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_TRUECOLOR, 1, 2},
> -	{32,  {16, 8, 0}, {8, 8, 0},  {0, 8, 0}, {0, 0, 0}, 0,
> +	{32,  {16, 8, 0}, {8, 8, 0},  {0, 8, 0}, {24, 8, 0}, 0,
>  		FB_TYPE_PACKED_PIXELS, 0,		FB_VISUAL_TRUECOLOR, 1, 2},
>  	SVGA_FORMAT_END
>  };

Why do you think this is correct? I think that the highest byte is usually
just a padding. In one older version of this driver i used 'your' version of
that structure and i perceived problems with some cards (but i forgot which
cards exactly) so perhaps that on some cards the highest byte is not just a
padding, but neither alpha channel.

> +	/* set predefined mode for bits_per_pixel settings */
> +	var->transp.offset = 0;
> +	var->transp.length = 0;
> +	switch(var->bits_per_pixel) {
> +	case 4:
> +	case 8:
> +		var->red.length = 6;
> +		var->red.offset = 0;
> +		var->green = var->red;
> +		var->blue = var->red;
> +		break;
> +	case 16:
> +		var->red.length = 5;
> +		var->blue.length = 5;
> +		if (var->green.length != 6 && var->green.length != 5)
> +			var->green.length = 6;
> +		var->transp.length = 0;
> +		break;
> +	case 32:
> +		var->transp.length = 8;
> +		var->transp.offset = 24;
> +	case 24:
> +		var->red.length = 8;
> +		var->green = var->red;
> +		var->blue = var->red;
> +		break;
> +	default:
> +		printk(KERN_ERR "depth not supported: %u\n", var->bits_per_pixel);
> +		return -EINVAL;
> +	}

This is unnecessary, red, green and blue structures are filled by
svga_match_format().

> - sets r,g,b length field from the bits_per_pixel value otherwise
>   the fbset fails in simple case like switching depths: 
>   8bpp ->32bpp -> 8bpp

This problem is not caused by not not filled length fields (you can examine
that fields by fbset). Problem is in strict interpretation of matching rules
by this driver and in a strange fbset behavior.

When some depth and some color lengths are requested then this driver
(or precisely svga_match_format() ) only changes them up (which is correct
behavior according to some previous email from A. Daplas).

But if you do some partial change of mode using fbset, then fbset uses
previous values for unspecified values of var structure in
FBIOPUT_VSCREENINFO call. For example if you use 32bpp and do
fbset -depth 16, then fbset calls FBIOPUT_VSCREENINFO with arguments
requesting depth 16 but color length 8 for each channel. Better way
is to put zeroes to color lengts (which is what fbset does when you
do something like 'fbset 640x480-60 -depth 16') - workaround is to use
argument -rgba 0,0,0,0  with -depth change using fbset.

I don't really care what is a correct behavior of FBIOPUT_VSCREENINFO,
but it should be consistent, explainable and fix should implement it in
a generic way in svga_match_format() function.

>  	/* Find appropriate format */
>  	rv = svga_match_format (s3fb_formats, var, NULL);
>  	if ((rv < 0) || ((par->chip == CHIP_988_VIRGE_VX) ? (rv == 7) : (rv == 6)))
>  	{		/* 24bpp on VIRGE VX, 32bpp on others */
>  		printk(KERN_ERR "fb%d: unsupported mode requested\n", info->node);
> -		return rv;
> +		return rv < 0 ? rv : -EINVAL;
>  	}

Yes, this is a bug. 'return -EINVAL' is sufficient (as EINVAL is only error
returned by svga_match_format() ) to fix it.

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
