From: Woody <woody@suwalski.net>
Subject: Re: [PATCH] cyber2000fb.c: Fix 16bpp mode
Date: Thu, 8 Nov 2007 08:03:41 -0500
Message-ID: <4733092D.3010104@suwalski.net>
References: <000501c81e5e$c1334160$4399c420$@nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iq72K-00008Q-E8 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Nov 2007 05:03:08 -0800
Received: from ottmail.xandros.com ([142.46.212.35])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Iq72J-0005xO-Qc
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Nov 2007 05:03:08 -0800
In-Reply-To: <20071108082159.GB23626@deprecation.cyrius.com>
References: <20071108082159.GB23626@deprecation.cyrius.com>
Content-Disposition: inline
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
To: Martin Michlmayr <tbm@cyrius.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Jan Rinze <janrinze@home.nl>

Martin Michlmayr wrote:
> Jan Rinze noticed that 16bpp screen mode is not working on Netwinder:
> "After some deduction it appeared that it was running in 24bpp instead
> of 16bpp. Found the bug: a missing 'break' statement at the end of a
> switch case.  After adding the break statement 16bpp works fine."
>
> Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
> Cc: Jan Rinze <janrinze@home.nl>
> Cc: Woody Suwalski <woody@suwalski.net>
>
> --- a/drivers/video/cyber2000fb.c
> +++ b/drivers/video/cyber2000fb.c
> @@ -874,6 +874,8 @@ static int cyber2000fb_set_par(struct fb_info *info)
>  		default:
>  			BUG();
>  		}
> +		break;
> +
>  	case 24:/* TRUECOLOUR, 16m */
>  		hw.co_pixfmt		= CO_PIXFMT_24BPP;
>  		hw.width		*= 3;
>
>   
Yes, with the above bug fix I have tested that 16-bit X fbdev works OK.
Woody


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
