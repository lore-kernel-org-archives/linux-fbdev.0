From: James Simmons <jsimmons@infradead.org>
Subject: Re: drawings ops structures
Date: Thu, 22 Aug 2002 10:38:47 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208221038050.9077-100000@maxwell.earthlink.net>
References: <Pine.GSO.4.21.0208192118010.8385-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17hw17-0002Fw-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Aug 2002 10:45:09 -0700
In-Reply-To: <Pine.GSO.4.21.0208192118010.8385-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> Then I start to wonder ...
>   - why are dx and dy in struct fb_image of type __u16, while they are of type
>    __u32 in struct fb_copyarea and struct fb_fillrect?
>   - why is the order of the fields different for each structure?
>     Wouldn't it be better to always use the same order for the common fields,
>     e.g.
>
> 	__u32 dx;
> 	__u32 dy;
> 	__u32 width;
> 	__u32 height;

I cleaned it up. We have now:

struct fb_copyarea {
        __u32 sx;       /* screen-relative */
        __u32 sy;
        __u32 dx;
        __u32 dy;
        __u32 width;
        __u32 height;
};

struct fb_fillrect {
        __u32 dx;       /* screen-relative */
        __u32 dy;
        __u32 width;
        __u32 height;
        __u32 color;
        __u32 rop;
};

struct fb_image {
        __u32 dx;       /* Where to place image */
        __u32 dy;
        __u32 width;    /* Size of image */
        __u32 height;
        __u32 fg_color; /* Only used when a mono bitmap */
        __u32 bg_color;
        __u8  depth;    /* Dpeth of the image */
        char  *data;    /* Pointer to image data */
};



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
