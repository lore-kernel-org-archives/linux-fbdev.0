From: "Nitin Mahajan" <Nitin@soc-soft.com>
Subject: Problem with Bit BLT
Date: Tue, 8 Jul 2003 20:43:54 +0530
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <E519BE9E8DAC6A4B89DA4AD1D2A155B71F2856@soc-mail.soc-soft.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C34563.8C084648"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [202.138.125.53] (helo=vscrn3.securesynergyonline.com)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ZuAV-0008HS-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 08 Jul 2003 08:14:12 -0700
Received: from mail.soc-soft.com (202.56.254.199) by vscrn3.securesynergyonline.com (202.138.125.53), id <1057676744435.228822026.vscrn3.securesynergyonline.com>
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 08 Jul 2003 21:05:44 +0600
content-class: urn:content-classes:message
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: czr@iohazard.tts.fi

This is a multi-part message in MIME format.

------_=_NextPart_001_01C34563.8C084648
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

HI!
Iam writing a image blit routine for 69030 controller......
But Iam not able to see anything on screen.Fidled around lot with this
code..........
Can any one help me out and tell whasts wrong in this code........
BR00 and all are typecasted to their MMIO address.......
BLIT_BASE is MMIO_BASE+0x400000;
=20
Image width is 239 pixels and Image height is 309 pixels....
At first Iam intending to write only 64 KB of data and check how and
where it comes.....
=20
void chips_imageblit(struct fb_image *image)
{
    UINT32 dst_span,src_span;
    UINT32 tmp,i;
    printf("Inside image blit\n");
    dst_span =3D xres * bytes_per_pixel;
   =20
    /*BR00*/
    BR00 &=3D 0x00000000;
    BR00 |=3D dst_span<<13;
    src_span =3D image->width * bytes_per_pixel;
    BR00 |=3D src_span;
    printf("Wrote BR00 %x\n",BR00);
   =20
    /*BR04*/
    BR04 |=3D (((UINT32)1)<<10);
    BR04 |=3D 0xCC;
    BR04 =3D 0x400;
     printf("Wrote BR04 %x\n",BR04);
    /*BR06*/
    BR06 =3D 0x00000000;
    printf("Wrote BR06 %x\n",BR06);
    /*BR07*/
    BR07 =3D 0x00000000;
    printf("Wrote BR07 %x\n",BR07);
    memcpy(BLIT_BASE,image->data,0xFFFF);
    printf("memcpy done\n");
   =20
//    BR08 |=3D (((UINT32)image->height)<<16);
    printf("The value for xr20 is %x\n",read_xtn_reg(0x20));
    printf("Before writing BR08 %x\n",BR08);
    printf("Wrote1 BR08 %x tmp =3D %x\n",BR08,tmp);
    printf("Wrote1 BR08\n");
    BR08 |=3D image->width * bytes_per_pixel;
    BR08 =3D 0x13502cd;
    printf("Wrote2 BR08 %x\n",BR08);
    printf("The value for xr20 is %x\n",read_xtn_reg(0x20));
     =20
    printf("Going out image blit\n");
  =20
}
=20
Thanking in advance ,
=20
=20

