From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: tty-related oops in latest kernel(s)?
Date: Thu, 31 May 2007 07:14:46 +0800
Message-ID: <1180566886.4570.14.camel@daplas>
References: <84144f020705280022lf3902caj1def02ed56e0bff@mail.gmail.com>
	<84144f020705280234g39aa04b3hfe369f4477e6043d@mail.gmail.com>
	<Pine.LNX.4.64.0705291900001.32656@jalava.cc.jyu.fi>
	<84144f020705291157k465ec6c4sb81081844bb57514@mail.gmail.com>
	<Pine.LNX.4.64.0705300654493.5241@jalava.cc.jyu.fi>
	<84144f020705292254o319f6619m787bf29491c92509@mail.gmail.com>
	<Pine.LNX.4.64.0705301458400.4634@jalava.cc.jyu.fi>
	<20070530083953.9909bcef.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0705301857370.29485@jalava.cc.jyu.fi>
	<20070530090945.ab9d51d9.akpm@linux-foundation.org>
	<20070530180428.GA5731@martell.zuzino.mipt.ru>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HtXNY-0007Xt-Rr for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 May 2007 16:14:57 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HtXNY-0003Zp-BA
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 30 May 2007 16:14:56 -0700
Received: by py-out-1112.google.com with SMTP id u77so4228248pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 30 May 2007 16:14:55 -0700 (PDT)
In-Reply-To: <20070530180428.GA5731@martell.zuzino.mipt.ru>
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
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Pekka Enberg <penberg@cs.helsinki.fi>, Tero Roponen <teanropo@jyu.fi>, Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, 2007-05-30 at 22:04 +0400, Alexey Dobriyan wrote:
> On Wed, May 30, 2007 at 09:09:45AM -0700, Andrew Morton wrote:
> > On Wed, 30 May 2007 19:01:09 +0300 (EEST) Tero Roponen <teanropo@jyu.fi> wrote:
> > 
> > > On Wed, 30 May 2007, Andrew Morton wrote:
> > > 
> > > > On Wed, 30 May 2007 15:02:49 +0300 (EEST) Tero Roponen <teanropo@jyu.fi> wrote:
> > > > 
> > > > > On Wed, 30 May 2007, Pekka Enberg wrote:
> > > > > 
> > > > > > On 5/30/07, Tero Roponen <teanropo@jyu.fi> wrote:
[snip]
> Two suspicious things for me:
> 
> 1)
> 
> --- a/drivers/video/neofb.c
> +++ b/drivers/video/neofb.c
> @@ -1295,7 +1295,7 @@ static int neofb_setcolreg(u_int regno, 
>  		outb(blue >> 10, 0x3c9);
>  		break;
>  	case 16:
> -		((u32 *) fb->pseudo_palette)[regno] =
> +		((u16 *) fb->pseudo_palette)[regno] =

u32 is correct.

>  				((red & 0xf800)) | ((green & 0xfc00) >> 5) |
>  				((blue & 0xf800) >> 11);
>  		break;
> 
> 
> 
> 2) palette in neofb_par is "u32 palette[16];" which is 4x16 = 64 bytes.
>    struct fb_info::pseudo_palette is assigned to it in neo_alloc_fb_info().
>    Yet, we check at the beginning of neofb_setcolreg() for color map
>    length which neofb advertises as 256 which seems too many.
> 

Yes, 256 is too many. the pseudo_palette is used for the 16-color
console only.

I'm impressed that this bug has escaped notice for this long. That bug
is present since the 2.5.x era.

Probably, the best thing to do is hide the pseudo_palette from the
drivers and move it to the console layer where it belongs to spare
future driver writers from palette usage confusion. That will be a
thankless job.

Tony



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
