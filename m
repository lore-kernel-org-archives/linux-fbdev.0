From: "twomol" <twomol@126.com>
Subject: Strange iotcl operation
Date: Thu, 22 Jun 2006 09:36:50 +0800 (CST)
Message-ID: <4499F432.00003A.03013@m61.126.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1718813848=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtE85-000619-7i for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 18:37:09 -0700
Received: from m15-12.126.com ([220.181.15.12])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FtE80-0005Gw-EH
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 18:37:09 -0700
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


--===============1718813848==
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_ZfCzIHkLJnRWxETxjehWlrjIGncr"


--Boundary-=_ZfCzIHkLJnRWxETxjehWlrjIGncr
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi,all
I'm using FC5, our graphic card's framebuffer driver's ioctl function work abnormally.I mean
our framebuffer driver provide extending ioctl command. But the ioctl cmd can't be transport correctly from user space to kernel space, ie,if I ioctl(fd,0x123456,&arg) in user space, the kernel space can not get the cmd 0x12345, but a totally different number. 
But if I use standard cmd such as FBIOGET_VSCREENINFO, it work normally.
By the way, My framebuffer driver work on FC4
Any Suggestion is appreciate.
 
 
--Boundary-=_ZfCzIHkLJnRWxETxjehWlrjIGncr
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV><SPAN >Hi,all</SPAN></DIV>
<DIV><SPAN>I'm using FC5, our graphic card's framebuffer driver's ioctl f=
unction work abnormally.I mean</SPAN></DIV>
<DIV><SPAN>our framebuffer driver provide extending ioctl command. But th=
e ioctl cmd can't be transport correctly from user space to kernel space,=
 ie,if I ioctl(fd,0x123456,&amp;arg) in user space, the kernel space can =
not get the cmd 0x12345, but a totally different number. </SPAN></DIV>
<DIV><SPAN>But if I use standard cmd such as FBIOGET_VSCREENINFO, it work=
 normally.</SPAN></DIV>
<DIV><SPAN>By the way, My framebuffer driver work on FC4</SPAN></DIV>
<DIV><SPAN>Any Suggestion is appreciate.</SPAN></DIV>
<DIV><SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN></SPAN>&nbsp;</DIV><br><!-- footer --><br><br><br><br><br><div=
 style=3D"border-bottom:1px solid #999"></div><br>

=09<font color=3D"black" style=3D"font-size:14.8px">=C4=E3 =B2=BB =CF=EB =
=CA=D4 =CA=D4 =BD=F1 =CF=C4 =D7=EE =A1=B0=BF=E1=A1=B1 =B5=C4 =D3=CA =CF=E4=
 =C2=F0 =A3=BF</font>
=09<br>
=09 <a href=3D"http://www.126.com/" target=3D"_blank" style=3D"font-size:=
13px;line-height:160%;color:blue">=D4=CC =BA=AD =D6=D0 =BB=AA =B4=AB =CD=B3=
 =CE=C4 =BB=AF =D3=DA =CA=C0 =BD=E7 =D2=BB =C1=F7 =BF=C6 =BC=BC =D6=AE =D6=
=D0=A3=AC=B4=B4 =D0=C2 Ajax =BC=BC =CA=F5=A3=AC126 =A1=B0D =BC=C6 =BB=AE=A1=
=B1=BB=F0 =C8=C8 =CC=E5 =D1=E9 =D6=D0 =A3=A1
</a>


--Boundary-=_ZfCzIHkLJnRWxETxjehWlrjIGncr--


--===============1718813848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
--===============1718813848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1718813848==--
