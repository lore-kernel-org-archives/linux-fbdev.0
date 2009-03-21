From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [PATCH] atyfb: speed up Mach64 cursor
Date: Sat, 21 Mar 2009 22:01:03 +0200
Message-ID: <20090321200103.GU10127@sci.fi>
References: <20090317220443.d8dd67bb.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <syrjala@sci.fi>) id 1Ll7Ng-000470-Fl
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Mar 2009 20:01:20 +0000
Received: from smtp5.welho.com ([213.243.153.39])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ll7Nd-00065U-IE for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Mar 2009 20:01:20 +0000
Content-Disposition: inline
In-Reply-To: <20090317220443.d8dd67bb.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Tue, Mar 17, 2009 at 10:04:43PM +0100, Krzysztof Helt wrote:
> --- a/drivers/video/aty/mach64_cursor.c
> +++ b/drivers/video/aty/mach64_cursor.c
> @@ -77,9 +77,13 @@ static int atyfb_cursor(struct fb_info *info, struct f=
b_cursor *cursor)
>  	if (par->asleep)
>  		return -EPERM;
>  =

> -	/* Hide cursor */
>  	wait_for_fifo(1, par);
> -	aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par) & ~HWCURSOR_=
ENABLE, par);
> +	if (cursor->enable)
> +		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
> +			    | HWCURSOR_ENABLE, par);
> +	else =

> +		aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par)
> +				& ~HWCURSOR_ENABLE, par);


It looks like you are now enabling the cursor before the cursor image
is loaded or the cursor is moved to the correct position so the user
could briefly see a corrupted and/or misplaced cursor.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

---------------------------------------------------------------------------=
---
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
