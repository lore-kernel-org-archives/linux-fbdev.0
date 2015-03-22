From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:07:18 +0000
Subject: [PATCH 0/13] staging: sm750: reformat sm750.c
Message-Id: <20150322230718.GA16751@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

As suggested by Dan Carpenter, I've rewritten my patch as a series of smaller patches.

Dan's Mail: http://marc.info/?l=kernel-janitors&m2679651624193&w=2

Patches 1-12 only reformat code. Patch 13 changes the code, by moving assignments out of if conditions.

The module builds, but as I don't own a sm750 card, I can't test it.


