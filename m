From: Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: [PATCH] fix warning in fbmem.c
Date: Thu, 17 Jun 2004 11:29:38 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.56.0406171128250.12749@jjulnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F93@difpst1a.dif.dk>
 <Pine.GSO.4.58.0406171015270.21503@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BatED-0008KB-A2
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 02:30:37 -0700
Received: from mail.dif.dk ([193.138.115.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BatEC-0005FE-8S
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Jun 2004 02:30:36 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.dif.dk (Postfix) with ESMTP id 334CFFFC92
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 11:39:05 +0200 (CEST)
Received: from mail.dif.dk ([127.0.0.1])
 by localhost (saerimmer [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03386-19 for <linux-fbdev-devel@lists.sourceforge.net>;
 Thu, 17 Jun 2004 11:39:02 +0200 (CEST)
Received: from diftmgw2.backbone.dif.dk (diftmgw2.backbone.dif.dk [10.227.136.246])
	by mail.dif.dk (Postfix) with ESMTP id EFF18FFC8F
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Jun 2004 11:39:01 +0200 (CEST)
In-Reply-To: <Pine.GSO.4.58.0406171015270.21503@waterleaf.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Thu, 17 Jun 2004, Geert Uytterhoeven wrote:

> On Thu, 17 Jun 2004, Jesper Juhl wrote:
> > Here are two proposed patches to fix the following warning in fbmem.c :
> > drivers/video/fbmem.c:933: warning: passing arg 1 of `copy_from_user' discards qualifiers from pointer target type
> >
> > The cause of the warning is that the .data member of struct fb_image is of
> > type 'const char *' and copy_from_user() takes a 'void *' as it's first
> > 'to' argument.
> > I see two ways to fix it;
> > a) use a simple cast to hide the warning
> > b) rewrite the code to copy into a buffer pointed to by a non-const
> > pointer, then assign the pointer to cursor.image.data
>
> Here is a variant of b, which avoids the cast and makes cursor.mask const as
> well.
>

> --- linux-2.6.7-rc1/include/linux/fb.h.orig	2004-05-24 11:14:01.000000000 +0200
> +++ linux-2.6.7-rc1/include/linux/fb.h	2004-06-07 22:38:01.000000000 +0200
> @@ -375,7 +375,7 @@ struct fb_cursor {
>  	__u16 set;		/* what to set */
>  	__u16 enable;		/* cursor on/off */
>  	__u16 rop;		/* bitop operation */
> -	char *mask;		/* cursor mask bits */
> +	const char *mask;	/* cursor mask bits */
>  	struct fbcurpos hot;	/* cursor hot spot */
>  	struct fb_image	image;	/* Cursor image */
>  };
>

Nice. I didn't know the code well enough to dare make this change as well.


--
Jesper Juhl <juhl-lkml@dif.dk>


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
