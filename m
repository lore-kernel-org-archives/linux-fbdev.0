From: Paul Furber <paulf@gam.co.za>
Subject: vesafb and xres_virtual
Date: Fri, 07 Jun 2002 04:02:02 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3D00141A.2090308@gam.co.za>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from fedex.is.co.za ([196.4.160.243])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17G95q-0003rF-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 06 Jun 2002 19:03:10 -0700
Received: from gam.co.za (c4-ndf-15.dial-up.net [196.34.159.143])
	by fedex.is.co.za (Postfix) with ESMTP id 901CB3A268
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  7 Jun 2002 04:02:58 +0200 (SAST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net

Hi all,
Perhaps someone can enlighten me. I've been ploughing through the vesafb 
source and various other bits (video.S in boot as well) and I see that 
the vesa driver supports changing the virtual y resolution but not the 
virtual x. I suspect there is a really good reason for this - possibly 
the real mode nature of BIOS calls or perhaps something to do with 
bytes_per_line and the console driver - but I am not sure. Would it be 
possible to allow virtual x resolutions to be set at startup? If not 
then can the authors please fix the rivafb driver for GeForce2 Go chips? 
:) I really need hardware x panning - it's for a demo that will boot and 
run off a floppy.

many thanks - and hoping to be able to contribute,

Paul.


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
