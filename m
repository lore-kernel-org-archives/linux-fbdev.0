From: Takashi Yoshii <yoshii.takashi@renesas.com>
Subject: Re: [PATCH] Add fb_check_var() for fixed mode
 device.
Date: Thu, 04 Sep 2008 16:21:27 +0900
Message-ID: <48BF8C77.70607@renesas.com>
References: <48B4E16C.4000107@renesas.com>
	<Pine.LNX.4.64.0808270855110.7910@anakin> <g94i4r$2hq$1@ger.gmane.org>
	<20080828074521.GO16680@sci.fi> <48B785DA.1030408@renesas.com>
	<1219999758.4421.259.camel@thor.sulgenrain.local>
	<Pine.LNX.4.64.0808291127510.18326@anakin>
	<1220017912.4421.291.camel@thor.sulgenrain.local>
	<Pine.LNX.4.64.0808291610230.18326@anakin>
	<1220019790.4421.297.camel@thor.sulgenrain.local>
	<48B90BD3.4020702@gmx.de> <48BD8FF0.5050905@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kb9AB-00087Z-2W for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 00:21:55 -0700
Received: from mail.renesas.com ([202.234.163.13] helo=mail03.idc.renesas.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kb9A9-0003I1-Jv
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 00:21:55 -0700
In-reply-to: <48BD8FF0.5050905@gmx.de>
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
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Ville Syrj?l? <syrjala@sci.fi>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@tungstengraphics.com>

Hi,

>> Basic idea is, that when we have fixed mode devices (aka drivers which 
>> don't implement fb_check_var) we just simply fill in a "emulated" valid 
>> monitor/modeline into the var struct during the register_framebuffer() 
>> initialization call. Since the modeline is valid, X does not has any 
>> problems with it.
It works nicely, and simple. but,
IMHO, It is not bad for workaround, but not for merging into mainline.
If it is only for workaround, setting info->var->pixclock(and some others)
 in your driver, is simpler (assuming we have source code).

Generally, pixclock is 0 in purpose.
It means there really is no clock, or author didn't have enough HW spec.
Anyway, it indicate there is no information about pixclock.
I think nothing other than 0 is suitable for this, because 
this is T of clock, and T=0 is logically invalid (f=INF?).
.... I think.

If it is true as fbdev specification, that means applications must ignore
 timings when pixclock==0.
/yoshii

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
