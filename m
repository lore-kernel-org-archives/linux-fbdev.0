From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: Re: [PATCH] fbdev: colormap fixes
Date: Fri, 29 Jul 2005 06:16:48 +0800
Message-ID: <42E95950.2080101@gmail.com>
References: <200507280031.j6S0V3L3016861@hera.kernel.org>	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be> <9e473391050728074573e40038@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DyGgY-0008Vt-9a
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 15:17:02 -0700
Received: from rproxy.gmail.com ([64.233.170.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1DyGgX-0006hR-Qz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Jul 2005 15:17:02 -0700
Received: by rproxy.gmail.com with SMTP id a41so864601rng
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 28 Jul 2005 15:16:53 -0700 (PDT)
In-Reply-To: <9e473391050728074573e40038@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Jon Smirl wrote:
> Can you review this fix for the issues below? I fixed things to
> automatically adjust the number of entries to whatever fits in
> PAGE_SIZE.
>
> diff --git a/drivers/video/fbsysfs.c b/drivers/video/fbsysfs.c
> --- a/drivers/video/fbsysfs.c
> +++ b/drivers/video/fbsysfs.c
> @@ -244,15 +244,15 @@ static ssize_t show_virtual(struct class
>  
>  /* Format for cmap is "%02x%c%4x%4x%4x\n" */
>   
Why is the alpha channel not given the same weight as the RGB? Wouldn't
it be correct to also give it 4 bytes (16 bits)  Also, what would happen if
you exceed 256 entries, you've only alloted a maximum of 256 for the
index?  This will also be a problem because you cannot access cmap entries
past 255.

So, 4 bytes per channel + 4 bytes for the index will be needed per entry,

Tony



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
