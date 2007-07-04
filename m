From: "Lothar Wassmann" <LW@KARO-electronics.de>
Subject: Re: [PATCH] pxafb: Add support for other
	palette formats
Date: Wed, 4 Jul 2007 09:17:19 +0200
Message-ID: <18059.18815.378793.220680@ipc1.karo>
References: <200707031607.08511.hjk@linutronix.de>
	<200707031845.57256.hjk@linutronix.de>
	<468A85A2.1070506@grupopie.com>
	<200707031944.21467.hjk@linutronix.de>
	<468A9300.7060608@grupopie.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1040061042=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I5z7a-0002EG-3O for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jul 2007 00:17:54 -0700
Received: from mail.karo-electronics.de ([213.146.116.110])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I5z7X-0005j8-G4
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 04 Jul 2007 00:17:54 -0700
In-Reply-To: <468A9300.7060608@grupopie.com>
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
To: Paulo Marques <pmarques@grupopie.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

--===============1040061042==

Hi,

> I assume the "red 6@16" is a typo for "red 6@12", since the "3 byte / 
> green 6@6 and blue 6@0" match exactly the 18bpp packed format. Even 
> 
Take a closer look at the actual pixel format of the PXA270.
The usual graphics packages AFAIK support either packed pixels
(i.e. 18 bit on screen => 18 bit in memory) or unpacked (i.e. 18/24
or whatever bits => 32 bit in memory).
The PXA supports either the unpacked pixel format (which is a waste of
memory especially on embedded systems) or a strange format which is
neither: 18bit on screen in 24bit in memory (IOW 4 pixels in 3
words in memory).


Lothar Wassmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra���e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch���ftsf���hrer: Matthias Kaussen, Rolf Rosenstein
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________


--===============1040061042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1040061042==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1040061042==--
