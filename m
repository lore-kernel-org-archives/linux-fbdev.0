From: "Mukund JB." <mukundjb@esntechnologies.co.in>
Subject: regarding the structures of framebuffer driver
Date: Wed, 8 Sep 2004 09:42:20 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4EE0CBA31942E547B99B3D4BFAB3481110736B@mail.esn.co.in>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4tml-0006tD-Aw
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 21:10:19 -0700
Received: from [202.125.86.130] (helo=ns2.astrainfonets.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C4tmi-0005RN-6d
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Sep 2004 21:10:18 -0700
Received: from mail.esn.co.in ([202.125.80.34])
	by ns2.astrainfonets.net (8.12.8p1/8.12.8) with ESMTP id i8845pUE017218
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 8 Sep 2004 04:05:51 GMT
Content-class: urn:content-classes:message
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net



Hi all,

I am very new to video drivers and iam working on framebuffer drivers.
Pls help me clear my doubts.
This mail is regarding the structures of framebuffer driver

I have some doubt regarding the kernel structures I have found in the
skeletonfb.c file which model of framebuffer driver.

I am not able to understand the following parts of code :-
I am separating each section of code by " ******** ".

************************************************************************
****

/* ------------ Interfaces to hardware functions ------------ */


struct fbgen_hwswitch xxx_switch =3D {
    xxx_detect, xxx_encode_fix, xxx_decode_var, xxx_encode_var,
xxx_get_par,
    xxx_set_par, xxx_getcolreg, xxx_setcolreg, xxx_pan_display,
xxx_blank,
    xxx_set_disp
};

/*---------------- chipset specific functions --------------------------
*/

Followed by comment the above "fbgen_hwswitch" structure functions were
defined.
R the function pointers declared in the above "fbgen_hwswitch" structure
a sort of call back functions.
Will they be called from the user space (Application like X server)?

If so, where is the list of user space calls from which the above
functions will be called?=20
R these user space calls valid whether there is a X server on top of
framebuffer driver or any other application which can directly interact?
( I heard from the NET, there will be applications like X server which
can    directly interact with framebuffer driver. )

************************************************************************
****
static struct fb_ops xxxfb_ops =3D {
	owner:		THIS_MODULE,
	fb_open:	xxxfb_open,    /* only if you need it to do
something */
	fb_release:	xxxfb_release, /* only if you need it to do
something */
	fb_get_fix:	fbgen_get_fix,
	fb_get_var:	fbgen_get_var,
	fb_set_var:	fbgen_set_var,
	fb_get_cmap:	fbgen_get_cmap,
	fb_set_cmap:	fbgen_set_cmap,
	fb_pan_display:	fbgen_pan_display,
	fb_ioctl:	xxxfb_ioctl,   /* optional */
};

Also, where can I find the call backs for these functions?
Where is XFree86 driver source in /usr/?.


Thanks a lot in advance,
Mukund jampala





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
