From: Zachary Smith <plinius@comcast.net>
Subject: Re: [RFC] Does fbdev need a cursor API for userland?
Date: Sun, 17 Oct 2004 10:18:10 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4172A952.4080607@comcast.net>
References: <200410172347.15516.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJEbZ-00016p-Ik
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 10:14:01 -0700
Received: from sccrmhc13.comcast.net ([204.127.202.64])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CJEbY-0005IM-1t
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 17 Oct 2004 10:14:01 -0700
In-Reply-To: <200410172347.15516.adaplas@hotpop.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Antonino A. Daplas wrote:

> IMO, I believe that the cursor ioctl should just be removed :-)

Well I don't need a cursor from userland, but I do need a way to
manage the hardware cursor (sprite) if it exists from within
the kernel.

Zack


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
