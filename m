From: Andrew Morton <akpm@osdl.org>
Subject: Re: Third repost: freq_rounding.patch
Date: Wed, 13 Jul 2005 15:37:00 -0700
Message-ID: <20050713153700.03a26e06.akpm@osdl.org>
References: <9e47339105071315225ebfe20b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DspqJ-0006Of-KN
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:36:39 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx2.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1DspqG-0003zT-HT
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 13 Jul 2005 15:36:39 -0700
In-Reply-To: <9e47339105071315225ebfe20b@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> Can we get this into the kernel? 
> 
> --
> Jon Smirl
> jonsmirl@gmail.com
> 
> #Fix rounding error when mode frequency is very close to monitor limit
> #Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
> --- a/drivers/video/fbmon.c
> +++ b/drivers/video/fbmon.c
> @@ -1241,6 +1241,8 @@ int fb_validate_mode(const struct fb_var
>                vtotal *= 2;
> 
>        hfreq = pixclock/htotal;
> +       hfreq = (hfreq + 500) / 1000 * 1000;
> +
>        vfreq = hfreq/vtotal;
> 
>        return (vfreq < vfmin || vfreq > vfmax ||

Yes, I'll stick these in unless someone complains.

Please don't send patches like this in the future, however:

a) Don't use a filename as the Subject:.  Use a real English-language
   description.

b) Don't add stuff like hashes to the changelog - others just have to go
   and edit it all away.

c) Don't use an email client which converts tabs to spaces.

See http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
