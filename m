From: Kalyan Chakravarthy Dasari <kalyan@sasken.com>
Subject: Problem in displaying logo at boot up time
Date: Fri, 27 Sep 2002 12:41:57 +0530 (IST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.30.0209271238100.10028-100000@sunrnd2.sasken.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from samar.sasken.com ([164.164.56.2])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17upIE-00066m-00
	for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Sep 2002 00:12:07 -0700
Received: from samar (localhost [127.0.0.1])
	by samar.sasken.com (8.11.6/8.11.6) with SMTP id g8R7BwT16478
	for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Sep 2002 12:41:58 +0530 (IST)
Received: from localhost (kalyan@localhost)
	by sunrnd2.sasken.com (8.11.6/8.11.6) with ESMTP id g8R7BvP11014
	for <Linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Sep 2002 12:41:57 +0530 (IST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer <Linux-fbdev-devel@lists.sourceforge.net>


Hi,
	I am using Linux 2.4.8 with necessary patches for ARM processor. I
am using SA-1110 processor running at 206 MHz, with a 640x480 Hitachi
8-bit color LCD. I am trying to display a logo at boot up time. I am able
to display penguin logo and other logo's of size upto 320x240. If I try to
display an image of size 640x480 kernel panics while booting. Is there any
limitation on the size of the logo that can be displayed while booting? Is
there any fix provided if the limitation is there?

Any pointers will be helpful,

thanks,
kalyan


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Kalyan C Dasari
IAS-BlackRose
Sasken Communication Technologies Limited
Bangalore

Phone -- (o)- 53 555 01 / 53 555 03 extn: 3322
         (R)- 5542448
E-mail   kalyan@sasken.com

_____________________________________________________________________
         CONFIDENTIALITY INFORMATION AND DISCLAIMER
---------------------------------------------------------------------
"This communication sent by Sasken Communication Technologies Limited is
privileged and confidential, and is directed to and for the use of the
addressee only. If this message reaches anyone other than the intended
recipient, we request the reader not to reproduce, copy, disseminate or in
any manner distribute it. We further request such recipient to notify us
immediately by return email and delete the original message.
Sasken does not guarantee the security of any information transmitted
electronically and is not liable for the proper, timely and complete
transmission thereof. Opinions, conclusions and other information in this
communication that do not relate to the official business of Sasken shall
be understood as neither given nor endorsed by it."
_____________________________________________________________________

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
