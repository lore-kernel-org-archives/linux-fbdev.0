From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: vesafb
Date: Thu, 08 Jun 2006 08:32:49 +0800
Message-ID: <44877031.80409@gmail.com>
References: <bb9a78950606051102s514075aar7924d05756ccd3c1@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fo8qj-0008VW-DR for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 17:58:13 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fo8qj-0007bV-1k for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 17:58:13 -0700
Received: from py-out-1112.google.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fo8qj-00054J-2C
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 17:58:13 -0700
Received: by py-out-1112.google.com with SMTP id i49so371457pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 07 Jun 2006 17:58:12 -0700 (PDT)
In-Reply-To: <bb9a78950606051102s514075aar7924d05756ccd3c1@mail.gmail.com>
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

Nathan King wrote:
> Hey folks,
> 
> I'm trying to get a feel for how all this works as I get ready to really
> start monkeying with the driver, so I liberally sprinkled some printk's
> around vesafb.c and cfb_fillrect.c and recompiled. However I only ever
> get messages from three of the vesafb.c functions, all on bootup, and
> none from cfb_fillrect.c. I know doing all those messages will slow down
> my system(or they would if they worked right) but I'm just trying to
> figure out what files control what.
> 
> So my question is, which files are responsible for all these constant
> fillrect and bitblt operations, and can they monkeyed with to generate
> kernel or other messages?

fillrect is called by ops->fill and ops->clear_margins.  The first one
should be called when scrolling the screen, while the second will be
called if xres is not divisible by the fontwidth or yres is not divisible
by the fontheight.

Tony