------_=_NextPart_001_01C34563.8C084648
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1141" name=3DGENERATOR></HEAD>
<BODY>
<DIV>HI!</DIV>
<DIV>Iam writing a image blit routine for 69030 controller......</DIV>
<DIV>But Iam not able to see anything on screen.Fidled around lot with =
this=20
code..........</DIV>
<DIV>Can any one help me out and tell whasts wrong in this =
code........</DIV>
<DIV>BR00 and all are typecasted to their MMIO address.......</DIV>
<DIV>BLIT_BASE is MMIO_BASE+0x400000;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D839320815-08072003>Image=20
width is 239 pixels and Image height is 309 =
pixels....</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D839320815-08072003>At=20
first Iam intending to write only 64 KB of data and check how and where =
it=20
comes.....</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2></FONT>&nbsp;</DIV>
<DIV>void chips_imageblit(struct fb_image =
*image)<BR>{<BR>&nbsp;&nbsp;&nbsp;=20
UINT32 dst_span,src_span;<BR>&nbsp;&nbsp;&nbsp; UINT32 tmp,i;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; printf("Inside image =
blit\n");<BR>&nbsp;&nbsp;&nbsp;=20
dst_span =3D xres * bytes_per_pixel;<BR>&nbsp;&nbsp;&nbsp; </DIV>
<DIV>&nbsp;&nbsp;&nbsp; /*BR00*/<BR>&nbsp;&nbsp;&nbsp; BR00 &amp;=3D=20
0x00000000;<BR>&nbsp;&nbsp;&nbsp; BR00 |=3D=20
dst_span&lt;&lt;13;<BR>&nbsp;&nbsp;&nbsp; src_span =3D image-&gt;width * =

bytes_per_pixel;<BR>&nbsp;&nbsp;&nbsp; BR00 |=3D =
src_span;<BR>&nbsp;&nbsp;&nbsp;=20
printf("Wrote BR00 %x\n",BR00);<BR>&nbsp;&nbsp;&nbsp; =
<BR>&nbsp;&nbsp;&nbsp;=20
/*BR04*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;BR04 |=3D=20
(((UINT32)1)&lt;&lt;10);<BR>&nbsp;&nbsp;&nbsp; BR04 |=3D=20
0xCC;<BR>&nbsp;&nbsp;&nbsp; <A href=3D"file://BR04">BR04</A> =3D=20
0x400;<BR>&nbsp;&nbsp;&nbsp;&nbsp; printf("Wrote BR04=20
%x\n",BR04);<BR>&nbsp;&nbsp;&nbsp; /*BR06*/<BR>&nbsp;&nbsp;&nbsp; BR06 =
=3D=20
0x00000000;<BR>&nbsp;&nbsp;&nbsp; printf("Wrote BR06=20
%x\n",BR06);<BR>&nbsp;&nbsp;&nbsp; /*BR07*/<BR>&nbsp;&nbsp;&nbsp; BR07 =
=3D=20
0x00000000;<BR>&nbsp;&nbsp;&nbsp; printf("Wrote BR07 %x\n",BR07);</DIV>
<DIV>&nbsp;&nbsp;&nbsp;=20
memcpy(BLIT_BASE,image-&gt;data,0xFFFF);<BR>&nbsp;&nbsp;&nbsp; =
printf("memcpy=20
done\n");<BR>&nbsp;&nbsp;&nbsp; <BR>//&nbsp;&nbsp;&nbsp; BR08 |=3D=20
(((UINT32)image-&gt;height)&lt;&lt;16);<BR>&nbsp;&nbsp;&nbsp; =
printf("The value=20
for xr20 is %x\n",read_xtn_reg(0x20));<BR>&nbsp;&nbsp;&nbsp; =
printf("Before=20
writing BR08 %x\n",BR08);<BR>&nbsp;&nbsp;&nbsp;&nbsp;printf("Wrote1 BR08 =
%x tmp=20
=3D %x\n",BR08,tmp);<BR>&nbsp;&nbsp;&nbsp; <A=20
href=3D"file://printf">printf</A>("Wrote1 =
BR08\n");<BR>&nbsp;&nbsp;&nbsp; <A=20
href=3D"file://BR08">BR08</A> |=3D image-&gt;width *=20
bytes_per_pixel;<BR>&nbsp;&nbsp;&nbsp; BR08 =3D =
0x13502cd;<BR>&nbsp;&nbsp;&nbsp;=20
printf("Wrote2 BR08 %x\n",BR08);<BR>&nbsp;&nbsp;&nbsp; printf("The value =
for=20
xr20 is %x\n",read_xtn_reg(0x20));<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
<BR>&nbsp;&nbsp;&nbsp; printf("Going out image blit\n");<BR>&nbsp;&nbsp; =

<BR>}</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanking in advance ,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C34563.8C084648--
Scanned by SecureSynergy VirusScreen Service. 
For more information log on to : http://www.securesynergyonline.com or http://www.securesynergy.com


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
