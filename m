From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: [PATCH] matroxfb update to new API
Date: Tue, 27 May 2003 19:50:21 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030527175021.GA2453@vana.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

Hi,
  I just created stripped down version of matroxfb - it is available
as diff for 2.5.70 at 
ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/mga-stripdown-2.5.70.gz.

  I'll still update my own version of fbdev layer and matroxfb, as
this stripped down driver is quite unusable for me.
						Petr Vandrovec

----- Forwarded message from Petr Vandrovec <vandrove@vc.cvut.cz> -----

Date: Tue, 27 May 2003 19:46:31 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Subject: [PATCH] matroxfb update to new API

Hi Linus,
  as it appears that current fbdev layer is not going to disappear,
there is update of matroxfb. I'm sorry that it is quite large, but
due to completely changed underlying API there is no reasonable way 
how to split it into smaller pieces.

(Mis) Features:
Removed support for text mode. No way for it with current API.
Removed support for hardware cursor. Generic cursor code has enough 
	troubles as is, in software mode.
No reasonable fbset support... It is especially annoying on multihead
	system, as 'stty cols XXX rows YYY' does not change pixclock...
Removed fastfont support. No way for it with current API.

(Mis) Features inherited from generic fbdev API:
Cursor on other framebuffers than primary one does not blink.
Contents of visible, but not foreground, display is not updated.

						Thanks,
							Petr Vandrovec
