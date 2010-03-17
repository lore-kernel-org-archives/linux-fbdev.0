From: ville.syrjala@nokia.com
Date: Wed, 17 Mar 2010 22:46:15 +0000
Subject: omapfb mem_idx patchset
Message-Id: <1268865983-16270-1-git-send-email-ville.syrjala@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Imre Deak <imre.deak@nokia.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

This patchset is based on the v3 monolithic patch.

These are the changes from v3:
* split up into smaller chunks
* OMAPFB_MEM_IDX defines fixed to use the full byte
* unnecessary changes removed
* converted to use rwsems
* further modified further to make lockdep happy
* some debug WARN_ON()s added

The add locking + convert to rwsem patches could be squashed together
if you don't want the intermediate step in the tree.
