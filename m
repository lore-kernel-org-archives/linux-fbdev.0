From: Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: Some questions
Date: Fri, 07 Mar 2003 16:19:49 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E68B895.2080500@winischhofer.net>
References: <Pine.LNX.4.44.0303061526500.4540-100000@phoenix.infradead.org>	<3E688BDA.8080506@winischhofer.net> <1047045694.1310.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000609060009020502030601"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [213.229.38.66] (helo=mail.falke.at)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18rJge-0007Uf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 07 Mar 2003 07:23:04 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Sven Luther <luther@dpt-info.u-strasbg.fr>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------000609060009020502030601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This works - perfectly, I must say.

However, the scrolling problem is still here, but I think I know the 
reason for this:

Imagine a console of 120x40 (using the std 8x16 font), on a screen of 
1024x768, using ypanning.

This uses only 40*16=640 pixels vertically instead of the 768 available.

The problem is the y panning, and is kind of both console's as well as 
the driver's fault:

When the y panning area reaches its end, it's supposed to copy the 
screen to the beginning of this area and pan to position 0.

However, fbcon calculates p->vrows by info->var.yres_virtual / fontheight.

This disregards the fact that the visible screen area is actually larger 
than the area console is supposed to use.

Therefore, the calculation of vrows has to take the difference between 
these two into account.

The attached patch fixes this for me but I have no idea if I cought all 
possible itches. It will no apply cleanly, because I had made changes to 
fbcon.c before making a backup copy - but it sure illustrates the problem.

Why you used info->var.yres_virtual (and not the adapted 
var.yres_virtual) in fbcon_resize() is beyond me, BTW.

Thomas

