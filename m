From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 10 Oct 2015 12:30:49 +0000
Subject: [PATCH 0/5] add missing of_node_put
Message-Id: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

for_each_child_of_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

The complete semantic patch that fixes this problem is
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
+  of_node_put(child);
?  break;
   ...
}
... when != child

@@
expression root,e;
local idexpression child;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
(
   return child;
|
+  of_node_put(child);
?  return ...;
)
   ...
 }
// </smpl>

---

 arch/arm/kernel/devtree.c             |    1 +
 arch/arm/mach-shmobile/pm-rmobile.c   |    4 +++-
 drivers/power/charger-manager.c       |    4 +++-
 drivers/regulator/of_regulator.c      |    1 +
 drivers/video/backlight/88pm860x_bl.c |    1 +
 5 files changed, 9 insertions(+), 2 deletions(-)
