From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] fb: sm501fb off-by-1 sysfs store
Date: Thu, 1 Mar 2007 14:25:55 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0703011423060.766@pademelon.sonytel.be>
References: <20070301082456.GA3701@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMlIN-0004Sp-IP for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 05:26:07 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMlIJ-0002UR-1V
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 05:26:04 -0800
In-Reply-To: <20070301082456.GA3701@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>
Cc: Ben Dooks <ben@fluff.org.uk>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thu, 1 Mar 2007, Paul Mundt wrote:
> Currently sm501fb_crtsrc_store() won't allow the routing to be changed
> via echos from userspace in to the sysfs file. The reason for this is
> that the strnicmp() for both heads uses a sizeof() for the string length,
> which ends up being strlen() + 1 (\0 in the normal case, but the echo
> gives a newline, which is where the issue occurs), this then causes a
> mismatch and subsequently bails with the -EINVAL.

> sizeof("string") is great for making sure you have space in your buffer,
> but rather less so for string comparisons :-)

> diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
> index 02b290c..72b5358 100644
> --- a/drivers/video/sm501fb.c
> +++ b/drivers/video/sm501fb.c
> @@ -1074,9 +1074,9 @@ static ssize_t sm501fb_crtsrc_store(struct device *dev,
>  	if (len < 1)
>  		return -EINVAL;
>  
> -	if (strnicmp(buf, "crt", sizeof("crt")) == 0)
> +	if (strnicmp(buf, "crt", 3) == 0)
>  		head = HEAD_CRT;
> -	else if (strnicmp(buf, "panel", sizeof("panel")) == 0)
> +	else if (strnicmp(buf, "panel", 5) == 0)
>  		head = HEAD_PANEL;
>  	else
>  		return -EINVAL;

What about using just `strlen("string")' instead? ISTR gcc optimizes this to a
constant. Not that it matters that much, as the actual string won't be
duplicated.

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
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
