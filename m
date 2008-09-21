From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: [PATCH 0/2] vgacon_scrolldelta cleanup
Date: Sun, 21 Sep 2008 18:00:07 +0200
Message-ID: <1222012809-5783-1-git-send-email-marcin.slusarz@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752732AbYIUQAp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Antonino Daplas <adaplas@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

[PATCH 1/2] vgacon: optimize scrolling
[PATCH 2/2] vgacon: vgacon_scrolldelta simplification

 drivers/video/console/vgacon.c |   48 ++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 24 deletions(-)
