From: James <james@onyx.nurealm.net>
Subject: typo in src/linux-2.6.9/Documentation/svga.txt?
Date: Sun, 24 Oct 2004 17:00:00 -0600
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410242300.i9ON00WO003941@onyx.nurealm.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLrLH-0003Si-UN
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Oct 2004 16:00:03 -0700
Received: from onyx.nurealm.net ([199.45.155.18])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CLrLH-00018O-Cb
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Oct 2004 16:00:03 -0700
Received: from onyx.nurealm.net (localhost.localdomain [127.0.0.1])
	by onyx.nurealm.net (8.13.1/8.13.0) with ESMTP id i9ON00WO003941
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 24 Oct 2004 17:00:01 -0600
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net

There is, at "3. Mode IDs":

    0x0200 to 0x08ff - VESA BIOS modes. The ID is a VESA mode ID increased by
         0x0100. All VESA modes should be autodetected and shown on the menu.

I'm guessing that should be "increased by 0x0200" to conform with
"src/linux-2.6.9/Documentation/fb/vesafb.txt", which states:

 The video mode number of the Linux kernel is the VESA mode number plus
 0x200.

It's a bit confusing.


James



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
