From: "sun york" <yorksun@freescale.com>
Subject: How to test virtual resolution
Date: Wed, 6 Aug 2008 08:37:53 -0700
Message-ID: <FE151544B54DB0428FFA9AE99C27A12102183DD0@az33exm22.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1802643036=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQlDJ-0002Di-Mu for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 08:46:15 -0700
Received: from az33egw02.freescale.net ([192.88.158.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KQl5N-0005ah-Oh
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 08:38:03 -0700
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m76FbrkQ005537 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 08:37:54 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m76FbqNJ006777
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 6 Aug 2008 10:37:53 -0500 (CDT)
Content-class: urn:content-classes:message
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1802643036==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8F7DA.6366EE88"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8F7DA.6366EE88
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I was asked to add the support for virtual resolution for fsl_diu_fb. I
don't know how to test it without X. It seems that fbcon can use the
virtual resolution and pan around. Can someone shed some light on this?
=20
York
=20

------_=_NextPart_001_01C8F7DA.6366EE88
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D812003515-06082008><FONT face=3DArial size=3D2>I was =
asked to add=20
the support for virtual resolution&nbsp;for fsl_diu_fb. I don't know how =
to test=20
it without X. It seems that fbcon can use the virtual resolution and pan =
around.=20
Can someone shed some light on this?</FONT></SPAN></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>York</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C8F7DA.6366EE88--


--===============1802643036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============1802643036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1802643036==--
