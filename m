From: "Jon Dufresne" <jon.dufresne@gmail.com>
Subject: Autodectect best video mode at module load time
Date: Wed, 3 Sep 2008 10:43:31 -0700
Message-ID: <376ea3380809031043w1ef9c0deh76557df0b5629ca2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KawOE-0005Wt-3n for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 10:43:34 -0700
Received: from ey-out-1920.google.com ([74.125.78.146])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KawOD-00062q-Mi
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 10:43:34 -0700
Received: by ey-out-1920.google.com with SMTP id 4so1164452eyk.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 03 Sep 2008 10:43:31 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Hi,

I want to add support to my framebuffer driver to add support to
autodetect the best video mode and resolution, at module load time. I
am good for calculating this, but I'm curious where the fbdev can get
information on the monitor attached. Is this something that should be
found in the device hardware itself, or should I look elsewhere in the
kernel.

Thanks,
Jon

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
