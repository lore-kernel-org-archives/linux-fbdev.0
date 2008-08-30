From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Add fb_check_var() for fixed mode
 device.
Date: Sat, 30 Aug 2008 10:58:59 +0200
Message-ID: <48B90BD3.4020702@gmx.de>
References: <48B4E16C.4000107@renesas.com>	
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<g94i4r$2hq$1@ger.gmane.org>	 <20080828074521.GO16680@sci.fi>
	<48B785DA.1030408@renesas.com>	
	<1219999758.4421.259.camel@thor.sulgenrain.local>	
	<Pine.LNX.4.64.0808291127510.18326@anakin>	
	<1220017912.4421.291.camel@thor.sulgenrain.local>	
	<Pine.LNX.4.64.0808291610230.18326@anakin>
	<1220019790.4421.297.camel@thor.sulgenrain.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080603060109020902090603"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZMIa-0006vZ-Nl for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Aug 2008 01:59:12 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KZMIZ-0003oM-3K
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 30 Aug 2008 01:59:12 -0700
In-Reply-To: <1220019790.4421.297.camel@thor.sulgenrain.local>
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
To: =?UTF-8?B?TWljaGVsIETDpG56ZXI=?= <michel@tungstengraphics.com>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Ville Syrj?l? <syrjala@sci.fi>, Geert Uytterhoeven <geert@linux-m68k.org>

This is a multi-part message in MIME format.
--------------080603060109020902090603
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Michel D=C3=A4nzer wrote:
> On Fri, 2008-08-29 at 16:14 +0200, Geert Uytterhoeven wrote:
>> On Fri, 29 Aug 2008, Michel Dnzer wrote:
>>> On Fri, 2008-08-29 at 14:16 +0200, Geert Uytterhoeven wrote:
>>>> | X.Org X Server 1.4.2
>>> [...]
>>>
>>>> | (EE) FBDEV(0): FBIOPUT_VSCREENINFO succeeded but modified mode
>>> [...]
>>>
>>>> Hence Xorg is broken on all embedded devices with a frame buffer dri=
ver
>>>> that supports a single fixed video mode only?
>>> No. As discussed before, you're probably missing
>>>
>>> http://cgit.freedesktop.org/xorg/xserver/commit/?id=3Dc095da04fe7c73b=
6503ef5b93549b13796c51b22
>>>
>>> which is in the upcoming xserver 1.5 release.
>> Ah, upcoming. That's not current/previous/... ;-)
>=20
> Yeah, it might have been nice to backport this to the 1.4 branch, but
> it's kind of too late now. Of course, you can always bug your
> distributor to backport it. :)

The attached patch is a completely different approach to solve the=20
issue. I've tested it, and it works even with the buggy version of X=20
(1.4.2).

Basic idea is, that when we have fixed mode devices (aka drivers which=20
don't implement fb_check_var) we just simply fill in a "emulated" valid=20
monitor/modeline into the var struct during the register_framebuffer()=20
initialization call. Since the modeline is valid, X does not has any=20
problems with it.

The patch has a few benefits:
a) We still keep binary compatability/behavior for FBIOGET_VSCREENINFO=20
and FBIOPUT_VSCREENINFO.
b) In Xorg.conf files, users can simply delete all monitor and display=20
sections -> Xorg will autoconfigure itself to the only valid=20
resolution/modeline itself on all devices (I really like this!!!)

Thus, the patch basically changes the fixed mode drivers to have some=20
monitor timings by default. As an example, before I got:
root@c3000:~# fbset -i
mode "1024x768"
     geometry 1024 768 1024 768 8
     timings 0 0 0 0 0 0 0
     rgba 8/0,8/0,8/0,0/0
endmode

Now I see:
root@c3000:~# fbset -i
mode "1024x768-60"
     # D: 65.003 MHz, H: 48.365 kHz, V: 60.006 Hz
     geometry 1024 768 1024 768 8
     timings 15384 168 8 29 3 144 6
     rgba 8/0,8/0,8/0,0/0
endmode

Opinions ?

Signed-off-by: Helge Deller <deller@gmx.de>



--------------080603060109020902090603
Content-Type: text/x-patch;
 name="fb_check_var_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fb_check_var_fix.patch"

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 98843c2..72b3113 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1470,9 +1470,23 @@ register_framebuffer(struct fb_info *fb_info)
 	if (!fb_info->pixmap.blit_y)
 		fb_info->pixmap.blit_y = ~(u32)0;
 
-	if (!fb_info->modelist.prev || !fb_info->modelist.next)
+	if (!fb_info->modelist.prev || !fb_info->modelist.next) {
 		INIT_LIST_HEAD(&fb_info->modelist);
 
+		/* For drivers which does not support mode setting
+		 * initialize an emulated modeline */
+		if (!fb_info->fbops->fb_check_var &&
+		     fb_info->var.pixclock == 0) {
+			char modestr[32];
+			snprintf(modestr, sizeof(modestr), "%dx%d-%d",
+				fb_info->var.xres,
+				fb_info->var.yres,
+				fb_info->var.bits_per_pixel);
+			fb_find_mode(&fb_info->var, fb_info, modestr,
+				NULL, 0, NULL, fb_info->var.bits_per_pixel);
+		}
+	}
+
 	fb_var_to_videomode(&mode, &fb_info->var);
 	fb_add_videomode(&mode, &fb_info->modelist);
 	registered_fb[i] = fb_info;

--------------080603060109020902090603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------080603060109020902090603
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------080603060109020902090603--
