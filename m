From: David Mosberger <davidm@napali.hpl.hp.com>
Subject: fglrx + radeonfb leads to crashes?
Date: Wed, 17 Mar 2004 12:18:05 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200403172018.i2HKI5E0002012@napali.hpl.hp.com>
Reply-To: davidm@hpl.hp.com
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B3hWd-00005O-78
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 12:20:27 -0800
Received: from palrel10.hp.com ([156.153.255.245])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B3hWZ-0000fO-GM
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Mar 2004 12:20:23 -0800
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
To: ajoshi@shell.unixbox.com
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Ani,

I have a machine here with an ATI FireGL Z1 card.  It works fine with
the ATI fglrx binary-only driver on 2.6.5-rc1.  However, if radeonfb
is enabled and I try to stop the X server or switch away from it to
another virtual console, then the screen display gets all messed up
and the machine gets stuck.  When this hapens, I periodically see this
kind of message:

  radeonfb: FIFO Timeout !

Now, this is on ia64 machine so at this point I'm just wondering
whether this problem also shows up on other machines.  If it's an
ia64-specific problem, I can look into it.  Otherwise, I guess I'll
just disable radeonfp for now.

Thanks,

	--david


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
