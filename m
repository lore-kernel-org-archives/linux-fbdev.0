From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Tue, 09 Sep 2003 21:37:17 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063136237.639.42.camel@gaston>
References: <1062960554.647.34.camel@gaston>
	 <Pine.LNX.4.44.0309090054470.23354-100000@phoenix.infradead.org>
	 <20030909175404.GA8039@dreamland.darkstar.lan>
	 <1063131198.642.5.camel@gaston>
	 <20030909192430.GA10981@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19woJw-0005L7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 12:38:36 -0700
Received: from pentafluge.infradead.org ([213.86.99.235])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 19woJv-00011D-I3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 12:38:35 -0700
In-Reply-To: <20030909192430.GA10981@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Kronos <kronos@kronoz.cjb.net>
Cc: James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 2003-09-09 at 21:24, Kronos wrote:

> Most of work consists in changing "." into "->" ;)
> Changes to fbmem.c are very similar to Greg KH's patch:

You probably want to fix more drivers , that would help getting
it merged. I will take care of all the pmac ones (controlfb,
platinumfb, valkyriefb) and I can take care of aty128fb,
chipsfb and radeonfb too if necessary.

Some comments though:

>+static void release_fb_info(struct class_device *class_dev) {
>+       struct fb_info *info = to_fb_info(class_dev);
>+
>+       if (info->release)
>+               info->release(info);
>+       
>+       kfree(info);
>+}

Since you provide the implicit kfree(), you should also provide an
framebuffer_alloc() some for consistency imho. That would take the
size of the private structure like for netdevs and allocate both.

> +static struct class fb_class = {
> +	.name		= "video",

I'd rather use "display" here. "video" is too broad and will cause
confusion with multimedia stuff.

Ben.




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
