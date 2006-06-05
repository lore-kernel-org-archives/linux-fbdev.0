From: "Nathan King" <natetheking@gmail.com>
Subject: vesafb
Date: Mon, 5 Jun 2006 13:02:45 -0500
Message-ID: <bb9a78950606051102s514075aar7924d05756ccd3c1@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1956321939=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fo5mT-0006DA-J4 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 14:41:37 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fo5mT-0006yk-AQ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 14:41:37 -0700
Received: from nz-out-0102.google.com ([64.233.162.206])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fo5mT-0002ig-6t
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Jun 2006 14:41:37 -0700
Received: by nz-out-0102.google.com with SMTP id s18so421333nze
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 07 Jun 2006 14:41:31 -0700 (PDT)
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

--===============1956321939==
Content-Type: multipart/alternative; 
	boundary="----=_Part_4763_31592448.1149530565257"

------=_Part_4763_31592448.1149530565257
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey folks,

I'm trying to get a feel for how all this works as I get ready to really
start monkeying with the driver, so I liberally sprinkled some printk's
around vesafb.c and cfb_fillrect.c and recompiled. However I only ever get
messages from three of the vesafb.c functions, all on bootup, and none from
cfb_fillrect.c. I know doing all those messages will slow down my system(or
they would if they worked right) but I'm just trying to figure out what
files control what.

So my question is, which files are responsible for all these constant
fillrect and bitblt operations, and can they monkeyed with to generate
kernel or other messages?

Using 2.6.16 with fedora core 5 and the VESA driver.

Many thanks,
Nathan

------=_Part_4763_31592448.1149530565257
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey folks,<br><br>I'm trying to get a feel for how all this works as I get ready to really start monkeying with the driver, so I liberally sprinkled some printk's around vesafb.c and cfb_fillrect.c and recompiled. However I only ever get messages from three of the 
vesafb.c functions, all on bootup, and none from cfb_fillrect.c. I know doing all those messages will slow down my system(or they would if they worked right) but I'm just trying to figure out what files control what. <br>
<br>So my question is, which files are responsible for all these constant fillrect and bitblt operations, and can they monkeyed with to generate kernel or other messages?<br><br>Using 2.6.16 with fedora core 5 and the VESA driver.
<br><br>Many thanks,<br>Nathan<br>

------=_Part_4763_31592448.1149530565257--


--===============1956321939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1956321939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1956321939==--
