From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Tue, 9 Sep 2003 22:45:44 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030909204544.GA16724@dreamland.darkstar.lan>
References: <1062960554.647.34.camel@gaston> <Pine.LNX.4.44.0309090054470.23354-100000@phoenix.infradead.org> <20030909175404.GA8039@dreamland.darkstar.lan> <1063131198.642.5.camel@gaston> <20030909192430.GA10981@dreamland.darkstar.lan> <1063136237.639.42.camel@gaston>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wpOM-0007Vk-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 13:47:14 -0700
Received: from mail-2.tiscali.it ([195.130.225.148])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wpOL-000596-Ln
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 Sep 2003 13:47:13 -0700
Content-Disposition: inline
In-Reply-To: <1063136237.639.42.camel@gaston>
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
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Tue, Sep 09, 2003 at 09:37:17PM +0200, Benjamin Herrenschmidt ha scritto: 
> > Most of work consists in changing "." into "->" ;)
> > Changes to fbmem.c are very similar to Greg KH's patch:
> 
> You probably want to fix more drivers , that would help getting
> it merged.

I sent radeonfb as an example. I've already fixed chipsfb.c, cyber2000fb.c,
hgafb.c, imsttfb.c, neofb.c, tdfxfb.c, tridentfb.c, vesafb.c and i810.

> Some comments though:
> 
> >+static void release_fb_info(struct class_device *class_dev) {
> >+       struct fb_info *info = to_fb_info(class_dev);
> >+
> >+       if (info->release)
> >+               info->release(info);
> >+       
> >+       kfree(info);
> >+}
> 
> Since you provide the implicit kfree(), 

Implicit? What do you mean?

> you should also provide an
> framebuffer_alloc() some for consistency imho. That would take the
> size of the private structure like for netdevs and allocate both.

Like this?

struct fb_info *framebuffer_alloc(size_t size, struct device *dev) {
        struct fb_info *ret;

        ret = kmalloc(sizeof(struct fb_info) + size, GFP_KERNEL);
        if (!ret)
                return NULL;
        memset(ret, 0, sizeof(struct fb_info) + size);

        ret->class_dev.dev = dev;

        if (size)
                ret->par = ret + 1;

        return ret;
}

> > +static struct class fb_class = {
> > +	.name		= "video",
> 
> I'd rather use "display" here. "video" is too broad and will cause
> confusion with multimedia stuff.

Ok.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
K.R.O.N.O.S
Kinetic Replicant Optimized for Nocturnal Observation and Sabotage


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
