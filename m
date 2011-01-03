From: "Janorkar, Mayuresh" <mayur@ti.com>
Date: Mon, 03 Jan 2011 11:13:35 +0000
Subject: [PATCH 0/2] A minor cleanup in modedb file and adding a new entry
Message-Id: <EAF47CD23C76F840A9E7FCE10091EFAB03232B6B10@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

A small part of drivers/video/modedb.c file was not as per coding guidelines.
It had spaces instead of tabs, no spaces around "|" operator.

A minor cleanup would address this issue.
and adding a new enrtry in database would include an entry for
panel-taal in the mode database.

Mayuresh Janorkar (2):
  Cleaning up modedb file
  Adding a timings for panel-taal in mode database

 drivers/video/modedb.c |  319 +++++++++++++++++++++---------------------------
 1 files changed, 137 insertions(+), 182 deletions(-)

