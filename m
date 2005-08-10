From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: cursor maddnes and a solution
Date: Wed, 10 Aug 2005 16:06:46 +0800
Message-ID: <42F9B596.7070206@gmail.com>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>	 <42F99B5E.1070309@gmail.com> <9e4733910508092358360f8bc8@mail.gmail.com> <42F9B1C3.2030201@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2lcL-0004bB-Ln
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 01:07:17 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2lcK-0000iO-Cm
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 01:07:17 -0700
Received: by wproxy.gmail.com with SMTP id i3so77763wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Aug 2005 01:07:10 -0700 (PDT)
In-Reply-To: <42F9B1C3.2030201@gmail.com>
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@gmail.com>

Antonino A. Daplas wrote:

I believe this is also needed, otherwise we'll be stuck with a
rectangular cursor:

> 
> struct fb_cursor_ops {
>     int (*cursor_move)(int x, int y);
>     int (*cursor_show)(int show);
>     int (*cursor_load_image)(u32 *image, int width, int height);
>     int (*cursor_load_color)(struct fb_cmap *cmap);
>     int (*cursor_set_size)(int width, int height);
>     int (*cursor_capabilities)(int set, int caps);
	int (*cursor_load_mask)(u8 *mask);
> };
> 

Also, if u32 *image is always in 32-bit truecolor, then cursor_load_color
may not be needed.

Tony


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
