From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Reading the EDID block for x86 machines
Date: Tue, 18 Mar 2003 22:07:13 -0800 (PST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030319060713.58910.qmail@web14906.mail.yahoo.com>
References: <1048050587.1183.3.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from web14906.mail.yahoo.com ([216.136.225.58])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vWjJ-0007L0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Mar 2003 22:07:13 -0800
In-Reply-To: <1048050587.1183.3.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Thanks for making an extreme effort at trying to get
this work. I wish the video card vendors paid
attention to the list so that they would have an idea
of what lengths their customers will take in order to
use their products. It's times like this that made me
abandon the Microsoft world and become a Linux
convert. 

Does anyone have a good ATI contact? Maybe they'll at
least see the light and provide us with the info
needed to avoid a user mode solution for their
hardware. 

I agree that the user mode solution is the easiest
path from here.  V0.6 of the scitech x86emu works to
reset my radeon with a minor tweak - INT 15 needs to
be implement to simply return 1.

I have had no success in getting V0.8 to work but I
didn't try very hard given that V0.6 is working for
me. The emulator hangs on both versions.

Just to report on what I'm doing to keep busy, I have
a full DRI accelerated Mesa running standalone on most
Radeons100-300. The accelerated Mesa uses both DRM and
FB drivers.  I'm in the process of modifying embedded
QT (which contains a window manager) to run on it as
an OpenGL application. The goal is to see if OpenGL
would make an effective alternative platform to X.
There is a lot of code to write before this all works,
contributions welcome.

=====
Jon Smirl
jonsmirl@yahoo.com

__________________________________________________
Do you Yahoo!?
Yahoo! Platinum - Watch CBS' NCAA March Madness, live on your desktop!
http://platinum.yahoo.com


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
