From: Scott Mcdermott <scott.m.mcdermott@gmail.com>
Subject: Re: intelfb crashes during modprobe
Date: Thu, 14 Aug 2008 09:14:16 -0700
Message-ID: <20080814161416.GG5916@omnius.localdomain>
References: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KTfSx-0005Y8-Vr for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Aug 2008 09:14:25 -0700
Received: from wa-out-1112.google.com ([209.85.146.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KTfSv-0005KZ-8Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 14 Aug 2008 09:14:23 -0700
Received: by wa-out-1112.google.com with SMTP id j5so340311wah.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 14 Aug 2008 09:14:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <376ea3380808140821k4e2ec102n452bcc7bb9cc3676@mail.gmail.com>
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
To: linux-fbdev-devel@lists.sourceforge.net

Jon Dufresne on Thu 14/08 08:21 -0700:
> My target platform is an x86 with an intel 965G
> chipset running fedora.

I believe intelfb dev for later chipsets has gone here:

http://www.google.com/search?q=%22kernel%20modesetting%22

supposedly 965G works in that tree, and is enableable
with FC9 shipped kernel given the command line args
mentioned

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
