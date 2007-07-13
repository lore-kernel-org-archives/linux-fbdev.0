From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [patch 2/4] fbdev: Add
	fb_append_extra_logo()
Date: Fri, 13 Jul 2007 19:53:53 +0800
Message-ID: <1184327633.4702.11.camel@daplas>
References: <20070710122702.765654000@pademelon.sonytel.be>
	<20070710123540.678435000@pademelon.sonytel.be>
	<1184285757.4566.11.camel@daplas>
	<Pine.LNX.4.62.0707130857350.15603@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9Jio-000524-5u for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 04:54:07 -0700
Received: from nz-out-0506.google.com ([64.233.162.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9Jim-0006Zc-Ps
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 04:54:06 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1135068nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 13 Jul 2007 04:54:04 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0707130857350.15603@pademelon.sonytel.be>
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
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geoff Levand <geoffrey.levand@am.sony.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, cbe-oss-dev@ozlabs.org

On Fri, 2007-07-13 at 08:58 +0200, Geert Uytterhoeven wrote:
> On Fri, 13 Jul 2007, Antonino A. Daplas wrote:
> > On Tue, 2007-07-10 at 14:27 +0200, Geert Uytterhoeven wrote:
> > > --- a/include/linux/linux_logo.h
> > > +++ b/include/linux/linux_logo.h
> > > @@ -33,5 +33,13 @@ struct linux_logo {
> > >  };
> > >  
> > >  extern const struct linux_logo *fb_find_logo(int depth);
> > > +#if defined(CONFIG_LOGO) && defined(CONFIG_FB)
> > 
> > The CONFIG_LOGO is also probably redundant, but that's arguable.
> 
> You can have CONFIG_LOGO without CONFIG_FB (depends on FB ||
> SGI_NEWPORT_CONSOLE).
> 

Okay.

Tony 



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
