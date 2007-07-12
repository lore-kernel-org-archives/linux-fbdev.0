From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] pxafb: Add support for
	other	palette formats
Date: Thu, 12 Jul 2007 16:01:28 +0800
Message-ID: <1184227288.4504.16.camel@daplas>
References: <200707031607.08511.hjk@linutronix.de>
	<468A6159.6000808@grupopie.com> <200707031703.53102.hjk@linutronix.de>
	<18058.28725.106989.860166@ipc1.karo>
	<Pine.LNX.4.64.0707031756490.13482@anakin>
	<1184226980.4504.14.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8tcK-0005o2-OW for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 01:01:53 -0700
Received: from nz-out-0506.google.com ([64.233.162.236])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8tcK-0000Ng-6S
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jul 2007 01:01:40 -0700
Received: by nz-out-0506.google.com with SMTP id f1so140365nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jul 2007 01:01:36 -0700 (PDT)
In-Reply-To: <1184226980.4504.14.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: "Geert.Uytterhoeven" <Geert.Uytterhoeven@sonycom.com>, Thomas Gleixner <tglx@linutronix.de>, Paulo Marques <pmarques@grupopie.com>, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, 2007-07-12 at 15:56 +0800, Antonino A. Daplas wrote:
> On Tue, 2007-07-03 at 17:58 +0200, Geert Uytterhoeven wrote:
> > On Tue, 3 Jul 2007, Lothar Wassmann wrote:
> > > > Can userspace applications work with such a weired format?
> > > > If yes, I'm looking forward to your patch.
> > > > 
> > > At least framebuffer consoles don't work with that. So you should
> > > add a configuration option that allows enabling the strange PXA pixel
> > > formats only when CONFIG_FRAMEBUFFER_CONSOLE is not set.
> > 
> > Of course framebuffer consoles handle that!
> > 
> > Just make sure to implement proper fb_ops.fb_{fillrect,copyarea,imageblit}().
> 
> As long as it is in packed-pixel format, the generic drawing libraries
> should be able to handle that.  Make sure that info->pseudo_palette[] is
> correctly filled.

My mistake, copyarea and fillrect won't be able to handle that, but
imageblit should.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