Antonino Daplas wrote:
> On Fri, 2003-03-07 at 20:08, Thomas Winischhofer wrote:
> 
>>
>>However, there is still (at least) one problem within the console layer.
>>
>>With my patch, I can now have a console of for instance 128x20 
>>characters, on a 1024x768 screen. Scrolling mostly works, but sometimes 
>>console seems to forget to pan. I can't reproduce this on purpose, but 
>>printing eg. a directory with ls works in 90% of the cases (=scrolls 
>>correctly), but prints text beyond the current amount of rows in the 
>>remaining 10% of the cases. If I press enter until the last line of the 
>>console is on the very bottom of the 1024x768 screen, then it remembers 
>>its amount of rows and pans correctly.
>>
> 
> 
> Try this patch.  The fbcon_resize test is more liberal and it now correctly
> updates p->vrows and scroll_phys_max (for panning glitches).
> 
> Tony
> 
> 
> diff -Naur linux-2.5.64-fbdev/drivers/video/console/fbcon.c linux-2.5.64/drivers/video/console/fbcon.c
> --- linux-2.5.64-fbdev/drivers/video/console/fbcon.c	2003-03-06 01:29:29.000000000 +0000
> +++ linux-2.5.64/drivers/video/console/fbcon.c	2003-03-07 13:54:04.000000000 +0000
> @@ -580,8 +580,8 @@
>  	struct fb_info *info = p->fb_info;
>  	unsigned int cw = vc->vc_font.width;
>  	unsigned int ch = vc->vc_font.height;
> -	unsigned int rw = info->var.xres % cw;
> -	unsigned int bh = info->var.yres % ch;
> +	unsigned int rw = info->var.xres - (cw * vc->vc_cols);
> +	unsigned int bh = info->var.yres - (ch * vc->vc_rows);
>  	unsigned int rs = info->var.xres - rw;
>  	unsigned int bs = info->var.yres - bh;
>  	struct fb_fillrect region;
> @@ -1815,14 +1815,14 @@
>  	   (y_diff < 0 || y_diff > fh)) {
>  		var.activate = FB_ACTIVATE_TEST;
>  		err = fb_set_var(&var, info);
> -		if (err || width != var.xres/fw ||
> -		    height != var.yres/fh)
> +		if (err || width > var.xres/fw ||
> +		    height > var.yres/fh)
>  			return -EINVAL;
>  		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
>  		var.activate = FB_ACTIVATE_NOW;
>  		fb_set_var(&var, info);
> -		p->vrows = info->var.yres_virtual/fh;
>  	}
> +	p->vrows = info->var.yres_virtual/fh;
>  	return 0;
>  }
>  
> @@ -1857,6 +1857,7 @@
>  	}
>  	if (info)
>  		info->var.yoffset = p->yscroll = 0;
> +        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
>  	switch (p->scrollmode & __SCROLL_YMASK) {
>  	case __SCROLL_YWRAP:
>  		scrollback_phys_max = p->vrows - vc->vc_rows;
> @@ -1875,7 +1876,6 @@
>  
>  	info->currcon = unit;
>  	
> -        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
>  	update_var(unit, info);
>  	fbcon_set_palette(vc, color_table); 	
>  
> 
> 


-- 
Thomas Winischhofer
Vienna/Austria
mailto:thomas@winischhofer.net            http://www.winischhofer.net/



--------------000609060009020502030601
Content-Type: application/x-java-applet;version=1.1.1;
 name="fbcon_patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="fbcon_patch"

LS0tIGRyaXZlcnMvdmlkZW8vY29uc29sZS9mYmNvbi5jX29sZAkyMDAzLTAzLTA3IDE1OjU2
OjMzLjAwMDAwMDAwMCArMDEwMAorKysgZHJpdmVycy92aWRlby9jb25zb2xlL2ZiY29uLmMJ
MjAwMy0wMy0wNyAxNjoxMzozMC4wMDAwMDAwMDAgKzAxMDAKQEAgLTEwNDQsNiArMTA0NCw5
IEBACiAJCXZjLT52Y19yb3dzID0gbnJfcm93czsKIAl9CiAJcC0+dnJvd3MgPSBpbmZvLT52
YXIueXJlc192aXJ0dWFsIC8gdmMtPnZjX2ZvbnQuaGVpZ2h0OworCWlmKGluZm8tPnZhci55
cmVzID4gKHZjLT52Y19mb250LmhlaWdodCAqICh2Yy0+dmNfcm93cyArIDEpKSkgeworCSAg
IHAtPnZyb3dzIC09IChpbmZvLT52YXIueXJlcyAtICh2Yy0+dmNfZm9udC5oZWlnaHQgKiB2
Yy0+dmNfcm93cykpIC8gdmMtPnZjX2ZvbnQuaGVpZ2h0OworCX0KIAlpZiAoKGluZm8tPnZh
ci55cmVzICUgdmMtPnZjX2ZvbnQuaGVpZ2h0KSAmJgogCSAgICAoaW5mby0+dmFyLnlyZXNf
dmlydHVhbCAlIHZjLT52Y19mb250LmhlaWdodCA8CiAJICAgICBpbmZvLT52YXIueXJlcyAl
IHZjLT52Y19mb250LmhlaWdodCkpCkBAIC0xODIyLDkgKzE4MjUsMTAgQEAKIAkJdmFyLmFj
dGl2YXRlID0gRkJfQUNUSVZBVEVfTk9XOwogCQlmYl9zZXRfdmFyKCZ2YXIsIGluZm8pOwog
CX0KLQlwLT52cm93cyA9IGluZm8tPnZhci55cmVzX3ZpcnR1YWwvZmg7Ci0JeV9kaWZmID0g
dmFyLnlyZXMgLSBpbmZvLT52YXIueXJlczsKLQlpZih5X2RpZmYgPiBmaCkgcC0+dnJvd3Mg
LT0gKHlfZGlmZiAvIGZoKTsKKwlwLT52cm93cyA9IHZhci55cmVzX3ZpcnR1YWwvZmg7CisJ
aWYodmFyLnlyZXMgPiAoZmggKiAoaGVpZ2h0ICsgMSkpKSB7CisJICAgcC0+dnJvd3MgLT0g
KHZhci55cmVzIC0gKGZoICogaGVpZ2h0KSkgLyBmaDsKKwl9CiAJcmV0dXJuIDA7CiB9CiAK
QEAgLTIwOTYsNiArMjEwMCwxMSBAQAogCQkvKiByZXNldCB3cmFwL3BhbiAqLwogCQlpbmZv
LT52YXIueG9mZnNldCA9IGluZm8tPnZhci55b2Zmc2V0ID0gcC0+eXNjcm9sbCA9IDA7CiAJ
CXAtPnZyb3dzID0gaW5mby0+dmFyLnlyZXNfdmlydHVhbCAvIGg7CisjaWYgMAkJLyogSU5D
T01QTEVURSAtIGxldCB0aGUgY29uc29sZSBndXJ1cyBoYW5kbGUgdGhpcyAqLwkKKwkJaWYo
aW5mby0+dmFyLnlyZXMgPiAoaCAqICh2Yy0+dmNfcm93cyArIDEpKSB7CisJICAgICAgICAg
ICAgIHAtPnZyb3dzIC09IChpbmZvLT52YXIueXJlcyAtIChoICogdmMtPnZjX3Jvd3MpKSAv
IGg7CisJICAgICAgICB9CisjZW5kaWYJCQogCQlpZiAoKGluZm8tPnZhci55cmVzICUgaCkK
IAkJICAgICYmIChpbmZvLT52YXIueXJlc192aXJ0dWFsICUgaCA8IGluZm8tPnZhci55cmVz
ICUgaCkpCiAJCQlwLT52cm93cy0tOwo=
--------------000609060009020502030601--



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
