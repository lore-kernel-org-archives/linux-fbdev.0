From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [FBDEV UPDATE] Newer patch. (fwd)
Date: Sat, 25 Oct 2003 00:59:31 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031024225931.GC807@elf.ucw.cz>
References: <20031024212201.GK643@openzaurus.ucw.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADAvB-0006eA-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 16:00:41 -0700
Received: from gprs146-242.eurotel.cz ([160.218.146.242] helo=amd.ucw.cz)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ADAuJ-0006tc-TN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 24 Oct 2003 15:59:50 -0700
Content-Disposition: inline
In-Reply-To: <20031024212201.GK643@openzaurus.ucw.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jsimmons@infradead.org, kernel list <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: pavel@ucw.cz

Hi!

> Hi folks. 
> 
>   I have a new patch against 2.6.0-test8. This patch is a few fixes and I 
> added back in functionality for switching the video mode for fbcon via 
> fbset again. Give it a try and let me know the results.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

It has even worse problems with cursor than -test8 (I would not think
that's possible).

Try this for a demo of vga-softcursor problems:

echo -e "\33[10;5000]\33[11;50]\33[?18;0;136c\33[?102m"

... and even during normal boot cursor is corrupted.

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
