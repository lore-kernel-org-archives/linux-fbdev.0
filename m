From: "Ramya Segar" <ramya.segar@gmail.com>
Subject: Double buffering amba-clcd fb driver
Date: Wed, 18 Oct 2006 15:57:47 +0530
Message-ID: <55a8df6f0610180327o2fe790actcfca77c94b067919@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1894644539=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ga8eN-0003Yy-79 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 03:27:51 -0700
Received: from ug-out-1314.google.com ([66.249.92.172])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ga8eL-0000Hg-Ox
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 03:27:51 -0700
Received: by ug-out-1314.google.com with SMTP id p27so116645ugc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 18 Oct 2006 03:27:48 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

--===============1894644539==
Content-Type: multipart/alternative; 
	boundary="----=_Part_61205_6067663.1161167267501"

------=_Part_61205_6067663.1161167267501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I m a realtive newcomer to linux and device drivers in particular.
I have doubts regrading how to enable double buffering in the fb driver for
amba-clcd.
I m interested in knowing how to enable double bufefring, where two buffers
are allocated and swapped during vertical blanking period (this is how i
understood it).
As I understand it, the dbe extension of XFree86 X server provides software
double buffering, where each window has two buffers, a front and back..
If you can point me to any documentation on this, it would be a great help..

Thanks in adavnce,
Ramya.

------=_Part_61205_6067663.1161167267501
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br>I m a realtive newcomer to linux and device drivers in particular.<br>I have doubts regrading how to enable double buffering in the fb driver for amba-clcd.<br>I m interested in knowing how to enable double bufefring, where two buffers are allocated and swapped during vertical blanking period (this is how i understood it).
<br>As I understand it, the dbe extension of XFree86 X server provides
software double buffering, where each window has two buffers, a front
and back..<br>If you can point me to any documentation on this, it would be a great help..<br><br>Thanks in adavnce,<br>Ramya.<br>

------=_Part_61205_6067663.1161167267501--


--===============1894644539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1894644539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1894644539==--
