From: Otto Wyss <otto.wyss@orpatec.ch>
Subject: CVS cleanup
Date: Sun, 17 Oct 2004 19:30:36 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4172AC3D.37DF426F@orpatec.ch>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJEro-0002gu-0n
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 10:30:48 -0700
Received: from mail.xor.ch ([212.55.210.163])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CJErm-00081X-Il
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 10:30:47 -0700
Received: from orpatec.ch (80.218.105.53)
          by mail.xor.ch with MERCUR Mailserver (v4.03.03 NjYtMjMxMS00NjIy)
          for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 17 Oct 2004 19:36:33 +0200
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
To: 'linux-fbdev-devel' <linux-fbdev-devel@lists.sourceforge.net>

I'm considering to put all code in the CVS into the FBdev directory so
it can easily be retrieved. The following directory exists:

- atyfb: Seems to be rather old and probably can be removed, otherwise
I'll move it into "FBdev/drivers/atyfb/".

- fbtest: Seems to be actual => I'll move it into "FBdev/fbtest"

- fbutils: I don't know => I'll move it into "FBdev/fbutils"

Any objections or corrections?

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
