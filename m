From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: cursor maddnes and a solution
Date: Wed, 10 Aug 2005 15:50:27 +0800
Message-ID: <42F9B1C3.2030201@gmail.com>
References: <Pine.LNX.4.56.0508090115420.2749@pentafluge.infradead.org>	 <42F99B5E.1070309@gmail.com> <9e4733910508092358360f8bc8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E2lMa-0003cV-FQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 00:51:00 -0700
Received: from wproxy.gmail.com ([64.233.184.196])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1E2lMZ-00051u-CC
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Aug 2005 00:51:00 -0700
Received: by wproxy.gmail.com with SMTP id i21so74032wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Aug 2005 00:50:53 -0700 (PDT)
In-Reply-To: <9e4733910508092358360f8bc8@mail.gmail.com>
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@gmail.com>

Jon Smirl wrote:
> 
> The hardware mouse cursor is relevant in graphics mode because you may
> not be able to generate screens in real time. If you can't the
> software mouse cursor lags and may become unusable. Hardware mouse
> cursor eliminates this problem.
> 

I don't have anything against hardware cursor support for userspace. And
I don't even mind if we remove hardware cursor support for fbcon (I don't
see the benefit anyway).  What I don't want is using fbops->fb_cursor
to support a userspace hardware cursor.  In it's current incarnation
it is just wrong.  Besides being a multiplexer with a 100-byte parameter,
it also requires information that are internal to fbdev only. And even if
we manage to make it work, we'll end up with a function with a multiple
personality disorder, it behaves differently when client is fbcon, and
changes behavior again when the client is userspace.

So let's keep fbops->fb_cursor for fbcon use only.  Better yet, let fbcon
call soft_cursor unconditionally, remove hardware cursor from all drivers,
then overhaul fbops->fb_cursor. Or if people think this is too radical,
let's create a new cursor API and gradually phase out the old API, as
proposed in my previous post. Here's one:

struct fb_cursor_ops {
	int (*cursor_move)(int x, int y);
	int (*cursor_show)(int show);
	int (*cursor_load_image)(u32 *image, int width, int height);
	int (*cursor_load_color)(struct fb_cmap *cmap);
	int (*cursor_set_size)(int width, int height);
	int (*cursor_capabilities)(int set, int caps);
};

struct fb_info {
	...
	struct fb_cursor_ops *cursor_ops;
	...
};

In cursor_load_image, we can make image to be always 32-bit truecolor and
just let the driver convert it to something the hardware can support.

In cursor_capabilities, it will either set the capabilities, or get it.
int caps may be t0o small to describe the capabilities so this can be changed.

Tony

 


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
