From: Scott Mcdermott <vaxerdec@gmail.com>
Subject: appropriate list for intelfb devel? 965GM
	support?
Date: Thu, 7 Feb 2008 00:38:23 -0800
Message-ID: <20080207083823.GA17726@omnius.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JN2HI-0006jn-6a for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Feb 2008 00:38:40 -0800
Received: from rv-out-0910.google.com ([209.85.198.190])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JN2HG-0004Xb-Tq
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 07 Feb 2008 00:38:40 -0800
Received: by rv-out-0910.google.com with SMTP id g11so6867380rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 07 Feb 2008 00:38:36 -0800 (PST)
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
To: linux-fbdev-devel@lists.sourceforge.net

I am trying to determine where the appropriate list is for
intelfb related postings.

I am trying to determine if there are any developers working
on adding support for the 965GM chipset.  Currently it seems
to max out at 865GM.

I doubt it's a matter of just recognizing the PCI ID.  A
gander at xorg sources says that this chipset requires
somewhat different programming.  I wish I had the expertise
to do it myself.

If there is a developer that needs some hardware to add
support, I can probably work something out with someone in
the Bay Area.  I'm using vesafb right now, which works, but
it's quite a bit slower than using a native chipset fbdev
driver (I've used both radeon and matrox before).
Especially because it uses software scrolling and doesn't
seem to support hardware panning with this chipset.

I appreciate any comments.  Thanks.

-- 
Scott

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
