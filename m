From: Jon Smirl <jonsmirl@gmail.com>
Subject: fbdev hardware cursor support
Date: Wed, 25 May 2005 01:40:57 -0400
Message-ID: <9e473391050524224063df2372@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Daoda-0006IX-B3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 May 2005 22:41:02 -0700
Received: from wproxy.gmail.com ([64.233.184.194])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DaodX-0007OH-U6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 24 May 2005 22:41:02 -0700
Received: by wproxy.gmail.com with SMTP id 69so498222wri
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 24 May 2005 22:40:58 -0700 (PDT)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

What is the status of fbdev hardware cursor support? I see the ioctl
is disabled in the driver.

If a driver is using the softcursor support would the ioctl control that cu=
rsor?
Does softcursor work in a bitmap graphics mode?

The EGL based X server is going to need fbdev hardware cursors working.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
