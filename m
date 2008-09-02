From: Helge Deller <deller@gmx.de>
Subject: Re: [PATCH] Add fb_check_var() for fixed mode
 device.
Date: Tue, 02 Sep 2008 21:11:44 +0200
Message-ID: <48BD8FF0.5050905@gmx.de>
References: <48B4E16C.4000107@renesas.com>	
	<Pine.LNX.4.64.0808270855110.7910@anakin>
	<g94i4r$2hq$1@ger.gmane.org>	 <20080828074521.GO16680@sci.fi>
	<48B785DA.1030408@renesas.com>	
	<1219999758.4421.259.camel@thor.sulgenrain.local>	
	<Pine.LNX.4.64.0808291127510.18326@anakin>	
	<1220017912.4421.291.camel@thor.sulgenrain.local>	
	<Pine.LNX.4.64.0808291610230.18326@anakin>
	<1220019790.4421.297.camel@thor.sulgenrain.local>
	<48B90BD3.4020702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KabII-0003Dy-Df for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 12:12:02 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1KabIH-0008GW-Kb
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 12:12:02 -0700
In-Reply-To: <48B90BD3.4020702@gmx.de>
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

Helge Deller wrote:
> The attached patch is a completely different approach to solve the 
> issue. I've tested it, and it works even with the buggy version of X 
> (1.4.2).
> 
> Basic idea is, that when we have fixed mode devices (aka drivers which 
> don't implement fb_check_var) we just simply fill in a "emulated" valid 
> monitor/modeline into the var struct during the register_framebuffer() 
> initialization call. Since the modeline is valid, X does not has any 
> problems with it.
> 
> The patch has a few benefits:
> a) We still keep binary compatability/behavior for FBIOGET_VSCREENINFO 
> and FBIOPUT_VSCREENINFO.
> b) In Xorg.conf files, users can simply delete all monitor and display 
> sections -> Xorg will autoconfigure itself to the only valid 
> resolution/modeline itself on all devices (I really like this!!!)
> 
> Thus, the patch basically changes the fixed mode drivers to have some 
> monitor timings by default. As an example, before I got:
> root@c3000:~# fbset -i
> mode "1024x768"
>     geometry 1024 768 1024 768 8
>     timings 0 0 0 0 0 0 0
>     rgba 8/0,8/0,8/0,0/0
> endmode
> 
> Now I see:
> root@c3000:~# fbset -i
> mode "1024x768-60"
>     # D: 65.003 MHz, H: 48.365 kHz, V: 60.006 Hz
>     geometry 1024 768 1024 768 8
>     timings 15384 168 8 29 3 144 6
>     rgba 8/0,8/0,8/0,0/0
> endmode
> 
> Opinions ?

Sadly nobody answered yet....

Helge

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
