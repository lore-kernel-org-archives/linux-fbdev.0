From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [patch 2/4] fbdev: Add
	fb_append_extra_logo()
Date: Fri, 13 Jul 2007 19:45:34 +0800
Message-ID: <1184327134.4702.6.camel@daplas>
References: <20070710122702.765654000@pademelon.sonytel.be>
	<20070710123540.678435000@pademelon.sonytel.be>
	<1184285757.4566.11.camel@daplas>
	<Pine.LNX.4.62.0707130855360.15603@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9Jav-00047x-Na for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 04:45:57 -0700
Received: from nz-out-0506.google.com ([64.233.162.234])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9Jav-0003Zt-EN
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 04:45:57 -0700
Received: by nz-out-0506.google.com with SMTP id f1so1131640nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 13 Jul 2007 04:45:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0707130855360.15603@pademelon.sonytel.be>
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

On Fri, 2007-07-13 at 08:56 +0200, Geert Uytterhoeven wrote:
> On Fri, 13 Jul 2007, Antonino A. Daplas wrote:
> > On Tue, 2007-07-10 at 14:27 +0200, Geert Uytterhoeven wrote:
> > > --- a/drivers/video/fbmem.c
> > > +++ b/drivers/video/fbmem.c
> > > @@ -318,6 +318,13 @@ static struct logo_data {
> > >  	const struct linux_logo *logo;
> > >  } fb_logo __read_mostly;
> > >  
> > > +#define FB_LOGO_EX_NUM_MAX 10
> > > +static struct logo_data_extra {
> > > +	const struct linux_logo *logo;
> > > +	unsigned int n;
> > > +} fb_logo_ex[FB_LOGO_EX_NUM_MAX];
> > > +static unsigned int fb_logo_ex_num;
> > > +
> > >  static void fb_rotate_logo_ud(const u8 *in, u8 *out, u32 width, u32 height)
> > >  {
> > >  	u32 size = width * height, i;
> > > @@ -411,10 +418,22 @@ static void fb_do_show_logo(struct fb_in
> > >  	}
> > >  }
> > >  
> > > +#ifdef CONFIG_FB
> > 
> > The #ifdef is redundant.
> 
> IIRC, it's needed for the CONFIG_FB=m case.

What would happen if CONFIG_FB=m? (We already have a patch that prevents
logo drawing if the driver or fbcon is modular)

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
