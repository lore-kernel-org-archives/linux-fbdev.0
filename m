From: James Simmons <jsimmons@infradead.org>
Subject: fbdev changes.
Date: Sun, 13 Oct 2002 13:27:08 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210131318420.5997-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pintail.mail.pas.earthlink.net ([207.217.120.122])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 180pQZ-0005e5-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 13:33:31 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>


Hi!

  The final changes to the fbdev layer are at hand. One of the last
changes I wanted to purpose was to create a console driectory in
drivers/video and move all console related stuff into that directory.
The next step was to move the dri stuff into that directory with the agp
code possible. The questions I have is should we move the agp code over to
that directory. Should the DRI code move over directly or should we move
DRI driver specific code into the same directory as the fbdev driver
directories? For example in aty directory we have all the ati framebuffer
and ATI dri code. What do you think?

Second change!! We need a uiversal cursor api. I purposed some time ago a
api but nothing happend.I like to resolve this final part to remove th
last bit of console crude from the fbdev layer.

The api I suggested was :


/*
 * hardware cursor control
 */

#define FB_CUR_SETCUR   0x01
#define FB_CUR_SETPOS   0x02
#define FB_CUR_SETHOT   0x04
#define FB_CUR_SETCMAP  0x08
#define FB_CUR_SETSHAPE 0x10
#define FB_CUR_SETALL   0x1F

struct fbcurpos {
        __u16 x, y;
};

struct fbcursor {
        __u16 set;              /* what to set */
        __u16 enable;           /* cursor on/off */
        struct fbcurpos pos;    /* cursor position */
        struct fbcurpos hot;    /* cursor hot spot */
        struct fb_cmap cmap;    /* color map info */
        struct fbcurpos size;   /* cursor bit map size */
        char *image;            /* cursor image bits */
        char *mask;             /* cursor mask bits */
};

If you have any suggestion please post you purpose struct. Thank you.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@users.sf.net] 	                ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
