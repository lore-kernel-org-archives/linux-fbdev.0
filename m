From: James Simmons <jsimmons@transvirtual.com>
Subject: Re: aty128 framebuffer - cannot change resolution
Date: Sat, 27 Jul 2002 12:43:28 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0207271241390.17619-100000@www.transvirtual.com>
References: <20020719123642.29135f53.hanno@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from www.transvirtual.com ([206.14.214.140])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 17YXTS-0000g6-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 27 Jul 2002 12:43:34 -0700
In-Reply-To: <20020719123642.29135f53.hanno@gmx.de>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: =?X-UNKNOWN?Q?Hanno_B=F6ck?= <hanno@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net


Use this:

video=3Daty128fb:<xres>x<yres>[-<bpp>][@refresh]

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'\_   _/`\
 \___)=3D(___/

On Fri, 19 Jul 2002, Hanno B=F6ck wrote:

> i have a problem with the aty128fb. It always starts with 640x480-resolut=
ion, although i have applied vga=3D791 (should be 1024x768) commandline.
>
> It is an ATI Rage 128 RF/SG AGP and Kernel 2.4.18.
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
