From: "abc xyz" <abc50xyz@gmail.com>
Subject: kmalloc is failing and kernel is hanging
Date: Wed, 3 Dec 2008 17:22:41 +0530
Message-ID: <aa4f58ed0812030352i6ee5bd3ake14bf37aaf18fa0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0311015337672489838=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <abc50xyz@gmail.com>) id 1L7qHc-0001sw-Cq
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Dec 2008 11:52:44 +0000
Received: from rv-out-0708.google.com ([209.85.198.249])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L7qHb-0002lK-2n for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Dec 2008 11:52:44 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3313019rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 03 Dec 2008 03:52:41 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

--===============0311015337672489838==
Content-Type: multipart/alternative; 
	boundary="----=_Part_86775_22851230.1228305161092"

------=_Part_86775_22851230.1228305161092
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I have an ARM PXA-255 board with an LCD support. I have ported kernel
2.6.26.3 on it and am trying to make frame buffer driver up for my board. I
m able to able to  get the backlight on tho LCD panel. In pxafb.c file, the
function pxafb_probe is calling pxafb_init_fbinfo function. This
pxafb_init_fbinfo is then allocating some memory by calling kmalloc. The
kmalloc fails here and my kernel hangs.

I am able to able to figure out the problem as kmalloc as returning a valid
address to the variable fbi.  I also tried with GFP_ATOMIC flag in kmalloc
but still the problem exists.
Any help to solve this problem will be highly appreciated.


-- 
Regards,
Volatile

------=_Part_86775_22851230.1228305161092
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,<br><br>I have an ARM PXA-255 board with an LCD support. I have ported kernel <a href="http://2.6.26.3">2.6.26.3</a> on it and am trying to make frame buffer driver up for my board. I m able to able to&nbsp; get the backlight on tho LCD panel. In pxafb.c file, the function pxafb_probe is calling pxafb_init_fbinfo function. This pxafb_init_fbinfo is then allocating some memory by calling kmalloc. The kmalloc fails here and my kernel hangs.<br>
<br>I am able to able to figure out the problem as kmalloc as returning a valid address to the variable fbi.&nbsp; I also tried with GFP_ATOMIC flag in kmalloc but still the problem exists.<br>Any help to solve this problem will be highly appreciated.<br>
<br clear="all"><br>-- <br>Regards,<br>Volatile<br>

------=_Part_86775_22851230.1228305161092--


--===============0311015337672489838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0311015337672489838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0311015337672489838==--
