From: Armin Krieg <warcomp@web.de>
Subject: problems with radeonfb in linux-2.6.11-rc3
Date: Fri, 4 Feb 2005 00:29:43 +0000
Message-ID: <200502040029.43885.warcomp@web.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwqPy-0002TD-Fl
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Feb 2005 15:29:46 -0800
Received: from smtp07.web.de ([217.72.192.225])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1CwqPw-0006RL-Lx
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 03 Feb 2005 15:29:46 -0800
Received: from [213.47.49.234] (helo=chello213047049234.5.sc-graz.chello.at)
	by smtp07.web.de with asmtp (TLSv1:RC4-MD5:128)
	(WEB.DE 4.103 #192)
	id 1CwqPo-0004WH-00
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 00:29:36 +0100
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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

Hi !

I have some problems with the new 2.6.11-rc3 patch...
I normally have the radeonfb activated and use a bigger console...

but now the display (a 17inch tft) blanks when the framebuffer is loaded,
using "vga=normal" doesn't help, then i'm able to see a curser jumping
around on the bottom of the screen!
Currently I've to completely disable the radeonfb...
I'm using a Radeon 9600XT and there are no error-messages in syslog....

and i hope i can give also another bug-report, although I think its a problem
with the new dri-code...
I'm using a cvs-snapshot of x.org and with the newer kernels 2.6.11-XXX or
a cvs-snapshot of drm my screen is completely "distorted", but i can see the
edges of windows...so it seems to be a problem with a correct order of the
horizontal lines...

good luck ;-)

thx and wkr,

Armin

PS: I'm using amd64 version of slackware-current (core-packages are not 
original....)


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
