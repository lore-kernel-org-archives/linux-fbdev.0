From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Thu, 26 Mar 2015 22:24:03 +0000
Subject: [PATCH v2 00/12] reformat sm750.c
Message-Id: <cover.1427406762.git.michel.von.czettritz@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

As suggested by Dan Carpenter, I've rewritten my patch as a series of smaller patches.

Dan's Mail: http://marc.info/?l=kernel-janitors&m2679651624193&w=2

Patches 1-11 only reformat code. Patch 12 changes the code, by moving assignments out of if conditions.
The module builds, but as I don't own a sm750 card, I can't test it.

---
v2:
* rebase on top of staging-testing
* delete original patch 6, as the original code was deleted by Lorenzo
* fix formatting as proposed by Dan Carpenter

Michel von Czettritz (12):
  staging: sm750: Reindent
  staging: sm750: add missing spaces after ','
  staging: sm750: move '{' to previous line
  staging: sm750: fix whitespace around braces
  staging: sm750: fix whitespaces around pointers
  staging: sm750: no braces for single stmt if blocks
  staging: sm750: comment formating
  staging: sm750: 80 characters per line
  staging: sm750: blank line after declaration
  staging: sm750: fix whitespace
  staging: sm750: fix whitspace for cast to pointer
  staging: sm750: move assignment out of if cond

 drivers/staging/sm750fb/sm750.c | 1358 ++++++++++++++++++++-------------------
 1 file changed, 687 insertions(+), 671 deletions(-)

-- 
2.3.3

