From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Devices don't get linked to their class.
Date: Fri, 03 Sep 2004 15:02:31 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1094187751.2979.41.camel@laptop.cunninghams>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C36GN-0000Pf-BZ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 22:05:27 -0700
Received: from relay01.kbs.net.au ([203.220.32.149] ident=8)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C36GM-0006fh-IG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Sep 2004 22:05:27 -0700
Received: from [203.220.93.129] (helo=[203.220.93.129])
	by relay01.kbs.net.au with esmtp (Exim 3.36 #2)
	id 1C36GK-0000iW-00
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 03 Sep 2004 15:05:24 +1000
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi all.

Some of my suspend2 users have reported that their displays go blank as
soon as suspend starts writing to disk. I understand why. I suspend
everything else except the storage device and it's parents at the start
of writing the image.

Interestingly, though, the issue doesn't occur with all display drivers,
perhaps (I guess) because they haven't had PM support written yet.
Having switched from the vesafb driver to the radeon one, I'm now able
to reproduce the behaviour described above.

This morning I began work on addressing the problem. I thought the best
approach would be to use device classes to find the struct dev for the
frame buffer driver, and then use the same code I use for storage
devices to avoid suspending the frame buffer until later. I successfully
wrote a helper to find the 'graphics' class that fbmem.c creates, but
now I've run into a more serious issue. register_framebuffer (in the
same time) calls class_simple_device_add with a NULL for the pointer to
the struct device. Is it possible for this issue to be addressed? I can
see that (at least in the Radeon case) one could simply call
register_framebuffer with an additional parameter, but thought I'd email
you and seek your wisdom.

By the way, am I missing something? It looks like framebuffer_alloc does
nothing with the dev parameter passed to it.

Regards,

Nigel

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
