From: "krishna priya" <priyark1@gmail.com>
Subject: direct frame buffer application
Date: Thu, 15 Mar 2007 15:50:27 +0530
Message-ID: <24a0517a0703150320h610546c8q8aa6fe0a4a4b0c0a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1873925341=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HRn4P-00009W-AB for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 03:20:29 -0700
Received: from an-out-0708.google.com ([209.85.132.250])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HRn4O-0002iR-TC
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 15 Mar 2007 03:20:29 -0700
Received: by an-out-0708.google.com with SMTP id d40so167941and
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 15 Mar 2007 03:20:28 -0700 (PDT)
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

--===============1873925341==
Content-Type: multipart/alternative; 
	boundary="----=_Part_64374_15251731.1173954027904"

------=_Part_64374_15251731.1173954027904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody

This is priya working on linux-2.6.12 kernel on omapldk5912 board.I am
trying load direct librraies on ldk board using 2.6.12 kernel.I am able to
load the libraries successfully  but i am not able to run the Direct Frame
buffer application with the libraries.that application is direclty entering
in to Error messages that the driver is not opening for this
application.That means the frame buffer driver itself is not initializing
for this application.


Version of DirectFB-0.9.20


Any one can suggest me how to use the frame buffer driver to run the
directFB application using  /dev/fb0 device.

-- 
Thanks
Krishna Priya

------=_Part_64374_15251731.1173954027904
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi everybody<br><br>This is priya working on linux-2.6.12 kernel on omapldk5912 board.I am trying load direct librraies on ldk board using 2.6.12 kernel.I am able to load the libraries successfully&nbsp; but i am not able to run the Direct Frame buffer application with the 
libraries.that application is direclty entering in to Error messages that the driver is not opening for this application.That means the frame buffer driver itself is not initializing for this application.<br><br><br>Version of 
DirectFB-0.9.20<br><br><br>Any one can suggest me how to use the frame buffer driver to run the directFB application using&nbsp; /dev/fb0 device.<br>
<br>-- <br>Thanks <br>Krishna Priya

------=_Part_64374_15251731.1173954027904--


--===============1873925341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1873925341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1873925341==--
