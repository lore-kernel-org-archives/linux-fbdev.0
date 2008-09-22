From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: Setting interlace mode with fbdev fbset
Date: Mon, 22 Sep 2008 10:57:02 -0700
Message-ID: <376ea3380809221057j2bb9115did274c3d96a11ec2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jon.dufresne@gmail.com>) id 1Khpeo-00038M-2h
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Sep 2008 17:57:10 +0000
Received: from nf-out-0910.google.com ([64.233.182.187])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Khpei-0002Qe-9z for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 22 Sep 2008 17:57:10 +0000
Received: by nf-out-0910.google.com with SMTP id g16so565772nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 22 Sep 2008 10:57:02 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I am trying to confirm that the fbdev driver I'm developing works
correctly with interlace modes. First thing I need to know, is when
passing mode parameters to the fbdev using fbset, should the values be
per field, or per frame? So for example I want to set my monitor to
1080i, which of the following commands looks more correct:

fbset -g 1920 1080 2048 2048 32 -t 13468 148 88 30 4 44 10 -hsync high
-vsync high -laced true

or

fbset -g 1920 540 2048 2048 32 -t 13468 148 88 15 2 44 5 -hsync high
-vsync high -laced true

notice in the second command (which is the specs per field), more than
just the vertical lines is halved.

Thanks,
Jon

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
