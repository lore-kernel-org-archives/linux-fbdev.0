From: Andrew Walrond <andrew@walrond.org>
Subject: I want to use fb device for my 3D game. Can it do what I need?
Date: Fri, 9 Jan 2004 22:00:10 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200401092200.10820.andrew@walrond.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Af4fz-0003tq-Bz
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 14:00:19 -0800
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25] helo=cenedra.office)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Af4fy-0003Tn-L6
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Jan 2004 14:00:18 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net

Hello list!

I have developed a software library for rendering 3D scenes.
It would be very cool if I could use the fb device so that X needn't be 
running, freeing considerable resources for the application
Note that it is a _software_ renderer, I don't need access to 3D hardware 
acceleration, just a means of copying/bliting frames to the screen as fast as 
possible, and a double buffering facility

So what I need is an api allowing me to

- Set the screen resolution/colour depth. (16bit colour depth or better is 
required)

- Allocate front and back buffers

- Copy scene to back buffer

- Swap buffers synced with vertical refresh

Does fbdev have the facilities I need?

Andrew Walrond



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
