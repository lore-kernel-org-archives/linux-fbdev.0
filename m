From: Dave Airlie <airlied@gmail.com>
Date: Tue, 21 Dec 2010 01:41:14 +0000
Subject: vt/fbcon binding and handover fixes
Message-Id: <1292895677-4242-1-git-send-email-airlied@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org

I've been working on some issues with the fb handoff between vesafb and KMS
on my machine with a dual-gpu card. These 3 patches are the primary result
of this, to fix a number of issues where the VT layer and fbcon layers
got themselves into a place that they couldn't get out off, having the second
card complicates things nicely where we have an fbdev registered but fbcon
gets unbound to the dummy console and can't get back.

Also a fix to the overlap tests which had an off-by-one.

Dave.

