From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: fbdev broken in current bk for PPC
Date: Fri, 10 Sep 2004 12:23:42 +1000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1094783022.2667.106.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S266905AbUIJCZO@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

Recent changes upstream are breaking fbdev on pmacs.

I haven't had time to go deep into that (but I suspect Linus sees it
too on his own g5 unless he removed offb from his .config).

From what I see, it seems that offb is kicking in by default, reserves
the mmio regions, and then whatever chip driver loads can't access them.

offb is supposed to be a "fallback" driver in case no fbdev is taking
over, it should also be "forced" in with video=ofonly kernel command
line. This logic has been broken.

Ben.
