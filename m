From: "Nathan King" <natetheking@gmail.com>
Subject: reading pixel data from kernelspace
Date: Sun, 8 Oct 2006 19:04:06 -0500
Message-ID: <bb9a78950610081704t2fb5657eud2f57b60c9aa305b@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0297386168=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWicv-0008Vm-0j for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 17:04:13 -0700
Received: from nf-out-0910.google.com ([64.233.182.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GWicu-00081D-IK
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 17:04:12 -0700
Received: by nf-out-0910.google.com with SMTP id l36so1647533nfa
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 08 Oct 2006 17:04:06 -0700 (PDT)
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

--===============0297386168==
Content-Type: multipart/alternative; 
	boundary="----=_Part_166619_5313624.1160352246042"

------=_Part_166619_5313624.1160352246042
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey folks,

I'm messing with some virtual framebuffering, and had a question. When in
userspace, if I want to read the contents of the framebuffer I just do a

open("/dev/fb0",O_RDONLY)

and I've got a nice clean capture of the screen. Where, however, does this
data live in kernelspace? My vfb driver declares a pointer and then
allocates whatever memory the display needs, basically
width*height*bytes_per_pixel bytes. A lot like the variable "videomemory" in
drivers/video/vfb.c.  If I try to copy this data, however, it comes out
garbled. Some parts look a little like the original, but most of it is
pretty random. Is there another home for this pixel data somewhere? I tried
reading from info->screen_base, but got exactly the same results.

Much thanks,
Nathan

------=_Part_166619_5313624.1160352246042
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey folks,<br><br>I'm messing with some virtual framebuffering, and had a question. When in userspace, if I want to read the contents of the framebuffer I just do a <br><br>open(&quot;/dev/fb0&quot;,O_RDONLY)<br><br>and I've got a nice clean capture of the screen. Where, however, does this data live in kernelspace? My vfb driver declares a pointer and then allocates whatever memory the display needs, basically width*height*bytes_per_pixel bytes. A lot like the variable &quot;videomemory&quot; in drivers/video/vfb.c.&nbsp; If I try to copy this data, however, it comes out garbled. Some parts look a little like the original, but most of it is pretty random. Is there another home for this pixel data somewhere? I tried reading from info-&gt;screen_base, but got exactly the same results.
<br><br>Much thanks,<br>Nathan<br><br><br>

------=_Part_166619_5313624.1160352246042--


--===============0297386168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0297386168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============0297386168==--
