From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2.6.20 1/1] fbdev,
	mm: hecuba/E-Ink fbdev driver
Date: Wed, 21 Feb 2007 18:47:52 -0500
Message-ID: <45a44e480702211547h255c86dax82680c8f20df6d07@mail.gmail.com>
References: <20070217104215.GB25512@localhost> <1171715652.5186.7.camel@lappy>
	<45a44e480702170525n9a15fafpb370cb93f1c1fcba@mail.gmail.com>
	<20070217135922.GA15373@linux-sh.org>
	<45a44e480702180331t7e76c396j1a9861f689d4186b@mail.gmail.com>
	<20070218235741.GA22298@linux-sh.org>
	<45a44e480702192013s7d49d05ai31e576f0448a485e@mail.gmail.com>
	<Pine.LNX.4.62.0702200906070.2082@pademelon.sonytel.be>
	<45a44e480702210855t344441c1xf8e081c82ece4e63@mail.gmail.com>
	<1172101416.4217.19.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HK1Bi-0003Ne-EZ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:47:57 -0800
Received: from ug-out-1314.google.com ([66.249.92.174])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HK1Bi-0004Pq-32
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Feb 2007 15:47:54 -0800
Received: by ug-out-1314.google.com with SMTP id z38so1151935ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 21 Feb 2007 15:47:52 -0800 (PST)
In-Reply-To: <1172101416.4217.19.camel@daplas>
Content-Disposition: inline
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

On 2/21/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> On Wed, 2007-02-21 at 11:55 -0500, Jaya Kumar wrote:
> >
> > You are right. I will need that. I could put that into struct
> > fb_deferred_io. So drivers would setup like:
> >
>
> Is it also possible to let the drivers do the 'deferred_io'
> themselves?  Say, a driver that would flush the dirty pages on
> every VBLANK interrupt.

Yes, I think so. The deferred_io callback that the driver would get
would be to provide them with the dirty pages list. Then, they could
use that to handle the on-vblank work.

> > When the driver calls register_framebuffer and unregister_framebuffer,
> > I can then do the init and destruction of the other members of that
> > struct. Does this sound okay?
>
> It would be better if separate registering functions are created for
> this functionality (ie deferred_io_register/unregister).
>

Ok. Will do it that way.

Thanks,
jaya

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
