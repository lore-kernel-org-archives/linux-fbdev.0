From: James Simmons <jsimmons@infradead.org>
Subject: Re: cursor maddnes and a solution
Date: Thu, 11 Aug 2005 23:40:34 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0508112338410.9641@pentafluge.infradead.org>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org> 
 <42F99B5E.1070309@gmail.com> <9e4733910508092358360f8bc8@mail.gmail.com>
 <42F9B1C3.2030201@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3Lj3-0001DB-5J
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 15:40:37 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E3Lj2-0002Tn-Nj
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 11 Aug 2005 15:40:37 -0700
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@hotpop.com>, Jon Smirl <jonsmirl@gmail.com>


> I don't have anything against hardware cursor support for userspace. And
> I don't even mind if we remove hardware cursor support for fbcon (I don't
> see the benefit anyway).  

Please don't remove hw cursor support from fbcon :-)

> struct fb_cursor_ops {
> 	int (*cursor_move)(int x, int y);
> 	int (*cursor_show)(int show);
> 	int (*cursor_load_image)(u32 *image, int width, int height);
> 	int (*cursor_load_color)(struct fb_cmap *cmap);
> 	int (*cursor_set_size)(int width, int height);
> 	int (*cursor_capabilities)(int set, int caps);
> };

> struct fb_info {
> 	...
> 	struct fb_cursor_ops *cursor_ops;
> 	...
> };

We don't need all that mess. You just have a struct fb_cursor in struct 
fb_info and fill in what data you want. All call fb_cusor when you want to 
alter the hardware state.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
