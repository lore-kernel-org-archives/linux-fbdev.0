From: Srinivasa Deevi
 <sdeevi%integrated-devices.com@integrated-devices.com>
Subject: how to test fbcon ?
Date: Wed, 09 Jun 2004 16:24:36 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <40C79C34.5060000@integrated-devices.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYCQ5-0001qV-53
	for Linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Jun 2004 16:23:45 -0700
Received: from pimout1-ext.prodigy.net ([207.115.63.77])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BYCQ1-0006yD-O9
	for Linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Jun 2004 16:23:41 -0700
Received: from integrated-devices.com (adsl-66-122-252-196.dsl.sndg02.pacbell.net [66.122.252.196])
	by pimout1-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id i59NNWsg237924
	for <Linux-fbdev-devel@lists.sourceforge.net>; Wed, 9 Jun 2004 19:23:32 -0400
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Linux-fbdev-devel@lists.sourceforge.net

Hi all,

I need some help regarding making fbcon to work properly. I have got our 
framebuffer working in graphics mode. I could even run 'fbv' application 
with out any problem. I have also enabled 16 bit pixel mode for console 
and can see the code is running through that mode. I did observe the 
cursor blinking too. But I don't see any characters there. I don't know 
what I am missing here. The printk messages in driver are as shown below :

 idarmfb: idarmfb_init
idarmfb: idarmfb is Initializing.....
idarmfb: idarmfb_set_var
idarmfb: get_line_length
idarmfb: get_line_length , Len 352
idarmfb: set_color_bitfields
idarmfb: idarmfb_encode_fix
idarmfb: get_line_length
idarmfb: get_line_length , Len 352
Test : FBCON HAS CFB16
idarmfb: do_install_cmap
idarmfb: idarmfbcon_switch , con 0
idarmfb: do_install_cmap
idarmfb: idarmfb_set_cmap
idarmfb: idarmfbcon_switch , con 0
idarmfb: do_install_cmap
idarmfb: idarmfb_set_cmap
Console: switching to colour frame buffer device 22x27
fb0: IDARM frame buffer device, using 75K of video memory
Dummy keyboard driver installed.

I can see the tux logo coming up on the screen . But don't know what I 
am missing . can somebody help me ?

thanks in advance
sri





-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
