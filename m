From: Chad A Daelhousen <cd9@cse.Buffalo.EDU>
Subject: 2.4.x Radeon patches and documentation
Date: Tue, 4 Nov 2003 13:14:43 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20031104181443.GA1669@gagarin.cse.Buffalo.EDU>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AH5hV-0000qO-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 04 Nov 2003 10:14:45 -0800
Received: from gagarin.cse.buffalo.edu ([128.205.36.11] ident=daemon)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AH5hU-00035a-RH
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 04 Nov 2003 10:14:44 -0800
Received: (from cd9@localhost)
	by gagarin.cse.buffalo.edu (8.11.7p1+Sun/8.11.6) id hA4IEha02855
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 4 Nov 2003 13:14:43 -0500 (EST)
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I have been making minor changes to radeonfb.c in the 2.4 series to make
my hardware work with it for a while, and documenting what I have found
while doing so. The current work is at
[http://thesapphirecat.iwarp.com/present/program/radeonfb.html] and
[http://thesapphirecat.iwarp.com/present/program/radeonpatches.html].
(Patches are actually made against the CK patchset, but AFAIK those
don't touch drivers/video.)

I would like to combine the framebuffer documentation I've found into
one single, cohesive document. I have the Framebuffer-HOWTO SGML, text
files under Documentation/fb, and of course the HTML pages above. Is
anyone already working on such a project? Are any of my sources so
obsolete or inaccurate I should not bother to include them?

-- 
Chad Daelhousen
My opinions are my own, until UB purchases my soul.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
