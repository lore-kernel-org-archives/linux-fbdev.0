From: tomas carnecky <tom@dbservice.com>
Subject: opengl for framebuffer
Date: Mon, 05 Jan 2004 16:35:10 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FF9842E.5090807@dbservice.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdWl8-0003HA-W0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 07:35:14 -0800
Received: from [213.133.97.13] (helo=matterhorn.dbservice.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AdWl8-0000qn-JF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 05 Jan 2004 07:35:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by matterhorn.dbservice.com (Postfix on SuSE Linux 8.0 (i386)) with ESMTP id 723A91B138
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  5 Jan 2004 16:35:13 +0100 (CET)
Received: from dbservice.com (emmen.dbservice.com [62.65.141.13])
	by matterhorn.dbservice.com (Postfix on SuSE Linux 8.0 (i386)) with ESMTP id 2ED62191D6
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  5 Jan 2004 16:35:11 +0100 (CET)
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

Hi ,

I'm looking for a opengl library for the framebuffer devices.
I found an project (http://fbdri.sf.net) but they released only one 
tarball,
and that was about two years ago. Anyone knows another project?

I think there is a port of the XFree86 xserver to the framebuffer,
but I don't want to use this large bunch of applications and libraries,
just to get opengl working on the framebuffer.

Long ago, I had the idea to write a collection of libraries to make 
opengl 3D
acceleration avilable without a xserver or framebuffer. It works now 
(somehow).
There exists a _really_ small documentation 
(www.dbservice.com/tom/graphics.html).

I'd like to know what you think about it.

-- 

wereHamster a.k.a. Tom Carnecky   Emmen, Switzerland

(GC 3.1) GIT d+ s+: a--- C++ UL++ P L++ E- W++ N++ !o !K  w ?O ?M
          ?V PS PE ?Y PGP t ?5 X R- tv b+ ?DI D+ G++ e-- h! !r !y+




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
