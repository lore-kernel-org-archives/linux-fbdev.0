From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver
Date: Wed, 21 Feb 2007 21:52:16 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702212151190.20620@pentafluge.infradead.org>
References: <20070217104215.GB25512@localhost> <1171715652.5186.7.camel@lappy>
	<45a44e480702170525n9a15fafpb370cb93f1c1fcba@mail.gmail.com> 
	<20070217135922.GA15373@linux-sh.org>
	<45a44e480702180331t7e76c396j1a9861f689d4186b@mail.gmail.com>
	<20070218235741.GA22298@linux-sh.org>
	<45a44e480702192013s7d49d05ai31e576f0448a485e@mail.gmail.com>
	<Pine.LNX.4.62.0702200906070.2082@pademelon.sonytel.be>
	<45a44e480702210855t344441c1xf8e081c82ece4e63@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HJzO0-0000Ji-Hb for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 13:52:28 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HJzNz-0005eo-5C
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 13:52:28 -0800
In-Reply-To: <45a44e480702210855t344441c1xf8e081c82ece4e63@mail.gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>, Geert Uytterhoeven <geert@linux-m68k.org>


Could you make it work without the framebuffer. There are embedded LCD 
displays that have internal memory that need data flushed to them.

On Wed, 21 Feb 2007, Jaya Kumar wrote:

> On 2/20/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Don't you need a way to specify the maximum deferral time? E.g. a field in
> > fb_info.
> > 
> 
> You are right. I will need that. I could put that into struct
> fb_deferred_io. So drivers would setup like:
> 
> static struct fb_deferred_io hecubafb_defio = {
>        .delay          = HZ,
>        .deferred_io    = hecubafb_dpy_update,
> };
> 
> where that would be:
> struct fb_deferred_io {
>        unsigned long delay;    /* delay between mkwrite and deferred handler
> */
>        struct mutex lock;      /* mutex that protects the page list */
>        struct list_head pagelist;      /* list of touched pages */
>        struct delayed_work deferred_work;
>        void (*deferred_io)(struct fb_info *info, struct list_head
> *pagelist); /* callback */
> };
> 
> and the driver would do:
> ...
> info->fbdefio = hecubafb_defio;
> register_framebuffer...
> 
> When the driver calls register_framebuffer and unregister_framebuffer,
> I can then do the init and destruction of the other members of that
> struct. Does this sound okay?
> 
> Thanks,
> jaya
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
