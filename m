From: krzysztof.h1@poczta.fm
Subject: Re: Implementing new fb driver
Date: 17 Sep 2008 15:34:43 +0200
Message-ID: <20080917133444.11D82CF1A0@f21.poczta.interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kfxf3-0002Rl-VP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Sep 2008 07:05:42 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kfxf1-0004gL-E2
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Sep 2008 07:05:41 -0700
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
To: Alessio Sangalli <alesan@manoweb.com>, "krzysztof.h1@poczta.fm" <krzysztof.h1@poczta.fm>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

> krzysztof.h1@poczta.fm wrote:
> 
> 
> I have a question; this hardware supports (only) true color cursors. Is
> the fb API unable to deal with this? I have read only 1-bit cursor
> images are supported.
> 

No. Look at the include/linux/fb.h

#define FB_CUR_SETIMAGE 0x01
#define FB_CUR_SETPOS   0x02
#define FB_CUR_SETHOT   0x04
#define FB_CUR_SETCMAP  0x08
#define FB_CUR_SETSHAPE 0x10
#define FB_CUR_SETSIZE  0x20
#define FB_CUR_SETALL   0xFF

struct fbcurpos {
    __u16 x, y;
};

struct fb_cursor {
    __u16 set;      /* what to set */
    __u16 enable;       /* cursor on/off */
    __u16 rop;      /* bitop operation */
    const char *mask;   /* cursor mask bits */
    struct fbcurpos hot;    /* cursor hot spot */
    struct fb_image image;  /* Cursor image */
};

You can set colormap for the cursor. 

> This said, I ma confused by the hw cursors calls, and I am not sure how
> to proceed. Basically my hardware can store a number of cursor images,
> enable or disable the cursor, and move the cursor at a specified
> position. How do I implement that?
> 

There is only one function to handle cursor (fb_cursor) which set appropriate properties based on set flags (the constants above). 
One file I fixed cursor handling is the tdfxfb driver (look there).

Best regards,
Krzysztof

----------------------------------------------------------------------
Jak zrobic swoja wlasna tapete na telefon?
Sprawdz >>  http://link.interia.pl/f1f14   


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
