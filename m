From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Finally found why 2.6.x has troubles with taking over vgacon
Date: Sat, 3 Jul 2004 21:56:13 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040703195613.GA30739@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgqcW-0005Jm-5F
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 12:56:20 -0700
Received: from vana.vc.cvut.cz ([147.32.240.58])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34)
	id 1BgqcV-0008Jd-H2
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Jul 2004 12:56:20 -0700
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Antonio,
  yesterday I finally found why 2.6.x has problems with taking over vgacon.
Problem is that take_over_console does:


  if (IS_VISIBLE)
    save_screen(i);
  ...
  visual_init(i, 0);
  ...

so code nicely saves screen contents, and calls visual_init, which calls 
fbcon's init, which in turn can issue vc_resize. And this vc_resize will
trigger read from vc->vc_origin. But vc_origin still points to videomemory,
not to the buffer where save_screen() copied its data.

  In my fbcon (http://platan.vc.cvut.cz/ftp/pub/linux/matrox-latest/matroxfb-2.6.7-c1784.tar.gz)
after I put

  origin = visual_origin = screenbuf;

below save_screen call, and removed clearing screen from radeon sources 
both radeonfb and matroxfb were able to take over vgacon, without any 
randomly colored characters on screen.

  It also allows for removing special fillrect clear, as now code
which clears upper few lines of logo area actually works...
						Best regards,
							Petr Vandrovec




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
