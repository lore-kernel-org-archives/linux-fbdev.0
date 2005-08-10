From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: cursor maddnes and a solution
Date: Wed, 10 Aug 2005 09:25:30 -0400
Message-ID: <9e473391050810062531d77aa7@mail.gmail.com>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>
	 <42F99B5E.1070309@gmail.com>
	 <9e4733910508092358360f8bc8@mail.gmail.com>
	 <42F9B1C3.2030201@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2qaP-0005H5-SA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 06:25:37 -0700
Received: from wproxy.gmail.com ([64.233.184.197])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2qaO-0003C5-Jk
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 06:25:37 -0700
Received: by wproxy.gmail.com with SMTP id i3so120847wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Aug 2005 06:25:30 -0700 (PDT)
In-Reply-To: <42F9B1C3.2030201@gmail.com>
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@infradead.org>

On 8/10/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> struct fb_cursor_ops {
>         int (*cursor_move)(int x, int y);
>         int (*cursor_show)(int show);
>         int (*cursor_load_image)(u32 *image, int width, int height);
>         int (*cursor_load_color)(struct fb_cmap *cmap);
>         int (*cursor_set_size)(int width, int height);
>         int (*cursor_capabilities)(int set, int caps);
> };

Doen't fb already support an image format with embedded color map? Can
we use it and merge:
>         int (*cursor_load_image)(u32 *image, int width, int height);
>         int (*cursor_load_color)(struct fb_cmap *cmap);

The size can also be computed from the image so the size call can be elimin=
ated.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
