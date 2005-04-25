From: Travos Xavier <xavier_travos@yahoo.fr>
Subject: modifing lcd size for omap5912 fb
Date: Mon, 25 Apr 2005 13:43:36 +0200 (CEST)
Message-ID: <20050425114336.52036.qmail@web26408.mail.ukl.yahoo.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="0-609631677-1114429416=:50429"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ20b-00040f-UU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 04:44:13 -0700
Received: from web26408.mail.ukl.yahoo.com ([217.146.176.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DQ206-0005Wj-H6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 25 Apr 2005 04:44:13 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

--0-609631677-1114429416=:50429
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

I work on the omap5912 and I want to plug a 640x480 lcd but the configura=
tion is done for a 320x240 screen for this arch (see drivers/viseo/omap/o=
map1610.h) I modified the init_registers function that writes the timing =
in the lcd controler on the omap5912. By the way I have problems with the=
 external timings and the VSYNC signal control that doesn't work as it sh=
ould.
=20
Have you solutions for my problem ?
=20
regards
=20
Xavier


	=09
---------------------------------
 D=E9couvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vo=
s mails !
Cr=E9ez votre Yahoo! Mail
--0-609631677-1114429416=:50429
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<DIV>
<DIV>I work on the omap5912 and I want to plug a 640x480 lcd but the conf=
iguration is done for a 320x240 screen for this arch (see drivers/viseo/o=
map/omap1610.h) I modified the init_registers function that writes the ti=
ming in the lcd controler on the omap5912. By the way I have problems wit=
h the external timings and the VSYNC signal control that doesn't work as =
it should.</DIV>
<DIV>&nbsp;</DIV>
<DIV>Have you solutions for my problem ?</DIV>
<DIV>&nbsp;</DIV>
<DIV>regards</DIV>
<DIV>&nbsp;</DIV>
<DIV>Xavier</DIV></DIV><p>
		<hr size=3D1>=20
D=E9couvrez le nouveau Yahoo! Mail : <font color=3D"red">250 Mo d'espace<=
/font> de stockage pour vos mails !<br><a href=3D"http://fr.rd.yahoo.com/=
mail/taglines/*http://us.rd.yahoo.com/evt=3D25917/*http://us.rd.yahoo.com=
/mail_fr/mail_campaigns/splash/taglines_250/default/*http://fr.promotions=
.yahoo.com/mail/creer28.html">Cr=E9ez votre Yahoo! Mail</a>


--0-609631677-1114429416=:50429--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
