From: "Janorkar, Mayuresh" <mayur@ti.com>
Date: Fri, 17 Dec 2010 15:51:43 +0000
Subject: New entry in modedb
Message-Id: <EAF47CD23C76F840A9E7FCE10091EFAB0322F86892@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi!

We keep a database for modes in drivers/video/modedb.c
The file says:

/*
 *  Standard video mode definitions (taken from XFree86)
 */

I am using a panel whose entry is not available in this mode database.
Can I add a new entry for my panel?

If this entry is not added, I am not able to set omapfb.mode through bootargs.

I wish to know if it is allowed to add a new entry.
But any other suggestions are wel-come.

-Thanks,
Mayuresh
