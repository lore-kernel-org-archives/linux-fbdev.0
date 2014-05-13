From: Takashi Iwai <tiwai@suse.de>
Date: Tue, 13 May 2014 10:09:26 +0000
Subject: [PATCH 0/3] minor console cleanup patches
Message-Id: <1399975769-30526-1-git-send-email-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

here is a small series of cleanup patches for some annoyance I
stumbled during debugging the framebuffer issues:

 [PATCH 1/3] vgacon: Fix & cleanup refcounting
 [PATCH 2/3] console: Use explicit pointer type for vc_uni_pagedir*
 [PATCH 3/3] console: Remove superfluous readonly check

There should be no functional changes by this.


Takashi

