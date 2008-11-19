From: "Jatin Kumar" <jatin.kumar@gatech.edu>
Subject: asynchronous resolution change
Date: Tue, 18 Nov 2008 20:04:20 -0500
Message-ID: <333fec630811181704t19194e5et6d5299e2305f4401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2290578991378029513=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jatinkumar@gmail.com>) id 1L2bUY-0003lc-N0
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Nov 2008 01:04:26 +0000
Received: from rv-out-0708.google.com ([209.85.198.249])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L2bUU-0007PP-Ow for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 19 Nov 2008 01:04:26 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3032831rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 18 Nov 2008 17:04:20 -0800 (PST)
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

--===============2290578991378029513==
Content-Type: multipart/alternative; 
	boundary="----=_Part_55208_10564789.1227056660678"

------=_Part_55208_10564789.1227056660678
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am new to linux fb model and had some queries regarding resolution change
mechanisms.

Consider a situation where the frambuffer kernel module (vfb/xenfb etc)
wants to change the resolution.

1. Is there a mechanism to this, considering the applications/windowing
system/console above the framebuffer hasnt initiated the size change?

2. Is there a way to do an upcall into the application/windowing
system/console modules to inform them about the size change asynchronously?

In this particular case ; the display hardware(instead of the user) has
initiated the resolution change.Is it possible in the current fb framework
to support it?

Excuse me for the lack of knowledge in this area.
Any other suggstions/explanations are welcome.

Thanks
jk

------=_Part_55208_10564789.1227056660678
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I am new to linux fb model and had some queries regarding resolution change mechanisms.<br><br>Consider a situation where the frambuffer kernel module (vfb/xenfb etc) wants to change the resolution.<br><br>1. Is there a mechanism to this, considering the applications/windowing system/console above the framebuffer hasnt initiated the size change?<br>
<br>2. Is there a way to do an upcall into the application/windowing system/console modules to inform them about the size change asynchronously?<br><br>In this particular case ; the display hardware(instead of the user) has initiated the resolution change.Is it possible in the current fb framework to support it?<br>
<br>Excuse me for the lack of knowledge in this area.<br>Any other suggstions/explanations are welcome.<br><br>Thanks<br>jk<br>

------=_Part_55208_10564789.1227056660678--


--===============2290578991378029513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2290578991378029513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2290578991378029513==--
