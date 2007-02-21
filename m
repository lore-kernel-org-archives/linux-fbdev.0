From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,
	mm: hecuba/E-Ink	fbdev driver
Date: Thu, 22 Feb 2007 07:43:36 +0800
Message-ID: <1172101416.4217.19.camel@daplas>
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
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK152-0002g8-16 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:41:07 -0800
Received: from nz-out-0506.google.com ([64.233.162.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK151-0002rP-OU
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:41:00 -0800
Received: by nz-out-0506.google.com with SMTP id i11so4195668nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 15:40:59 -0800 (PST)
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Paul Mundt <lethal@linux-sh.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, 2007-02-21 at 11:55 -0500, Jaya Kumar wrote: 
> On 2/20/07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Don't you need a way to specify the maximum deferral time? E.g. a field in
> > fb_info.
> >
> 
> You are right. I will need that. I could put that into struct
> fb_deferred_io. So drivers would setup like:
> 

Is it also possible to let the drivers do the 'deferred_io'
themselves?  Say, a driver that would flush the dirty pages on
every VBLANK interrupt.

> static struct fb_deferred_io hecubafb_defio = {
>         .delay          = HZ,
>         .deferred_io    = hecubafb_dpy_update,
> };
> 
> where that would be:
> struct fb_deferred_io {
>         unsigned long delay;    /* delay between mkwrite and deferred handler */
>         struct mutex lock;      /* mutex that protects the page list */
>         struct list_head pagelist;      /* list of touched pages */
>         struct delayed_work deferred_work;
>         void (*deferred_io)(struct fb_info *info, struct list_head
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

It would be better if separate registering functions are created for
this functionality (ie deferred_io_register/unregister).

Tony



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
